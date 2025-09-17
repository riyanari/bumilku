import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'congrats_page.dart';

class LoadingPage extends StatefulWidget {
  final String babyName;
  final DateTime edd;

  const LoadingPage({super.key, required this.babyName, required this.edd});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin {
  int _dot = 1;
  Timer? _dotTimer;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Controller untuk progress 0..1 selama 2.2 detik
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )
      ..addListener(() => setState(() {})) // update UI setiap frame
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CongratsPage(
                babyName: widget.babyName,
                edd: widget.edd,
              ),
            ),
          );
        }
      })
      ..forward();

    // Animasi titik-titik pada teks
    _dotTimer = Timer.periodic(const Duration(milliseconds: 400), (t) {
      if (!mounted) return;
      setState(() => _dot = _dot % 3 + 1);
    });
  }

  @override
  void dispose() {
    _dotTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dots = '.' * _dot; // 1..3 titik
    final percent = (_controller.value * 100).clamp(0, 100).round();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lingkaran progress + angka persen di tengah
            SizedBox(
              width: 110,
              height: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      backgroundColor: kBoxGreenColor,
                      strokeWidth: 14,
                      value: _controller.value, // determinate progress
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Menyiapkan Bumilku$dots',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Mohon tunggu sebentar',
              style: blackTextStyle.copyWith(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
