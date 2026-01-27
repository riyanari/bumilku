import 'package:bumilku_app/cubit/auth_cubit.dart';
import 'package:bumilku_app/cubit/medis_cubit.dart';
import 'package:bumilku_app/cubit/self_detection_cubit.dart';
import 'package:bumilku_app/pages/HomePage.dart';
import 'package:bumilku_app/pages/admin/list_bunda_page.dart';
import 'package:bumilku_app/pages/login_page.dart';
import 'package:bumilku_app/pages/signup/onboarding_sign_up.dart';
import 'package:bumilku_app/pages/tutorial_video_page.dart';
import 'package:bumilku_app/splash_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubit/locale_cubit.dart';
import 'firebase_options.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ✅ Aktifkan App Check (pilih salah satu mode di bawah)
  await FirebaseAppCheck.instance.activate(
    // Untuk DEV cepat (disarankan saat development)
    androidProvider: AndroidProvider.debug,

    // Untuk PRODUCTION (lebih aman)
    // androidProvider: AndroidProvider.playIntegrity,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => MedisCubit()),
        BlocProvider(create: (context) => SelfDetectionCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,

            // ✅ ini sekarang valid karena dari cubit
            initialRoute: '/splash',
            routes: {
              '/splash': (_) => const SplashPage(),
              '/tutorial': (_) => const TutorialVideoPage(),
              '/login': (_) => const LoginPage(),
              '/home': (_) => const HomePage(),
              '/onboarding': (_) => OnboardingSignupPage(),
              '/list-bunda': (_) => const ListBundaPage(),
            },

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('id'), Locale('en')],
          );
        },
      ),
    );
  }
}
