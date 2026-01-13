import 'package:bumilku_app/cubit/self_detection_cubit.dart';
import 'package:bumilku_app/models/self_detection_model.dart';
import 'package:bumilku_app/pages/self_detection/detail_history_page.dart';
import 'package:bumilku_app/pages/self_detection/self_detection_page.dart';
import 'package:bumilku_app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bumilku_app/models/user_model.dart';
import 'package:bumilku_app/services/user_services.dart';

import '../../l10n/app_localizations.dart';

class DetectionHistoryPage extends StatefulWidget {
  const DetectionHistoryPage({super.key});

  @override
  State<DetectionHistoryPage> createState() => _DetectionHistoryPageState();
}

class _DetectionHistoryPageState extends State<DetectionHistoryPage> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  UserModel? _currentUserData;
  bool _isLoadingUser = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    if (_currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<SelfDetectionCubit>().getDetectionHistory(_currentUser.uid);
      });
    }
  }

  Future<void> _loadUserData() async {
    if (_currentUser != null) {
      try {
        final userData = await UserServices().getUserById(_currentUser.uid);
        setState(() {
          _currentUserData = userData;
          _isLoadingUser = false;
        });
      } catch (e) {
        // ignore: avoid_print
        print('Error loading user data: $e');
        setState(() => _isLoadingUser = false);
      }
    } else {
      setState(() => _isLoadingUser = false);
    }
  }

  // =========================
  // RISK RULE (SAMA SEPERTI RESULT PAGE)
  // =========================
  String _riskLevelFromMovementCount(int c) {
    if (c == 0) return 'unknown';
    if (c < 4) return 'risiko tinggi';
    if (c < 7) return 'perlu perhatian';
    if (c < 10) return 'perlu pemantauan';
    return 'normal';
  }

  /// Ambil fetalMovementCount dari model secara aman.
  int _getFetalMovementCount(SelfDetectionModel detection) {
    // 1) Kalau SelfDetectionModel kamu memang punya field ini:
    // return detection.fetalMovementCount ?? 0;

    // 2) Kalau datanya disimpan di map/json:
    try {
      final dynamic json = (detection as dynamic).toJson?.call();
      if (json is Map && json['fetalMovementCount'] != null) {
        final v = json['fetalMovementCount'];
        if (v is int) return v;
        return int.tryParse(v.toString()) ?? 0;
      }
    } catch (_) {}

    // 3) Fallback: coba akses dynamic property langsung
    try {
      final v = (detection as dynamic).fetalMovementCount;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    } catch (_) {}

    return 0;
  }

  /// Tentukan riskLevel yang dipakai UI:
  /// - Kalau ada fetalMovementCount > 0 -> gunakan aturan movementCount
  /// - Kalau tidak ada -> gunakan riskLevel lama
  String _resolveRiskLevel(SelfDetectionModel detection) {
    final c = _getFetalMovementCount(detection);
    if (c > 0) return _riskLevelFromMovementCount(c);
    return detection.riskLevel.toLowerCase();
  }

  int _resolveRiskScore(SelfDetectionModel detection) {
    final c = _getFetalMovementCount(detection);
    return c > 0 ? c : detection.score;
  }

  // Hitung umur dari tanggal lahir
  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

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

  String _riskLevelLabel(BuildContext context, String riskLevel) {
    final t = AppLocalizations.of(context)!;
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return t.riskLevelHigh;
      case 'perlu perhatian':
      case 'sedang':
        return t.riskLevelNeedAttention;
      case 'perlu pemantauan':
        return t.riskLevelNeedMonitoring;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return t.riskLevelNormal;
      default:
        return t.riskLevelUnknown;
    }
  }

  String _getRiskStatusLabel(BuildContext context, String riskLevel) {
    final t = AppLocalizations.of(context)!;
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return t.riskStatusNeedsTreatment;
      case 'perlu perhatian':
      case 'sedang':
        return t.riskStatusNeedsAttention;
      case 'perlu pemantauan':
        return t.riskStatusNeedsMonitoring;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return t.riskStatusSafe;
      default:
        return t.riskStatusUnknown;
    }
  }

  void _navigateToDetail(BuildContext context, SelfDetectionModel detection) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailHistoryPage(detection: detection),
      ),
    );
  }

  Widget _buildUserProfileHeader(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    if (_isLoadingUser) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 120, height: 16, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  Container(width: 80, height: 12, color: Colors.grey[300]),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (_currentUserData == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
              child: Icon(Icons.person, size: 30, color: kPrimaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.historyUserDataUnavailable,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.historyPleaseRelogin,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final user = _currentUserData!;
    final age = _calculateAge(user.tglLahir);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: kPrimaryColor.withValues(alpha: 0.1),
            child: Icon(Icons.person, size: 30, color: kPrimaryColor),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.cake, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      t.historyAgeYears(age),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        user.alamat,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              user.role,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.historyTitle,
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kPrimaryColor.withValues(alpha: 0.05),
              kBackgroundColor.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildUserProfileHeader(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.history, color: kPrimaryColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    t.historySectionTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: BlocBuilder<SelfDetectionCubit, SelfDetectionState>(
                builder: (context, state) {
                  if (state is SelfDetectionLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    );
                  }

                  if (state is SelfDetectionFailed) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                          const SizedBox(height: 16),
                          Text(
                            t.historyErrorTitle,
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.error,
                            style: primaryTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (_currentUser != null) {
                                context
                                    .read<SelfDetectionCubit>()
                                    .getDetectionHistory(_currentUser.uid);
                              }
                            },
                            child: Text(t.historyRetry),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SelfDetectionHistoryLoaded) {
                    final history = state.detectionHistory;

                    if (history.isEmpty) {
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
                                  t.historyEmptyTitle,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  t.historyEmptySubtitle,
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
                                      MaterialPageRoute(
                                        builder: (_) => SelfDetectionPageView(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: Text(
                                    t.historyStartDetectionNow,
                                    style: const TextStyle(
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
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        final detection = history[index];

                        // ✅ riskLevel di history pakai movementCount (kalau ada)
                        final resolvedRiskLevel = _resolveRiskLevel(detection);
                        final riskLabel = _riskLevelLabel(context, resolvedRiskLevel);

                        final displayDate = detection.createdAt ?? detection.date;
                        final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(displayDate);

                        final riskColor = _getRiskColor(resolvedRiskLevel);
                        final resolvedScore = _resolveRiskScore(detection);

                        return GestureDetector(
                          onTap: () => _navigateToDetail(context, detection),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: riskColor.withValues(alpha: 0.1),
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
                                          _getRiskIcon(resolvedRiskLevel),
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
                                              riskLabel.toUpperCase(),
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

                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildInfoItem(
                                        t.historyFetalMovementLabel,
                                        "$resolvedScore",
                                        Icons.assessment,
                                      ),
                                      _buildInfoItem(
                                        t.historyDetailLabel,
                                        t.historyDetailCount(detection.details.length),
                                        Icons.list,
                                      ),
                                      _buildInfoItem(
                                        t.historyStatusLabel,
                                        _getRiskStatusLabel(context, resolvedRiskLevel),
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
                  }

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: kPrimaryColor),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
