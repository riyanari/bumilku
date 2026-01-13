import 'package:bumilku_app/pages/self_detection/data/pregnancy_tips_data.dart';
import 'package:bumilku_app/pages/self_detection/pregnancy_education_data.dart';
import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../cubit/self_detection_cubit.dart';
import '../../models/self_detection_model.dart';

class DetailHistoryPage extends StatelessWidget {
  final SelfDetectionModel detection;

  const DetailHistoryPage({super.key, required this.detection});

  // =========================
  // SIMPLE I18N (EN/ID)
  // =========================
  bool _isEn(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  String t(BuildContext context, {required String id, required String en}) =>
      _isEn(context) ? en : id;

  // =========================
  // RULE RISK dari GERAKAN JANIN (INTERNAL KEY: ID)
  // =========================
  String _riskLevelFromMovementCount(int c) {
    if (c == 0) return 'unknown';
    if (c < 4) return 'risiko tinggi';
    if (c < 7) return 'perlu perhatian';
    if (c < 10) return 'perlu pemantauan';
    return 'normal';
  }

  String _resolveRiskLevel({
    required bool hasFetalMovementData,
    required int fetalMovementCount,
  }) {
    if (hasFetalMovementData && fetalMovementCount > 0) {
      return _riskLevelFromMovementCount(fetalMovementCount);
    }
    return detection.riskLevel.toLowerCase();
  }

  int _resolveScore({
    required bool hasFetalMovementData,
    required int fetalMovementCount,
  }) {
    if (hasFetalMovementData && fetalMovementCount > 0)
      return fetalMovementCount;
    return detection.score;
  }

  // =========================
  // RISK TEXT (DISPLAY) EN/ID
  // internal riskLevel tetap ID untuk mapping
  // =========================
  String riskLevelText(BuildContext context, String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return t(context, id: 'Risiko Tinggi', en: 'High Risk');
      case 'perlu perhatian':
      case 'sedang':
        return t(context, id: 'Perlu Perhatian', en: 'Needs Attention');
      case 'perlu pemantauan':
        return t(context, id: 'Perlu Pemantauan', en: 'Needs Monitoring');
      case 'normal':
      case 'rendah':
      case 'kehamilan normal':
        return t(context, id: 'Normal', en: 'Normal');
      default:
        return t(context, id: 'Tidak Diketahui', en: 'Unknown');
    }
  }

