import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medis_model.dart';
import '../theme/theme.dart';
import 'HomePage.dart';

class CongratsPage extends StatelessWidget {
  final MedisModel medis;

  const CongratsPage({super.key, required this.medis});

  @override
  Widget build(BuildContext context) {
    print("=== [CongratsPage] Data Medis ===");
    print("id: ${medis.id}");
    print("userId: ${medis.userId}");
    print("babyName: ${medis.babyName}");
    print("EDD: ${medis.edd}");
    print("cycleLength: ${medis.cycleLength}");
    print("selectedLmp: ${medis.selectedLmp}");
    print("pregnancyOrder: ${medis.pregnancyOrder}");
    print("createdAt: ${medis.createdAt}");

    final dateFmt = DateFormat('d MMMM y', 'id_ID');
    final babyName = medis.babyName ?? "Bayi";

    return Scaffold(
      backgroundColor: tSecondary10Color,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset('assets/bg_congrats.png', fit: BoxFit.cover),

          // Konten utama
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
                                'Selamat, Bunda!',
                                style: primaryTextStyle.copyWith(
                                  fontWeight: bold,
                                  fontSize: MediaQuery.of(context).size.width < 390 ? 18 : 22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bunda akan bertemu $babyName pada',
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
                              MaterialPageRoute(builder: (_) => HomePage()),
                                  (route) => false,
                            );
                          },
                          child: Text(
                            'Mulai',
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
  }
}
