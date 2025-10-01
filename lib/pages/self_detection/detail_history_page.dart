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

  @override
  Widget build(BuildContext context) {
    final displayDate = detection.createdAt ?? detection.date;
    final formattedDate = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID').format(displayDate);
    final riskColor = _getRiskColor(detection.riskLevel);

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