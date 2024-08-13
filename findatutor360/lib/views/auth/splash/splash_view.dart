import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/auth/onboarding/onboarding_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    User? user = FirebaseAuth.instance.currentUser;
    String? userToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    if (user != null && user.emailVerified && userToken != null) {
      context.pushReplacement(
          HomeView.path); // Navigate to Home if the user is verified
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool showOnboarding = preferences.getBool('userToken') ?? true;
      if (showOnboarding) {
        context.pushReplacement(OnboardingView.path);
        // Show Onboarding if the user is new or not logged in
      } else {
        context.pushReplacement(LoginView.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplash(
      type: Transition.fade,
      backgroundColor: customTheme['whiteColor']!,
      navigator: OnboardingView(),
      durationInSeconds: 3,
      child: Image.asset(
        'assets/images/logo.png',
        width: 200,
        height: 200,
      ),
    ));
  }
}
