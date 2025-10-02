import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter/material.dart';
import '../self_detection_controller.dart';

class FetalMovementPage extends StatefulWidget {
  final SelfDetectionController controller;

  const FetalMovementPage({super.key, required this.controller});

  @override
  State<FetalMovementPage> createState() => _FetalMovementPageState();
}

class _FetalMovementPageState extends State<FetalMovementPage> {
  final List<String> _activityPatterns = [
    'Lebih aktif pagi hari',
    'Lebih aktif siang hari',
    'Lebih aktif malam hari',
    'Tidak ada pola khusus'
  ];

  final List<String> _comparisonOptions = [
    'Lebih aktif',
    'Sama saja',
    'Lebih sedikit'
  ];

  final List<String> _complaintOptions = [
    'Pusing/lemas',
    'Nyeri perut',
    'Tidak ada'
  ];

  // Controller untuk input field
  final TextEditingController _movementCountController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupControllers();
  }

  void _initializeData() {
    if (widget.controller.fetalMovementDateTime == null) {
      widget.controller.fetalMovementDateTime = DateTime.now();
    }
    if (widget.controller.movementComparison.isEmpty) {
      widget.controller.movementComparison = 'Sama saja';
    }
    if (widget.controller.fetalActivityPattern.isEmpty) {
      widget.controller.fetalActivityPattern = 'Tidak ada pola khusus';
    }
  }

  void _setupControllers() {
    _movementCountController.text = widget.controller.fetalMovementCount > 0
        ? widget.controller.fetalMovementCount.toString()
        : '';
    _durationController.text = widget.controller.fetalMovementDuration > 0
        ? widget.controller.fetalMovementDuration.toString()
        : '';

    _movementCountController.addListener(() {
      final count = int.tryParse(_movementCountController.text) ?? 0;
      widget.controller.fetalMovementCount = count;
      setState(() {});
    });

    _durationController.addListener(() {
      final duration = int.tryParse(_durationController.text) ?? 0;
      widget.controller.fetalMovementDuration = duration;
      setState(() {});
    });
  }

  void _showDateTimePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.controller.fetalMovementDateTime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && mounted) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(widget.controller.fetalMovementDateTime ?? DateTime.now()),
      );

      if (time != null && mounted) {
        setState(() {
          widget.controller.fetalMovementDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  // PERHITUNGAN DINAMIS - Hitung gerakan per jam
  double _getMovementsPerHour(int movementCount, int durationMinutes) {
    if (durationMinutes == 0) return 0.0;
    return (movementCount / durationMinutes) * 60;
  }

  // Tentukan status berdasarkan gerakan per jam
  FetalMovementStatus _calculateStatus(int movementCount, int durationMinutes) {
    if (movementCount == 0 || durationMinutes == 0) {
      return FetalMovementStatus.incomplete;
    }

    final movementsPerHour = _getMovementsPerHour(movementCount, durationMinutes);

    // Standar: 10 gerakan dalam 2 jam = 5 gerakan per jam
    const normalThreshold = 5.0; // 5 gerakan per jam
    const warningThreshold = 3.0; // 3 gerakan per jam
    const dangerThreshold = 1.0;  // 1 gerakan per jam

    if (movementsPerHour >= normalThreshold) {
      return FetalMovementStatus.normal;
    } else if (movementsPerHour >= warningThreshold) {
      return FetalMovementStatus.monitoring;
    } else if (movementsPerHour >= dangerThreshold) {
      return FetalMovementStatus.attention;
    } else {
      return FetalMovementStatus.emergency;
    }
  }

  // Hitung gerakan yang diharapkan untuk durasi tertentu
  double _getExpectedMovement(int durationMinutes) {
    // Standar: 10 gerakan dalam 120 menit = 0.0833 gerakan per menit
    const standardRate = 10 / 120;
    return durationMinutes * standardRate;
  }

  String? _validateMovementCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Jumlah gerakan harus diisi';
    }
    final count = int.tryParse(value);
    if (count == null) {
      return 'Masukkan angka yang valid';
    }
    if (count < 0) {
      return 'Tidak boleh negatif';
    }
    return null;
  }

  String? _validateDuration(String? value) {
    if (value == null || value.isEmpty) {
      return 'Durasi harus diisi';
    }
    final duration = int.tryParse(value);
    if (duration == null) {
      return 'Masukkan angka yang valid';
    }
    if (duration <= 0) {
      return 'Durasi harus lebih dari 0 menit';
    }
    return null;
  }

  @override
  void dispose() {
    _movementCountController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pencatatan Gerakan Janin",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: tPrimaryColor,
            ),
          ),
          const SizedBox(height: 10),

          // Informasi penting
          _buildInfoCard(),
          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              children: [
                _buildSectionTitle("Parameter Utama Pencatatan"),
                const SizedBox(height: 12),

                _buildDateTimeField(),
                const SizedBox(height: 16),

                _buildMovementCountField(),
                const SizedBox(height: 16),

                _buildDurationField(),
                const SizedBox(height: 16),

                _buildActivityPatternField(),
                const SizedBox(height: 20),

                _buildSectionTitle("Kondisi Subjektif Ibu"),
                const SizedBox(height: 12),

                _buildMovementComparisonField(),
                const SizedBox(height: 16),

                _buildAdditionalComplaintsField(),
                const SizedBox(height: 20),

                _buildSummarySection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: Colors.blue[700], size: 16),
              const SizedBox(width: 8),
              Text(
                "Informasi Penting",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "Gerakan janin normal: minimal 5 gerakan per jam (atau 10 gerakan dalam 2 jam). "
                "Sistem akan menyesuaikan secara otomatis berdasarkan durasi pencatatan Anda.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: tPrimaryColor,
      ),
    );
  }

  Widget _buildDateTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tanggal & Waktu Pencatatan",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.controller.fetalMovementDateTime != null
                    ? "${widget.controller.fetalMovementDateTime!.day}/${widget.controller.fetalMovementDateTime!.month}/${widget.controller.fetalMovementDateTime!.year} ${widget.controller.fetalMovementDateTime!.hour}:${widget.controller.fetalMovementDateTime!.minute.toString().padLeft(2, '0')}"
                    : "Pilih tanggal & waktu",
                style: TextStyle(
                  color: widget.controller.fetalMovementDateTime != null ? Colors.black : Colors.grey[400],
                ),
              ),
              IconButton(
                icon: Icon(Icons.calendar_today, color: tPrimaryColor),
                onPressed: _showDateTimePicker,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMovementCountField() {
    final hasError = _validateMovementCount(_movementCountController.text) != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Jumlah Gerakan yang Dirasakan",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError ? Colors.red : Colors.grey[300]!,
              width: hasError ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _movementCountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukkan jumlah gerakan",
                    hintStyle: TextStyle(fontSize: 12),
                    errorStyle: TextStyle(height: 0),
                  ),
                ),
              ),
              Text(
                "kali",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            _validateMovementCount(_movementCountController.text)!,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.red,
            ),
          ),
        ] else ...[
          const SizedBox(height: 4),
          Text(
            "Target: 5 gerakan per jam",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDurationField() {
    final hasError = _validateDuration(_durationController.text) != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Durasi Waktu yang Dibutuhkan",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError ? Colors.red : Colors.grey[300]!,
              width: hasError ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Masukkan durasi dalam menit",
                    hintStyle: TextStyle(fontSize: 12),
                    errorStyle: TextStyle(height: 0),
                  ),
                ),
              ),
              Text(
                "menit",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            _validateDuration(_durationController.text)!,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActivityPatternField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pola Aktivitas Janin",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ..._activityPatterns.map((pattern) => RadioListTile<String>(
          title: Text(pattern, style: const TextStyle(fontSize: 12)),
          value: pattern,
          groupValue: widget.controller.fetalActivityPattern,
          onChanged: (value) {
            setState(() {
              widget.controller.fetalActivityPattern = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
        )),
      ],
    );
  }

  Widget _buildMovementComparisonField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Perbandingan Gerakan dengan Hari Sebelumnya",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ..._comparisonOptions.map((option) => RadioListTile<String>(
          title: Text(option, style: const TextStyle(fontSize: 12)),
          value: option,
          groupValue: widget.controller.movementComparison,
          onChanged: (value) {
            setState(() {
              widget.controller.movementComparison = value!;
            });
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
        )),
      ],
    );
  }

  Widget _buildAdditionalComplaintsField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Keluhan Lain yang Dirasakan",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ..._complaintOptions.map((complaint) => CheckboxListTile(
          title: Text(complaint, style: const TextStyle(fontSize: 12)),
          value: widget.controller.fetalAdditionalComplaints.contains(complaint),
          onChanged: (value) {
            setState(() {
              if (value == true) {
                widget.controller.fetalAdditionalComplaints = [
                  ...widget.controller.fetalAdditionalComplaints,
                  complaint
                ];
              } else {
                widget.controller.fetalAdditionalComplaints =
                    widget.controller.fetalAdditionalComplaints
                        .where((item) => item != complaint)
                        .toList();
              }
            });
          },
          contentPadding: EdgeInsets.zero,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
        )).toList(),
      ],
    );
  }

  Widget _buildSummarySection() {
    final movementCount = widget.controller.fetalMovementCount;
    final duration = widget.controller.fetalMovementDuration;
    final hasData = movementCount > 0 && duration > 0;

    // PERHITUNGAN DINAMIS
    final status = _calculateStatus(movementCount, duration);
    final movementsPerHour = _getMovementsPerHour(movementCount, duration);
    final expectedMovement = _getExpectedMovement(duration);

    if (!hasData) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          "Isi data di atas untuk melihat ringkasan",
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: status.color.withValues(alpha:0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                status.icon,
                color: status.color,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                status.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: status.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // INFORMASI GERAKAN PER JAM
          Text(
            "Gerakan: $movementCount kali dalam $duration menit "
                "(${movementsPerHour.toStringAsFixed(1)} gerakan/jam)",
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),

          Text(
            status.getMessage(movementCount, duration, movementsPerHour),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),

          Text(
            "Detail Pencatatan:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text("• Jumlah gerakan: $movementCount kali", style: const TextStyle(fontSize: 11)),
          Text("• Durasi: $duration menit", style: const TextStyle(fontSize: 11)),
          Text("• Pola: ${widget.controller.fetalActivityPattern}", style: const TextStyle(fontSize: 11)),
          Text("• Perbandingan: ${widget.controller.movementComparison}", style: const TextStyle(fontSize: 11)),
          if (widget.controller.fetalAdditionalComplaints.isNotEmpty)
            Text("• Keluhan: ${widget.controller.fetalAdditionalComplaints.join(', ')}", style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

// ENUM UNTUK STATUS YANG LEBIH DINAMIS
enum FetalMovementStatus {
  incomplete(Colors.grey, Icons.hourglass_empty, "Data Belum Lengkap"),
  normal(Colors.green, Icons.check_circle, "Kondisi Normal"),
  monitoring(Colors.blue, Icons.timelapse, "Perlu Pemantauan"),
  attention(Colors.orange, Icons.info, "Perlu Perhatian"),
  emergency(Colors.red, Icons.warning, "Perhatian Khusus");

  const FetalMovementStatus(this.color, this.icon, this.title);
  final Color color;
  final IconData icon;
  final String title;

  String getMessage(int movementCount, int duration, double movementsPerHour) {
    switch (this) {
      case FetalMovementStatus.normal:
        return "Gerakan janin dalam batas normal (${movementsPerHour.toStringAsFixed(1)} gerakan/jam).";
      case FetalMovementStatus.monitoring:
        return "Gerakan janin ${movementsPerHour.toStringAsFixed(1)} gerakan/jam. Tetap pantau secara rutin.";
      case FetalMovementStatus.attention:
        return "Gerakan janin ${movementsPerHour.toStringAsFixed(1)} gerakan/jam. Disarankan konsultasi dengan tenaga kesehatan.";
      case FetalMovementStatus.emergency:
        return "Gerakan janin hanya ${movementsPerHour.toStringAsFixed(1)} gerakan/jam. Segera hubungi tenaga kesehatan.";
      case FetalMovementStatus.incomplete:
        return "Lengkapi data pencatatan untuk analisis yang akurat.";
    }
  }
}