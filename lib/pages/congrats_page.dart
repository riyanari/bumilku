import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/theme.dart';
import 'HomePage.dart';

class CongratsPage extends StatelessWidget {
  final String babyName;
  final DateTime edd;

  const CongratsPage({super.key, required this.babyName, required this.edd});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('d MMMM y', 'id_ID');

    return Scaffold(
      // backgroundColor diabaikan karena kita pakai background image full
      backgroundColor: tSecondary10Color,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image full screen
          Image.asset(
            'assets/bg_congrats.png',
            fit: BoxFit.cover,
          ),

          // (opsional) overlay tipis biar teks tetap kebaca
          // Container(color: Colors.black.withOpacity(0.1)),

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
                          Image.asset("assets/left_padi.png", height: 80,),
                          Column(
                            children: [
                              Text(
                                'Selamat, Bunda!',
                                style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 22),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Bunda akan bertemu $babyName pada',
                                style: blackTextStyle.copyWith(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                dateFmt.format(edd),
                                style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: bold),
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => HomePage()),
                                  (route) => false,
                            );
                          },
                          child: Text('Mulai', style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 14)),
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
