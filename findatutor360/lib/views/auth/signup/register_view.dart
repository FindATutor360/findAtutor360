// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
// ignore: unused_import
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/auth/email/verify_email/verify_email_view.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/button/secondary_button.dart';
import 'package:findatutor360/custom_widgets/header/custom_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/operation_runner.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const path = '/registerView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends OperationRunnerState<RegisterView> {
  bool checkedValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late AuthController _authController;
  bool _passwordvisible = true;
  bool _confirmPasswordvisible = true;

  @override
  Widget build(BuildContext context) {
    _authController = context.watch<AuthController>();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const CustomHeader(),
                const SizedBox(height: 20),
                const MainText(text: 'Create your account'),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _fullNameController,
                        label: Text('Fullname',
                            style: TextStyle(
                                color: customTheme['secondaryTextColor'])),
                        hint: 'Enter your fullname',
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your fullname';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _emailController,
                        label: Text('Email',
                            style: TextStyle(
                                color: customTheme['secondaryTextColor'])),
                        hint: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      CustomTextFormField(
                        controller: _passwordController,
                        label: Text('Password',
                            style: TextStyle(
                                color: customTheme['secondaryTextColor'])),
                        hint: 'Enter your password',
                        obscureText: _passwordvisible ? true : false,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                _passwordvisible = !_passwordvisible;
                              },
                            );
                          },
                          child: Icon(_passwordvisible == true
                              ? Iconsax.eye
                              : Iconsax.eye_slash),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        label: Text('Confirm Password',
                            style: TextStyle(
                                color: customTheme['secondaryTextColor'])),
                        hint: 'Confirm your password',
                        obscureText: _confirmPasswordvisible ? true : false,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                _confirmPasswordvisible =
                                    !_confirmPasswordvisible;
                              },
                            );
                          },
                          child: Icon(_confirmPasswordvisible == true
                              ? Iconsax.eye
                              : Iconsax.eye_slash),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: CheckboxListTile(
                    title: Text(
                      "I accept the Terms and Conditions",
                      style: GoogleFonts.manrope(
                          fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    value: checkedValue,
                    activeColor: customTheme['primaryColor'],
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _authController.isLoading,
                    builder: (context, isLoading, child) {
                      return isLoading
                          ? const CircularProgressIndicator()
                          : PrimaryButton(
                              isIconPresent: false,
                              text: 'Create Account',
                              fontWeight: FontWeight.w600,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await signUp(
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                }
                              },
                            );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SecondaryButton(
                      imageSrc: 'assets/images/google.png',
                      onPressed: () async {
                        await continueWithGoogle();
                      },
                      buttonColor: Colors.transparent,
                    ),
                    const SizedBox(width: 20),
                    const SecondaryButton(
                      imageSrc: 'assets/images/twitter.png',
                      onPressed: null,
                      buttonColor: Colors.transparent,
                    ),
                    const SizedBox(width: 20),
                    SecondaryButton(
                      imageSrc: 'assets/images/facebook.png',
                      onPressed: () async {
                        await continueWithFacebook();
                      },
                      buttonColor: Colors.transparent,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Already have an account?',
                      style: GoogleFonts.manrope(
                          color: customTheme['mainTextColor'],
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                  TextButton(
                    onPressed: () {
                      context.go(LoginView.path);
                    },
                    child: Text('Login',
                        style: GoogleFonts.manrope(
                            color: customTheme['primaryColor'],
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (!checkPasswords(
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    )) {
      showSnackMessage(context, 'Passwords do not match', isError: true);
      return;
    }

    User? user = await _authController.signUp(
      context,
      fullName: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => VerifyEmailView(
                  userEmail: _emailController.text,
                  userName: _fullNameController.text,
                ))),
      );
    } else {
      log("User not created", name: 'debug');
    }
  }

  bool checkPasswords({
    required String password,
    required String confirmPassword,
  }) {
    return password == confirmPassword;
  }

  Future<void> continueWithGoogle() async {
    User? user = await _authController.continueWithGoogle(
      context,
    );

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => VerifyEmailView(
                userEmail: user.email,
                userName: user.displayName,
              )),
        ),
      );
    } else {
      log("User not created", name: 'debug');
    }
  }

  Future<void> continueWithFacebook() async {
    User? user = await _authController.continueWithFacebook(
      context,
    );

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => VerifyEmailView(
                userEmail: user.email,
                userName: user.displayName,
              )),
        ),
      );
    } else {
      log("User not created", name: 'debug');
    }
  }
}
