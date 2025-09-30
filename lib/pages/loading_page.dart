import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/medis_cubit.dart';
import '../models/medis_model.dart';
import '../theme/theme.dart';
import 'congrats_page.dart';
import 'HomePage.dart';

class LoadingPage extends StatefulWidget {
  final String userId;

  const LoadingPage({super.key, required this.userId});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  int _dot = 1;
  Timer? _dotTimer;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Mulai fetch data
    context.read<MedisCubit>().getUserMedis(widget.userId);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )
      ..addListener(() => setState(() {}))
      ..forward();

    _dotTimer = Timer.periodic(const Duration(milliseconds: 400), (t) {
      if (!mounted) return;
      setState(() => _dot = _dot % 3 + 1);
    });
  }

  void _navigateToCongrats(MedisModel? medis) {
    if (!mounted) return;
    final fallbackMedis = medis ??
        MedisModel(
          id: 'temp',
          userId: widget.userId,
          cycleLength: 28,
          selectedLmp: DateTime.now(),
          edd: DateTime.now().add(const Duration(days: 280)),
          babyName: "Bayi",
          pregnancyOrder: 1,
          createdAt: DateTime.now(),
        );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CongratsPage(medis: fallbackMedis),
      ),
    );
  }

  @override
  void dispose() {
    _dotTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dots = '.' * _dot;
    final percent = (_controller.value * 100).clamp(0, 100).round();

    return BlocListener<MedisCubit, MedisState>(
      listener: (context, state) {
        if (state is MedisSuccess) {
          final medis = state.activeMedis ??
              (state.medisHistory.isNotEmpty ? state.medisHistory.first : null);

          Future.delayed(const Duration(seconds: 3), () {
            _navigateToCongrats(medis);
          });
        } else if (state is MedisFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Gagal memuat data medis: ${state.error}")),
          );
          Future.delayed(const Duration(seconds: 3), () {
            _navigateToCongrats(null); // tetap ke Congrats walau error
          });
        }
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      backgroundColor: kBoxGreenColor,
                      strokeWidth: 14,
                      value: _controller.value,
                    ),
                    Text(
                      '$percent%',
                      style: primaryTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Menyiapkan Bumilku$dots',
                style:
                primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Mohon tunggu sebentar',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
