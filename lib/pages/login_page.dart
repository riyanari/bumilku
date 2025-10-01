import 'package:bumilku_app/pages/signup/onboarding_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../components/loading_button.dart';
import '../theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  bool kunciPassword = true;
  bool isUsernameError = false;
  bool isPasswordError = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validasi form
    setState(() {
      isUsernameError = username.isEmpty;
      isPasswordError = password.isEmpty;
    });

    if (!isUsernameError && !isPasswordError) {
      // Panggil AuthCubit untuk login
      context.read<AuthCubit>().signIn(
        username: username,
        password: password,
      );
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          _showErrorDialog(state.error);
        } else if (state is AuthSuccess) {
          // Login berhasil, navigasi ke home
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Stack(
          children: [
            _imageLogin(),
            _formLogin(context, isLoading),
            if (isLoading) _loadingOverlay(),
          ],
        );
      },
    );
  }

  Widget _loadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha:0.3),
      child: Center(
        child: CircularProgressIndicator(),
      ),
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

  Widget _formLogin(BuildContext context, bool isLoading) {
    return Semantics(
      label: 'Login form',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            decoration: BoxDecoration(
              color: tPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                Semantics(
                  label: 'Username Input Field. Masukkan username',
                  child: TextFormField(
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Username',
                      hintStyle: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      errorText: isUsernameError ? 'Username harus diisi' : null,
                    ),
                    onChanged: (value) {
                      if (isUsernameError && value.isNotEmpty) {
                        setState(() {
                          isUsernameError = false;
                        });
                      }
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Semantics(
                  label: 'Password Input Field. Masukkan Password',
                  child: TextFormField(
                    obscureText: kunciPassword,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Password',
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
                          label: kunciPassword
                              ? 'Show password'
                              : 'Hide password',
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
                      errorText: isPasswordError ? 'Password harus diisi' : null,
                    ),
                    onChanged: (value) {
                      if (isPasswordError && value.isNotEmpty) {
                        setState(() {
                          isPasswordError = false;
                        });
                      }
                    },
                    onFieldSubmitted: (value) {
                      _login();
                    },
                  ),
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const LoadingButton()
                    : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Semantics(
                    label: 'Login',
                    hint: 'Press to log in',
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
                          "Login",
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
                    Text("Belum punya akun? ", style: secondaryTextStyle),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OnboardingSignupPage(),
                          ),
                        );
                      },
                      child: Text("Sign Up", style: whiteTextStyle),
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

  void _togglePasswordVisibility() {
    setState(() {
      kunciPassword = !kunciPassword;
    });
  }
}