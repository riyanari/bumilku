import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bumilku_app/models/user_model.dart';
import 'package:bumilku_app/cubit/medis_cubit.dart';
import 'package:bumilku_app/cubit/self_detection_cubit.dart';

import '../../models/medis_model.dart';
import '../../models/self_detection_model.dart';

class BundaMonitoringPage extends StatefulWidget {
  final UserModel bunda;

  const BundaMonitoringPage({super.key, required this.bunda});

  @override
  State<BundaMonitoringPage> createState() => _BundaMonitoringPageState();
}

class _BundaMonitoringPageState extends State<BundaMonitoringPage> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<MedisCubit>().getUserMedis(widget.bunda.id);
    context.read<SelfDetectionCubit>().getDetectionHistory(widget.bunda.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          "Monitoring ${widget.bunda.name}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 22),
            onPressed: _loadData,
            tooltip: "Refresh Data",
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Info Bunda
          _buildBundaHeader(),

          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTabButton(0, "Perkembangan", Icons.pregnant_woman),
                _buildTabButton(1, "Self Detection", Icons.analytics_outlined),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildBundaHeader() {
    final age = _calculateAge(widget.bunda.tglLahir);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink.shade100,
            Colors.purple.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha:0.2),
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
                colors: [
                  Colors.pink.shade200,
                  Colors.pink.shade400,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withValues(alpha:0.3),
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
                      "$age tahun",
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
        color: Colors.white.withValues(alpha:0.7),
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
        onTap: () {
          setState(() {
            _selectedTab = tabIndex;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.shade400,
                Colors.pink.shade600,
              ],
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
    return BlocBuilder<MedisCubit, MedisState>(
      builder: (context, state) {
        if (state is MedisLoading) {
          return _buildLoadingState("Memuat data kehamilan...");
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
              "Belum Ada Data Kehamilan",
              "Data kehamilan akan muncul di sini",
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

        return _buildLoadingState("Memuat data...");
      },
    );
  }

  Widget _buildPregnancyCard(MedisModel medis, int index, bool isActive) {
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
          colors: [
            Colors.white,
            isActive ? Colors.pink.shade50 : Colors.grey.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1),
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
                    color: Colors.white.withValues(alpha:0.2),
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
                        "Kehamilan ${index + 1}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        isActive ? "Kehamilan Aktif" : "Riwayat Kehamilan",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha:0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.favorite, size: 14, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          "AKTIF",
                          style: TextStyle(
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
                _buildProgressSection(gestationalAge, weeks, days, trimester, daysToEdd, progressPercentage),
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
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2,
      children: [
        _buildInfoCard("👶 Nama Bayi", medis.babyName ?? 'Belum diberi nama', Colors.blue),
        _buildInfoCard("📅 HPHT", DateFormat('dd/MM/yyyy').format(medis.selectedLmp), Colors.green),
        _buildInfoCard("🎯 Perkiraan Lahir", DateFormat('dd/MM/yyyy').format(medis.edd), Colors.orange),
        _buildInfoCard("🔄 Siklus", "${medis.cycleLength} hari", Colors.purple),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha:0.3)),
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

  Widget _buildProgressSection(int gestationalAge, int weeks, int days, String trimester, int daysToEdd, double progressPercentage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
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
                "Perkembangan Kehamilan",
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
                          _getTrimesterColor(trimester).withValues(alpha:0.7),
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
                "Trimester $trimester",
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
              _buildStatItem("Usia Kandungan", "$weeks minggu $days hari", Icons.calendar_today, Colors.blue),
              _buildStatItem("Hari Menuju Lahir", "$daysToEdd hari", Icons.celebration, daysToEdd <= 30 ? Colors.red : Colors.orange),
              _buildStatItem("Trimester", trimester, Icons.auto_awesome, _getTrimesterColor(trimester)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSection(int gestationalAge) {
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
                "Timeline Perkembangan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTimelineItem("Trimester 1", "Minggu 1-13", gestationalAge <= 91),
          _buildTimelineItem("Trimester 2", "Minggu 14-27", gestationalAge > 91 && gestationalAge <= 189),
          _buildTimelineItem("Trimester 3", "Minggu 28-40", gestationalAge > 189),
        ],
      ),
    );
  }

  Widget _buildCardFooter(DateTime createdAt, bool isActive) {
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
              "Data dibuat: ${DateFormat('dd/MM/yyyy HH:mm').format(createdAt)}",
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          if (isActive)
            Icon(Icons.star, size: 14, color: Colors.amber),
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
            color: color.withValues(alpha:0.1),
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
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
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
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelfDetectionTab() {
    return BlocBuilder<SelfDetectionCubit, SelfDetectionState>(
      builder: (context, state) {
        if (state is SelfDetectionLoading) {
          return _buildLoadingState("Memuat riwayat deteksi...");
        }

        if (state is SelfDetectionFailed) {
          return _buildErrorState(state.error, _loadData);
        }

        if (state is SelfDetectionHistoryLoaded) {
          final history = state.detectionHistory;

          // FILTER DATA YANG MEMILIKI GERAKAN JANIN
          final fetalMovementDetections = history.where((detection) =>
          detection.hasFetalMovementData == true
          ).toList();

          // Urutkan dari yang terbaru
          fetalMovementDetections.sort((a, b) {
            final dateA = a.createdAt ?? a.date;
            final dateB = b.createdAt ?? b.date;
            return dateB.compareTo(dateA);
          });

          final allItems = <Widget>[
            _buildSectionHeader("Pemantauan Gerakan Janin"),
            if (fetalMovementDetections.isNotEmpty)
              _buildMovementStats(fetalMovementDetections),
            _buildSectionHeader("Riwayat Self Detection"),
          ];

          // Tambahkan riwayat self detection atau empty state
          if (history.isNotEmpty) {
            allItems.addAll(history.map((detection) => _buildDetectionCard(detection)).toList());
          } else {
            allItems.add(_buildEmptyState(
              Icons.analytics_outlined,
              "Belum Ada Data Self Detection",
              "Data deteksi mandiri akan muncul di sini",
            ));
          }

          allItems.add(_buildSectionHeader("Riwayat Gerakan Janin"));

          // Tambahkan riwayat gerakan janin atau empty state
          if (fetalMovementDetections.isNotEmpty) {
            allItems.addAll(fetalMovementDetections.map((detection) => _buildMovementCard(detection)).toList());
          } else {
            allItems.add(_buildEmptyState(
              Icons.favorite_border,
              "Belum Ada Data Gerakan Janin",
              "Data gerakan janin akan muncul di sini",
            ));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              return allItems[index];
            },
          );
        }

        return _buildLoadingState("Memuat data...");
      },
    );
  }

  // PERBAIKAN: Ambil data dari SelfDetectionModel yang sebenarnya
  Widget _buildMovementStats(List<SelfDetectionModel> fetalMovementDetections) {
    if (fetalMovementDetections.isEmpty) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.purple.shade50,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Column(
          children: [
            Icon(Icons.favorite_border, size: 40, color: Colors.grey.shade400),
            const SizedBox(height: 8),
            Text(
              "Belum Ada Data Gerakan Janin",
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
    final duration = latestDetection.fetalMovementDuration ?? 12; // Default 12 jam
    final movementsPerHour = latestDetection.movementsPerHour ?? 0.0;

    // HITUNG STATUS BERDASARKAN STANDAR BARU
    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(movementCount);
    final statusMessage = _getFetalMovementMessage(movementCount, movementsPerHour);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.pink, size: 24),
              const SizedBox(width: 12),
              Text(
                "Statistik Gerakan Janin",
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
                  "Rata-rata Gerakan",
                  "${_calculateAverageMovement(fetalMovementDetections)}",
                  Icons.trending_up,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMovementStatCard(
                  "Sesi Normal",
                  "${_countNormalSessions(fetalMovementDetections)}",
                  Icons.check_circle,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMovementStatCard(
                  "Total Sesi",
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
          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Detail Pencatatan Terbaru:",
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
                    _buildDetailItem("Jumlah Gerakan", "$movementCount kali", Icons.numbers),
                    _buildDetailItem("Durasi", "$duration jam", Icons.timer),
                    _buildDetailItem("Gerakan per Jam", "${movementsPerHour.toStringAsFixed(1)}/jam", Icons.speed),
                    _buildDetailItem("Perbandingan",
                        latestDetection.movementComparison?.toString() ?? 'Tidak ada data',
                        Icons.compare
                    ),
                    _buildDetailItem("Pola Aktivitas",
                        latestDetection.fetalActivityPattern?.toString() ?? 'Tidak ada data',
                        Icons.pattern
                    ),
                    if (latestDetection.fetalAdditionalComplaints != null &&
                        latestDetection.fetalAdditionalComplaints!.isNotEmpty &&
                        latestDetection.fetalAdditionalComplaints![0] != 'Tidak ada')
                      _buildDetailItem("Keluhan",
                          latestDetection.fetalAdditionalComplaints!.join(', '),
                          Icons.medical_services
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
                        "Standar normal: minimal 10 gerakan dalam 12 jam",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "(${(10/12).toStringAsFixed(1)} gerakan per jam)",
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

  // PERBAIKAN: Gunakan SelfDetectionModel untuk movement card
  Widget _buildMovementCard(SelfDetectionModel detection) {
    final movementCount = detection.fetalMovementCount ?? 0;
    final duration = detection.fetalMovementDuration ?? 12;
    final movementsPerHour = detection.movementsPerHour ?? 0.0;
    final displayDate = detection.createdAt ?? detection.date;

    // HITUNG STATUS BERDASARKAN STANDAR BARU
    final statusColor = _getFetalMovementColorFromCount(movementCount);
    final statusIcon = _getFetalMovementIconFromCount(movementCount);
    final statusTitle = _getFetalMovementTitle(movementCount);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1),
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
              color: statusColor.withValues(alpha:0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
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
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor.withValues(alpha:0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "$movementCount gerakan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    Text(
                      "${movementsPerHour.toStringAsFixed(1)}/jam",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
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
                    _buildMovementDetailItem("Durasi", "$duration jam", Icons.timer),
                    _buildMovementDetailItem("Pola",
                        detection.fetalActivityPattern?.toString() ?? 'Tidak ada data',
                        Icons.pattern
                    ),
                    _buildMovementDetailItem("Perbandingan",
                        detection.movementComparison?.toString() ?? 'Tidak ada data',
                        Icons.compare
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
                        "Keluhan:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        detection.fetalAdditionalComplaints!.join(', '),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
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

  // METHOD BARU: Helper untuk status gerakan janin berdasarkan standar baru
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

  // PERBAIKAN: Helper methods untuk gerakan janin dari data sebenarnya
  int _calculateAverageMovement(List<SelfDetectionModel> detections) {
    if (detections.isEmpty) return 0;
    final total = detections.fold(0, (sum, detection) => sum + (detection.fetalMovementCount ?? 0));
    return total ~/ detections.length;
  }

  int _countNormalSessions(List<SelfDetectionModel> detections) {
    return detections.where((detection) => (detection.fetalMovementCount ?? 0) >= 10).length;
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
              color: Colors.pink.withValues(alpha:0.1),
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
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha:0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionCard(SelfDetectionModel detection) {
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
            color: Colors.black.withValues(alpha:0.1),
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
              color: riskColor.withValues(alpha:0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
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
                    _getRiskIcon(detection.riskLevel),
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detection.riskLevel.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "${detection.score} poin",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
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
                _buildDetectionInfoItem("Detail", "${detection.details.length} faktor", Icons.list_alt),
                _buildDetectionInfoItem("Status", _getRiskStatus(detection.riskLevel), Icons.info_outline),
                if (detection.hasFetalMovementData == true)
                  _buildDetectionInfoItem("Gerakan Janin", "Tercatat", Icons.favorite),
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
            color: Colors.pink.withValues(alpha:0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: Colors.pink),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMovementDetailItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 14, color: Colors.pink),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: 70,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
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
          Text(
            message,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline_rounded, size: 80, color: Colors.red.shade300),
          const SizedBox(height: 16),
          const Text(
            "Terjadi Kesalahan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              error,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Coba Lagi"),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper Methods
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
    List<String> names = name.split(' ');
    if (names.length > 1) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }
    return 'B';
  }
}