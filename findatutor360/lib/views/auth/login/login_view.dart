// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/button/secondary_button.dart';
import 'package:findatutor360/custom_widgets/header/custom_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/auth/change_password/change_password.dart';
import 'package:findatutor360/views/auth/email/verify_email/verify_email_view.dart';
import 'package:findatutor360/views/auth/signup/register_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const path = '/loginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AuthController _authController;

  bool _passwordvisible = true;

  @override
  Widget build(BuildContext context) {
    _authController = context.read<AuthController>();
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CustomHeader(),
              const SizedBox(height: 20),
              const MainText(
                text: 'Login to get started',
              ),
              const SizedBox(height: 80),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                        controller: _emailController,
                        textCapitalization: TextCapitalization.none,
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
                        }),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                        controller: _passwordController,
                        textCapitalization: TextCapitalization.none,
                        label: Text('Password',
                            style: TextStyle(
                                color: customTheme['secondaryTextColor'])),
                        hint: 'Enter your password',
                        obscureText: _passwordvisible ? true : false,
                        autofocus: true,
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
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  router.push(ChangePasswordView.path);
                },
                child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 30),
                    child: TextButton(
                      onPressed: null,
                      child: Text('Forgot password?',
                          style: GoogleFonts.manrope(
                              color: customTheme['primaryColor'],
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                    )),
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
                            text: 'Login',
                            fontWeight: FontWeight.w600,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await logIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            });
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
                      buttonColor: Colors.transparent),
                  const SizedBox(width: 20),
                  const SecondaryButton(
                      imageSrc: 'assets/images/twitter.png',
                      onPressed: null,
                      buttonColor: Colors.transparent),
                  const SizedBox(width: 20),
                  SecondaryButton(
                      imageSrc: 'assets/images/facebook.png',
                      onPressed: () async {
                        await continueWithFacebook();
                      },
                      buttonColor: Colors.transparent),
                ],
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Don\'t have an account?',
                    style: GoogleFonts.manrope(
                        color: customTheme['mainTextColor'],
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
                TextButton(
                  onPressed: () {
                    context.go(RegisterView.path);
                  },
                  child: Text('Sign up',
                      style: GoogleFonts.manrope(
                          color: customTheme['primaryColor'],
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
              ]),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      _authController.isLoading.value = true;
      User? user = await _authController.logIn(
        context,
        email: _emailController.text,
        password: _passwordController.text,
      );
      _authController.isLoading.value = false;
      if (user != null && user.emailVerified) {
        Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: customTheme['primaryColor'],
          textColor: customTheme['whiteColor'],
          fontSize: 16.0,
        );
        context.pushReplacement(HomeView.path);
      } else {
        _authController.isLoading.value = false;
        log("User not created", name: 'debug');
      }
    } catch (e) {
      _authController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: "Login fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['whiteColor'],
        fontSize: 16.0,
      );
    }
  }

  Future<void> continueWithGoogle() async {
    try {
      _authController.isLoading.value = true;
      User? user = await _authController.continueWithGoogle(
        context,
      );
      _authController.isLoading.value = false;
      if (user != null) {
        Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: customTheme['primaryColor'],
          textColor: customTheme['whiteColor'],
          fontSize: 16.0,
        );
        context.pushReplacement(HomeView.path);
      } else if (!user!.emailVerified) {
        _authController.isLoading.value = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => VerifyEmailView(
                  userEmail: user.email,
                  userName: user.displayName,
                )),
          ),
        );
        log("User not created", name: 'debug');
      }
    } catch (e) {
      _authController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: "Login fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['whiteColor'],
        fontSize: 16.0,
      );
    }
  }

  Future<void> continueWithFacebook() async {
    try {
      _authController.isLoading.value = true;
      User? user = await _authController.continueWithFacebook(
        context,
      );
      _authController.isLoading.value = false;

      if (user != null) {
        Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: customTheme['primaryColor'],
          textColor: customTheme['whiteColor'],
          fontSize: 16.0,
        );
        context.pushReplacement(HomeView.path);
      } else if (!user!.emailVerified) {
        _authController.isLoading.value = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => VerifyEmailView(
                  userEmail: user.email,
                  userName: user.displayName,
                )),
          ),
        );

        log("User not created", name: 'debug');
      }
    } catch (e) {
      _authController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: "Login fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['whiteColor'],
        fontSize: 16.0,
      );
    }
  }
}
