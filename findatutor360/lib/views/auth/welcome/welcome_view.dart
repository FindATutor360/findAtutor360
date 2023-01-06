import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/index.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: const MainText(
                text: 'Welcome',
              ),
            ),
            const SizedBox(height: 25),
            const Image(image: AssetImage('assets/images/welcome.png')),
            const SizedBox(height: 20),
            PrimaryButton(
                isIconPresent: false,
                text: 'Create an account',
                onPressed: () {
                  router.go('/login');
                }),
            const SizedBox(height: 20),
            PrimaryButton(
                isIconPresent: true,
                text: 'Browse as a guest',
                buttonColor: customTheme['lightGrayColor'],
                textColor: customTheme['primaryColor'],
                iconColor: customTheme['primaryColor'],
                iconName: Iconsax.people,
                onPressed: () {
                  router.go('/parent');
                })
          ],
        ),
      ),
    ));
  }
}
