import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class DataSignUpPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController; // UBAH: usernameController -> emailController
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool kunciPassword;
  final bool kunciConfirmPassword;
  final VoidCallback togglePasswordVisibility;
  final VoidCallback toggleConfirmPasswordVisibility;
  final VoidCallback signUp;
  final bool isLoading; // TAMBAH: loading state

  const DataSignUpPage({
    super.key,
    required this.formKey,
    required this.emailController, // UBAH: usernameController -> emailController
    required this.passwordController,
    required this.confirmPasswordController,
    required this.kunciPassword,
    required this.kunciConfirmPassword,
    required this.togglePasswordVisibility,
    required this.toggleConfirmPasswordVisibility,
    required this.signUp,
    this.isLoading = false, // TAMBAH: default false
  });

  Widget _buildPasswordStrengthIndicator() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: passwordController,
      builder: (context, value, child) {
        final password = value.text;
        int strength = 0;
        if (password.length >= 6) strength++;
        if (password.contains(RegExp(r'[A-Z]'))) strength++;
        if (password.contains(RegExp(r'[0-9]'))) strength++;
        if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

        Color _getStrengthColor(int s) {
          switch (s) {
            case 1: return Colors.red;
            case 2: return Colors.orange;
            case 3: return Colors.yellow[700]!;
            case 4: return Colors.green;
            default: return Colors.grey;
          }
        }

        String _getStrengthText(int s) {
          switch (s) {
            case 1: return 'Lemah';
            case 2: return 'Cukup';
            case 3: return 'Baik';
            case 4: return 'Kuat';
            default: return '';
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kekuatan Password:',
                style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Row(
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                    decoration: BoxDecoration(
                      color: index < strength ? _getStrengthColor(strength) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 4),
            Text(
              _getStrengthText(strength),
              style: TextStyle(fontSize: 11, color: _getStrengthColor(strength), fontWeight: FontWeight.w600),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        children: [
          // === Logo ===
          Image.asset('assets/lg_bumilku.png',
              height: MediaQuery.of(context).size.height * 0.12,
              filterQuality: FilterQuality.high),
          const SizedBox(height: 20),

          // === Header ===
          Text('Daftar Akun Baru',
              style: primaryTextStyle.copyWith(fontSize: 28, fontWeight: bold)),
          const SizedBox(height: 20),

          // === Card Form ===
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha:0.1), blurRadius: 20, offset: const Offset(0, 10)), // PERBAIKI: withOpacity
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Email (UBAH: dari Username ke Email)
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress, // TAMBAH: keyboard type email
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined), // UBAH: icon dari person ke email
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: kunciPassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(kunciPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          onPressed: togglePasswordVisibility,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Password wajib diisi';
                        if (v.length < 6) return 'Password minimal 6 karakter';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: kunciConfirmPassword,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(kunciConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          onPressed: toggleConfirmPasswordVisibility,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Konfirmasi password wajib diisi';
                        if (v != passwordController.text) return 'Password tidak cocok';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    _buildPasswordStrengthIndicator(),

                    // TAMBAH: Loading Button atau Regular Button
                    // const SizedBox(height: 24),
                    // if (isLoading)
                    //   SizedBox(
                    //     width: double.infinity,
                    //     height: 52,
                    //     child: ElevatedButton(
                    //       onPressed: null,
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: kPrimaryColor.withValues(alpha:0.7),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //         ),
                    //       ),
                    //       child: const Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           SizedBox(
                    //             height: 20,
                    //             width: 20,
                    //             child: CircularProgressIndicator(
                    //               strokeWidth: 2,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //           SizedBox(width: 12),
                    //           Text(
                    //             'Mendaftarkan...',
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 16,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   )
                    // else
                    //   SizedBox(
                    //     width: double.infinity,
                    //     height: 52,
                    //     child: ElevatedButton(
                    //       onPressed: signUp,
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: kPrimaryColor,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //         ),
                    //         elevation: 0,
                    //       ),
                    //       child: Text(
                    //         'Daftar',
                    //         style: whiteTextStyle.copyWith(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
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