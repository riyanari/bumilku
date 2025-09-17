import 'package:bumilku_app/pages/HomePage.dart';
import 'package:bumilku_app/pages/onboarding_menstruasi_page.dart';
import 'package:bumilku_app/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/onboarding': (_) => const OnboardingMenstruasiPage(),
        '/home': (_) => HomePage(),
      },
      // ✅ Tambahkan localization
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'), // Bahasa Indonesia
      ],
    );
  }
}
