import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailSuccessView extends StatelessWidget {
  const EmailSuccessView({super.key});
  static const path = '/emailSuccess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
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
                'Your account was created successfully \n You can now login to your account',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                    color: customTheme['secondaryTextColor'],
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: PrimaryButton(
                text: 'Go to Login',
                isIconPresent: false,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  router.go(LoginView.path);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
