import 'dart:convert';
import 'package:bumilku_app/pages/self_detection/self_detection_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bumilku_app/theme/theme.dart';

import 'detail_history_page.dart';

class DetectionHistoryPage extends StatelessWidget {
  const DetectionHistoryPage({super.key});

  Future<List<Map<String, dynamic>>> loadDetectionResults() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingResults =
        prefs.getStringList('detection_results') ?? [];
    return existingResults
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
  }

  Future<void> deleteDetectionResult(int index, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingResults =
        prefs.getStringList('detection_results') ?? [];

    if (index >= 0 && index < existingResults.length) {
      existingResults.removeAt(index);
      await prefs.setStringList('detection_results', existingResults);

      // Refresh the page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DetectionHistoryPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Riwayat Deteksi",
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kPrimaryColor.withValues(alpha:0.05),
              kBackgroundColor.withValues(alpha:0.2),
            ],
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: loadDetectionResults(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      "Terjadi kesalahan",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }

            final results = snapshot.data ?? [];

            if (results.isEmpty) {
              return Center(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 80, color: tGreyColor),
                        const SizedBox(height: 20),
                        Text(
                          "Belum ada riwayat deteksi",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Hasil deteksi mandiri akan muncul di sini",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SelfDetectionPageView()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            "Lakukan Self Detection Sekarang",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                final date = DateTime.parse(item["date"]);
                final formattedDate =
                    "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
                final riskData = item["data"];
                final riskLevel =
                    riskData["riskLevel"]?.toString() ?? "Tidak diketahui";
                final score = riskData["score"] ?? 0;

                final riskColor = _getRiskColor(riskLevel);

                return GestureDetector(
                  onTap: () {
                    _showDetailDialog(context, item, index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Header dengan risiko dan tanggal
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: riskColor.withValues(alpha:0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: riskColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getRiskIcon(riskLevel),
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      riskLevel.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: riskColor,
                                      ),
                                    ),
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ),

                        // Info tambahan
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoItem(
                                "Poin Risiko",
                                "$score",
                                Icons.assessment,
                              ),
                              _buildInfoItem(
                                "Detail",
                                "${riskData["details"] is List ? (riskData["details"] as List).length : 0} faktor",
                                Icons.list,
                              ),
                              _buildInfoItem(
                                "Status",
                                _getRiskStatus(riskLevel),
                                Icons.info,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: kPrimaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  void _showDetailDialog(BuildContext context, Map<String, dynamic> item, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailHistoryPage(
          historyItem: item,
          itemIndex: index,
          onDelete: () => deleteDetectionResult(index, context),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
    String title,
    IconData icon,
    List<Widget> children,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
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
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String prefix, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prefix, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
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

  void _showDeleteConfirmation(BuildContext context, int index) {
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
          content: const Text(
            "Apakah Anda yakin ingin menghapus riwayat deteksi ini?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi
                deleteDetectionResult(index, context);
                _showDeleteSuccess(context);
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteSuccess(BuildContext context) {
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
