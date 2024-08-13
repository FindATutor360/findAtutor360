import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/main/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  static const path = '/welcomeView';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                    router.push(LoginView.path);
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
                    router.push(HomeView.path);
                  })
            ],
          ),
        ),
      )),
    );
  }
}
