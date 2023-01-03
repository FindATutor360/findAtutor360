import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Text('Welcome',
                  style: GoogleFonts.manrope(
                      color: const Color.fromRGBO(48, 53, 57, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700))),
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
              buttonColor: const Color.fromRGBO(222, 224, 227, 1),
              textColor: const Color.fromRGBO(4, 118, 175, 1),
              iconColor: const Color.fromRGBO(4, 118, 175, 1),
              iconName: Iconsax.people,
              onPressed: () {
                router.go('/parent');
              })
        ],
      ),
    ));
  }
}
