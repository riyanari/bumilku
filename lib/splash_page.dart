import 'dart:async';

import 'package:bumilku_app/services/medis_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/half_circle_painter.dart';
import '../cubit/auth_cubit.dart';
import '../theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndNavigate();
    });
  }

  Future<void> _checkAuthAndNavigate() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    print("=== [SplashPage] Start check ===");
    print("CurrentUser: ${user?.uid}");
    print("EmailVerified: ${user?.emailVerified}");

    await Future.delayed(const Duration(seconds: 2)); // splash delay

    if (!mounted) return;

    if (user == null) {
      print("=== [SplashPage] User belum login → ke /login");
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    } else {
      try {
        // 🔄 RELOAD USER UNTUK MENDAPATKAN STATUS EMAIL VERIFICATION TERBARU
        await user.reload();
        final refreshedUser = auth.currentUser;

        print("=== [SplashPage] After reload - EmailVerified: ${refreshedUser?.emailVerified}");

        // 👇 CEK APAKAH EMAIL SUDAH TERVERIFIKASI
        if (refreshedUser?.emailVerified == false) {
          print("=== [SplashPage] Email belum terverifikasi → ke /email-verification");
          Navigator.pushNamedAndRemoveUntil(
              context,
              '/email-verification',
                  (_) => false,
              arguments: {
                'userId': refreshedUser!.uid,
                'email': refreshedUser.email ?? '',
              }
          );
          return;
        }

        // 👇 LOAD USER DATA KE AUTH CUBIT DULU SEBELUM NAVIGASI
        print("=== [SplashPage] Loading user data to AuthCubit...");
        final authCubit = context.read<AuthCubit>();

        // Tunggu sampai data user selesai dimuat
        await _loadUserDataToCubit(authCubit, refreshedUser!.uid);

        // 🔑 Cek role user terlebih dahulu
        final authState = authCubit.state;
        if (authState is AuthSuccess) {
          final userData = authState.user;
          print("=== [SplashPage] Role user: ${userData.role}");

          // Jika role admin, langsung ke halaman list bunda
          if (userData.role.toLowerCase() == 'admin') {
            print("=== [SplashPage] User adalah admin → ke /list-bunda");
            Navigator.pushNamedAndRemoveUntil(context, '/list-bunda', (_) => false);
            return;
          }

          // Jika bukan admin, cek data medis seperti biasa
          print("=== [SplashPage] User adalah bunda → cek data medis");
          final medis = await MedisServices().getActiveMedis(refreshedUser.uid);

          if (medis != null) {
            print("=== [SplashPage] User punya medis aktif ===");
            print("MedisId: ${medis.id}");
            print("babyName: ${medis.babyName}");
            print("EDD: ${medis.edd}");
            Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
          } else {
            print("=== [SplashPage] Tidak ada data medis aktif → ke onboarding");
            Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (_) => false);
          }
        } else {
          print("!!! [SplashPage] AuthCubit state tidak valid → ke login");
          Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
        }
      } catch (e) {
        print("!!! [SplashPage] ERROR: $e");
        // Fallback ke login jika ada error
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      }
    }
  }

  // 👇 METHOD BARU: Load user data ke AuthCubit
  Future<void> _loadUserDataToCubit(AuthCubit authCubit, String userId) async {
    try {
      print("=== [SplashPage] Memuat data user ke AuthCubit...");

      // Panggil method getCurrentUser dari AuthCubit
      authCubit.getCurrentUser(userId);

      // Tunggu sampai state berubah menjadi AuthSuccess
      await _waitForAuthSuccess(authCubit);

      print("=== [SplashPage] Data user berhasil dimuat ke AuthCubit");
    } catch (e) {
      print("!!! [SplashPage] Gagal memuat data user: $e");
      throw e;
    }
  }

  // 👇 METHOD BARU: Tunggu sampai AuthSuccess
  Future<void> _waitForAuthSuccess(AuthCubit authCubit) async {
    final completer = Completer<void>();
    StreamSubscription? subscription;

    subscription = authCubit.stream.listen((state) {
      print("=== [SplashPage] AuthCubit state: ${state.runtimeType}");

      if (state is AuthSuccess) {
        print("=== [SplashPage] AuthSuccess diterima, user: ${state.user.name}");
        if (!completer.isCompleted) {
          subscription?.cancel();
          completer.complete();
        }
      } else if (state is AuthFailed) {
        print("!!! [SplashPage] AuthFailed: ${state.error}");
        if (!completer.isCompleted) {
          subscription?.cancel();
          completer.completeError(state.error);
        }
      }
    });

    // Timeout setelah 10 detik
    final timeout = Future.delayed(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        subscription?.cancel();
        completer.completeError('Timeout loading user data');
      }
    });

    try {
      await completer.future;
    } finally {
      subscription.cancel();
      timeout.ignore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 90,
            right: -50,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: HalfCirclePainter(
                color: const Color(0x33B8FFD8),
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: -75,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: HalfCirclePainter(
                color: const Color(0x3396FFC6),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/lg_text_bumilku.png',
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ],
                  ),
                ),
                const CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  backgroundColor: kBoxGreenColor,
                  semanticsLabel: 'Loading...',
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}