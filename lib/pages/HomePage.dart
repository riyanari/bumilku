import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bumilku_app/pages/materi_maternitas.dart';
import 'package:bumilku_app/pages/pertanyaan_umum_page.dart';
import 'package:bumilku_app/pages/profile_page.dart';
import 'package:bumilku_app/pages/self_detection/detection_history_page.dart';
import 'package:bumilku_app/pages/self_detection/self_detection_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/medis_cubit.dart';
import '../l10n/app_localizations.dart';
import '../theme/theme.dart';
import 'calendar_menstruasi.dart';
import 'login_page.dart';
import '../cubit/locale_cubit.dart';
import 'tutorial_video_page.dart'; // Import halaman tutorial video

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showTutorialTooltip = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<MedisCubit>().getUserMedis(user.uid);
    }

    // Tampilkan tooltip tutorial saat pertama kali masuk (opsional)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorialTooltip();
    });
  }

  void _checkAndShowTutorialTooltip() {
    // Anda bisa menambahkan logika untuk mengecek apakah user sudah pernah melihat tutorial
    // Misalnya menggunakan SharedPreferences
    setState(() {
      _showTutorialTooltip = true;
    });

    // Otomatis hide tooltip setelah beberapa detik
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showTutorialTooltip = false;
        });
      }
    });
  }

  Widget feature(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SelfDetectionPageView()),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/det_self.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.selfDetection,
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.selfDetectionDesc,
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DetectionHistoryPage()),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/riwayat_detection.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.checkHistory,
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.checkHistoryDesc,
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MateriMaternitas()),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/matern.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.maternalNursingTitle,
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.maternalNursingDesc,
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PertanyaanUmumPage()),
                  );
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffFBE0EC),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withValues(alpha:0.3),
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/det_maternitas.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.faqTitle,
                          style: primaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          t.faqDesc,
                          style: greyTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocaleCubit, Locale>(
      listener: (context, locale) {
        debugPrint('[LANG] LocaleCubit emitted new locale: $locale');
        debugPrint(
          '[LANG] AppLocalizations locale now: ${Localizations.localeOf(context)}',
        );
      },
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, currentLocale) {
          final t = AppLocalizations.of(context);

          // Jika localization belum siap, tampilkan loading
          if (t == null) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginPage()),
                      (route) => false,
                );
              }

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
            child: SafeArea(
              child: Scaffold(
                backgroundColor: kBackgroundColor,
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18.0, 30, 18, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/lg_bumilku.png",
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      t.appName,
                                      style: primaryTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showTutorialTooltip = false;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const TutorialVideoPage(fromHome: true),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: kBackground2Color,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.help_outline,
                                          color: kPrimaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    // Profile Icon
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProfilePage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: kBackground2Color,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: kPrimaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    // Language Switcher
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kBackground2Color,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: BlocBuilder<LocaleCubit, Locale>(
                                        builder: (context, locale) {
                                          final code = (locale.languageCode == 'en') ? 'EN' : 'ID';

                                          return PopupMenuButton<String>(
                                            tooltip: "Language",
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                              child: Text(
                                                code,
                                                style: primaryTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: bold,
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            onSelected: (value) {
                                              debugPrint('[LANG] Popup selected: $value');
                                              debugPrint(
                                                '[LANG] Current locale BEFORE set: ${context.read<LocaleCubit>().state}',
                                              );

                                              if (value == 'id') {
                                                context.read<LocaleCubit>().setIndonesian();
                                              } else {
                                                context.read<LocaleCubit>().setEnglish();
                                              }

                                              debugPrint('[LANG] Requested change to: $value');
                                            },
                                            itemBuilder: (context) => const [
                                              PopupMenuItem(value: 'id', child: Text('Indonesia')),
                                              PopupMenuItem(value: 'en', child: Text('English')),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    // Logout Icon
                                    GestureDetector(
                                      onTap: () {
                                        _showLogoutConfirmation(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: kBackground2Color,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.logout,
                                          color: kPrimaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Calendar dan data medis
                            BlocBuilder<MedisCubit, MedisState>(
                              builder: (context, state) {
                                if (state is MedisLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MedisSuccess) {
                                  final activeMedis = state.activeMedis;
                                  final medisHistory = state.medisHistory;

                                  final medisToShow =
                                      activeMedis ??
                                          (medisHistory.isNotEmpty
                                              ? medisHistory.first
                                              : null);

                                  if (medisToShow == null) {
                                    return Column(
                                      children: [
                                        Text(t.noPregnancyData),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () {
                                            _showAddPregnancyDialog(context);
                                          },
                                          child: Text(t.addPregnancy),
                                        ),
                                      ],
                                    );
                                  }

                                  return CalendarMenstruasi(
                                    medisId: medisToShow.id,
                                    cycleLength: medisToShow.cycleLength,
                                    lmp: medisToShow.selectedLmp,
                                    edd: medisToShow.edd,
                                    onSave: (cycleLength, lmp) {
                                      final adjustment = cycleLength - 28;
                                      final newEdd = lmp.add(
                                        Duration(days: 280 + adjustment),
                                      );

                                      final user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user != null) {
                                        if (activeMedis != null) {
                                          context.read<MedisCubit>().addMedis(
                                            userId: user.uid,
                                            cycleLength: cycleLength,
                                            selectedLmp: lmp,
                                            edd: newEdd,
                                            babyName: activeMedis.babyName,
                                          );
                                        } else {
                                          context.read<MedisCubit>().addMedis(
                                            userId: user.uid,
                                            cycleLength: cycleLength,
                                            selectedLmp: lmp,
                                            edd: newEdd,
                                          );
                                        }
                                      }
                                    },
                                  );
                                } else if (state is MedisFailed) {
                                  return Column(
                                    children: [
                                      Text("Error: ${state.error}"),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          final user =
                                              FirebaseAuth.instance.currentUser;
                                          if (user != null) {
                                            context.read<MedisCubit>().getUserMedis(
                                              user.uid,
                                            );
                                          }
                                        },
                                        child: Text(t.tryAgain),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Text(t.medicalDataNotAvailable),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showAddPregnancyDialog(context);
                                        },
                                        child: Text(t.addFirstPregnancy),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            feature(context),
                          ],
                        ),
                      ),
                    ),

                    // Floating Button untuk Tutorial (opsional tambahan)
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Column(
                        children: [
                          // Tooltip untuk floating button
                          if (_showTutorialTooltip)
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha:0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Tutorial Penggunaan Aplikasi',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                            ),

                          // Floating Action Button untuk Tutorial
                          // FloatingActionButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _showTutorialTooltip = false;
                          //     });
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (_) => const TutorialVideoPage(),
                          //       ),
                          //     );
                          //   },
                          //   backgroundColor: kPrimaryColor,
                          //   foregroundColor: Colors.white,
                          //   elevation: 4,
                          //   child: const Icon(Icons.play_circle_fill),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Dialog konfirmasi logout
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
        onPressed: () {
          Navigator.pop(context);
        },
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

  // Dialog untuk menambah kehamilan baru
  void _showAddPregnancyDialog(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.addPregnancyNewTitle),
        content: Text(t.addPregnancyNewDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              final defaultLmp = DateTime.now().subtract(const Duration(days: 30));
              final defaultEdd = defaultLmp.add(const Duration(days: 280));

              context.read<MedisCubit>().addMedis(
                userId: user.uid,
                cycleLength: 28,
                selectedLmp: defaultLmp,
                edd: defaultEdd,
              );
            },
            child: Text(t.add),
          ),
        ],
      ),
    );
  }
}