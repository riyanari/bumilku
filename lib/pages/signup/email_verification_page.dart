import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/locale_cubit.dart';
import '../HomePage.dart';
import '../login_page.dart';

class EmailVerificationPage extends StatefulWidget {
  final String userId;
  final String email;

  const EmailVerificationPage({
    Key? key,
    required this.userId,
    required this.email,
  }) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _isResending = false;

  Timer? _verificationTimer; // cek verifikasi tiap 5 detik
  Timer? _secondsTimer; // counter detik
  int _secondsElapsed = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("=== [EmailVerificationPage] Init for user: ${widget.userId} ===");
    _startVerificationCheck();
    _startSecondsTimer();
  }

  void _startVerificationCheck() {
    _verificationTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final authCubit = context.read<AuthCubit>();
        await authCubit.checkEmailVerification();
      } catch (e) {
        debugPrint("Error checking verification: $e");
      }
    });
  }

  void _startSecondsTimer() {
    _secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  Future<void> _resendVerificationEmail() async {
    final isEn = context.read<LocaleCubit>().state.languageCode == 'en';

    setState(() => _isResending = true);
    try {
      final authCubit = context.read<AuthCubit>();
      await authCubit.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEn
                      ? 'Verification email has been resent'
                      : 'Email verifikasi telah dikirim ulang',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEn ? 'Failed to send email: $e' : 'Gagal mengirim email: $e',
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  void _navigateToHome() {
    _verificationTimer?.cancel();
    _secondsTimer?.cancel();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    _verificationTimer?.cancel();
    _secondsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        final appBarTitle = isEn ? 'Email Verification' : 'Verifikasi Email';
        final title = isEn ? 'Verify Your Email' : 'Verifikasi Email Anda';

        final desc1 = isEn
            ? 'We have sent a verification link to your email:'
            : 'Kami telah mengirimkan link verifikasi ke email Anda:';

        final infoText = isEn
            ? 'Open your email and click the verification link we sent to activate your account.'
            : 'Buka email Anda dan klik link verifikasi yang telah kami kirimkan untuk mengaktifkan akun Anda.';

        final resendText = isEn ? 'Resend Email' : 'Kirim Ulang Email';

        final autoCheckText = isEn
            ? 'Auto check: $_secondsElapsed seconds'
            : 'Pemeriksaan otomatis: $_secondsElapsed detik';

        final backToLoginText = isEn ? 'Back to Login' : 'Kembali ke Halaman Login';

        final verifiedSnack = isEn
            ? 'Email verified! Redirecting...'
            : 'Email berhasil diverifikasi! Mengarahkan...';

        final checkingText =
        isEn ? 'Checking verification status...' : 'Memeriksa status verifikasi...';

        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            debugPrint("=== [EmailVerificationPage] Auth State: $state ===");

            if (state is AuthSuccess) {
              debugPrint("=== [EmailVerificationPage] Email verified successfully! ===");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.verified, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          verifiedSnack,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              Future.delayed(const Duration(seconds: 2), _navigateToHome);
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                appBarTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // Header Illustration
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mark_email_unread_outlined,
                        size: 60,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Description
                    Text(
                      desc1,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    // Email Address
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 24,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Instructions
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              infoText,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade800,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Resend Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isResending ? null : _resendVerificationEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isResending
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.refresh, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              resendText,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Timer Info
                    Text(
                      autoCheckText,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Back to Login
                    TextButton(
                      onPressed: () {
                        _verificationTimer?.cancel();
                        _secondsTimer?.cancel();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                              (route) => false,
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey.shade600,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back, size: 16),
                          const SizedBox(width: 8),
                          Text(backToLoginText),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Loading Indicator
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return Column(
                            children: [
                              const CircularProgressIndicator(color: Colors.orange),
                              const SizedBox(height: 16),
                              Text(
                                checkingText,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
