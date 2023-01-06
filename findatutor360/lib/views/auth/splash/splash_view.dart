import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/auth/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

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
