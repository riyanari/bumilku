import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';
import 'package:bumilku_app/pages/self_detection/data/complaint_education_data.dart';
import '../../../l10n/app_localizations.dart';

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

  // =========================
  // RISK LOGIC FROM MOVEMENT
  // =========================
  String _riskLevelFromMovementCount(int c) {
    if (c == 0) return 'unknown';
    if (c < 4) return 'risiko tinggi';
    if (c < 7) return 'perlu perhatian';
    if (c < 10) return 'perlu pemantauan';
    return 'normal';
  }

  String _riskLevelLabel(AppLocalizations t, String riskLevel) {
    switch (riskLevel) {
      case 'risiko tinggi':
        return t.riskHigh;
      case 'perlu perhatian':
        return t.riskAttention;
      case 'perlu pemantauan':
        return t.riskMonitoring;
      case 'normal':
        return t.riskNormal;
      default:
        return t.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final details =
    riskResult['details'] is List ? riskResult['details'] as List<String> : [];
    final recommendation =
        riskResult['recommendation']?.toString() ?? t.noSpecificRecommendation;

    final complaintEducations =
    riskResult['complaintEducations'] as Map<String, ComplaintEducation>?;
    final riskEducation = riskResult['riskEducation'] as Map<String, String>?;
    final generalTips = riskResult['generalTips'] as List<String>?;

    // Fetal movement data
    final hasFetalMovementData = riskResult['hasFetalMovementData'] == true;
    final fetalMovementCount = (riskResult['fetalMovementCount'] ?? 0) as int;
    final fetalMovementDuration = (riskResult['fetalMovementDuration'] ?? 0) as int;
    final movementsPerHour = (riskResult['movementsPerHour'] ?? 0.0) as double;

    // Score: use fetal movement count if available, otherwise fallback to riskResult['score']
    final int score = hasFetalMovementData
        ? fetalMovementCount
        : ((riskResult['score'] ?? 0) as int);

    // Safe parse
    final dynamic fetalMovementStatusDynamic = riskResult['fetalMovementStatus'];
    final Map<String, dynamic> fetalMovementStatus =
    _parseFetalMovementStatus(fetalMovementStatusDynamic);

    final movementComparison = riskResult['movementComparison']?.toString() ?? '';
    final fetalActivityPattern = riskResult['fetalActivityPattern']?.toString() ?? '';

    // Risk level: from movementCount if we have movement data, else use raw
    final riskLevelRaw =
        riskResult['riskLevel']?.toString().toLowerCase() ?? 'unknown';
    final riskLevel = hasFetalMovementData
        ? _riskLevelFromMovementCount(fetalMovementCount)
        : riskLevelRaw;

    final riskData = _getRiskData(t, riskLevel);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.selfDetectionResultTitle,
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
            onPressed: () => _showSaveConfirmation(context, t),
            tooltip: t.saveResultTooltip,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              (riskData['color'] as Color).withValues(alpha: 0.1),
              kBackgroundColor.withValues(alpha: 0.3),
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
              _buildAnimatedRiskHeader(
                t: t,
                riskLevel: riskLevel,
                score: score,
                riskData: riskData,
              ),

              const SizedBox(height: 24),

              if (details.isNotEmpty) _buildAnimatedRiskDetailsCard(t, details),

              const SizedBox(height: 16),

              if (hasFetalMovementData)
                _buildFetalMovementSection(
                  t: t,
                  movementCount: fetalMovementCount,
                  durationHours: fetalMovementDuration,
                  movementsPerHour: movementsPerHour,
                  status: fetalMovementStatus,
                  comparison: movementComparison,
                  pattern: fetalActivityPattern,
                ),

              const SizedBox(height: 16),

              _buildModernRecommendationCard(
                t: t,
                recommendation: recommendation,
                riskData: riskData,
              ),

              const SizedBox(height: 16),

              if (riskEducation != null)
                _buildAnimatedRiskEducationSection(t, riskEducation, riskData),

              const SizedBox(height: 16),

              if (complaintEducations != null && complaintEducations.isNotEmpty)
                _buildAnimatedComplaintEducationSection(t, complaintEducations, riskData),

              const SizedBox(height: 16),

              if (generalTips != null)
                _buildAnimatedGeneralTipsSection(t, generalTips, riskData),

              const SizedBox(height: 24),

              _buildModernActionButtons(context, t, riskData),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // SAFE PARSERS
  // =========================
  Map<String, dynamic> _parseFetalMovementStatus(dynamic statusData) {
    if (statusData is Map<String, dynamic>) return statusData;
    if (statusData is Map) return Map<String, dynamic>.from(statusData);

    return {
      'status': 'incomplete',
      'title': 'Data Tercatat',
      'message': 'Data gerakan janin telah tercatat',
      'color': 'grey',
    };
  }

  // =========================
  // FETAL MOVEMENT SECTION
  // =========================
  Widget _buildFetalMovementSection({
    required AppLocalizations t,
    required int movementCount,
    required int durationHours,
    required double movementsPerHour,
    required Map<String, dynamic> status,
    required String comparison,
    required String pattern,
  }) {
    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(t, movementCount);
    final statusMessage = _getFetalMovementMessage(t, movementCount);

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
                statusColor.withValues(alpha: 0.08),
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
                        color: statusColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(statusIcon, color: statusColor, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.fetalMovementRecordTitle,
                        style: blackTextStyle.copyWith(fontSize: 14, fontWeight: bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // status box
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

                Text(
                  t.recordDetailTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),

                _buildFetalMovementDetailItem(
                  t.movementCountLabel,
                  "$movementCount ${t.timesSuffix}",
                ),
                _buildFetalMovementDetailItem(
                  t.recordDurationLabel,
                  "$durationHours ${t.hoursSuffix}",
                ),
                _buildFetalMovementDetailItem(
                  t.movementsPerHourLabel,
                  "${movementsPerHour.toStringAsFixed(1)} ${t.movementsPerHourSuffix}",
                ),
                _buildFetalMovementDetailItem(
                  t.comparisonWithYesterdayLabel,
                  comparison.isNotEmpty ? comparison : t.noData,
                ),
                _buildFetalMovementDetailItem(
                  t.activityPatternLabel,
                  pattern.isNotEmpty ? pattern : t.noData,
                ),

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
                          t.fetalMovementNormalStandard((10 / 12).toStringAsFixed(1)),
                          style: TextStyle(fontSize: 12, color: Colors.blue[700]),
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

  String _getFetalMovementTitle(AppLocalizations t, int movementCount) {
    if (movementCount == 0) return t.fetalMovementIncompleteTitle;
    if (movementCount >= 10) return t.fetalMovementNormalTitle;
    if (movementCount >= 7) return t.fetalMovementMonitoringTitle;
    if (movementCount >= 4) return t.fetalMovementAttentionTitle;
    return t.fetalMovementCriticalTitle;
  }

  String _getFetalMovementMessage(AppLocalizations t, int movementCount) {
    if (movementCount == 0) return t.fetalMovementIncompleteMsg;
    if (movementCount >= 10) return t.fetalMovementNormalMsg(movementCount);
    if (movementCount >= 7) return t.fetalMovementMonitoringMsg(movementCount);
    if (movementCount >= 4) return t.fetalMovementAttentionMsg(movementCount);
    return t.fetalMovementCriticalMsg(movementCount);
  }

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

  Widget _buildFetalMovementDetailItem(String label, String value) {
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
  // HEADER
  // =========================
  Widget _buildAnimatedRiskHeader({
    required AppLocalizations t,
    required String riskLevel,
    required int score,
    required Map<String, dynamic> riskData,
  }) {
    final Color color = riskData['color'] as Color;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3), width: 3),
            ),
            child: Icon(
              riskData['icon'] as IconData,
              size: 50,
              color: color,
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              _riskLevelLabel(t, riskLevel).toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${t.totalRiskPointsLabel} ",
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
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

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
                        colors: [color, color.withValues(alpha: 0.7)],
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

          Text(
            riskData['message'] as String,
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

  // =========================
  // CARDS
  // =========================
  Widget _buildModernRecommendationCard({
    required AppLocalizations t,
    required String recommendation,
    required Map<String, dynamic> riskData,
  }) {
    final Color color = riskData['color'] as Color;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.08),
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
                      color: color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.medical_services, color: color),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    t.recommendationTitle,
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
                  border: Border.all(color: color.withValues(alpha: 0.2)),
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

  Widget _buildAnimatedRiskDetailsCard(AppLocalizations t, List<dynamic> details) {
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
                      color: Colors.orange.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.warning, color: Colors.orange[700]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t.identifiedRiskFactorsTitle,
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
              ...details.asMap().entries.map(
                    (entry) => AnimatedContainer(
                  duration: Duration(milliseconds: 200 + (entry.key * 100)),
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.circle, size: 8, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value.toString(),
                          style: const TextStyle(fontSize: 14, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedComplaintEducationSection(
      AppLocalizations t,
      Map<String, ComplaintEducation> educations,
      Map<String, dynamic> riskData,
      ) {
    final Color color = riskData['color'] as Color;

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
                color.withValues(alpha: 0.03),
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
                        color: color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.medical_information, color: color),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      t.complaintEducationTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...educations.entries.map(
                      (entry) => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
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
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.lightbulb_outline, size: 16, color: Colors.amber),
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
                              const Icon(Icons.warning, size: 16, color: Colors.red),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedRiskEducationSection(
      AppLocalizations t,
      Map<String, String> riskEducation,
      Map<String, dynamic> riskData,
      ) {
    final Color color = riskData['color'] as Color;

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
                color.withValues(alpha: 0.05),
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
                        color: color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.health_and_safety, color: color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        riskEducation['title'] ?? t.riskEducationTitle,
                        style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
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
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.withValues(alpha: 0.2)),
                    ),
                    child: Text(riskEducation['recommendations']!, style: whiteTextStyle),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedGeneralTipsSection(
      AppLocalizations t,
      List<String> generalTips,
      Map<String, dynamic> riskData,
      ) {
    final Color color = riskData['color'] as Color;

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
                color.withValues(alpha: 0.03),
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
                        color: color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.lightbulb_outline, color: color),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      t.healthyPregnancyTipsTitle,
                      style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...generalTips.asMap().entries.map(
                      (entry) => AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (entry.key * 100)),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
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
                            color: color.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.favorite, size: 16, color: color),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // ACTION BUTTONS + DIALOGS
  // =========================
  Widget _buildModernActionButtons(
      BuildContext context,
      AppLocalizations t,
      Map<String, dynamic> riskData,
      ) {
    final Color color = riskData['color'] as Color;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withValues(alpha: 0.1),
                Colors.blue.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue, width: 2),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: () => _showSaveConfirmation(context, t),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.save_alt_rounded),
                const SizedBox(width: 8),
                Text(
                  t.saveDetectionResultButton,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: color,
              side: BorderSide(color: color, width: 2),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: onBack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back_rounded),
                const SizedBox(width: 8),
                Text(
                  t.backToSelfDetectionButton,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSaveConfirmation(BuildContext context, AppLocalizations t) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.withValues(alpha: 0.05)],
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
                    color: Colors.blue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.save_alt_rounded, color: Colors.blue, size: 30),
                ),
                const SizedBox(height: 16),
                Text(
                  t.saveResultDialogTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  t.saveResultDialogMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, height: 1.4),
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
                        child: Text(t.cancel),
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
                          _showSaveSuccess(context, t);
                        },
                        child: Text(t.save),
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

  void _showSaveSuccess(BuildContext context, AppLocalizations t) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(t.saveSuccessSnack),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // =========================
  // RISK DATA + PROGRESS
  // =========================
  Map<String, dynamic> _getRiskData(AppLocalizations t, String riskLevel) {
    switch (riskLevel) {
      case 'risiko tinggi':
      case 'tinggi':
        return {
          'color': Colors.red,
          'icon': Icons.warning_rounded,
          'message': t.riskMsgHigh,
          'showEmergency': true,
        };

      case 'perlu perhatian':
        return {
          'color': Colors.orange,
          'icon': Icons.info_rounded,
          'message': t.riskMsgAttention,
          'showEmergency': false,
        };

      case 'perlu pemantauan':
        return {
          'color': Colors.blue,
          'icon': Icons.timelapse,
          'message': t.riskMsgMonitoring,
          'showEmergency': false,
        };

      case 'normal':
      case 'rendah':
        return {
          'color': Colors.green,
          'icon': Icons.check_circle_rounded,
          'message': t.riskMsgNormal,
          'showEmergency': false,
        };

      default:
        return {
          'color': Colors.grey,
          'icon': Icons.help_rounded,
          'message': t.riskMsgUnknown,
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
        return 5;
      case 'perlu pemantauan':
        return 4;
      case 'normal':
      case 'rendah':
        return 2;
      default:
        return 1;
    }
  }
}
