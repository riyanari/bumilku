import 'package:bumilku_app/pages/signup/onboarding_sign_up.dart';
import 'package:flutter/material.dart';
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
  bool isLoading = false;
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

  @override
  Widget build(BuildContext context) {

    void togglePasswordVisibility() {
      setState(() {
        kunciPassword = !kunciPassword;
      });
    }


    Widget imageLogin() {
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

    Widget formLogin() {
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
                        errorText: isUsernameError ? 'username Harus diisi' : null,
                      ),
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
                          onTap: togglePasswordVisibility,
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
                        errorText: isPasswordError ? 'Password Harus diisi' : null,
                      ),
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
                        onPressed: (){
                          Navigator.of(context).pushReplacementNamed('/home');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Login",
                              style: whiteTextStyle.copyWith(
                                  fontWeight: extraBold,
                                  fontSize: 14
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Belum punya akun? ", style: secondaryTextStyle,),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OnboardingSignupPage(),
                              ),
                            );
                          },
                          child: Text("Sign Up", style: whiteTextStyle,)),
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

    return Semantics(
      label: 'Login Page',
      child: Scaffold(
        body: Stack(
          children: [
            imageLogin(),
            formLogin(),
          ],
        ),
      ),
    );
  }
}
