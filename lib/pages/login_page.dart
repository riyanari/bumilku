import 'package:bumilku_app/pages/signup/email_verification_page.dart';
import 'package:bumilku_app/pages/signup/onboarding_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/locale_cubit.dart';
import '../components/loading_button.dart';
import '../theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  bool kunciPassword = true;
  bool isEmailError = false;
  bool isPasswordError = false;
  String? _loginError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      isEmailError = email.isEmpty;
      isPasswordError = password.isEmpty;
      _loginError = null;
    });

    if (!isEmailError && !isPasswordError) {
      context.read<AuthCubit>().signIn(
        email: email,
        password: password,
      );
    }
  }

  void _navigateToEmailVerification(String userId, String email) {
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

  void _showForgotPasswordDialog(bool isEn) {
    final TextEditingController forgotPasswordController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEn ? "Forgot Password" : "Lupa Password",
          style: primaryTextStyle,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEn
                  ? "Enter your email to reset your password"
                  : "Masukkan email Anda untuk mengatur ulang password",
              style: secondaryTextStyle,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: forgotPasswordController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: isEn ? "Email" : "Email",
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEn ? "Cancel" : "Batal",
              style: secondaryTextStyle,
            ),
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthPasswordResetSent) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEn
                          ? "Password reset email has been sent!"
                          : "Email reset password telah dikirim!",
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: TextButton(
              onPressed: () {
                final email = forgotPasswordController.text.trim();
                if (email.isNotEmpty) {
                  context.read<AuthCubit>().resetPassword(email);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEn
                            ? "Please enter your email."
                            : "Silakan isi email terlebih dahulu.",
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              child: Text(
                isEn ? "Send" : "Kirim",
                style: primaryTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      kunciPassword = !kunciPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final isEn = locale.languageCode == 'en';

        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              if (state.error.contains('EMAIL_NOT_VERIFIED')) {
                final parts = state.error.split(':');
                if (parts.length >= 3) {
                  final userId = parts[1];
                  final userEmail = parts[2];
                  debugPrint(
                    "=== [LoginPage] Email belum terverifikasi, navigasi ke verification page ===",
                  );
                  _navigateToEmailVerification(userId, userEmail);
                  return;
                }
              }

              setState(() {
                _loginError = state.error;
              });
            } else if (state is AuthSuccess) {
              final user = state.user;
              if (user.role.toLowerCase() == 'admin') {
                Navigator.of(context).pushReplacementNamed('/list-bunda');
              } else {
                Navigator.of(context).pushReplacementNamed('/home');
              }
            }
          },
          child: Scaffold(
            body: _buildBody(context, isEn),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, bool isEn) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Stack(
          children: [
            _imageLogin(),
            _formLogin(context, isLoading, isEn),
          ],
        );
      },
    );
  }

  Widget _imageLogin() {
    return Semantics(
      label: 'Bumilku Smart Logo',
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Semantics(
              label: 'Bumilku Logo',
              child: Image.asset(
                'assets/lg_text_bumilku.png',
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formLogin(BuildContext context, bool isLoading, bool isEn) {
    final hintEmail = isEn ? 'Enter Email' : 'Masukkan Email';
    final hintPass = isEn ? 'Enter Password' : 'Masukkan Password';
    final errEmail = isEn ? 'Email is required' : 'Email harus diisi';
    final errPass = isEn ? 'Password is required' : 'Password harus diisi';

    final forgot = isEn ? 'Forgot Password?' : 'Lupa Password?';
    final loginTxt = isEn ? 'Login' : 'Login';

    final dontHave = isEn ? "Don't have an account? " : "Belum punya akun? ";
    final signUp = isEn ? "Sign Up" : "Sign Up";

    return Semantics(
      label: 'Login form',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            decoration: BoxDecoration(
              color: tPrimaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                Semantics(
                  label: isEn ? 'Email input field' : 'Email Input Field. Masukkan email',
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: hintEmail,
                      hintStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email, color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      errorText: isEmailError ? errEmail : null,
                    ),
                    onChanged: (value) {
                      if (isEmailError && value.isNotEmpty) {
                        setState(() => isEmailError = false);
                      }
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Semantics(
                  label:
                  isEn ? 'Password input field' : 'Password Input Field. Masukkan Password',
                  child: TextFormField(
                    obscureText: kunciPassword,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: hintPass,
                      hintStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                        color: kPrimaryColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _togglePasswordVisibility,
                        child: Semantics(
                          label: kunciPassword ? 'Show password' : 'Hide password',
                          child: Icon(
                            kunciPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 1.0,
                        ),
                      ),
                      errorText: isPasswordError ? errPass : null,
                    ),
                    onChanged: (value) {
                      if (isPasswordError && value.isNotEmpty) {
                        setState(() => isPasswordError = false);
                      }
                    },
                    onFieldSubmitted: (_) => _login(),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _showForgotPasswordDialog(isEn),
                      child: Text(
                        forgot,
                        style: whiteTextStyle.copyWith(fontSize: 12),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),

                if (_loginError != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _loginError!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red.shade600,
                            size: 16,
                          ),
                          onPressed: () {
                            setState(() => _loginError = null);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                isLoading
                    ? const LoadingButton()
                    : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Semantics(
                    label: loginTxt,
                    hint: isEn ? 'Press to log in' : 'Tekan untuk masuk',
                    button: true,
                    enabled: !isLoading,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: _login,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          loginTxt,
                          style: whiteTextStyle.copyWith(
                            fontWeight: extraBold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(dontHave, style: secondaryTextStyle),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OnboardingSignupPage(),
                          ),
                        );
                      },
                      child: Text(signUp, style: whiteTextStyle),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
