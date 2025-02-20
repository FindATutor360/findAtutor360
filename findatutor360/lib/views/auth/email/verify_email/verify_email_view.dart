// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:findatutor360/views/auth/signup/register_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({
    this.userEmail,
    this.userName,
    super.key,
  });
  static const path = '/verifyEmail';

  final String? userName;
  final String? userEmail;

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late AuthController authController;
  User? user;
  Timer? emailVerificationTimer;
  // final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
  final ValueNotifier<int> countdown = ValueNotifier<int>(60);

  @override
  void initState() {
    super.initState();
    authController = context.read<AuthController>();
    user = FirebaseAuth.instance.currentUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startCountdown();
      navigateUser();
    });
  }

  void startCountdown() {
    countdown.value = 30;
    setIsLoading(true);

    emailVerificationTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value -= 1;
      } else {
        setIsLoading(false);
        timer.cancel();
      }
    });
  }

  void setIsLoading(bool value) {
    // Defer updating isLoading to prevent triggering during build
    if (authController.isLoading.value != value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        authController.isLoading.value = value;
      });
    }
  }

  Future<void> navigateUser() async {
    setIsLoading(true);
    if (user != null) {
      Users? users = await authController.getUserInfo(user!.uid).first; // '

      Timer.periodic(const Duration(seconds: 3), (timer) async {
        await user!.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user!.emailVerified) {
          timer.cancel();
          emailVerificationTimer?.cancel();

          await authController.addUserInfo(
            user!,
            widget.userName ?? users?.fullName,
            widget.userEmail ?? users?.email,
            user!.photoURL ?? users?.photoUrl,
            users?.backGround ?? '',
            users?.dOB ?? '',
            users?.sex ?? '',
            users?.phoneNumber ?? user!.phoneNumber,
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
            msg: "Account created successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: customTheme['primaryColor'],
            textColor: customTheme['whiteColor'],
            fontSize: 16.0,
          );
          context.pushReplacement(HomeView.path);

          setIsLoading(false);

          log("User Email verified", name: 'debug');
        }
      });
    } else {
      log("No user found", name: 'debug');
      context.pushReplacement(RegisterView.path);
      setIsLoading(false);
    }
  }

  void resendVerificationEmail() {
    user?.sendEmailVerification();
    countdown.value = 60;
    setIsLoading(true);

    emailVerificationTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value -= 1;
      } else {
        setIsLoading(false);
        timer.cancel();
      }
    });
    showSnackMessage(context, 'Verification email resent.', isError: false);
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
                        context.go(RegisterView.path);
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
              valueListenable: authController.isLoading,
              builder: (context, isLoading, child) {
                return isLoading
                    ? Column(
                        children: [
                          const CircularProgressIndicator(), // Show the loader
                          const SizedBox(height: 10),
                          ValueListenableBuilder<int>(
                            valueListenable: countdown,
                            builder: (context, countdownValue, child) {
                              return Text(
                                'Retry available in $countdownValue seconds',
                                style: GoogleFonts.manrope(
                                  color: customTheme['secondaryTextColor'],
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(); // Hide the loader
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Didn\'t receive the code?',
                    style: GoogleFonts.manrope(
                        color: customTheme['mainTextColor'],
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
                ValueListenableBuilder<int>(
                  valueListenable: countdown,
                  builder: (context, countdownValue, child) {
                    return TextButton(
                      onPressed: countdownValue == 0
                          ? () async {
                              resendVerificationEmail();
                            }
                          : null,
                      child: Text('Resend',
                          style: GoogleFonts.manrope(
                              color: countdownValue == 0
                                  ? customTheme['primaryColor']
                                  : Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();

    countdown.dispose();
    emailVerificationTimer?.cancel();
  }
}
