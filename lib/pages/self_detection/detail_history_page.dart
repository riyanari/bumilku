import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../cubit/self_detection_cubit.dart';
import '../../models/self_detection_model.dart';

class DetailHistoryPage extends StatelessWidget {
  final SelfDetectionModel detection;

  const DetailHistoryPage({
    super.key,
    required this.detection,
  });

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return Colors.red;
      case 'perlu perhatian':
      case 'sedang':
        return Colors.orange;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getRiskIcon(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return Icons.warning_rounded;
      case 'perlu perhatian':
      case 'sedang':
        return Icons.info_rounded;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return Icons.check_circle_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  String _getRiskStatus(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return "Perlu Penanganan";
      case 'perlu perhatian':
      case 'sedang':
        return "Perlu Perhatian";
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return "Aman";
      default:
        return "Tidak Diketahui";
    }
  }

  // METHOD BARU: Warna untuk status gerakan janin
  Color _getFetalMovementColor(String colorName) {
    switch (colorName) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // METHOD BARU: Icon untuk status gerakan janin
  IconData _getFetalMovementIcon(String colorName) {
    switch (colorName) {
      case 'green':
        return Icons.check_circle;
      case 'blue':
        return Icons.timelapse;
      case 'orange':
        return Icons.info;
      case 'red':
        return Icons.warning;
      default:
        return Icons.hourglass_empty;
    }
  }

  // METHOD BARU: Parse fetal movement status
  Map<String, dynamic> _parseFetalMovementStatus(dynamic statusData) {
    if (statusData is Map<String, dynamic>) {
      return statusData;
    } else if (statusData is Map) {
      return Map<String, dynamic>.from(statusData);
    } else {
      return {
        'status': 'incomplete',
        'title': 'Data Tercatat',
        'message': 'Data gerakan janin telah tercatat',
        'color': 'grey'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = detection.createdAt ?? detection.date;
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID').format(displayDate);
    final riskColor = _getRiskColor(detection.riskLevel);

    // DATA GERAKAN JANIN
    final hasFetalMovementData = detection.hasFetalMovementData == true;
    final fetalMovementCount = detection.fetalMovementCount ?? 0;
    final fetalMovementDuration = detection.fetalMovementDuration ?? 0;
    final movementsPerHour = detection.movementsPerHour ?? 0.0;
    final fetalMovementStatusDynamic = detection.fetalMovementStatus;
    final fetalMovementStatus = _parseFetalMovementStatus(fetalMovementStatusDynamic);
    final movementComparison = detection.movementComparison?.toString() ?? '';
    final fetalActivityPattern = detection.fetalActivityPattern?.toString() ?? '';
    final fetalAdditionalComplaints = detection.fetalAdditionalComplaints ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Deteksi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteConfirmation(context),
            tooltip: "Hapus Riwayat",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              riskColor.withValues(alpha:0.05),
              kBackgroundColor.withValues(alpha:0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header Info
              _buildHeaderCard(riskColor, formattedDate),

              const SizedBox(height: 20),

              // HASIL GERAKAN JANIN (jika ada data)
              if (hasFetalMovementData) ...[
                _buildFetalMovementSection(
                  fetalMovementCount,
                  fetalMovementDuration,
                  movementsPerHour,
                  fetalMovementStatus,
                  movementComparison,
                  fetalActivityPattern,
                  fetalAdditionalComplaints,
                ),
                const SizedBox(height: 16),
              ],

              // Informasi Risiko
              _buildSectionCard(
                "Informasi Risiko",
                Icons.assessment,
                kPrimaryColor,
                [
                  _buildDetailItem("Tingkat Risiko", detection.riskLevel.toUpperCase(),
                      color: riskColor),
                  _buildDetailItem("Skor", "${detection.score}"),
                  _buildDetailItem("Status", _getRiskStatus(detection.riskLevel)),
                ],
              ),

              const SizedBox(height: 16),

              // Rekomendasi
              _buildSectionCard(
                "Rekomendasi",
                Icons.recommend,
                Colors.green,
                [
                  _buildDetailItem("", detection.recommendation),
                ],
              ),

              // Detail Temuan
              if (detection.details.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  "Detail Temuan",
                  Icons.list,
                  Colors.orange,
                  detection.details.map((detail) => _buildDetailItem("•", detail)).toList(),
                ),
              ],

              // Edukasi Risiko
              if (detection.riskEducation != null && detection.riskEducation!['description'] != null) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  "Edukasi Risiko",
                  Icons.school,
                  Colors.blue,
                  [
                    _buildDetailItem("", detection.riskEducation!['description']!),
                  ],
                ),
              ],

              // Tips Umum
              if (detection.generalTips != null && detection.generalTips!.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  "Tips Kehamilan Sehat",
                  Icons.lightbulb_outline,
                  Colors.amber,
                  detection.generalTips!.map((tip) => _buildDetailItem("❤️", tip.toString())).toList(),
                ),
              ],

              const SizedBox(height: 30),

              // Tombol Delete
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET BARU: Section untuk menampilkan hasil gerakan janin
  Widget _buildFetalMovementSection(
      int movementCount,
      int duration,
      double movementsPerHour,
      Map<String, dynamic> status,
      String comparison,
      String pattern,
      List<dynamic> additionalComplaints,
      ) {
    final statusColor = _getFetalMovementColor(status['color'] ?? 'grey');
    final statusIcon = _getFetalMovementIcon(status['color'] ?? 'grey');

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite, size: 20, color: statusColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Hasil Pencatatan Gerakan Janin",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Status gerakan janin
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha:0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor.withValues(alpha:0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(statusIcon, size: 20, color: statusColor),
                      const SizedBox(width: 8),
                      Text(
                        (status['title'] ?? 'DATA TERCATAT').toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    status['message']?.toString() ?? 'Data gerakan janin telah tercatat',
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Detail pencatatan
            Text(
              "Detail Pencatatan:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),

            _buildFetalMovementDetailItem(
                "Jumlah Gerakan",
                "$movementCount kali"
            ),
            _buildFetalMovementDetailItem(
                "Durasi Pencatatan",
                "$duration menit"
            ),
            _buildFetalMovementDetailItem(
                "Gerakan per Jam",
                "${movementsPerHour.toStringAsFixed(1)} gerakan/jam"
            ),
            _buildFetalMovementDetailItem(
                "Perbandingan dengan Kemarin",
                comparison.isNotEmpty ? comparison : 'Tidak ada data'
            ),
            _buildFetalMovementDetailItem(
                "Pola Aktivitas",
                pattern.isNotEmpty ? pattern : 'Tidak ada data'
            ),

            // Keluhan tambahan
            if (additionalComplaints.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildFetalMovementDetailItem(
                  "Keluhan Tambahan",
                  additionalComplaints.join(', ')
              ),
            ],

            const SizedBox(height: 12),

            // Informasi tambahan
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.blue[700], size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Standar normal: minimal 5 gerakan per jam",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk item detail gerakan janin
  Widget _buildFetalMovementDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
              value,
              style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold
              )
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(Color riskColor, String formattedDate) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              riskColor.withValues(alpha:0.1),
              riskColor.withValues(alpha:0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Icon dan Status
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getRiskIcon(detection.riskLevel),
                  size: 40,
                  color: riskColor,
                ),
              ),

              const SizedBox(height: 16),

              // Risk Level
              Text(
                detection.riskLevel.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                ),
              ),

              const SizedBox(height: 8),

              // Date
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Score dan Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem("Poin Risiko", "${detection.score}", Icons.assessment),
                  _buildInfoItem("Status", _getRiskStatus(detection.riskLevel), Icons.info),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, Color color, List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Content
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String prefix, String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prefix,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: kPrimaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _showDeleteConfirmation(context),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline),
            SizedBox(width: 8),
            Text("Hapus Riwayat Ini"),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Hapus Riwayat',
      desc: 'Apakah Anda yakin ingin menghapus riwayat deteksi ini?\nTindakan ini tidak dapat dibatalkan.',
      btnCancelText: "Batal",
      btnOkText: "Hapus",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _deleteDetection(context);
      },
      btnCancelColor: kPrimaryColor,
      btnOkColor: Colors.red,
    ).show();
  }

  void _deleteDetection(BuildContext context) {
    // Hapus dari Firebase via Cubit
    context.read<SelfDetectionCubit>().deleteDetection(detection.id);

    // Kembali ke halaman riwayat
    Navigator.pop(context);

    // Tampilkan snackbar sukses
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text("Riwayat berhasil dihapus!"),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}