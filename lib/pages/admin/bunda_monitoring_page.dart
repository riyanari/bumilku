import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bumilku_app/models/user_model.dart';
import 'package:bumilku_app/cubit/medis_cubit.dart';
import 'package:bumilku_app/cubit/self_detection_cubit.dart';

import '../../l10n/app_localizations.dart';
import '../../models/medis_model.dart';
import '../../models/self_detection_model.dart';
import '../../services/medis_service.dart';
import '../../services/self_detection_service.dart';

class BundaMonitoringPage extends StatefulWidget {
  final UserModel bunda;

  const BundaMonitoringPage({super.key, required this.bunda});

  @override
  State<BundaMonitoringPage> createState() => _BundaMonitoringPageState();
}

class _BundaMonitoringPageState extends State<BundaMonitoringPage> {
  int _selectedTab = 0;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<MedisCubit>().getUserMedis(widget.bunda.id);
    context.read<SelfDetectionCubit>().getDetectionHistory(widget.bunda.id);
  }

  Future<void> _confirmDeleteBunda() async {
    final t = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(t.deleteBundaTitle),
        content: Text(t.deleteBundaMessage(widget.bunda.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _deleteBundaAndAllData();
    }
  }

  Future<void> _deleteBundaAndAllData() async {
    final t = AppLocalizations.of(context)!;

    setState(() => _isDeleting = true);

    try {
      final userId = widget.bunda.id;

      // ✅ ambil semua doc yang mau dihapus
      final medisDocs = await MedisServices().getMedisDocRefsByUserId(userId);
      final detectionDocs = await SelfDetectionService().getDetectionDocRefsByUserId(userId);
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

      // ✅ hapus pakai batch (limit 500 operasi per batch)
      await _commitBatchesDelete([
        userRef,
        ...medisDocs,
        ...detectionDocs,
      ]);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.deleteSuccess)),
      );

      // balik ke ListBundaPage
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.deleteFailed(e.toString()))),
      );
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  /// ✅ Helper: Firestore batch max 500 operasi.
  /// Kalau data banyak, otomatis pecah jadi beberapa batch.
  Future<void> _commitBatchesDelete(List<DocumentReference> refs) async {
    final db = FirebaseFirestore.instance;

    const limit = 450; // amanin di bawah 500
    for (int i = 0; i < refs.length; i += limit) {
      final chunk = refs.sublist(i, (i + limit > refs.length) ? refs.length : i + limit);
      final batch = db.batch();
      for (final ref in chunk) {
        batch.delete(ref);
      }
      await batch.commit();
    }
  }

  Widget _appBarIcon({
    required IconData icon,
    required String tooltip,
    VoidCallback? onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Icon(icon, size: 22),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          t.monitoringTitle(widget.bunda.name), // "Monitoring {name}"
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                _appBarIcon(
                  icon: Icons.refresh,
                  tooltip: t.refreshDataTooltip,
                  onTap: _loadData,
                ),
                _appBarIcon(
                  icon: Icons.delete_outline,
                  tooltip: t.deleteTooltip,
                  onTap: _isDeleting ? null : _confirmDeleteBunda,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildBundaHeader(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTabButton(0, t.tabDevelopment, Icons.pregnant_woman),
                _buildTabButton(1, t.tabSelfDetection, Icons.analytics_outlined),
              ],
            ),
          ),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  Widget _buildBundaHeader() {
    final t = AppLocalizations.of(context)!;
    final age = _calculateAge(widget.bunda.tglLahir);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pink.shade100, Colors.purple.shade100],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink.shade200, Colors.pink.shade400],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                _getInitials(widget.bunda.name),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bunda.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "@${widget.bunda.email}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    _buildInfoChip(
                      Icons.cake_outlined,
                      t.ageYears(age), // "{age} tahun" / "{age} years"
                    ),
                    _buildInfoChip(
                      Icons.calendar_today_outlined,
                      DateFormat('dd/MM/yyyy').format(widget.bunda.tglLahir),
                    ),
                    _buildInfoChip(
                      Icons.location_on_outlined,
                      widget.bunda.alamat,
                      isLong: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, {bool isLong = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.pink),
          const SizedBox(width: 4),
          SizedBox(
            width: isLong ? 120 : null,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(int tabIndex, String title, IconData icon) {
    final isSelected = _selectedTab == tabIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = tabIndex),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink.shade400, Colors.pink.shade600],
            )
                : null,
            color: isSelected ? null : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? Colors.white : Colors.grey.shade400,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildPerkembanganTab();
      case 1:
        return _buildSelfDetectionTab();
      default:
        return _buildPerkembanganTab();
    }
  }

  Widget _buildPerkembanganTab() {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<MedisCubit, MedisState>(
      builder: (context, state) {
        if (state is MedisLoading) {
          return _buildLoadingState(t.loadingPregnancyData);
        }

        if (state is MedisFailed) {
          return _buildErrorState(state.error, _loadData);
        }

        if (state is MedisSuccess) {
          final activeMedis = state.activeMedis;
          final medisHistory = state.medisHistory;

          if (medisHistory.isEmpty) {
            return _buildEmptyState(
              Icons.pregnant_woman_outlined,
              t.noPregnancyDataTitle,
              t.noPregnancyDataSubtitle,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: medisHistory.length,
            itemBuilder: (context, index) {
              final medis = medisHistory[index];
              final isActive = medis.id == activeMedis?.id;
              return _buildPregnancyCard(medis, index, isActive);
            },
          );
        }

        return _buildLoadingState(t.loadingDataGeneric);
      },
    );
  }

  Widget _buildPregnancyCard(MedisModel medis, int index, bool isActive) {
    final t = AppLocalizations.of(context)!;

    final now = DateTime.now();
    final gestationalAge = _calculateGestationalAge(medis.selectedLmp, now);
    final weeks = gestationalAge ~/ 7;
    final days = gestationalAge % 7;
    final trimester = _getTrimester(gestationalAge);
    final daysToEdd = medis.edd.difference(now).inDays;
    final progressPercentage = (gestationalAge / 280).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, isActive ? Colors.pink.shade50 : Colors.grey.shade100],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: isActive
                    ? [Colors.pink, Colors.pinkAccent]
                    : [Colors.grey, Colors.grey.shade600],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isActive ? Icons.pregnant_woman : Icons.history,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.pregnancyNumber(index + 1), // "Kehamilan {n}" / "Pregnancy {n}"
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        isActive ? t.activePregnancy : t.pregnancyHistory,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.favorite, size: 14, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          t.activeLabel.toUpperCase(), // "AKTIF" / "ACTIVE"
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoGrid(medis),
                const SizedBox(height: 10),
                _buildProgressSection(
                  gestationalAge,
                  weeks,
                  days,
                  trimester,
                  daysToEdd,
                  progressPercentage,
                ),
                const SizedBox(height: 10),
                _buildTimelineSection(gestationalAge),
                const SizedBox(height: 16),
                _buildCardFooter(medis.createdAt, isActive),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGrid(MedisModel medis) {
    final t = AppLocalizations.of(context)!;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2,
      children: [
        _buildInfoCard(
          t.babyNameLabel, // "👶 Nama Bayi"
          medis.babyName ?? t.babyNameNotSet, // "Belum diberi nama"
          Colors.blue,
        ),
        _buildInfoCard(
          t.lmpLabel, // "📅 HPHT"
          DateFormat('dd/MM/yyyy').format(medis.selectedLmp),
          Colors.green,
        ),
        _buildInfoCard(
          t.eddLabel, // "🎯 Perkiraan Lahir"
          DateFormat('dd/MM/yyyy').format(medis.edd),
          Colors.orange,
        ),
        _buildInfoCard(
          t.cycleLabel, // "🔄 Siklus"
          t.cycleDaysValue(medis.cycleLength), // "{n} hari" / "{n} days"
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(
      int gestationalAge,
      int weeks,
      int days,
      String trimester,
      int daysToEdd,
      double progressPercentage,
      ) {
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.purple.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: Colors.blue.shade700, size: 22),
              const SizedBox(width: 8),
              Text(
                t.pregnancyProgressTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  Container(
                    height: 14,
                    width: constraints.maxWidth * progressPercentage,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getTrimesterColor(trimester),
                          _getTrimesterColor(trimester).withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(progressPercentage * 100).toStringAsFixed(1)}%",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                t.trimesterWithValue(trimester), // "Trimester {x}" / "Trimester {x}"
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _getTrimesterColor(trimester),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                t.gestationalAgeLabel,
                t.gestationalAgeValue(weeks, days), // "{w} minggu {d} hari" / "{w} weeks {d} days"
                Icons.calendar_today,
                Colors.blue,
              ),
              _buildStatItem(
                t.daysToBirthLabel,
                t.daysValue(daysToEdd), // "{n} hari" / "{n} days"
                Icons.celebration,
                daysToEdd <= 30 ? Colors.red : Colors.orange,
              ),
              _buildStatItem(
                t.trimesterLabel,
                trimester,
                Icons.auto_awesome,
                _getTrimesterColor(trimester),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection(int gestationalAge) {
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline_outlined, color: Colors.green.shade700, size: 22),
              const SizedBox(width: 8),
              Text(
                t.timelineTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTimelineItem(t.trimester1, t.weekRange1_13, gestationalAge <= 91),
          _buildTimelineItem(t.trimester2, t.weekRange14_27, gestationalAge > 91 && gestationalAge <= 189),
          _buildTimelineItem(t.trimester3, t.weekRange28_40, gestationalAge > 189),
        ],
      ),
    );
  }

  Widget _buildCardFooter(DateTime createdAt, bool isActive) {
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.update, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.dataCreatedAt(DateFormat('dd/MM/yyyy HH:mm').format(createdAt)),
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ),
          if (isActive) const Icon(Icons.star, size: 14, color: Colors.amber),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimelineItem(String phase, String weeks, bool isCurrent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isCurrent ? Colors.green : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              phase,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCurrent ? Colors.green.shade700 : Colors.grey.shade600,
              ),
            ),
          ),
          Text(
            weeks,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildSelfDetectionTab() {
    final t = AppLocalizations.of(context)!;

    return BlocBuilder<SelfDetectionCubit, SelfDetectionState>(
      builder: (context, state) {
        if (state is SelfDetectionLoading) {
          return _buildLoadingState(t.loadingDetectionHistory);
        }

        if (state is SelfDetectionFailed) {
          return _buildErrorState(state.error, _loadData);
        }

        if (state is SelfDetectionHistoryLoaded) {
          final history = state.detectionHistory;

          final fetalMovementDetections = history
              .where((d) => d.hasFetalMovementData == true)
              .toList();

          fetalMovementDetections.sort((a, b) {
            final dateA = a.createdAt ?? a.date;
            final dateB = b.createdAt ?? b.date;
            return dateB.compareTo(dateA);
          });

          final allItems = <Widget>[
            _buildSectionHeader(t.fetalMovementMonitoringHeader),
            if (fetalMovementDetections.isNotEmpty)
              _buildMovementStats(fetalMovementDetections),
            _buildSectionHeader(t.selfDetectionHistoryHeader),
          ];

          if (history.isNotEmpty) {
            allItems.addAll(history.map(_buildDetectionCard));
          } else {
            allItems.add(
              _buildEmptyState(
                Icons.analytics_outlined,
                t.noSelfDetectionDataTitle,
                t.noSelfDetectionDataSubtitle,
              ),
            );
          }

          allItems.add(_buildSectionHeader(t.fetalMovementHistoryHeader));

          if (fetalMovementDetections.isNotEmpty) {
            allItems.addAll(fetalMovementDetections.map(_buildMovementCard));
          } else {
            allItems.add(
              _buildEmptyState(
                Icons.favorite_border,
                t.noFetalMovementDataTitle,
                t.noFetalMovementDataSubtitle,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: allItems.length,
            itemBuilder: (context, index) => allItems[index],
          );
        }

        return _buildLoadingState(t.loadingDataGeneric);
      },
    );
  }

  Widget _buildMovementStats(List<SelfDetectionModel> fetalMovementDetections) {
    final t = AppLocalizations.of(context)!;

    if (fetalMovementDetections.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.purple.shade50],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          children: [
            Icon(Icons.favorite_border, size: 40, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              t.noFetalMovementDataTitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    final latestDetection = fetalMovementDetections.first;
    final movementCount = latestDetection.fetalMovementCount ?? 0;
    final duration = latestDetection.fetalMovementDuration ?? 12;
    final movementsPerHour = latestDetection.movementsPerHour ?? 0.0;

    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(movementCount, t);
    final statusMessage = _getFetalMovementMessage(movementCount, movementsPerHour, t);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade50, Colors.purple.shade50],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.pink, size: 24),
              const SizedBox(width: 12),
              Text(
                t.fetalMovementStatsTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildMovementStatCard(
                  t.avgMovementsLabel,
                  "${_calculateAverageMovement(fetalMovementDetections)}",
                  Icons.trending_up,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMovementStatCard(
                  t.normalSessionsLabel,
                  "${_countNormalSessions(fetalMovementDetections)}",
                  Icons.check_circle,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMovementStatCard(
                  t.totalSessionsLabel,
                  "${fetalMovementDetections.length}",
                  Icons.list_alt,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
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
                Text(statusMessage, style: const TextStyle(fontSize: 14, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.latestRecordDetailTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                  children: [
                    _buildDetailItem(t.movementCountLabel, t.timesValue(movementCount), Icons.numbers),
                    _buildDetailItem(t.durationLabel, t.hoursValue(duration), Icons.timer),
                    _buildDetailItem(t.movementsPerHourLabel, t.perHourValue(movementsPerHour), Icons.speed),
                    _buildDetailItem(
                      t.comparisonLabel,
                      latestDetection.movementComparison?.toString() ?? t.noData,
                      Icons.compare,
                    ),
                    _buildDetailItem(
                      t.activityPatternLabel,
                      latestDetection.fetalActivityPattern?.toString() ?? t.noData,
                      Icons.pattern,
                    ),
                    if (latestDetection.fetalAdditionalComplaints != null &&
                        latestDetection.fetalAdditionalComplaints!.isNotEmpty &&
                        latestDetection.fetalAdditionalComplaints![0] != 'Tidak ada')
                      _buildDetailItem(
                        t.complaintsLabel,
                        latestDetection.fetalAdditionalComplaints!.join(', '),
                        Icons.medical_services,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.fetalMovementStandardTitle, // "Standar normal: minimal 10 gerakan dalam 12 jam"
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.fetalMovementStandardPerHour((10 / 12)), // "(0.8 per hour)"
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementCard(SelfDetectionModel detection) {
    final t = AppLocalizations.of(context)!;

    final movementCount = detection.fetalMovementCount ?? 0;
    final duration = detection.fetalMovementDuration ?? 12;
    final movementsPerHour = detection.movementsPerHour ?? 0.0;
    final displayDate = detection.createdAt ?? detection.date;

    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(movementCount, t);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                  child: Icon(statusIcon, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm').format(displayDate),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        statusTitle,
                        style: TextStyle(fontSize: 12, color: statusColor.withValues(alpha: 0.8)),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      t.movementsCountText(movementCount), // "{n} gerakan" / "{n} movements"
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    Text(
                      t.perHourValue(movementsPerHour), // "x.x/jam" / "x.x/hr"
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMovementDetailItem(t.durationLabel, t.hoursValue(duration), Icons.timer),
                    _buildMovementDetailItem(
                      t.activityPatternShortLabel,
                      detection.fetalActivityPattern?.toString() ?? t.noData,
                      Icons.pattern,
                    ),
                    _buildMovementDetailItem(
                      t.comparisonShortLabel,
                      detection.movementComparison?.toString() ?? t.noData,
                      Icons.compare,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (detection.fetalAdditionalComplaints != null &&
                    detection.fetalAdditionalComplaints!.isNotEmpty &&
                    detection.fetalAdditionalComplaints![0] != 'Tidak ada')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${t.complaintsLabel}:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        detection.fetalAdditionalComplaints!.join(', '),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Status fetal movement -> localized
  String _getFetalMovementTitle(int movementCount, AppLocalizations t) {
    if (movementCount == 0) return t.fetalMovementStatusIncomplete;
    if (movementCount >= 10) return t.fetalMovementStatusNormal;
    if (movementCount >= 7) return t.fetalMovementStatusMonitor;
    if (movementCount >= 4) return t.fetalMovementStatusAttention;
    return t.fetalMovementStatusUrgent;
  }

  String _getFetalMovementMessage(int movementCount, double movementsPerHour, AppLocalizations t) {
    if (movementCount == 0) {
      return t.fetalMovementMsgIncomplete;
    }
    if (movementCount >= 10) {
      return t.fetalMovementMsgNormal(movementCount);
    }
    if (movementCount >= 7) {
      return t.fetalMovementMsgMonitor(movementCount);
    }
    if (movementCount >= 4) {
      return t.fetalMovementMsgAttention(movementCount);
    }
    return t.fetalMovementMsgUrgent(movementCount);
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

  int _calculateAverageMovement(List<SelfDetectionModel> detections) {
    if (detections.isEmpty) return 0;
    final total = detections.fold(0, (sum, d) => sum + (d.fetalMovementCount ?? 0));
    return total ~/ detections.length;
  }

  int _countNormalSessions(List<SelfDetectionModel> detections) {
    return detections.where((d) => (d.fetalMovementCount ?? 0) >= 10).length;
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade700,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.pink.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 12, color: Colors.pink),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionCard(SelfDetectionModel detection) {
    final t = AppLocalizations.of(context)!;

    final displayDate = detection.createdAt ?? detection.date;
    final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(displayDate);
    final riskColor = _getRiskColor(detection.riskLevel);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
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
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: riskColor, shape: BoxShape.circle),
                  child: Icon(_getRiskIcon(detection.riskLevel), color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detection.riskLevel.toUpperCase(),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: riskColor),
                      ),
                      Text(formattedDate, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    t.pointsValue(detection.score), // "{n} poin" / "{n} points"
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: riskColor),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetectionInfoItem(t.detailLabel, t.factorsCount(detection.details.length), Icons.list_alt),
                _buildDetectionInfoItem(t.statusLabel, _getRiskStatus(detection.riskLevel, t), Icons.info_outline),
                if (detection.hasFetalMovementData == true)
                  _buildDetectionInfoItem(t.fetalMovementLabel, t.recordedLabel, Icons.favorite),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionInfoItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.pink.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: Colors.pink),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMovementDetailItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 14, color: Colors.pink),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        const SizedBox(height: 2),
        SizedBox(
          width: 70,
          child: Text(
            value,
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black87),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
          ),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, VoidCallback onRetry) {
    final t = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 80, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            t.errorOccurredTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              error,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(t.tryAgain),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(IconData icon, String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Risk Status localized
  String _getRiskStatus(String riskLevel, AppLocalizations t) {
    switch (riskLevel.toLowerCase()) {
      case 'risiko tinggi':
      case 'tinggi':
        return t.riskNeedTreatment;
      case 'perlu perhatian':
      case 'sedang':
        return t.riskNeedAttention;
      case 'kehamilan normal':
      case 'normal':
      case 'rendah':
        return t.riskSafe;
      default:
        return t.unknown;
    }
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

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  int _calculateGestationalAge(DateTime lmp, DateTime currentDate) {
    return currentDate.difference(lmp).inDays;
  }

  String _getTrimester(int gestationalAge) {
    if (gestationalAge <= 98) return "1";
    if (gestationalAge <= 196) return "2";
    return "3";
  }

  Color _getTrimesterColor(String trimester) {
    switch (trimester) {
      case "1":
        return Colors.green;
      case "2":
        return Colors.orange;
      case "3":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getInitials(String name) {
    final names = name.split(' ');
    if (names.length > 1) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }
    return 'B';
  }
}