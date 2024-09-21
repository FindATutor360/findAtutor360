import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dash_container/dash_conatiner.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/edit_profile_education_view.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileContactView extends StatelessWidget {
  const EditProfileContactView({super.key});
  static const path = '/edit_profile_contact';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Edit Profile info',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
           reverse: true,
          physics: const BouncingScrollPhysics(),
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
              ),
              const SizedBox(
                height: 40,
              ),
              const MainText(
                text: 'Contact Details',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              MainText(
                text: 'Phone Number',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                hint: 'Enter Phone Number',
                prefixIcon: Icon(
                  Iconsax.call,
                  color: customTheme['secondaryTextColor'],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Email',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                hint: 'Enter your email address',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: customTheme['secondaryTextColor'],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Street Address',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                hint: 'Tap to find on map',
                prefixIcon: Icon(
                  Iconsax.location,
                  color: customTheme['secondaryTextColor'],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Upload Images About yourself',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: CustomPaint(
                  painter: DashedRectanglePainter(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      children: [
                        Icon(
                          Iconsax.image5,
                          color: customTheme['primaryColor'],
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Click to ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: customTheme['mainTextColor'],
                              ),
                              children: [
                                TextSpan(
                                  text: 'Upload Photos',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: customTheme['primaryColor'],
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        MainText(
                          text: 'PNG, JPG, , GIF upto 5MB',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: customTheme['secondaryTextColor'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'Save and Continue',
                isIconPresent: false,
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                onPressed: () {
                  router.push(
                    EditProfileEducationView.path,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OutlineButton(
                text: 'Cancel',
                textColor: customTheme['primaryColor'],
                fontWeight: FontWeight.w600,
                borderRadius: BorderRadius.circular(8),
                buttonColor: customTheme['whiteColor'],
                isIconPresent: false,
                fontSize: 16,
                onPressed: () {
                  context.pop();
                },
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
