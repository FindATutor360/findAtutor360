import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dash_container/dash_conatiner.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/edit_profile_success_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileEducationView extends StatefulWidget {
  const EditProfileEducationView({super.key});
  static const path = '/edit_profile_education';

  @override
  State<EditProfileEducationView> createState() =>
      _EditProfileEducationViewState();
}

class _EditProfileEducationViewState extends State<EditProfileEducationView> {
  String typeDropdown = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                isSecondDone: true,
                isThirdActive: true,
              ),
              const SizedBox(
                height: 40,
              ),
              const MainText(
                text: 'Education',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              MainText(
                text: 'Education Level',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: DropdownButtonFormField(
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  dropdownColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(141, 150, 159, 1), width: 1)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromRGBO(4, 118, 175, 1))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(241, 4, 4, 1), width: 1)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromRGBO(4, 118, 175, 1))),
                    hintText: 'Select your education level',
                    hintStyle: TextStyle(
                      color: customTheme['secondaryTextColor'],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "Diploma",
                      child: MainText(
                        text: 'Diploma',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Degree",
                      child: MainText(
                        text: 'Degree',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Masters",
                      child: MainText(
                        text: 'Masters',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "PHD",
                      child: MainText(
                        text: 'PHD',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Doctrate",
                      child: MainText(
                        text: 'Doctrate',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      typeDropdown = value.toString();
                    });
                  },
                  validator: (value) {
                    if (typeDropdown.isEmpty) {
                      return "Please select your education level";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'School',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Enter School Name',
              ),
              const SizedBox(
                height: 24,
              ),
              const MainText(
                text: 'Achievements & Awards',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              MainText(
                text: 'Language',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Add a language',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Certification',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'What is the certification?',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Certification Details',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const ExpandTextFormField(
                hint: 'Details',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Upload Images of the Certificate',
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
                                text: 'Upload file',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: customTheme['primaryColor'],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        MainText(
                          text: 'PNG, JPG, , PDF upto 5MB',
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
                height: 12,
              ),
              MainText(
                text: 'Awards',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomTextFormField(
                hint: 'Add an Award',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Award Details',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 8,
              ),
              const ExpandTextFormField(
                hint: 'Details',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Upload Images of the Awards',
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
                                text: 'Upload file',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: customTheme['primaryColor'],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        MainText(
                          text: 'PNG, JPG, , PDF upto 5MB',
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
                    EditProfileSuccessView.path,
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
