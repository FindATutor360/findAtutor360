// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
// ignore: unused_import
import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/views/auth/email/verify_email/verify_email_view.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final checkedValue = ValueNotifier<bool>(false);

  String? password, confirmPassword;

  late AuthController _authController;

  bool _passwordvisible = true, _confirmPasswordvisible = true;

  @override
  Widget build(BuildContext context) {
    _authController = context.read<AuthController>();
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black);

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
                        textCapitalization: TextCapitalization.words,
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
                        textCapitalization: TextCapitalization.none,
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
                          child: Icon(
                            _passwordvisible == true
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            color: dynamicColor,
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
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        textCapitalization: TextCapitalization.none,
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
                          child: Icon(
                            _confirmPasswordvisible == true
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            color: dynamicColor,
                          ),
                        ),
                        onChanged: (String value) {
                          confirmPassword = _confirmPasswordController.text;
                        },
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
                ValueListenableBuilder<bool>(
                    valueListenable: checkedValue,
                    builder: (context, value, child) {
                      return Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Align(
                          child: CheckboxListTile(
                            tileColor: !value
                                ? customTheme['primaryColor']
                                : customTheme['whiteColor'],
                            title: const MainText(
                              text: "I accept the Terms and Conditions",
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              softWrap: true,
                            ),
                            value: value,
                            checkColor: dynamicColor,
                            activeColor: customTheme['primaryColor'],
                            onChanged: (bool? newValue) {
                              checkedValue.value = newValue!;
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      );
                    }),
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
                                if (_formKey.currentState!.validate() &&
                                    checkedValue.value != false) {
                                  await signUp();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MainText(
                      text: 'Already have an account?',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    try {
      _authController.isLoading.value = true;
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
        _authController.isLoading.value = false;
        log("User not created", name: 'debug');
      }
    } catch (e) {
      _authController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: "Failed to create account",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['errorColor'],
        fontSize: 16.0,
      );
    } finally {
      _authController.isLoading.value = false;
    }
  }

  bool checkPasswords({
    required String password,
    required String confirmPassword,
  }) {
    return password == confirmPassword;
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
          Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: customTheme['primaryColor'],
            textColor: customTheme['whiteColor'],
            fontSize: 16.0,
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
          Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: customTheme['primaryColor'],
            textColor: customTheme['whiteColor'],
            fontSize: 16.0,
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
        msg: "Accout creation fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['errorColor'],
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
          Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: customTheme['primaryColor'],
            textColor: customTheme['whiteColor'],
            fontSize: 16.0,
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
          Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: customTheme['primaryColor'],
            textColor: customTheme['whiteColor'],
            fontSize: 16.0,
          );
        }

        _authController.isLoading.value = false;
      } else {
        log("User not created", name: 'debug');
      }
    } catch (e) {
      _authController.isLoading.value = false;
      Fluttertoast.showToast(
        msg: "Account creation fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['errorColor'],
        fontSize: 16.0,
      );
    }
  }
}
