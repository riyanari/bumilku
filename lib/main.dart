import 'package:bumilku_app/cubit/auth_cubit.dart';
import 'package:bumilku_app/cubit/medis_cubit.dart';
import 'package:bumilku_app/pages/HomePage.dart';
import 'package:bumilku_app/pages/login_page.dart';
import 'package:bumilku_app/pages/signup/onboarding_sign_up.dart';
import 'package:bumilku_app/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthCubit(),
        ),
        BlocProvider(
            create: (context) => MedisCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash': (_) => const SplashPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => HomePage(),
          '/onboarding': (_) => OnboardingSignupPage(),
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
      ),
    );
  }
}
