import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/locale_cubit.dart';
import '../../l10n/app_localizations.dart';
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

  // =========================
  // Language Toggle (EN/ID) - sama gaya HomePage
  // =========================
  Widget _buildLangSwitcher(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          final code = (locale.languageCode.toLowerCase() == 'en') ? 'EN' : 'ID';

          return PopupMenuButton<String>(
            tooltip: t.languageTooltip, // "Language"
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Text(
                code,
                style: whiteTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
            ),
            onSelected: (value) {
              if (value == 'id') {
                context.read<LocaleCubit>().setIndonesian();
              } else {
                context.read<LocaleCubit>().setEnglish();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'id',
                child: Text(t.languageIndonesia), // "Indonesia"
              ),
              PopupMenuItem(
                value: 'en',
                child: Text(t.languageEnglish), // "English"
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        }

        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${t.logoutFailed}: ${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            t.mothersListTitle, // "Daftar Bunda" / "Mothers List"
            style: whiteTextStyle.copyWith(fontSize: 20, fontWeight: bold),
          ),
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            _buildLangSwitcher(context),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _showLogoutConfirmation(context),
              tooltip: t.logout, // "Logout"
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
                        color: Colors.grey.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: t.searchNameOrUsernameHint,
                      prefixIcon: const Icon(Icons.search, color: Colors.pink),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
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
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return _buildEmptyNoData(t);
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
                      return _buildEmptyNotFound(t);
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
                          onTap: () => _navigateToBundaMonitoring(context, user),
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
                                        color: avatarColor.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: avatarColor, width: 2),
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
                                                      t.badgeMother, // "Bunda" / "Mother"
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

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    _buildInfoRow(Icons.person_outline, user.email),
                                                    const SizedBox(height: 4),
                                                    _buildInfoRow(Icons.location_on_outlined, user.alamat),
                                                    const SizedBox(height: 4),
                                                    _buildInfoRow(
                                                      Icons.calendar_today_outlined,
                                                      "${DateFormat('dd/MM/yyyy').format(user.tglLahir)} • $umur ${t.yearsOldShort}",
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

  // =========================
  // Empty States
  // =========================
  Widget _buildEmptyNoData(AppLocalizations t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pregnant_woman_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            t.noMotherData,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyNotFound(AppLocalizations t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            t.notFoundTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? t.noMotherData
                : t.noResultsForQuery(_searchQuery),
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // =========================
  // Helpers
  // =========================
  int _hitungUmur(DateTime tglLahir) {
    final now = DateTime.now();
    int umur = now.year - tglLahir.year;
    if (now.month < tglLahir.month || (now.month == tglLahir.month && now.day < tglLahir.day)) {
      umur--;
    }
    return umur;
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

  Color _getAvatarColor(int index) {
    const colors = [
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
      final usernameMatch = user.email.toLowerCase().contains(lowercaseQuery);
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

  // =========================
  // Logout Dialog (pakai AppLocalizations)
  // =========================
  void _showLogoutConfirmation(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: t.logoutConfirmTitle,
      desc: t.logoutConfirmDesc,
      btnCancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: tGreyColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () => Navigator.pop(context),
        child: Text(
          t.cancel,
          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      btnOk: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.pop(context);
          context.read<AuthCubit>().signOut();
        },
        child: Text(
          t.logout,
          style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      titleTextStyle: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
      descTextStyle: const TextStyle(fontSize: 16, color: tGreyColor),
    ).show();
  }
}
