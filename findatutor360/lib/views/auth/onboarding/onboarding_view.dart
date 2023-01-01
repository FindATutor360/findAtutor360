import 'package:findatutor360/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Color.fromRGBO(30, 33, 36, 1),
          fontFamily: 'Manrope',
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.15,
        ),
        descriptionStyles: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(121, 132, 142, 1),
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Color.fromRGBO(154, 202, 229, 1),
          activeColor: Color.fromRGBO(4, 118, 175, 1),
          inactiveSize: Size(8, 8),
          activeSize: Size(13, 11),
        ),
        //Skip button
        skipButton: TextButton(
          onPressed: () {
            router.go('/welcome');
          },
          child: const Text(
            "Skip",
            style: TextStyle(
              color: Color.fromRGBO(4, 118, 175, 1),
              fontSize: 16,
              fontFamily: 'Manrope',
            ),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 130,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(4, 118, 175, 1),
                  backgroundBlendMode: BlendMode.darken,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  state.isLastPage ? "Get Started" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
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

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(onBoardState.page + 1,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutSine);
    } else {
      //print("nextButton pressed");
      router.go('/welcome');
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
