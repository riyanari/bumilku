import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/user_model.dart';
import './bunda_monitoring_page.dart'; // Import halaman monitoring

class ListBundaPage extends StatelessWidget {
  const ListBundaPage({super.key});

  int _hitungUmur(DateTime tglLahir) {
    final now = DateTime.now();
    int umur = now.year - tglLahir.year;
    if (now.month < tglLahir.month ||
        (now.month == tglLahir.month && now.day < tglLahir.day)) {
      umur--;
    }
    return umur;
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

  Color _getAvatarColor(int index) {
    final colors = [
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.teal,
      Colors.orange,
      Colors.deepPurple,
    ];
    return colors[index % colors.length];
  }

  Widget _buildQuickStats(UserModel user) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('self_detection')
          .where('userId', isEqualTo: user.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(); // Return empty if no data
        }

        final detections = snapshot.data!.docs;
        final highRiskCount = detections.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final riskLevel = data['riskLevel']?.toString().toLowerCase() ?? '';
          return riskLevel.contains('tinggi') || riskLevel.contains('high');
        }).length;

        return Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: highRiskCount > 0 ? Colors.red.shade50 : Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    highRiskCount > 0 ? Icons.warning : Icons.check_circle,
                    size: 10,
                    color: highRiskCount > 0 ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "${detections.length} deteksi",
                    style: TextStyle(
                      fontSize: 10,
                      color: highRiskCount > 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (highRiskCount > 0) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "$highRiskCount risiko",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Bunda"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pink.shade50,
              Colors.white,
            ],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('role', isEqualTo: 'bunda')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pregnant_woman_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Belum ada data bunda",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              );
            }

            final users = snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return UserModel(
                id: doc.id,
                username: data['username'] ?? '',
                name: data['name'] ?? '',
                role: data['role'] ?? '',
                alamat: data['alamat'] ?? '',
                tglLahir: (data['tglLahir'] as Timestamp).toDate(),
              );
            }).toList();

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final umur = _hitungUmur(user.tglLahir);
                final initials = _getInitials(user.name);
                final avatarColor = _getAvatarColor(index);

                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman monitoring bunda
                    _navigateToBundaMonitoring(context, user);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Avatar Circle
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: avatarColor.withValues(alpha:0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: avatarColor,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  initials,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: avatarColor,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            // User Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          user.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.pink.shade50,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.pregnant_woman,
                                              size: 12,
                                              color: Colors.pink.shade700,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "Bunda",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 6), // Reduced spacing

                                  // TAMBAHKAN INI: Quick Stats
                                  _buildQuickStats(user),

                                  const SizedBox(height: 6), // Reduced spacing

                                  // User Details
                                  _buildInfoRow(
                                    Icons.person_outline,
                                    user.username,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildInfoRow(
                                    Icons.location_on_outlined,
                                    user.alamat,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildInfoRow(
                                    Icons.calendar_today_outlined,
                                    "${DateFormat('dd/MM/yyyy').format(user.tglLahir)} • $umur tahun",
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // Arrow Icon
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.pink.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: Colors.pink.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _navigateToBundaMonitoring(BuildContext context, UserModel bunda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BundaMonitoringPage(bunda: bunda),
      ),
    );
  }
}