import 'dart:async';

import 'package:bumilku_app/pages/signup/DataMensPage.dart';
import 'package:bumilku_app/pages/signup/data_diri_page.dart';
import 'package:bumilku_app/pages/signup/data_signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/locale_cubit.dart';
import '../../cubit/medis_cubit.dart';
import '../../theme/theme.dart';
import 'email_verification_page.dart';

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
  final emailController = TextEditingController();
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
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authCubit = context.read<AuthCubit>();
      final medisCubit = context.read<MedisCubit>();

      final isEn = context.read<LocaleCubit>().state.languageCode == 'en';

      // Validasi data lengkap
      if (_selectedTanggalLahir == null) {
        _showErrorSnackBar(
          isEn
              ? "Please complete your birth date."
              : "Harap isi tanggal lahir dengan lengkap.",
        );
        setState(() => _isLoading = false);
        return;
      }

      if (selectedLmp == null || edd == null) {
        _showErrorSnackBar(
          isEn
              ? "Please complete your menstrual data."
              : "Harap isi data menstruasi dengan lengkap.",
        );
        setState(() => _isLoading = false);
        return;
      }

      // Stream subscription untuk mendengarkan state changes
      final completer = Completer<void>();
      StreamSubscription? authSubscription;

      authSubscription = authCubit.stream.listen((state) {
        debugPrint("[DEBUG] Auth State: $state");

        if (state is AuthEmailVerificationRequired) {
          debugPrint("[DEBUG] Email verification required for: ${state.email}");
          if (!completer.isCompleted) completer.complete();
        } else if (state is AuthFailed) {
          debugPrint("[DEBUG] AuthFailed: ${state.error}");
          if (!completer.isCompleted) completer.completeError(state.error);
        }
        // JANGAN handle AuthSuccess di sini karena user belum verified
      });

      try {
        // Panggil signUp
        await authCubit.signUp(
          name: _namaController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          role: "bunda",
          alamat: _alamatController.text.trim(),
          tglLahir: _selectedTanggalLahir!,
        );

        // Tunggu sampai proses selesai (harusnya AuthEmailVerificationRequired)
        await completer.future;
        await authSubscription.cancel();

        // Ambil state terbaru
        final authState = authCubit.state;
        if (authState is AuthEmailVerificationRequired) {
          final userId = authState.user.id;
          final email = authState.email;

          debugPrint(
              "=== [OnboardingSignupPage] SignUp berhasil, perlu verifikasi email ===");

          // Simpan data medis
          await medisCubit.addMedis(
            userId: userId,
            cycleLength: cycleLength,
            selectedLmp: selectedLmp!,
            edd: edd!,
            babyName: babyName,
          );

          debugPrint("=== [OnboardingSignupPage] Data medis berhasil disimpan ===");

          // Navigasi ke halaman verifikasi email
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => EmailVerificationPage(
                  userId: userId,
                  email: email,
                ),
              ),
                  (route) => false,
            );
          }
        } else {
          throw Exception("Sign up failed: unexpected state");
        }
      } catch (e) {
        await authSubscription.cancel();
        debugPrint("[ERROR] Sign up process: $e");
        _showErrorSnackBar(_getErrorMessage(e.toString(), isEn: isEn));
      }
    } catch (e) {
      debugPrint("[ERROR] Outer catch: $e");
      if (mounted) {
        final isEn = context.read<LocaleCubit>().state.languageCode == 'en';
        _showErrorSnackBar(_getErrorMessage(e.toString(), isEn: isEn));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getErrorMessage(String error, {required bool isEn}) {
    if (error.contains('email address is already in use') ||
        error.contains('email-already-in-use')) {
      return isEn
          ? 'This email is already in use. Please use a different email.'
          : 'Email sudah digunakan oleh akun lain. Silakan gunakan email yang berbeda.';
    } else if (error.contains('weak password')) {
      return isEn
          ? 'Password is too weak. Please use a stronger password.'
          : 'Password terlalu lemah. Gunakan password yang lebih kuat.';
    } else if (error.contains('invalid-email')) {
      return isEn ? 'Invalid email format.' : 'Format email tidak valid.';
    } else if (error.contains('network-request-failed')) {
      return isEn
          ? 'Network error. Please check your internet connection.'
          : 'Koneksi internet bermasalah. Periksa koneksi Anda.';
    } else if (error.contains('Email belum terverifikasi')) {
      return isEn
          ? 'Email is not verified yet. Please check your inbox.'
          : 'Email belum terverifikasi. Silakan cek email Anda untuk verifikasi.';
    } else {
      return isEn ? 'An error occurred: $error' : 'Terjadi kesalahan: $error';
    }
  }

  void _showErrorSnackBar(String message) {
    final isEn = context.read<LocaleCubit>().state.languageCode == 'en';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: isEn ? 'Close' : 'Tutup',
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
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        final backText = isEn ? 'Back' : 'Kembali';
        final nextText = isEn ? 'Next' : 'Lanjutkan';
        final registerText = isEn ? 'Register' : 'Daftar';

        final canNextPage0 = _namaController.text.trim().isNotEmpty &&
            _alamatController.text.trim().isNotEmpty &&
            _tanggalLahirController.text.trim().isNotEmpty;

        final canNextPage1 = selectedLmp != null;

        final isEnabled = (_currentPage == 0 && canNextPage0) ||
            (_currentPage == 1 && canNextPage1) ||
            (_currentPage == 2);

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
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        kunciPassword: kunciPassword,
                        kunciConfirmPassword: kunciConfirmPassword,
                        togglePasswordVisibility: () =>
                            setState(() => kunciPassword = !kunciPassword),
                        toggleConfirmPasswordVisibility: () =>
                            setState(() => kunciConfirmPassword = !kunciConfirmPassword),
                        signUp: _signUp,
                        isLoading: _isLoading,
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
                            onPressed: _isLoading
                                ? null
                                : () => _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: kPrimaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 52),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              backText,
                              style: whiteTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 16,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                            if (_currentPage == 0) {
                              if (!canNextPage0) return;
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else if (_currentPage == 1) {
                              if (!canNextPage1) return;
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else if (_currentPage == 2) {
                              _signUp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isEnabled
                                ? kPrimaryColor
                                : Colors.grey.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                            minimumSize: const Size(double.infinity, 52),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text(
                            _currentPage == 2 ? registerText : nextText,
                            style: whiteTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 16,
                            ),
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
      },
    );
  }
}
