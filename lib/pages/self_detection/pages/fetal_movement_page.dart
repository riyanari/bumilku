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

  // Durasi tetap 12 jam
  final int _fixedDurationHours = 12;

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

    // Set durasi tetap 12 jam
    widget.controller.fetalMovementDuration = _fixedDurationHours;
  }

  void _setupControllers() {
    _movementCountController.text = widget.controller.fetalMovementCount > 0
        ? widget.controller.fetalMovementCount.toString()
        : '';

    _movementCountController.addListener(() {
      final count = int.tryParse(_movementCountController.text) ?? 0;
      widget.controller.fetalMovementCount = count;
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
  double _getMovementsPerHour(int movementCount) {
    return movementCount / _fixedDurationHours;
  }

  // Tentukan status berdasarkan gerakan per jam
  FetalMovementStatus _calculateStatus(int movementCount) {
    if (movementCount == 0) {
      return FetalMovementStatus.incomplete;
    }

    // STANDAR BARU: minimal 10 gerakan dalam 12 jam
    const normalThreshold = 10; // Minimal 10 gerakan dalam 12 jam
    const warningThreshold = 7; // 7-9 gerakan dalam 12 jam
    const dangerThreshold = 4;  // 4-6 gerakan dalam 12 jam
    // Kurang dari 4 gerakan = emergency

    if (movementCount >= normalThreshold) {
      return FetalMovementStatus.normal;
    } else if (movementCount >= warningThreshold) {
      return FetalMovementStatus.monitoring;
    } else if (movementCount >= dangerThreshold) {
      return FetalMovementStatus.attention;
    } else {
      return FetalMovementStatus.emergency;
    }
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

  @override
  void dispose() {
    _movementCountController.dispose();
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

                _buildDurationInfo(),
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
            "Pencatatan gerakan janin dilakukan selama 12 jam. "
                "Gerakan janin normal: minimal 10 gerakan dalam 12 jam. "
                "Catat semua gerakan yang dirasakan dalam periode 12 jam.",
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
          "Tanggal & Waktu Mulai Pencatatan",
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
          "Jumlah Gerakan dalam 12 Jam",
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
                    hintText: "Masukkan total gerakan dalam 12 jam",
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
            "Target: minimal 10 gerakan dalam 12 jam",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDurationInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: Colors.green[700], size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Durasi Pencatatan: $_fixedDurationHours Jam",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
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
    final hasData = movementCount > 0;

    // PERHITUNGAN DINAMIS
    final status = _calculateStatus(movementCount);
    final movementsPerHour = _getMovementsPerHour(movementCount);

    if (!hasData) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          "Isi jumlah gerakan untuk melihat ringkasan",
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

          // INFORMASI GERAKAN
          Text(
            "Gerakan: $movementCount kali dalam $_fixedDurationHours jam "
                "(${movementsPerHour.toStringAsFixed(1)} gerakan/jam)",
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 6),

          Text(
            status.getMessage(movementCount, _fixedDurationHours, movementsPerHour),
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
          Text("• Durasi: $_fixedDurationHours jam", style: const TextStyle(fontSize: 11)),
          Text("• Target minimal: 10 gerakan", style: const TextStyle(fontSize: 11)),
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

  String getMessage(int movementCount, int durationHours, double movementsPerHour) {
    switch (this) {
      case FetalMovementStatus.normal:
        return "Gerakan janin dalam batas normal ($movementCount gerakan dalam $durationHours jam).";
      case FetalMovementStatus.monitoring:
        return "Gerakan janin $movementCount kali dalam $durationHours jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.";
      case FetalMovementStatus.attention:
        return "Gerakan janin $movementCount kali dalam $durationHours jam. Disarankan konsultasi dengan tenaga kesehatan.";
      case FetalMovementStatus.emergency:
        return "Gerakan janin hanya $movementCount kali dalam $durationHours jam. Segera hubungi tenaga kesehatan.";
      case FetalMovementStatus.incomplete:
        return "Lengkapi data pencatatan untuk analisis yang akurat.";
    }
  }
}