import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailSuccessView extends StatelessWidget {
  const EmailSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/success.png',
                width: MediaQuery.of(context).size.width),
            const SizedBox(height: 40),
            const MainText(
              text: 'Congratulations!',
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                'Your verification was successful. Press the button below to get started',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                    color: const Color.fromRGBO(121, 132, 142, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              text: 'Get Started',
              isIconPresent: false,
              fontWeight: FontWeight.w600,
              onPressed: () {
                router.go('/parent');
              },
            ),
          ],
        ),
      ),
    ));
  }
}
