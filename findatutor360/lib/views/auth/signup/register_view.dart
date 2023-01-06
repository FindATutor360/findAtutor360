import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/button/secondary_button.dart';
import 'package:findatutor360/custom_widgets/header/custom_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/index.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),
            const MainText(
              text: 'Create your account',
            ),
            const SizedBox(height: 50),
            CustomTextFormField(
                label: Text('Fullname',
                    style: TextStyle(color: customTheme['secondaryTextColor'])),
                hint: 'Enter your fullname',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your fullname';
                  }
                  return null;
                }),
            const SizedBox(height: 20),
            CustomTextFormField(
                label: Text('Email',
                    style: TextStyle(color: customTheme['secondaryTextColor'])),
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
                label: Text('Password',
                    style: TextStyle(color: customTheme['secondaryTextColor'])),
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
            const SizedBox(height: 20),
            CustomTextFormField(
                label: Text('Confirm Password',
                    style: TextStyle(color: customTheme['secondaryTextColor'])),
                hint: 'Confirm your password',
                obscureText: true,
                suffixIcon: const Icon(Iconsax.eye),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                }),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: CheckboxListTile(
                title: Text("I accept the Terms and Conditions",
                    style: GoogleFonts.manrope(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    )),
                value: checkedValue,
                activeColor: customTheme['primaryColor'],
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
                isIconPresent: false,
                text: 'Create Account',
                fontWeight: FontWeight.w600,
                onPressed: () {
                  router.go('/email_verify');
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
              Text('Already have an account?',
                  style: GoogleFonts.manrope(
                      color: customTheme['mainTextColor'],
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              TextButton(
                onPressed: () {
                  router.go('/login');
                },
                child: Text('Login',
                    style: GoogleFonts.manrope(
                        color: customTheme['primaryColor'],
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
