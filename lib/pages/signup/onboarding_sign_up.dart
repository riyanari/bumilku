import 'dart:async';

import 'package:bumilku_app/pages/loading_page.dart';
import 'package:bumilku_app/pages/signup/DataMensPage.dart';
import 'package:bumilku_app/pages/signup/data_diri_page.dart';
import 'package:bumilku_app/pages/signup/data_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/medis_cubit.dart';
import '../../theme/theme.dart';

class OnboardingSignupPage extends StatefulWidget {
  const OnboardingSignupPage({super.key});

  @override
  State<OnboardingSignupPage> createState() => _OnboardingSignupPageState();
}

class _OnboardingSignupPageState extends State<OnboardingSignupPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // === Page 0 ===
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  DateTime? _selectedTanggalLahir;

  // === Page 1 ===
  int cycleLength = 28;
  DateTime? selectedLmp;
  DateTime? edd;
  String? babyName;

  void _recalculateEDD() {
    if (selectedLmp == null) {
      setState(() => edd = null);
      return;
    }
    final adjustment = cycleLength - 28;
    final result = selectedLmp!.add(Duration(days: 280 + adjustment));
    setState(() => edd = result);
  }

  // === Page 2 ===
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool kunciPassword = true;
  bool kunciConfirmPassword = true;
  bool _isLoading = false;

  void _onBabyNameChanged(String name) {
    setState(() {
      babyName = name;
    });
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final authCubit = context.read<AuthCubit>();
        final medisCubit = context.read<MedisCubit>();

        final completer = Completer<AuthSuccess>();
        final authSubscription = authCubit.stream.listen((state) {
          if (state is AuthSuccess) {
            if (!completer.isCompleted) completer.complete(state);
          } else if (state is AuthFailed) {
            if (!completer.isCompleted) completer.completeError(state.error);
          }
        });

        // 👉 pasang listener dulu, baru panggil signUp
        await authCubit.signUp(
          name: _namaController.text.trim(),
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          role: "bunda",
          alamat: _alamatController.text.trim(),
          tglLahir: _selectedTanggalLahir!,
        );

        try {
          final authSuccess = await completer.future;
          await authSubscription.cancel();

          final userId = authSuccess.user.id;
          print("=== [OnboardingSignupPage] SignUp berhasil, userId=$userId ===");

          if (selectedLmp == null || edd == null) {
            _showErrorSnackBar("Harap isi data menstruasi dengan lengkap.");
            return;
          }

          await medisCubit.addMedis(
            userId: userId,
            cycleLength: cycleLength,
            selectedLmp: selectedLmp!,
            edd: edd!,
            babyName: babyName,
          );

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LoadingPage(userId: userId),
              ),
            );
          }
        } catch (e) {
          await authSubscription.cancel();
          _showErrorSnackBar(_getErrorMessage(e.toString()));
        }
      } catch (e) {
        if (mounted) {
          _showErrorSnackBar(_getErrorMessage(e.toString()));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('email address is already in use')) {
      return 'Username sudah digunakan oleh akun lain. Silakan gunakan username yang berbeda.';
    } else if (error.contains('weak password')) {
      return 'Password terlalu lemah. Gunakan password yang lebih kuat.';
    } else if (error.contains('invalid-email')) {
      return 'Format username/email tidak valid.';
    } else if (error.contains('network-request-failed')) {
      return 'Koneksi internet bermasalah. Periksa koneksi Anda.';
    } else {
      return 'Terjadi kesalahan: $error';
    }
  }

  // METHOD BARU: Show error snackbar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Tutup',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _namaController.dispose();
    _alamatController.dispose();
    _tanggalLahirController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  DataDiriPage(
                    namaController: _namaController,
                    alamatController: _alamatController,
                    tanggalLahirController: _tanggalLahirController,
                    selectedTanggalLahir: _selectedTanggalLahir,
                    onTanggalPicked: (date) {
                      setState(() => _selectedTanggalLahir = date);
                    },
                  ),
                  DataMensPage(
                    cycleLength: cycleLength,
                    selectedLmp: selectedLmp,
                    babyName: babyName,
                    edd: edd,
                    onCycleChanged: (val) {
                      setState(() => cycleLength = val);
                      _recalculateEDD();
                    },
                    onLmpChanged: (val) {
                      setState(() => selectedLmp = val);
                      _recalculateEDD();
                    },
                    onBabyNameChanged: _onBabyNameChanged,
                  ),
                  DataSignUpPage(
                    formKey: _formKey,
                    usernameController: usernameController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    kunciPassword: kunciPassword,
                    kunciConfirmPassword: kunciConfirmPassword,
                    togglePasswordVisibility: () =>
                        setState(() => kunciPassword = !kunciPassword),
                    toggleConfirmPasswordVisibility: () =>
                        setState(() => kunciConfirmPassword = !kunciConfirmPassword),
                    signUp: _signUp,
                  ),
                ],
              ),
            ),

            // === Navigation Buttons ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: kPrimaryColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          minimumSize: const Size(double.infinity, 52),
                          backgroundColor: Colors.white,
                        ),
                        child: Text('Kembali',
                            style: whiteTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 16,
                                color: kPrimaryColor)),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == 0) {
                          if (_namaController.text.isEmpty ||
                              _alamatController.text.isEmpty ||
                              _tanggalLahirController.text.isEmpty) return;
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        } else if (_currentPage == 1) {
                          if (selectedLmp == null) return;
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        } else if (_currentPage == 2) {
                          _signUp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        (_currentPage == 0 &&
                            _namaController.text.trim().isNotEmpty &&
                            _alamatController.text.trim().isNotEmpty &&
                            _tanggalLahirController.text
                                .trim()
                                .isNotEmpty) ||
                            (_currentPage == 1 && selectedLmp != null) ||
                            (_currentPage == 2)
                            ? kPrimaryColor
                            : Colors.grey.withValues(alpha:0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                        minimumSize: const Size(double.infinity, 52),
                      ),
                      child: Text(
                        _currentPage == 2 ? 'Daftar' : 'Lanjutkan',
                        style: whiteTextStyle.copyWith(
                            fontWeight: bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
