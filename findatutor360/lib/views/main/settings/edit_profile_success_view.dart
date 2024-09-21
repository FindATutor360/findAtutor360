import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class EditProfileSuccessView extends StatelessWidget {
  const EditProfileSuccessView({super.key});
  static const path = '/edit_profile_success';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Complete',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const ProgressBar(
                firstText: 'Personal',
                secondText: 'Contact',
                thirdText: 'Education',
                isFirstDone: true,
                isSecondActive: true,
                isSecondDone: true,
                isThirdActive: true,
                isThirdDone: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                child: Image.asset('assets/images/cart.png',
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MainText(
                    text: 'Success',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "You have successfully added additional details to your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Color(0xFF79848E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              //button
              PrimaryButton(
                isIconPresent: false,
                text: 'Continue',
                onPressed: () {
                  // router.go(ShopView.path);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OutlineButton(
                text: 'Undo All Edit',
                textColor: customTheme['badgeColor'],
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                buttonColor: customTheme['whiteColor'],
                borderSideColor: customTheme['badgeColor'],
                isIconPresent: false,
                fontSize: 16,
                onPressed: () {},
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