  String riskStatusText(BuildContext context, String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return t(context, id: 'Perlu Penanganan', en: 'Needs Immediate Care');
      case 'perlu perhatian':
      case 'sedang':
        return t(context, id: 'Perlu Perhatian', en: 'Needs Attention');
      case 'perlu pemantauan':
        return t(context, id: 'Perlu Pemantauan', en: 'Needs Monitoring');
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return t(context, id: 'Aman', en: 'Safe');
      default:
        return t(context, id: 'Tidak Diketahui', en: 'Unknown');
    }
  }

  // =========================
  // COLOR/ICON berdasarkan riskLevel internal (ID)
  // =========================
  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return Colors.red;
      case 'perlu perhatian':
      case 'sedang':
        return Colors.orange;
      case 'perlu pemantauan':
        return Colors.blue;
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
      case 'perlu pemantauan':
        return Icons.timelapse;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return Icons.check_circle_rounded;
      default:
        return Icons.help_rounded;
    }
  }

  // =========================
  // FETAL MOVEMENT HELPERS (DISPLAY EN/ID)
  // =========================
  Color _getFetalMovementColorFromCount(int movementCount) {
    if (movementCount == 0) return Colors.grey;
    if (movementCount >= 10) return Colors.green;
    if (movementCount >= 7) return Colors.blue;
    if (movementCount >= 4) return Colors.orange;
    return Colors.red;
  }

  IconData _getFetalMovementIconFromCount(int movementCount) {
    if (movementCount == 0) return Icons.hourglass_empty;
    if (movementCount >= 10) return Icons.check_circle;
    if (movementCount >= 7) return Icons.timelapse;
    if (movementCount >= 4) return Icons.info;
    return Icons.warning;
  }

  String _getFetalMovementTitle(BuildContext context, int movementCount) {
    if (movementCount == 0)
      return t(context, id: "Data Belum Lengkap", en: "Incomplete Data");
    if (movementCount >= 10)
      return t(context, id: "Kondisi Normal", en: "Normal Condition");
    if (movementCount >= 7)
      return t(context, id: "Perlu Pemantauan", en: "Needs Monitoring");
    if (movementCount >= 4)
      return t(context, id: "Perlu Perhatian", en: "Needs Attention");
    return t(context, id: "Perhatian Khusus", en: "Urgent Attention");
  }

  String _getFetalMovementMessage(
    BuildContext context,
    int movementCount,
    double movementsPerHour,
  ) {
    if (movementCount == 0) {
      return t(
        context,
        id: "Data gerakan janin belum lengkap. Silakan lengkapi pencatatan.",
        en: "Fetal movement data is incomplete. Please complete the record.",
      );
    }

    if (movementCount >= 10) {
      return t(
        context,
        id: "Gerakan janin dalam batas normal ($movementCount gerakan dalam 12 jam).",
        en: "Fetal movement is within normal range ($movementCount movements in 12 hours).",
      );
    }

    if (movementCount >= 7) {
      return t(
        context,
        id: "Gerakan janin $movementCount kali dalam 12 jam. Tetap pantau secara rutin dan perhatikan perubahan gerakan.",
        en: "Fetal movement is $movementCount times in 12 hours. Keep monitoring and watch for changes.",
      );
    }

    if (movementCount >= 4) {
      return t(
        context,
        id: "Gerakan janin $movementCount kali dalam 12 jam. Disarankan konsultasi dengan tenaga kesehatan.",
        en: "Fetal movement is $movementCount times in 12 hours. Consider consulting a healthcare provider.",
      );
    }

    return t(
      context,
      id: "Gerakan janin hanya $movementCount kali dalam 12 jam. Segera hubungi tenaga kesehatan.",
      en: "Fetal movement is only $movementCount times in 12 hours. Contact a healthcare provider immediately.",
    );
  }

  @override
  Widget build(BuildContext context) {
    // Locale untuk format tanggal
    final locale = Localizations.localeOf(context).toString(); // id_ID / en_US
    final displayDate = detection.createdAt ?? detection.date;
    final formattedDate = DateFormat(
      'EEEE, dd MMMM yyyy HH:mm',
      locale,
    ).format(displayDate);

    // DATA GERAKAN JANIN
    final hasFetalMovementData = detection.hasFetalMovementData == true;
    final fetalMovementCount = detection.fetalMovementCount ?? 0;
    final fetalMovementDuration = detection.fetalMovementDuration ?? 0;
    final movementsPerHour = detection.movementsPerHour ?? 0.0;
    final movementComparison = detection.movementComparison?.toString() ?? '';
    final fetalActivityPattern =
        detection.fetalActivityPattern?.toString() ?? '';
    final fetalAdditionalComplaints = detection.fetalAdditionalComplaints ?? [];

    // RESOLVED (internal key)
    final resolvedRiskLevel = _resolveRiskLevel(
      hasFetalMovementData: hasFetalMovementData,
      fetalMovementCount: fetalMovementCount,
    );
    final resolvedScore = _resolveScore(
      hasFetalMovementData: hasFetalMovementData,
      fetalMovementCount: fetalMovementCount,
    );

    final riskColor = _getRiskColor(resolvedRiskLevel);

    // ambil edu risk (EN/ID) berdasarkan resolvedRiskLevel
    final riskEdu = PregnancyEducationData.getRiskEducation(
      context,
      resolvedRiskLevel,
    );

    final tips = PregnancyEducationData.getGeneralTips(context);

    // kalau EN, pakai recommendation dari PregnancyEducationData
    // kalau ID, pakai dari detection (biar sesuai output deteksi lokal kamu)
    final recommendationText = _isEn(context)
        ? (riskEdu["recommendations"] ?? detection.recommendation)
        : detection.recommendation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(context, id: "Detail Deteksi", en: "Detection Detail"),
          style: const TextStyle(
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
            tooltip: t(context, id: "Hapus Riwayat", en: "Delete History"),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              riskColor.withValues(alpha: 0.05),
              kBackgroundColor.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeaderCard(
                context: context,
                riskColor: riskColor,
                formattedDate: formattedDate,
                resolvedRiskLevel: resolvedRiskLevel,
                resolvedScore: resolvedScore,
              ),

              const SizedBox(height: 20),

              if (hasFetalMovementData) ...[
                _buildFetalMovementSection(
                  context: context,
                  movementCount: fetalMovementCount,
                  duration: fetalMovementDuration,
                  movementsPerHour: movementsPerHour,
                  comparison: movementComparison,
                  pattern: fetalActivityPattern,
                  additionalComplaints: fetalAdditionalComplaints,
                ),
                const SizedBox(height: 16),
              ],

              _buildSectionCard(
                title: t(
                  context,
                  id: "Informasi Risiko",
                  en: "Risk Information",
                ),
                icon: Icons.assessment,
                color: kPrimaryColor,
                children: [
                  _buildDetailItem(
                    label: t(context, id: "Tingkat Risiko", en: "Risk Level"),
                    value: riskLevelText(
                      context,
                      resolvedRiskLevel,
                    ).toUpperCase(),
                    valueColor: riskColor,
                  ),
                  _buildDetailItem(
                    label: hasFetalMovementData
                        ? t(context, id: "Gerakan Janin", en: "Fetal Movements")
                        : t(context, id: "Skor", en: "Score"),
                    value: "$resolvedScore",
                  ),
                  _buildDetailItem(
                    label: t(context, id: "Status", en: "Status"),
                    value: riskStatusText(context, resolvedRiskLevel),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _buildSectionCard(
                title: t(context, id: "Rekomendasi", en: "Recommendation"),
                icon: Icons.recommend,
                color: Colors.green,
                children: [
                  ..._buildMultilineBullets(
                    context,
                    recommendationText,
                    // kalau string sudah pakai "•", kita render jadi bullet UI
                  ),
                ],
              ),

              if (detection.details.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: t(context, id: "Detail Temuan", en: "Findings Detail"),
                  icon: Icons.list,
                  color: Colors.orange,
                  children: detection.details.map((detail) {
                    final key = detail.toString().trim();

                    // coba ambil edukasi bilingual berdasarkan key Indonesia
                    final edu = PregnancyEducationData.getEducationByComplaint(
                      context,
                      key,
                    );

                    // kalau ketemu, tampilkan title sesuai bahasa
                    // kalau tidak, fallback tampilkan as-is
                    final display = edu != null ? (edu["title"] ?? key) : key;

                    return _buildBulletItem(display);
                  }).toList(),
                ),
              ],

              if (detection.riskEducation != null &&
                  detection.riskEducation!['description'] != null) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: t(context, id: "Edukasi Risiko", en: "Risk Education"),
                  icon: Icons.school,
                  color: Colors.blue,
                  children: [
                    _buildDetailItem(label: "", value: riskEdu["title"] ?? ""),
                    const SizedBox(height: 8),
                    _buildDetailItem(
                      label: "",
                      value: riskEdu["description"] ?? "",
                    ),
                  ],
                ),
              ],

              if (tips.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildSectionCard(
                  title: t(
                    context,
                    id: "Tips Kehamilan Sehat",
                    en: "Healthy Pregnancy Tips",
                  ),
                  icon: Icons.lightbulb_outline,
                  color: Colors.amber,
                  children: PregnancyTipsData.getTips(context)
                      .map((tip) => _buildBulletItem("❤️ $tip"))
                      .toList(),
                ),
              ],

              const SizedBox(height: 30),
              _buildDeleteButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // FETAL MOVEMENT UI
  // =========================
  Widget _buildFetalMovementSection({
    required BuildContext context,
    required int movementCount,
    required int duration,
    required double movementsPerHour,
    required String comparison,
    required String pattern,
    required List<dynamic> additionalComplaints,
  }) {
    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(context, movementCount);
    final statusMessage = _getFetalMovementMessage(
      context,
      movementCount,
      movementsPerHour,
    );

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite, size: 20, color: statusColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t(
                      context,
                      id: "Hasil Pencatatan Gerakan Janin",
                      en: "Fetal Movement Record Result",
                    ),
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

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(statusIcon, size: 20, color: statusColor),
                      const SizedBox(width: 8),
                      Text(
                        statusTitle.toUpperCase(),
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
                    statusMessage,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Text(
              t(context, id: "Detail Pencatatan:", en: "Record Details:"),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),

            _buildFetalMovementDetailItem(
              context,
              t(context, id: "Jumlah Gerakan", en: "Total Movements"),
              t(context, id: "$movementCount kali", en: "$movementCount times"),
            ),
            _buildFetalMovementDetailItem(
              context,
              t(context, id: "Durasi Pencatatan", en: "Recording Duration"),
              t(context, id: "$duration jam", en: "$duration hours"),
            ),
            _buildFetalMovementDetailItem(
              context,
              t(context, id: "Gerakan per Jam", en: "Movements per Hour"),
              t(
                context,
                id: "${movementsPerHour.toStringAsFixed(1)} gerakan/jam",
                en: "${movementsPerHour.toStringAsFixed(1)} movements/hour",
              ),
            ),
            _buildFetalMovementDetailItem(
              context,
              t(
                context,
                id: "Perbandingan dengan Kemarin",
                en: "Compared to Yesterday",
              ),
              comparison.isNotEmpty
                  ? comparison
                  : t(context, id: "Tidak ada data", en: "No data"),
            ),
            _buildFetalMovementDetailItem(
              context,
              t(context, id: "Pola Aktivitas", en: "Activity Pattern"),
              pattern.isNotEmpty
                  ? pattern
                  : t(context, id: "Tidak ada data", en: "No data"),
            ),

            if (additionalComplaints.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildFetalMovementDetailItem(
                context,
                t(context, id: "Keluhan Tambahan", en: "Additional Complaints"),
                additionalComplaints.join(', '),
              ),
            ],

            const SizedBox(height: 12),

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
                      t(
                        context,
                        id: "Standar normal: minimal 10 gerakan dalam 12 jam (${(10 / 12).toStringAsFixed(1)} gerakan/jam)",
                        en: "Normal standard: at least 10 movements in 12 hours (${(10 / 12).toStringAsFixed(1)} movements/hour)",
                      ),
                      style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            _buildFetalMovementStatusInfo(context, movementCount),
          ],
        ),
      ),
    );
  }

  Widget _buildFetalMovementStatusInfo(
    BuildContext context,
    int movementCount,
  ) {
    String statusText;
    Color statusColor;

    if (movementCount >= 10) {
      statusText = t(
        context,
        id: "✅ Normal: Gerakan janin dalam batas normal",
        en: "✅ Normal: Fetal movements are within normal range",
      );
      statusColor = Colors.green;
    } else if (movementCount >= 7) {
      statusText = t(
        context,
        id: "⚠️ Perlu Pemantauan: Gerakan janin mendekati batas minimal",
        en: "⚠️ Needs Monitoring: Movements are close to the minimum threshold",
      );
      statusColor = Colors.orange;
    } else if (movementCount >= 4) {
      statusText = t(
        context,
        id: "🔶 Perlu Perhatian: Gerakan janin berkurang",
        en: "🔶 Needs Attention: Fetal movements are reduced",
      );
      statusColor = Colors.orange[700]!;
    } else {
      statusText = t(
        context,
        id: "🚨 Perhatian Khusus: Gerakan janin sangat berkurang",
        en: "🚨 Urgent Attention: Fetal movements are very low",
      );
      statusColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.medical_information, color: statusColor, size: 16),
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

  Widget _buildFetalMovementDetailItem(
    BuildContext context,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: blackTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),
          ),
        ],
      ),
    );
  }

  // =========================
  // HEADER CARD (resolved + EN/ID)
  // =========================
  Widget _buildHeaderCard({
    required BuildContext context,
    required Color riskColor,
    required String formattedDate,
    required String resolvedRiskLevel,
    required int resolvedScore,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              riskColor.withValues(alpha: 0.1),
              riskColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getRiskIcon(resolvedRiskLevel),
                  size: 40,
                  color: riskColor,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                riskLevelText(context, resolvedRiskLevel).toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                formattedDate,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(
                    title: t(
                      context,
                      id: "Gerakan Janin",
                      en: "Fetal Movements",
                    ),
                    value: "$resolvedScore",
                    icon: Icons.assessment,
                  ),
                  _buildInfoItem(
                    title: t(context, id: "Status", en: "Status"),
                    value: riskStatusText(context, resolvedRiskLevel),
                    icon: Icons.info,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // SECTION HELPERS
  // =========================
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
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
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    if (label.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(value, style: const TextStyle(fontSize: 14, height: 1.4)),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: valueColor,
                fontWeight: valueColor != null
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
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

  Widget _buildInfoItem({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24, color: kPrimaryColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // =========================
  // DELETE UI (EN/ID)
  // =========================
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete_outline),
            const SizedBox(width: 8),
            Text(t(context, id: "Hapus Riwayat Ini", en: "Delete This Record")),
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
      title: t(context, id: "Hapus Riwayat", en: "Delete Record"),
      desc: t(
        context,
        id: "Apakah Anda yakin ingin menghapus riwayat deteksi ini?\nTindakan ini tidak dapat dibatalkan.",
        en: "Are you sure you want to delete this detection record?\nThis action cannot be undone.",
      ),
      btnCancelText: t(context, id: "Batal", en: "Cancel"),
      btnOkText: t(context, id: "Hapus", en: "Delete"),
      btnCancelOnPress: () {},
      btnOkOnPress: () => _deleteDetection(context),
      btnCancelColor: kPrimaryColor,
      btnOkColor: Colors.red,
    ).show();
  }

  void _deleteDetection(BuildContext context) {
    context.read<SelfDetectionCubit>().deleteDetection(detection.id);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              t(
                context,
                id: "Riwayat berhasil dihapus!",
                en: "Record deleted successfully!",
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<Widget> _buildMultilineBullets(BuildContext context, String text) {
    final lines = text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // kalau bukan bullet text, tampilkan biasa
    final hasBullets = lines.any((l) => l.startsWith('•') || l.startsWith('-'));

    if (!hasBullets) {
      return [_buildDetailItem(label: "", value: text)];
    }

    return lines.map((line) {
      var clean = line;
      if (clean.startsWith('•')) clean = clean.substring(1).trim();
      if (clean.startsWith('-')) clean = clean.substring(1).trim();
      return _buildBulletItem(clean);
    }).toList();
  }
}
