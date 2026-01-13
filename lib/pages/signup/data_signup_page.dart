import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/theme.dart';

class DataSignUpPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool kunciPassword;
  final bool kunciConfirmPassword;
  final VoidCallback togglePasswordVisibility;
  final VoidCallback toggleConfirmPasswordVisibility;
  final VoidCallback signUp;
  final bool isLoading;

  const DataSignUpPage({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.kunciPassword,
    required this.kunciConfirmPassword,
    required this.togglePasswordVisibility,
    required this.toggleConfirmPasswordVisibility,
    required this.signUp,
    this.isLoading = false,
  });

  Widget _buildPasswordStrengthIndicator(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: passwordController,
      builder: (context, value, child) {
        final password = value.text;
        int strength = 0;

        if (password.length >= 6) strength++;
        if (password.contains(RegExp(r'[A-Z]'))) strength++;
        if (password.contains(RegExp(r'[0-9]'))) strength++;
        if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

        Color getStrengthColor(int s) {
          switch (s) {
            case 1:
              return Colors.red;
            case 2:
              return Colors.orange;
            case 3:
              return Colors.yellow[700]!;
            case 4:
              return Colors.green;
            default:
              return Colors.grey;
          }
        }

        String getStrengthText(int s) {
          switch (s) {
            case 1:
              return t.passwordStrengthWeak; // "Lemah" / "Weak"
            case 2:
              return t.passwordStrengthFair; // "Cukup" / "Fair"
            case 3:
              return t.passwordStrengthGood; // "Baik" / "Good"
            case 4:
              return t.passwordStrengthStrong; // "Kuat" / "Strong"
            default:
              return '';
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.passwordStrengthLabel, // "Kekuatan Password:" / "Password strength:"
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                    decoration: BoxDecoration(
                      color: index < strength
                          ? getStrengthColor(strength)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 4),
            Text(
              getStrengthText(strength),
              style: TextStyle(
                fontSize: 11,
                color: getStrengthColor(strength),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        children: [
          Image.asset(
            'assets/lg_bumilku.png',
            height: MediaQuery.of(context).size.height * 0.12,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 20),

          Text(
            t.signUpNewAccountTitle, // "Daftar Akun Baru" / "Create New Account"
            style: primaryTextStyle.copyWith(fontSize: 28, fontWeight: bold),
          ),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: t.emailHint, // "Email"
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (v) {
                        final value = (v ?? '').trim();
                        if (value.isEmpty) return t.emailRequired; // "Email wajib diisi"
                        if (!_isValidEmail(value)) return t.emailInvalid; // "Format email tidak valid"
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: kunciPassword,
                      decoration: InputDecoration(
                        hintText: t.passwordHint, // "Password"
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            kunciPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: togglePasswordVisibility,
                          tooltip: kunciPassword
                              ? t.showPassword // "Tampilkan password" / "Show password"
                              : t.hidePassword, // "Sembunyikan password" / "Hide password"
                        ),
                      ),
                      validator: (v) {
                        final value = (v ?? '');
                        if (value.isEmpty) return t.passwordRequired; // "Password wajib diisi"
                        if (value.length < 6) return t.passwordMin6; // "Password minimal 6 karakter"
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: kunciConfirmPassword,
                      decoration: InputDecoration(
                        hintText: t.confirmPasswordHint, // "Konfirmasi Password"
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            kunciConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: toggleConfirmPasswordVisibility,
                          tooltip: kunciConfirmPassword
                              ? t.showPassword
                              : t.hidePassword,
                        ),
                      ),
                      validator: (v) {
                        final value = (v ?? '');
                        if (value.isEmpty) return t.confirmPasswordRequired; // "Konfirmasi password wajib diisi"
                        if (value != passwordController.text) return t.passwordNotMatch; // "Password tidak cocok"
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    _buildPasswordStrengthIndicator(context),

                    const SizedBox(height: 24),

                    // Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLoading
                              ? kPrimaryColor.withValues(alpha: 0.7)
                              : kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              t.signingUpLoading, // "Mendaftarkan..." / "Signing up..."
                              style: whiteTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                            : Text(
                          t.signUpButton, // "Daftar" / "Sign up"
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
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
