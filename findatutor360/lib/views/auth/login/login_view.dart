import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/button/secondary_button.dart';
import 'package:findatutor360/custom_widgets/header/custom_header.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/index.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),
            Text('Login to get started',
                style: GoogleFonts.manrope(
                    color: const Color.fromRGBO(48, 53, 57, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 80),
            CustomTextFormField(
                label: const Text('Email',
                    style: TextStyle(color: Color.fromRGBO(121, 132, 142, 1))),
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                }),
            const SizedBox(height: 30),
            CustomTextFormField(
                label: const Text('Password',
                    style: TextStyle(color: Color.fromRGBO(121, 132, 142, 1))),
                hint: 'Enter your password',
                obscureText: true,
                suffixIcon: const Icon(Iconsax.eye),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                }),
            const SizedBox(height: 15),
            Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 30),
                child: TextButton(
                  onPressed: null,
                  child: Text('Forgot password?',
                      style: GoogleFonts.manrope(
                          color: const Color.fromRGBO(4, 118, 175, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                )),
            const SizedBox(height: 20),
            PrimaryButton(
                isIconPresent: false,
                text: 'Login',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                onPressed: () {
                  router.go('/parent');
                }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SecondaryButton(
                    imageSrc: 'assets/images/google.png',
                    onPressed: null,
                    buttonColor: Colors.transparent),
                SizedBox(width: 20),
                SecondaryButton(
                    imageSrc: 'assets/images/twitter.png',
                    onPressed: null,
                    buttonColor: Colors.transparent),
                SizedBox(width: 20),
                SecondaryButton(
                    imageSrc: 'assets/images/facebook.png',
                    onPressed: null,
                    buttonColor: Colors.transparent),
              ],
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Don\'t have an account?',
                  style: GoogleFonts.manrope(
                      color: const Color.fromRGBO(48, 53, 57, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              TextButton(
                onPressed: () {
                  router.go('/register');
                },
                child: Text('Sign up',
                    style: GoogleFonts.manrope(
                        color: const Color.fromRGBO(4, 118, 175, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
            ]),
          ],
        ),
      )),
    );
  }
}
