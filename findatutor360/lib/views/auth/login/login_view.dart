// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/button/secondary_button.dart';
import 'package:findatutor360/custom_widgets/header/custom_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:findatutor360/views/auth/forget_password/forget_password.dart';
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
  AppPreferences appPreferences = AppPreferences();

  late AuthController _authController;
  String? password;

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
                      },
                    ),
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
                          child: Icon(
                            _passwordvisible == true
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            color: customTheme['mainTextColor'],
                          ),
                        ),
                        onChanged: (String value) {
                          password = _passwordController.text;
                        },
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
                  router.push(ForgetPasswordView.path);
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
      User? user = await _authController.continueWithGoogle(context);

      if (user != null) {
        Users? users = await _authController.getUserInfo(user.uid).first; // '

        if (user.emailVerified) {
          await _authController.addUserInfo(
            user,
            user.displayName ?? users?.fullName,
            user.email ?? users?.email,
            user.photoURL ?? users?.photoUrl,
            users?.backGround,
            users?.dOB,
            users?.sex,
            users?.phoneNumber ?? user.phoneNumber,
            users?.eduLevel,
            users?.college,
            users?.certificate,
            users?.certificateDetails,
            users?.certImageUrl,
            users?.award,
            users?.awardDetails,
            users?.awardImageUrl,
          );
        } else {
          // Send email verification and update profile
          await _authController.sendEmailVerification(
            user,
            context,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL,
          );
          // Update profile after sending verification
          await _authController.addUserInfo(
            user,
            user.displayName ?? '',
            user.email ?? '',
            user.photoURL ?? '',
            users?.backGround ?? '',
            users?.dOB ?? '',
            users?.sex ?? '',
            users?.phoneNumber ?? user.phoneNumber,
            users?.eduLevel ?? '',
            users?.college ?? '',
            users?.certificate ?? '',
            users?.certificateDetails ?? '',
            users?.certImageUrl ?? '',
            users?.award ?? '',
            users?.awardDetails ?? '',
            users?.awardImageUrl ?? '',
          );
        }

        // Navigate to home
        context.pushReplacement(HomeView.path);
      } else {
        log("User not created", name: 'debug');
      }

      _authController.isLoading.value = false;
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
        Users? users = await _authController.getUserInfo(user.uid).first; // '

        if (user.emailVerified) {
          await _authController.addUserInfo(
            user,
            user.displayName ?? users?.fullName,
            user.email ?? users?.email,
            user.photoURL ?? users?.photoUrl,
            users?.backGround,
            users?.dOB,
            users?.sex,
            users?.phoneNumber ?? user.phoneNumber,
            users?.eduLevel,
            users?.college,
            users?.certificate,
            users?.certificateDetails,
            users?.certImageUrl,
            users?.award,
            users?.awardDetails,
            users?.awardImageUrl,
          );
        } else {
          // Send email verification and update profile
          await _authController.sendEmailVerification(
            user,
            context,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL,
          );
          // Update profile after sending verification
          await _authController.addUserInfo(
            user,
            user.displayName ?? '',
            user.email ?? '',
            user.photoURL ?? '',
            users?.backGround ?? '',
            users?.dOB ?? '',
            users?.sex ?? '',
            users?.phoneNumber ?? user.phoneNumber,
            users?.eduLevel ?? '',
            users?.college ?? '',
            users?.certificate ?? '',
            users?.certificateDetails ?? '',
            users?.certImageUrl ?? '',
            users?.award ?? '',
            users?.awardDetails ?? '',
            users?.awardImageUrl ?? '',
          );
        }

        _authController.isLoading.value = false;
      } else {
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
