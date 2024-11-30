// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/auth/onboarding/onboarding_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const path = '/splashView';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));

    AppPreferences appPreferences = AppPreferences();
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isConnected = connectivityResult.contains(ConnectivityResult.none);

    // If not connected to the internet, show an error and return
    if (isConnected) {
      showSnackMessage(
          context, "No internet connection. Please connect to the internet.",
          isError: true);
      context.pushReplacement(LoginView.path);
      return;
    }

    try {
      if (!mounted) return;
      User? user = FirebaseAuth.instance.currentUser;

      // Check if user exists and reload to ensure the state is up-to-date
      await user?.reload();
      user = FirebaseAuth.instance.currentUser; // Refresh user data

      String? userToken = await user?.getIdToken();

      if (user != null && user.emailVerified && userToken != null) {
        AuthController authController =
            Provider.of<AuthController>(context, listen: false);

        authController.startUserInfo(user.uid);

        log('User id: ${user.uid}', name: 'debug');

        bool showOnboarding = await appPreferences.getBool('hasSeenOnboarding');
        if (showOnboarding) {
          authController.userStream?.listen((updatedUserInfo) async {
            if (updatedUserInfo != null) {
              authController.setUserInfo(updatedUserInfo);

              context.pushReplacement(HomeView.path);
            }
          });
        } else {
          context.pushReplacement(LoginView.path);
        }
      } else {
        context.pushReplacement(OnboardingView.path);
      }
    } catch (e) {
      // Handle network or unexpected errors
      context.pushReplacement(LoginView.path);
      showSnackMessage(context, "Network Error", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customTheme['whiteColor']!,
      body: Align(
        child: Image.asset(
          'assets/images/logo.png',
          width: 200,
          height: 200,
        ),
      ),

      //     AnimatedSplash(
      //   type: Transition.fade,
      //   backgroundColor: customTheme['whiteColor']!,
      //   navigator: OnboardingView(),
      //   // durationInSeconds: 4,
      //   child: Image.asset(
      //     'assets/images/logo.png',
      //     width: 200,
      //     height: 200,
      //   ),
      //  )
    );
  }

  @override
  void dispose() {
    _navigateUser().ignore();
    super.dispose();
  }
}
