import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:findatutor360/core/models/auth/user_model.dart';
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
  final auth = FirebaseAuth.instance;
  late AuthController _authController;

  // File? certImageUrl, awardImageUrl;

  final formKey = GlobalKey<FormState>();

  final collegeController = TextEditingController();
  final certificateController = TextEditingController();
  final certDetailsController = TextEditingController();
  final awardController = TextEditingController();
  final awardDetailsController = TextEditingController();

  final eduLevel = ValueNotifier<String>('');
  final certImageUrl = ValueNotifier<File?>(File(''));
  final awardImageUrl = ValueNotifier<File?>(File(''));
  final _awardImageUrl = ValueNotifier<String>('');
  final _certImageUrl = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _authController = context.read<AuthController>();
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
          child: StreamBuilder<Users?>(
            stream: _authController.getUserInfo(auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data != null) {
                final user = snapshot.data!;

                // Load the user data once when the stream emits the data

                collegeController.text = user.college ?? '';
                certificateController.text = user.certificate ?? '';
                certDetailsController.text = user.certificateDetails ?? '';
                awardController.text = user.award ?? '';

                awardDetailsController.text = user.awardDetails ?? '';

                if (user.eduLevel != null && user.eduLevel!.isNotEmpty) {
                  eduLevel.value = user.eduLevel!;
                } else {
                  eduLevel.value = 'Diploma';
                }

                awardImageUrl.value = File(user.awardImageUrl ?? '');
                certImageUrl.value = File(user.certImageUrl ?? '');

                return Form(
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
                      ValueListenableBuilder<String>(
                        valueListenable: eduLevel,
                        builder: (context, data, child) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: DropdownButtonFormField(
                              value: eduLevel.value,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(141, 150, 159, 1),
                                        width: 1)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(4, 118, 175, 1))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color.fromRGBO(241, 4, 4, 1),
                                        width: 1)),
                                focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromRGBO(4, 118, 175, 1))),
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
                                eduLevel.value = value.toString();
                              },
                              validator: (value) {
                                if (eduLevel.value.isEmpty) {
                                  return "Please select your education level";
                                }
                                return null;
                              },
                            ),
                          );
                        },
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
                      ValueListenableBuilder<File?>(
                          valueListenable: certImageUrl,
                          builder: (context, certImage, child) {
                            return certImageUrl.value!.path.isNotEmpty
                                ? Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(certImage!),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.image,
                                            allowMultiple: false,
                                          );

                                          if (result != null) {
                                            PlatformFile file =
                                                result.files.first;

                                            log('File Name: ${file.name}');
                                            log('File Size: ${file.size}');
                                            log('File Path: ${file.path}');
                                            log('File Path: ${file.identifier}');

                                            certImageUrl.value =
                                                File(file.path!);
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              customTheme['secondaryColor'],
                                          child: Icon(
                                            Icons.camera_alt_sharp,
                                            color: customTheme['mainTextColor'],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : _certImageUrl.value.isEmpty ||
                                        _authController.user?.certImageUrl !=
                                            null
                                    ? Stack(
                                        clipBehavior: Clip.none,
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width /
                                                1.5,
                                            height: MediaQuery.sizeOf(context)
                                                    .height /
                                                5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                  File(
                                                    _authController.user
                                                            ?.certImageUrl ??
                                                        '',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.image,
                                                allowMultiple: false,
                                              );

                                              if (result != null) {
                                                PlatformFile file =
                                                    result.files.first;

                                                certImageUrl.value = File(file
                                                    .path!); // Update with new image
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  customTheme['secondaryColor'],
                                              child: Icon(
                                                Icons.camera_alt_sharp,
                                                color: customTheme[
                                                    'mainTextColor'],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: InkWell(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.image,
                                              allowMultiple: false,
                                            );

                                            if (result != null) {
                                              PlatformFile file =
                                                  result.files.first;

                                              certImageUrl.value = File(file
                                                  .path!); // Update with new image
                                            }
                                          },
                                          child: CustomPaint(
                                            painter: DashedRectanglePainter(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16,
                                                      horizontal: 16),
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    Iconsax.image5,
                                                    color: customTheme[
                                                        'primaryColor'],
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: 'Click to ',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: customTheme[
                                                            'mainTextColor'],
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: 'Upload file',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: customTheme[
                                                                'primaryColor'],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  MainText(
                                                    text:
                                                        'PNG, JPG, , PDF upto 5MB',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: customTheme[
                                                        'secondaryTextColor'],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                          }),
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
                      ValueListenableBuilder<File?>(
                        valueListenable: awardImageUrl,
                        builder: (context, awardImage, child) {
                          return awardImageUrl.value!.path.isNotEmpty
                              ? Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(awardImage!),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                          allowMultiple: false,
                                        );

                                        if (result != null) {
                                          PlatformFile file =
                                              result.files.first;

                                          log('File Name: ${file.name}');
                                          log('File Size: ${file.size}');
                                          log('File Path: ${file.path}');
                                          log('File Path: ${file.identifier}');

                                          awardImageUrl.value =
                                              File(file.path!);
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            customTheme['secondaryColor'],
                                        child: Icon(
                                          Icons.camera_alt_sharp,
                                          color: customTheme['mainTextColor'],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : _awardImageUrl.value.isEmpty ||
                                      _authController.user?.awardImageUrl !=
                                          null
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  1.5,
                                          height: MediaQuery.sizeOf(context)
                                                  .height /
                                              5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(
                                                  _authController.user
                                                          ?.awardImageUrl ??
                                                      '',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.image,
                                              allowMultiple: false,
                                            );

                                            if (result != null) {
                                              PlatformFile file =
                                                  result.files.first;

                                              awardImageUrl.value = File(file
                                                  .path!); // Update with new image
                                            }
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                customTheme['secondaryColor'],
                                            child: Icon(
                                              Icons.camera_alt_sharp,
                                              color:
                                                  customTheme['mainTextColor'],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: InkWell(
                                        onTap: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                            type: FileType.image,
                                            allowMultiple: false,
                                          );

                                          if (result != null) {
                                            PlatformFile file =
                                                result.files.first;

                                            awardImageUrl.value = File(file
                                                .path!); // Update with new image
                                          }
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
                                                  color: customTheme[
                                                      'primaryColor'],
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    text: 'Click to ',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: customTheme[
                                                          'mainTextColor'],
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'Upload file',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: customTheme[
                                                              'primaryColor'],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                MainText(
                                                  text:
                                                      'PNG, JPG, , PDF upto 5MB',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: customTheme[
                                                      'secondaryTextColor'],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                        },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                );
              } else {
                return const Center(child: Text("No user data found"));
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> updateEducationDetails() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        _authController.isLoading.value = true;

        await Future.delayed(const Duration(seconds: 2));

        await _authController.updateEducationDetails(
          eduLevel.value,
          collegeController.text,
          certificateController.text,
          certDetailsController.text,
          certImageUrl.value!.path,
          awardController.text,
          awardDetailsController.text,
          awardImageUrl.value!.path,
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
}
