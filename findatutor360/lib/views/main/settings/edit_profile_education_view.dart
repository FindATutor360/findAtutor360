import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class EditProfileEducationView extends StatefulWidget {
  const EditProfileEducationView({super.key});
  static const path = '/edit_profile_education';

  @override
  State<EditProfileEducationView> createState() =>
      _EditProfileEducationViewState();
}

class _EditProfileEducationViewState extends State<EditProfileEducationView> {
  final auth = FirebaseAuth.instance.currentUser;
  late AuthController _authController;

  File? certImageUrl, awardImageUrl;

  final formKey = GlobalKey<FormState>();

  final collegeController = TextEditingController();
  final certificateController = TextEditingController();
  final certDetailsController = TextEditingController();
  final awardController = TextEditingController();
  final awardDetailsController = TextEditingController();

  String? typeDropdown;

  @override
  void initState() {
    super.initState();
    _authController = context.read<AuthController>();

    if (_authController.user != null) {
      collegeController.text = _authController.user!.college ?? '';
      certificateController.text = _authController.user!.certificate ?? '';
      certDetailsController.text =
          _authController.user!.certificateDetails ?? '';
      awardController.text = _authController.user!.award ?? '';
      awardDetailsController.text = _authController.user!.awardDetails ?? '';
      typeDropdown = _authController.user!.eduLevel ?? '';
      // certImageUrl = File(_authController.user!.certImageUrl ?? '');
      //awardImageUrl = File(_authController.user!.awardImageUrl ?? '');
    }
  }

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
          child: Form(
            key: formKey,
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
                    value: typeDropdown,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(141, 150, 159, 1),
                              width: 1)),
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
                      if (typeDropdown!.isEmpty) {
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
                CustomTextFormField(
                  hint: 'Enter School Name',
                  controller: collegeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter college Name';
                    }
                    return null;
                  },
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
                  text: 'Certification',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'What is the certification?',
                  controller: certificateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter certificate Name';
                    }
                    return null;
                  },
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
                ExpandTextFormField(
                  hint: 'Details',
                  controller: certDetailsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter certificate Details';
                    }
                    return null;
                  },
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
                _authController.user!.certImageUrl != null ||
                        certImageUrl != null
                    ? Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width / 1.5,
                            height: MediaQuery.sizeOf(context).height / 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: certImageUrl == null
                                    ? FileImage(
                                        File(_authController
                                                .user!.certImageUrl ??
                                            ''),
                                      )
                                    : FileImage(
                                        File(certImageUrl?.path ?? ''),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectImage(
                                (file) => setState(
                                  () {
                                    certImageUrl = file;
                                  },
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: customTheme['secondaryColor'],
                              child: Icon(
                                Icons.camera_alt_sharp,
                                color: customTheme['mainTextColor'],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: InkWell(
                          onTap: () async {
                            selectImage(
                              (file) => setState(
                                () {
                                  certImageUrl = file;
                                },
                              ),
                            );
                          },
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
                CustomTextFormField(
                  hint: 'Add an Award',
                  controller: awardController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter award Name';
                    }
                    return null;
                  },
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
                ExpandTextFormField(
                  hint: 'Details',
                  controller: awardDetailsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter award Details';
                    }
                    return null;
                  },
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
                _authController.user!.awardImageUrl != null ||
                        awardImageUrl != null
                    ? Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width / 1.5,
                            height: MediaQuery.sizeOf(context).height / 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: awardImageUrl == null
                                    ? FileImage(
                                        File(_authController.user!.award ?? ''),
                                      )
                                    : FileImage(
                                        File(awardImageUrl?.path ?? ''),
                                      ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              selectImage(
                                (file) => setState(
                                  () {
                                    awardImageUrl = file;
                                  },
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: customTheme['secondaryColor'],
                              child: Icon(
                                Icons.camera_alt_sharp,
                                color: customTheme['mainTextColor'],
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: InkWell(
                          onTap: () {
                            selectImage(
                              (file) => setState(
                                () {
                                  awardImageUrl = file;
                                },
                              ),
                            );
                          },
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
                      ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  child: ValueListenableBuilder(
                    valueListenable: _authController.isLoading,
                    builder: (context, isLoading, child) {
                      return isLoading
                          ? const CircularProgressIndicator()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryButton(
                                  text: 'Save and Continue',
                                  isIconPresent: false,
                                  fontWeight: FontWeight.w600,
                                  borderRadius: BorderRadius.circular(8),
                                  onPressed: () {
                                    updateEducationDetails();
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
                              ],
                            );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateEducationDetails() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        _authController.isLoading.value = true;

        await _authController.updateEducationDetails(
          typeDropdown,
          collegeController.text,
          certificateController.text,
          certDetailsController.text,
          certImageUrl?.path,
          awardController.text,
          awardDetailsController.text,
          awardImageUrl?.path,
        );

        _authController.isLoading.value = false;

        router.push(
          EditProfileSuccessView.path,
        );
      } catch (e) {
        _authController.isLoading.value = false;
        log("Error saving education details: $e", name: "debug");
        Fluttertoast.showToast(
          msg: "Error saving education details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: customTheme['badgeColor'],
          textColor: customTheme['whiteColor'],
          fontSize: 16.0,
        );
      }
    }
  }

  Future<void> selectImage(Function(File) onSelected) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      onSelected(File(result.files.first.path!));
    } else {
      // Handle cancellation or error if needed
    }
  }
}
