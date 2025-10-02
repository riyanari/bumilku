import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bumilku_app/models/user_model.dart';
import 'package:bumilku_app/cubit/medis_cubit.dart';
import 'package:bumilku_app/cubit/self_detection_cubit.dart';

import '../../models/medis_model.dart';
import '../../models/self_detection_model.dart';
import '../self_detection/detail_history_page.dart';

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
          // Avatar dengan efek lebih menarik
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
                  "@${widget.bunda.username}",
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
          // Header dengan status
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

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informasi utama
                _buildInfoGrid(medis),

                const SizedBox(height: 10),

                // Progress kehamilan
                _buildProgressSection(gestationalAge, weeks, days, trimester, daysToEdd, progressPercentage),

                const SizedBox(height: 10),

                // Timeline perkembangan
                _buildTimelineSection(gestationalAge),

                const SizedBox(height: 16),

                // Footer
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

          // Progress Bar
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

          // Statistik
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

          // Data contoh untuk gerakan janin (dalam aplikasi nyata, data ini akan diambil dari database)
          final List<FetalMovementRecord> movementRecords = [
            FetalMovementRecord(
              date: DateTime.now().subtract(const Duration(days: 1)),
              movementCount: 15,
              duration: 45,
              pattern: 'Lebih aktif malam hari',
              comparison: 'Sama saja',
              complaints: ['Tidak ada'],
            ),
            FetalMovementRecord(
              date: DateTime.now().subtract(const Duration(days: 2)),
              movementCount: 12,
              duration: 60,
              pattern: 'Lebih aktif siang hari',
              comparison: 'Lebih aktif',
              complaints: ['Pusing/lemas'],
            ),
            FetalMovementRecord(
              date: DateTime.now().subtract(const Duration(days: 3)),
              movementCount: 8,
              duration: 120,
              pattern: 'Tidak ada pola khusus',
              comparison: 'Lebih sedikit',
              complaints: ['Nyeri perut'],
            ),
          ];

          // Gabungkan semua data dalam satu list
          final allItems = [
            _buildSectionHeader("Pemantauan Gerakan Janin"),
            // Di dalam _buildSelfDetectionTab, ganti pemanggilan _buildMovementStats menjadi:
            _buildMovementStats(
              movementRecords,
              movementRecords.isNotEmpty ? movementRecords.first.movementCount : 0,
              movementRecords.isNotEmpty ? movementRecords.first.duration : 0,
              movementRecords.isNotEmpty ? (movementRecords.first.movementCount / (movementRecords.first.duration / 60)) : 0.0,
              {
                'color': movementRecords.isNotEmpty && movementRecords.first.movementCount >= 10 ? 'green' : 'orange',
                'title': movementRecords.isNotEmpty && movementRecords.first.movementCount >= 10 ? 'Kondisi Normal' : 'Perlu Perhatian',
                'message': movementRecords.isNotEmpty && movementRecords.first.movementCount >= 10
                    ? 'Gerakan janin dalam batas normal. Tetap pantau secara rutin.'
                    : 'Gerakan janin kurang dari normal. Perlu pemantauan lebih lanjut.',
              },
              movementRecords.isNotEmpty ? movementRecords.first.comparison : '',
              movementRecords.isNotEmpty ? movementRecords.first.pattern : '',
              movementRecords.isNotEmpty ? movementRecords.first.complaints : [],
            ),
            _buildSectionHeader("Riwayat Self Detection"),
            ...history.map((detection) => _buildDetectionCard(detection)).toList(),
            _buildSectionHeader("Riwayat Gerakan Janin"),
            ...movementRecords.map((record) => _buildMovementCard(record)).toList(),
          ];

          if (history.isEmpty && movementRecords.isEmpty) {
            return _buildEmptyState(
              Icons.analytics_outlined,
              "Belum Ada Data",
              "Data deteksi mandiri dan gerakan janin akan muncul di sini",
            );
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

  Widget _buildMovementStats(
      List<FetalMovementRecord> movementRecords,
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
          // Header
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

          // Statistik Cards
          Row(
            children: [
              Expanded(
                child: _buildMovementStatCard(
                  "Rata-rata Gerakan",
                  "${_calculateAverageMovement(movementRecords)}",
                  Icons.trending_up,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMovementStatCard(
                  "Sesi Normal",
                  "${_countNormalSessions(movementRecords)}",
                  Icons.check_circle,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMovementStatCard(
                  "Total Sesi",
                  "${movementRecords.length}",
                  Icons.list_alt,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Status Gerakan Janin
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
          const SizedBox(height: 12),

          // Detail Pencatatan
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

                // Grid untuk detail pencatatan
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                  children: [
                    _buildDetailItem("Jumlah Gerakan", "$movementCount kali", Icons.numbers),
                    _buildDetailItem("Durasi", "$duration menit", Icons.timer),
                    _buildDetailItem("Gerakan per Jam", "${movementsPerHour.toStringAsFixed(1)}/jam", Icons.speed),
                    _buildDetailItem("Perbandingan", comparison.isNotEmpty ? comparison : 'Tidak ada data', Icons.compare),
                    _buildDetailItem("Pola Aktivitas", pattern.isNotEmpty ? pattern : 'Tidak ada data', Icons.pattern),
                    if (additionalComplaints.isNotEmpty && additionalComplaints[0] != 'Tidak ada')
                      _buildDetailItem("Keluhan", additionalComplaints.join(', '), Icons.medical_services),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Informasi Standar
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
                        "Standar normal: minimal 10 gerakan dalam 2 jam",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "atau minimal 5 gerakan per jam",
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

// Helper methods untuk warna dan icon
  Color _getFetalMovementColor(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getFetalMovementIcon(String color) {
    switch (color) {
      case 'red':
        return Icons.warning;
      case 'green':
        return Icons.check_circle;
      case 'orange':
        return Icons.info;
      case 'blue':
        return Icons.timelapse;
      default:
        return Icons.help;
    }
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
          // Header
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

          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetectionInfoItem("Detail", "${detection.details.length} faktor", Icons.list_alt),
                _buildDetectionInfoItem("Status", _getRiskStatus(detection.riskLevel), Icons.info_outline),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementCard(FetalMovementRecord record) {
    final isNormal = record.movementCount >= 10;
    final statusColor = isNormal ? Colors.green : Colors.orange;
    final statusIcon = isNormal ? Icons.check_circle : Icons.info;

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
          // Header
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
                        DateFormat('dd/MM/yyyy HH:mm').format(record.date),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      Text(
                        isNormal ? "Gerakan Normal" : "Perlu Perhatian",
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor.withValues(alpha:0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${record.movementCount} gerakan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informasi utama
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMovementDetailItem("Durasi", "${record.duration} menit", Icons.timer),
                    _buildMovementDetailItem("Pola", record.pattern, Icons.pattern),
                    _buildMovementDetailItem("Perbandingan", record.comparison, Icons.compare),
                  ],
                ),
                const SizedBox(height: 8),

                // Keluhan
                if (record.complaints.isNotEmpty && record.complaints[0] != 'Tidak ada')
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
                        record.complaints.join(', '),
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

  // Helper methods untuk gerakan janin
  int _calculateAverageMovement(List<FetalMovementRecord> records) {
    if (records.isEmpty) return 0;
    final total = records.fold(0, (sum, record) => sum + record.movementCount);
    return total ~/ records.length;
  }

  int _countNormalSessions(List<FetalMovementRecord> records) {
    return records.where((record) => record.movementCount >= 10).length;
  }

  // Common State Widgets
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

  // Navigation
  void _navigateToDetectionDetail(BuildContext context, SelfDetectionModel detection) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailHistoryPage(detection: detection),
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

// Model untuk data gerakan janin
class FetalMovementRecord {
  final DateTime date;
  final int movementCount;
  final int duration;
  final String pattern;
  final String comparison;
  final List<String> complaints;

  FetalMovementRecord({
    required this.date,
    required this.movementCount,
    required this.duration,
    required this.pattern,
    required this.comparison,
    required this.complaints,
  });
}