import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/locale_cubit.dart';
import '../models/medis_model.dart';
import '../theme/theme.dart';
import 'HomePage.dart';

class CongratsPage extends StatelessWidget {
  final MedisModel medis;

  const CongratsPage({super.key, required this.medis});

  @override
  Widget build(BuildContext context) {
    debugPrint("=== [CongratsPage] Data Medis ===");
    debugPrint("id: ${medis.id}");
    debugPrint("userId: ${medis.userId}");
    debugPrint("babyName: ${medis.babyName}");
    debugPrint("EDD: ${medis.edd}");
    debugPrint("cycleLength: ${medis.cycleLength}");
    debugPrint("selectedLmp: ${medis.selectedLmp}");
    debugPrint("pregnancyOrder: ${medis.pregnancyOrder}");
    debugPrint("createdAt: ${medis.createdAt}");

    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        // Locale untuk format tanggal
        final fmtLocale = isEn ? 'en_US' : 'id_ID';
        final dateFmt = DateFormat('d MMMM y', fmtLocale);

        // Nama bayi fallback
        final babyName = (medis.babyName != null && medis.babyName!.trim().isNotEmpty)
            ? medis.babyName!.trim()
            : (isEn ? "Baby" : "Bayi");

        // Strings
        final title = isEn ? 'Congratulations, Mom!' : 'Selamat, Bunda!';
        final subtitle = isEn
            ? 'You will meet $babyName on'
            : 'Bunda akan bertemu $babyName pada';
        final buttonText = isEn ? 'Start' : 'Mulai';

        return Scaffold(
          backgroundColor: tSecondary10Color,
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background
              Image.asset('assets/bg_congrats.png', fit: BoxFit.cover),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    children: [
                      // Gambar burung
                      Image.asset(
                        'assets/img_bird.png',
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("assets/left_padi.png", height: 80),
                              Column(
                                children: [
                                  Text(
                                    title,
                                    style: primaryTextStyle.copyWith(
                                      fontWeight: bold,
                                      fontSize:
                                      MediaQuery.of(context).size.width < 390
                                          ? 18
                                          : 22,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    subtitle,
                                    style: blackTextStyle.copyWith(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    dateFmt.format(medis.edd),
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              Image.asset("assets/right_padi.png", height: 80),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => const HomePage()),
                                      (route) => false,
                                );
                              },
                              child: Text(
                                buttonText,
                                style: whiteTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
