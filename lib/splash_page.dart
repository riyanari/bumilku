import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      getInit();
    });
  }

  Future<void> getInit() async {
    // jalanin delay dan inisialisasi prefs bersamaan
    final prefsFuture = SharedPreferences.getInstance();
    final delayFuture = Future.delayed(const Duration(seconds: 3));
    final prefs = await prefsFuture;
    await delayFuture;

    if (!mounted) return;

    // cek flag utama
    final hasOnboarded = prefs.getBool('hasOnboardedMenstruasi') ?? false;

    // opsi fallback: kalau ada data lama juga dianggap sudah onboarding
    final recordsJson = prefs.getString('pregnancyRecords');
    final hasRecords = recordsJson != null && recordsJson != '[]';

    final goHome = hasOnboarded || hasRecords;

    // hapus seluruh stack supaya tidak bisa back ke splash/onboarding
    Navigator.pushNamedAndRemoveUntil(
      context,
      goHome ? '/home' : '/onboarding',
          (route) => false,
    );
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
                  color: const Color(
                      0x33B8FFD8)), // Gunakan painter yang telah Anda buat
            ),
          ),
          Positioned(
            top: -30,
            right: -75,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: HalfCirclePainter(
                  color: const Color(
                      0x3396FFC6)), // Gunakan painter yang telah Anda buat
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
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}