import 'dart:async';

import 'package:bumilku_app/services/medis_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/half_circle_painter.dart';
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

    await Future.delayed(const Duration(seconds: 2)); // splash delay

    if (!mounted) return;

    if (user == null) {
      print("=== [SplashPage] User belum login → ke /login");
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    } else {
      try {
        // 🔑 perbaikan: cek data medis berdasarkan userId
        print("=== [SplashPage] Cek data medis untuk userId: ${user.uid}");
        final medis = await MedisServices().getActiveMedis(user.uid);

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
      } catch (e) {
        print("!!! [SplashPage] ERROR ambil data medis: $e");
        Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (_) => false);
      }
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
