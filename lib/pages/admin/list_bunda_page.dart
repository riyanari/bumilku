import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/auth_cubit.dart';
import '../../models/user_model.dart';
import '../../theme/theme.dart';
import './bunda_monitoring_page.dart';

class ListBundaPage extends StatefulWidget {
  const ListBundaPage({super.key});

  @override
  State<ListBundaPage> createState() => _ListBundaPageState();
}

class _ListBundaPageState extends State<ListBundaPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Listen untuk state AuthInitial (setelah logout success)
        if (state is AuthInitial) {
          // Navigate ke login page dan hapus semua route
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        }

        // Handle logout error
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logout gagal: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Daftar Bunda",
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          // centerTitle: true,
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                _showLogoutConfirmation(context);
              },
              tooltip: "Logout",
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.pink.shade50, Colors.white],
            ),
          ),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha:0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari nama atau username...',
                      prefixIcon: const Icon(Icons.search, color: Colors.pink),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
              ),

              // List Bunda
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('role', isEqualTo: 'bunda')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.pink,
                          ),
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
                        email: data['email'] ?? '',
                        name: data['name'] ?? '',
                        role: data['role'] ?? '',
                        alamat: data['alamat'] ?? '',
                        tglLahir: (data['tglLahir'] as Timestamp).toDate(),
                      );
                    }).toList();

                    final filteredUsers = _filterUsers(users, _searchQuery);

                    if (filteredUsers.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Tidak ditemukan",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _searchQuery.isEmpty
                                  ? "Belum ada data bunda"
                                  : "Tidak ada hasil untuk '$_searchQuery'",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final umur = _hitungUmur(user.tglLahir);
                        final initials = _getInitials(user.name);
                        final avatarColor = _getAvatarColor(index);

                        return GestureDetector(
                          onTap: () {
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

                                    // User Info - Expanded to take remaining space
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Name and Badge row
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
                                              const SizedBox(width: 10),
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

                                          const SizedBox(height: 8),

                                          // User details with arrow icon
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _buildInfoRow(
                                                      Icons.person_outline,
                                                      user.email,
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
                                        ],
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
            ],
          ),
        ),
      ),
    );
  }

  // Helper Methods (tetap sama)
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

  List<UserModel> _filterUsers(List<UserModel> users, String query) {
    if (query.isEmpty) return users;

    final lowercaseQuery = query.toLowerCase();
    return users.where((user) {
      final nameMatch = user.name.toLowerCase().contains(lowercaseQuery);
      final usernameMatch = user.email.toLowerCase().contains(
        lowercaseQuery,
      );
      return nameMatch || usernameMatch;
    }).toList();
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _navigateToBundaMonitoring(BuildContext context, UserModel bunda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BundaMonitoringPage(bunda: bunda)),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Konfirmasi Logout',
      desc: 'Apakah Anda yakin ingin logout dari aplikasi BUMILKU?',
      btnCancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: tGreyColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Batal",
          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.pop(context); // Tutup dialog dulu
          context.read<AuthCubit>().signOut(); // Lalu logout
        },
        child: Text(
          "Logout",
          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      titleTextStyle: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
      descTextStyle: const TextStyle(fontSize: 16, color: tGreyColor),
    ).show();
  }
}
