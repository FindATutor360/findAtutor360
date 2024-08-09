import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        onBoardData: onBoardData,
        titleStyles: GoogleFonts.manrope(
          color: customTheme['mainTextColor'],
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: customTheme['secondaryTextColor'],
        ),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 100,
          inactiveColor: customTheme['secondaryColor'],
          activeColor: customTheme['primaryColor'],
          inactiveSize: const Size(8, 8),
          activeSize: const Size(13, 11),
        ),
        //Skip button
        skipButton: TextButton(
          onPressed: () {
            context.pushReplacement('/welcome');
          },
          child: Text(
            "Skip",
            style: TextStyle(
              color: customTheme['primaryColor'],
              fontSize: 16,
              fontFamily: 'Manrope',
            ),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state, context),
              child: Container(
                width: 130,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: customTheme['primaryColor'],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  state.isLastPage ? "Get Started" : "Next",
                  style: TextStyle(
                    color: customTheme['whiteColor'],
                    fontFamily: 'Manrope',
                    fontSize: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState, BuildContext context) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(onBoardState.page + 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutSine);
    } else {
      //print("nextButton pressed");
      context.pushReplacement('/welcome');
    }
  }
}

//Onboarding page model
final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Verify Tutors",
    description:
        "Study from professional and brilliant tutors whose information has been thoroughly verified",
    imgUrl: "assets/images/verifyTutors.png",
  ),
  const OnBoardModel(
    title: "Lesson on the go",
    description:
        "Learn new skills anywhere, anytime at your convenience with online and offline options",
    imgUrl: 'assets/images/lesson.png',
  ),
  const OnBoardModel(
    title: "Tools to teach",
    description:
        "We empower you with tools to be able to meet, schedule and teach learners wherever you are",
    imgUrl: 'assets/images/tool.png',
  ),
  const OnBoardModel(
    title: "Trust and safety",
    description:
        " Learn or teach with  comfort, knowing  your money is safe with us. Tutors are paid after the experience",
    imgUrl: 'assets/images/trust.png',
  ),
];
