import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';

class LoadingSelfDetectionPage extends StatelessWidget {
  const LoadingSelfDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ),
            const SizedBox(height: 20),
            Text(
              "Sedang menghitung risiko...",
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}