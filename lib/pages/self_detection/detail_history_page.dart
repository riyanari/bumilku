import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';

class DetailHistoryPage extends StatelessWidget {
  final Map<String, dynamic> historyItem;
  final int itemIndex;
  final VoidCallback onDelete;

  const DetailHistoryPage({
    super.key,
    required this.historyItem,
    required this.itemIndex,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final riskData = historyItem["data"];
    final riskLevel = riskData["riskLevel"]?.toString() ?? "Tidak diketahui";
    final score = riskData["score"] ?? 0;
    final details = riskData["details"] is List
        ? (riskData["details"] as List).map((e) => e.toString()).toList()
        : [];
    final recommendation = riskData["recommendation"]?.toString() ?? 'Tidak ada rekomendasi spesifik';
    final riskEducation = riskData["riskEducation"] as Map<String, dynamic>?;
    final generalTips = riskData["generalTips"] is List
        ? (riskData["generalTips"] as List).map((e) => e.toString()).toList()
        : [];

    final date = DateTime.parse(historyItem["date"]);
    final formattedDate = "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";

    final riskColor = _getRiskColor(riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Riwayat Deteksi",
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
              _buildHeaderCard(riskLevel, score, formattedDate, riskColor),

              const SizedBox(height: 20),

              // Faktor Risiko
              if (details.isNotEmpty)
                _buildSectionCard(
                  "Faktor Risiko Teridentifikasi",
                  Icons.warning,
                  Colors.orange,
                  details.map((detail) => _buildListItem("•", detail)).toList(),
                ),

              const SizedBox(height: 16),

              // Rekomendasi
              _buildSectionCard(
                "Rekomendasi",
                Icons.medical_services,
                kPrimaryColor,
                [_buildListItem("", recommendation)],
              ),

              const SizedBox(height: 16),

              // Edukasi Risiko
              if (riskEducation != null && riskEducation.isNotEmpty)
                _buildRiskEducationSection(riskEducation, riskColor),

              const SizedBox(height: 16),

              // Tips Umum
              if (generalTips.isNotEmpty)
                _buildSectionCard(
                  "Tips Kehamilan Sehat",
                  Icons.lightbulb_outline,
                  Colors.amber,
                  generalTips.map((tip) => _buildListItem("❤️", tip)).toList(),
                ),

              const SizedBox(height: 30),

              // Tombol Delete
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(String riskLevel, int score, String date, Color riskColor) {
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
                  _getRiskIcon(riskLevel),
                  size: 40,
                  color: riskColor,
                ),
              ),

              const SizedBox(height: 16),

              // Risk Level
              Text(
                riskLevel.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                ),
              ),

              const SizedBox(height: 8),

              // Date
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 16),

              // Score dan Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem("Poin Risiko", "$score", Icons.assessment),
                  _buildInfoItem("Status", _getRiskStatus(riskLevel), Icons.info),
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

  Widget _buildRiskEducationSection(Map<String, dynamic> riskEducation, Color riskColor) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.health_and_safety, size: 20, color: riskColor),
                ),
                const SizedBox(width: 12),
                Text(
                  riskEducation['title']?.toString() ?? "Edukasi Risiko",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: riskColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Content
            if (riskEducation['description'] != null)
              _buildListItem("📋", riskEducation['description']!.toString()),

            if (riskEducation['recommendations'] != null)
              _buildListItem("💡", riskEducation['recommendations']!.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String prefix, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            prefix,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.delete_outline, color: Colors.red),
              SizedBox(width: 8),
              Text("Hapus Riwayat"),
            ],
          ),
          content: const Text("Apakah Anda yakin ingin menghapus riwayat deteksi ini? Tindakan ini tidak dapat dibatalkan."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: tPrimaryColor),
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi
                onDelete();
                Navigator.pop(context); // Kembali ke halaman riwayat

                // Show success message
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
              },
              child: Text("Hapus", style: whiteTextStyle,),
            ),
          ],
        );
      },
    );
  }

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
}