import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';
import 'package:bumilku_app/pages/self_detection/data/complaint_education_data.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> riskResult;
  final VoidCallback onBack;
  final VoidCallback onSave;

  const ResultPage({
    super.key,
    required this.riskResult,
    required this.onBack,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final riskLevel = riskResult['riskLevel']?.toString().toLowerCase() ?? 'unknown';
    final score = riskResult['score'] ?? 0;
    final details = riskResult['details'] is List ? riskResult['details'] as List<String> : [];
    final recommendation = riskResult['recommendation']?.toString() ?? 'Tidak ada rekomendasi spesifik';
    final complaintEducations = riskResult['complaintEducations'] as Map<String, ComplaintEducation>?;
    final riskEducation = riskResult['riskEducation'] as Map<String, String>?;
    final generalTips = riskResult['generalTips'] as List<String>?;

    // DATA GERAKAN JANIN - PERBAIKAN TYPE CASTING
    final hasFetalMovementData = riskResult['hasFetalMovementData'] == true;
    final fetalMovementCount = riskResult['fetalMovementCount'] ?? 0;
    final fetalMovementDuration = riskResult['fetalMovementDuration'] ?? 0;
    final movementsPerHour = riskResult['movementsPerHour'] ?? 0.0;

    // PERBAIKAN: Handle dynamic type untuk fetalMovementStatus
    final dynamic fetalMovementStatusDynamic = riskResult['fetalMovementStatus'];
    final Map<String, dynamic> fetalMovementStatus = _parseFetalMovementStatus(fetalMovementStatusDynamic);

    final movementComparison = riskResult['movementComparison']?.toString() ?? '';
    final fetalActivityPattern = riskResult['fetalActivityPattern']?.toString() ?? '';

    final riskData = _getRiskData(riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Deteksi Mandiri",
          style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _showSaveConfirmation(context);
            },
            tooltip: "Simpan Hasil",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              riskData['color'].withValues(alpha:0.1),
              kBackgroundColor.withValues(alpha:0.3),
              Colors.white,
            ],
            stops: const [0.0, 0.3, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header dengan animasi dan gradient
              _buildAnimatedRiskHeader(riskLevel, score, riskData),

              const SizedBox(height: 24),

              // Detail faktor risiko (jika ada)
              if (details.isNotEmpty)
                _buildAnimatedRiskDetailsCard(details),

              const SizedBox(height: 16),

              // HASIL GERAKAN JANIN (jika ada data)
              if (hasFetalMovementData)
                _buildFetalMovementSection(
                    fetalMovementCount,
                    fetalMovementDuration,
                    movementsPerHour,
                    fetalMovementStatus,
                    movementComparison,
                    fetalActivityPattern
                ),

              const SizedBox(height: 16),

              // Card rekomendasi dengan desain modern
              _buildModernRecommendationCard(recommendation, riskData),

              const SizedBox(height: 16),

              // EDUKASI RISIKO
              if (riskEducation != null)
                _buildAnimatedRiskEducationSection(riskEducation, riskData),

              const SizedBox(height: 16),

              // EDUKASI KELUHAN
              if (complaintEducations != null && complaintEducations.isNotEmpty)
                _buildAnimatedComplaintEducationSection(complaintEducations, riskData),

              const SizedBox(height: 16),

              // TIPS UMUM
              if (generalTips != null)
                _buildAnimatedGeneralTipsSection(generalTips, riskData),

              const SizedBox(height: 24),

              // Tombol aksi dengan desain modern
              _buildModernActionButtons(context, riskData),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // METHOD BARU: Parse fetal movement status dengan aman
  Map<String, dynamic> _parseFetalMovementStatus(dynamic statusData) {
    if (statusData is Map<String, dynamic>) {
      return statusData;
    } else if (statusData is Map) {
      // Convert Map<dynamic, dynamic> to Map<String, dynamic>
      return Map<String, dynamic>.from(statusData);
    } else {
      // Return default jika data tidak valid
      return {
        'status': 'incomplete',
        'title': 'Data Tercatat',
        'message': 'Data gerakan janin telah tercatat',
        'color': 'grey'
      };
    }
  }

  // WIDGET BARU: Section untuk menampilkan hasil gerakan janin
  Widget _buildFetalMovementSection(
      int movementCount,
      int duration,
      double movementsPerHour,
      Map<String, dynamic> status,
      String comparison,
      String pattern
      ) {

    // HITUNG ULANG semua status di sini berdasarkan movementCount
    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(movementCount);
    final statusMessage = _getFetalMovementMessage(movementCount, movementsPerHour);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                statusColor.withValues(alpha:0.08),
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha:0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(statusIcon, color: statusColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                          "Hasil Pencatatan Gerakan Janin",
                          style: blackTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: bold
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Status gerakan janin - PAKAI YANG DIHITUNG ULANG
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
                      Text(
                        statusTitle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        statusMessage,
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
                    "$duration jam" // DIUBAH: dari menit ke jam
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
                          "Standar normal: minimal 10 gerakan dalam 12 jam (${(10/12).toStringAsFixed(1)} gerakan/jam)",
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
        ),
      ),
    );
  }

  String _getFetalMovementTitle(int movementCount) {
    if (movementCount == 0) return "Data Belum Lengkap";
    if (movementCount >= 10) return "Kondisi Normal";
    if (movementCount >= 7) return "Perlu Pemantauan";
    if (movementCount >= 4) return "Perlu Perhatian";
    return "Perhatian Khusus";
  }

  String _getFetalMovementMessage(int movementCount, double movementsPerHour) {
    if (movementCount == 0) {
      return "Data gerakan janin belum lengkap. Silakan lengkapi pencatatan.";
    }

    if (movementCount >= 10) {
      return "Gerakan janin dalam batas normal ($movementCount gerakan dalam 12 jam).";
    }

    if (movementCount >= 7) {
      return "Gerakan janin $movementCount kali dalam 12 jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.";
    }

    if (movementCount >= 4) {
      return "Gerakan janin $movementCount kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.";
    }

    return "Gerakan janin hanya $movementCount kali dalam 12 jam. Segera hubungi tenaga kesehatan.";
  }

// Method untuk menentukan warna berdasarkan jumlah gerakan
  Color _getFetalMovementColorFromCount(int movementCount) {
    if (movementCount == 0) return Colors.grey;
    if (movementCount >= 10) return Colors.green;
    if (movementCount >= 7) return Colors.blue;
    if (movementCount >= 4) return Colors.orange;
    return Colors.red;
  }

// Method untuk menentukan icon berdasarkan jumlah gerakan
  IconData _getFetalMovementIconFromCount(int movementCount) {
    if (movementCount == 0) return Icons.hourglass_empty;
    if (movementCount >= 10) return Icons.check_circle;
    if (movementCount >= 7) return Icons.timelapse;
    if (movementCount >= 4) return Icons.info;
    return Icons.warning;
  }

  // WIDGET BARU: Informasi status berdasarkan jumlah gerakan
  Widget _buildFetalMovementStatusInfo(int movementCount) {
    String statusText;
    Color statusColor;

    if (movementCount >= 10) {
      statusText = "✅ Normal: Gerakan janin dalam batas normal";
      statusColor = Colors.green;
    } else if (movementCount >= 7) {
      statusText = "⚠️ Perlu Pemantauan: Gerakan janin mendekati batas minimal";
      statusColor = Colors.orange;
    } else if (movementCount >= 4) {
      statusText = "🔶 Perlu Perhatian: Gerakan janin berkurang";
      statusColor = Colors.orange[700]!;
    } else {
      statusText = "🚨 Perhatian Khusus: Gerakan janin sangat berkurang";
      statusColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha:0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.medical_information,
            color: statusColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              statusText,
              style: TextStyle(
                fontSize: 12,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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

  // Helper untuk mendapatkan warna berdasarkan status gerakan janin
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

  // Helper untuk mendapatkan icon berdasarkan status gerakan janin
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

  Widget _buildAnimatedRiskHeader(String riskLevel, int score, Map<String, dynamic> riskData) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            riskData['color'].withValues(alpha:0.15),
            riskData['color'].withValues(alpha:0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: riskData['color'].withValues(alpha:0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon dengan background circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: riskData['color'].withValues(alpha:0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: riskData['color'].withValues(alpha:0.3),
                width: 3,
              ),
            ),
            child: Icon(
              riskData['icon'],
              size: 50,
              color: riskData['color'],
            ),
          ),

          const SizedBox(height: 20),

          // Status risiko dengan badge effect
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: riskData['color'],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: riskData['color'].withValues(alpha:0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              riskResult['riskLevel']?.toString().toUpperCase() ?? 'TIDAK DIKETAHUI',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Total poin dengan design modern
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Total Poin Risiko: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  TextSpan(
                    text: "$score",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: riskData['color'],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Progress bar visual
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: _getRiskProgress(riskLevel),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          riskData['color'],
                          riskData['color'].withValues(alpha:0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10 - _getRiskProgress(riskLevel),
                  child: const SizedBox(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Pesan
          Text(
            riskData['message'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ... (method lainnya tetap sama, seperti _buildAnimatedComplaintEducationSection,
  // _buildAnimatedRiskEducationSection, _buildAnimatedGeneralTipsSection, dll.)

  // Sisanya method tetap sama seperti sebelumnya...
  Widget _buildAnimatedComplaintEducationSection(Map<String, ComplaintEducation> educations, Map<String, dynamic> riskData) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                riskData['color'].withValues(alpha:0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: riskData['color'].withValues(alpha:0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.medical_information, color: riskData['color']),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Edukasi Keluhan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...educations.entries.map((entry) =>
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.value.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: riskData['color'],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  entry.value.tips,
                                  style: const TextStyle(fontSize: 14, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                          if (entry.value.warning.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.warning, size: 16, color: Colors.red),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    entry.value.warning,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    )
                ).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedRiskEducationSection(Map<String, String> riskEducation, Map<String, dynamic> riskData) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                riskData['color'].withValues(alpha:0.05),
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: riskData['color'].withValues(alpha:0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.health_and_safety, color: riskData['color']),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        riskEducation['title'] ?? "Edukasi Risiko",
                        style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (riskEducation['description'] != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      riskEducation['description']!,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                const SizedBox(height: 12),
                if (riskEducation['recommendations'] != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: riskData['color'],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: riskData['color'].withValues(alpha:0.2),
                      ),
                    ),
                    child: Text(
                        riskEducation['recommendations']!,
                        style: whiteTextStyle
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedGeneralTipsSection(List<String> generalTips, Map<String, dynamic> riskData) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                riskData['color'].withValues(alpha:0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: riskData['color'].withValues(alpha:0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.lightbulb_outline, color: riskData['color']),
                    ),
                    const SizedBox(width: 12),
                    Text(
                        "Tips Kehamilan Sehat",
                        style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...generalTips.asMap().entries.map((entry) =>
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (entry.key * 100)),
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: riskData['color'].withValues(alpha:0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 16,
                              color: riskData['color'],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(fontSize: 14, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    )
                ).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernRecommendationCard(String recommendation, Map<String, dynamic> riskData) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              riskData['color'].withValues(alpha:0.08),
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: riskData['color'].withValues(alpha:0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.medical_services, color: riskData['color']),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Rekomendasi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: riskData['color'].withValues(alpha:0.2),
                  ),
                ),
                child: Text(
                  recommendation,
                  style: blackTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedRiskDetailsCard(List<dynamic> details) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha:0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.warning, color: Colors.orange[700]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Faktor Risiko yang Teridentifikasi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...details.asMap().entries.map((entry) =>
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200 + (entry.key * 100)),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha:0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.withValues(alpha:0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.circle, size: 8, color: Colors.red),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.value.toString(),
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  )
              ).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernActionButtons(BuildContext context, Map<String, dynamic> riskData) {
    return Column(
      children: [
        // ✅ TOMBOL SAVE (hanya yang di bawah)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withValues(alpha:0.1),
                Colors.blue.withValues(alpha:0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue, width: 2),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () {
              _showSaveConfirmation(context);
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_alt_rounded),
                SizedBox(width: 8),
                Text(
                  "Simpan Hasil Deteksi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Tombol kembali
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                riskData['color'].withValues(alpha:0.1),
                riskData['color'].withValues(alpha:0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: riskData['color'],
              side: BorderSide(color: riskData['color'], width: 2),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: onBack,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_rounded),
                SizedBox(width: 8),
                Text(
                  "Kembali ke Deteksi Mandiri",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSaveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.blue.withValues(alpha:0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.save_alt_rounded, color: Colors.blue, size: 30),
                ),
                const SizedBox(height: 16),
                Text(
                  "Simpan Hasil Deteksi",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Apakah Anda ingin menyimpan hasil deteksi ini? Hasil akan disimpan dalam riwayat deteksi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          side: const BorderSide(color: Colors.grey),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Batal"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onSave();
                          _showSaveSuccess(context);
                        },
                        child: const Text("Simpan"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSaveSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text("Hasil deteksi berhasil disimpan!"),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Map<String, dynamic> _getRiskData(String riskLevel) {
    switch (riskLevel) {
      case 'risiko tinggi':
      case 'tinggi':
        return {
          'color': Colors.red,
          'icon': Icons.warning_rounded,
          'message': 'Hasil menunjukkan tingkat risiko tinggi. Segera konsultasi dengan dokter kandungan untuk penanganan lebih lanjut.',
          'showEmergency': true,
        };
      case 'perlu perhatian':
      case 'sedang':
        return {
          'color': Colors.orange,
          'icon': Icons.info_rounded,
          'message': 'Hasil menunjukkan tingkat risiko sedang. Perhatikan kondisi dan lakukan pemeriksaan rutin ke dokter kandungan.',
          'showEmergency': false,
        };
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return {
          'color': Colors.green,
          'icon': Icons.check_circle_rounded,
          'message': 'Hasil menunjukkan tingkat risiko rendah. Pertahankan pola hidup sehat dan rutin kontrol kehamilan.',
          'showEmergency': false,
        };
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.help_rounded,
          'message': 'Tidak dapat menentukan tingkat risiko. Silakan coba lagi atau konsultasi dengan dokter.',
          'showEmergency': false,
        };
    }
  }

  int _getRiskProgress(String riskLevel) {
    switch (riskLevel) {
      case 'risiko tinggi':
      case 'tinggi':
        return 8;
      case 'perlu perhatian':
      case 'sedang':
        return 5;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return 2;
      default:
        return 1;
    }
  }
}