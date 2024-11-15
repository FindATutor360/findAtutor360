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
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/edit_profile_education_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileContactView extends StatefulWidget {
  const EditProfileContactView({super.key});
  static const path = '/edit_profile_contact';

  @override
  State<EditProfileContactView> createState() => _EditProfileContactViewState();
}

class _EditProfileContactViewState extends State<EditProfileContactView> {
  final auth = FirebaseAuth.instance;
  late AuthController _authController;

  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final profileImageUrl = ValueNotifier<File?>(File(''));
  final _profileImageUrl = ValueNotifier<String>('');

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

                phoneController.text = user.phoneNumber ?? '';
                emailController.text = user.email ?? '';

                profileImageUrl.value = File(user.photoUrl ?? '');
                _profileImageUrl.value = user.photoUrl ?? '';

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
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        prefixIcon: Icon(
                          Iconsax.call,
                          color: customTheme['secondaryTextColor'],
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone Number';
                          }
                          return null;
                        },
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
                        controller: emailController,
                        enable: false,
                        prefixIcon: Icon(
                          Icons.email_outlined,
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
                      ValueListenableBuilder<File?>(
                        valueListenable: profileImageUrl,
                        builder: (context, profileImage, child) {
                          return profileImageUrl.value!.path.isNotEmpty
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
                                          image: FileImage(profileImage!),
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

                                          profileImageUrl.value =
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
                              : _profileImageUrl.value.isEmpty ||
                                      _authController.user?.photoUrl != null
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
                                              image: NetworkImage(
                                                user.photoUrl ?? '',
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

                                              profileImageUrl.value = File(file
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

                                            profileImageUrl.value = File(file
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
                                          updateContactDetails();
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

  Future<void> updateContactDetails() async {
    if (formKey.currentState != null &&
            formKey.currentState!.validate() &&
            profileImageUrl.value != null ||
        _profileImageUrl.value.isNotEmpty) {
      final FirebaseAuth auth = FirebaseAuth.instance;

      try {
        _authController.isLoading.value = true;

        await auth.currentUser!.updatePhotoURL(profileImageUrl.value!.path);

        await _authController.updateContactDetails(
          phoneController.text,
          profileImageUrl.value!.path,
        );

        _authController.isLoading.value = false;

        router.push(
          EditProfileEducationView.path,
        );
      } catch (e) {
        _authController.isLoading.value = false;
        log("Error saving Contact details: $e", name: "debug");
        Fluttertoast.showToast(
          msg: "Error saving Contact details",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: customTheme['badgeColor'],
          textColor: customTheme['whiteColor'],
          fontSize: 16.0,
        );
      }
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    try {
      String fileName = FirebaseAuth.instance.currentUser!.uid;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$fileName');
      await ref.putFile(imageFile);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      rethrow;
    }
  }
}
