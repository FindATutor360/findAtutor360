import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 15),
                  child: IconButton(
                      onPressed: () {
                        router.go('/register');
                      },
                      icon: Icon(
                          defaultTargetPlatform == TargetPlatform.android
                              ? Iconsax.arrow_left
                              : Iconsax.arrow_left_2,
                          color: const Color.fromRGBO(30, 33, 36, 1),
                          size: 25)),
                ),
                const Divider(
                  color: Color.fromRGBO(30, 33, 36, .1),
                  thickness: 1,
                ),
              ],
            ),
            Image.asset('assets/images/verifyEmail.png',
                width: MediaQuery.of(context).size.width),
            const SizedBox(height: 20),
            const MainText(
              text: 'Check your mail',
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [
                  Text(
                    'To continue, enter the code we just sent to',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                        color: const Color.fromRGBO(121, 132, 142, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'youremailaddress@gmail.com',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                        color: const Color.fromRGBO(30, 33, 36, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const CustomTextFormField(
                hint: 'Enter code', keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            PrimaryButton(
              text: 'Continue',
              isIconPresent: false,
              fontWeight: FontWeight.w600,
              onPressed: () {
                router.go('/email_success');
              },
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Didn\'t receive the code ?',
                  style: GoogleFonts.manrope(
                      color: const Color.fromRGBO(48, 53, 57, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              TextButton(
                onPressed: () {
                  //implement resend code here
                },
                child: Text('Resend',
                    style: GoogleFonts.manrope(
                        color: const Color.fromRGBO(4, 118, 175, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
            ]),
          ],
        ),
      ),
    ));
  }
}
