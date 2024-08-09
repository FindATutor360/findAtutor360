import 'dart:async';
import 'dart:developer';

import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late AuthController authController;
  User? user;
  Timer? emailVerificationTimer;
  final int verificationTimeout = 8;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    authController = context.read<AuthController>();
    user = FirebaseAuth.instance.currentUser;
    navigateUser();
  }

  Future<void> navigateUser() async {
    if (user != null) {
      emailVerificationTimer =
          Timer.periodic(const Duration(seconds: 3), (timer) async {
        await user!.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user!.emailVerified) {
          timer.cancel();
          emailVerificationTimer?.cancel();
          context.pushReplacement('/home');

          log("User Email verified", name: 'debug');
        }
      });

      await Future.delayed(Duration(seconds: verificationTimeout));
      if (!user!.emailVerified) {
        emailVerificationTimer?.cancel();
        context.pushReplacement('/register');
      }
    } else {
      log("No user found", name: 'debug');

      context.pushReplacement('/register');
    }
  }

  @override
  void dispose() {
    isLoading.dispose();
    emailVerificationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 15),
                  child: IconButton(
                      onPressed: () {
                        context.go('/register');
                      },
                      icon: Icon(
                          defaultTargetPlatform == TargetPlatform.android
                              ? Iconsax.arrow_left
                              : Iconsax.arrow_left_2,
                          color: customTheme['mainTextColor'],
                          size: 25)),
                ),
                Divider(
                  color: customTheme['dividerColor'],
                  thickness: 1,
                ),
              ],
            ),
            Image.asset('assets/images/verifyEmail.png',
                width: MediaQuery.of(context).size.width),
            const SizedBox(height: 20),
            const MainText(
              text: 'Check your mail',
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Text(
                    'To continue, verify the code we just sent to',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    user?.email ?? '', // Display the user's email
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                        color: customTheme['mainTextColor'],
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, isLoading, child) {
                return isLoading
                    ? const CircularProgressIndicator() // Show the loader
                    : const SizedBox.shrink(); // Hide the loader
              },
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Didn\'t receive the code?',
                  style: GoogleFonts.manrope(
                      color: customTheme['mainTextColor'],
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              TextButton(
                onPressed: () {
                  user?.sendEmailVerification(); // Resend verification email
                  showSnackMessage(context, 'Verification email resent.',
                      isError: false);
                },
                child: Text('Resend',
                    style: GoogleFonts.manrope(
                        color: customTheme['primaryColor'],
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
            ]),
          ],
        ),
      ),
    ));
  }
}
