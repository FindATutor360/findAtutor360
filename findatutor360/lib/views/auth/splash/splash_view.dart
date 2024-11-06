// ignore_for_file: use_build_context_synchronously

import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/auth/onboarding/onboarding_view.dart';
import 'package:findatutor360/views/auth/welcome/welcome_view.dart';
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
  // late AuthController _authController;
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? userToken = await FirebaseAuth.instance.currentUser?.getIdToken();

      AppPreferences appPreferences = AppPreferences();

      if (user != null && user.emailVerified && userToken != null) {
        final updatedUserInfo = await AuthController().getUserInfo(user.uid);
        if (updatedUserInfo != null) {
          Provider.of<AuthController>(context, listen: false)
              .setUserInfo(updatedUserInfo);

          context.pushReplacement(HomeView.path);
        }
      } else {
        bool showOnboarding = await appPreferences.getBool('userToken');
        if (showOnboarding) {
          context.pushReplacement(OnboardingView.path);
        } else {
          context.pushReplacement(LoginView.path);
        }
      }
    } catch (e) {
      context.pushReplacement(WelcomeView.path);
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
}
