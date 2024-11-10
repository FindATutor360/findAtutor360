import 'dart:developer';

import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/edit_profile_contact_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class EditPersonalProfileView extends StatefulWidget {
  const EditPersonalProfileView({super.key});
  static const path = '/edit_personal_profile';

  @override
  State<EditPersonalProfileView> createState() =>
      _EditPersonalProfileViewState();
}

class _EditPersonalProfileViewState extends State<EditPersonalProfileView> {
  late AuthController _authController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final backGroundController = TextEditingController();
  final dOBController = TextEditingController();
  final nameController = TextEditingController();
  String? typeDropdown;

  @override
  void initState() {
    super.initState();
    _authController = context.read<AuthController>();

    if (_authController.user != null || _auth.currentUser != null) {
      nameController.text = _authController.user?.fullName ??
          _auth.currentUser?.displayName ??
          'No Name';
      backGroundController.text = _authController.user?.backGround ?? '';
      dOBController.text = _authController.user?.dOB ?? '';
      typeDropdown = _authController.user?.sex;
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
                ),
                const SizedBox(
                  height: 40,
                ),
                const MainText(
                  text: 'Personal Details',
                  fontSize: 16,
                ),
                const SizedBox(
                  height: 24,
                ),
                MainText(
                  text: 'Name',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'Enter Your Name',
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Tutor Background',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpandTextFormField(
                  hint: 'Describe yoursself',
                  controller: backGroundController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please discribe yourself';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Date of Birth',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  controller: dOBController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your D.O.B';
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    Iconsax.calendar_1,
                    color: customTheme['secondaryTextColor'],
                  ),
                  hint: 'DD / MM / YY',
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Sex',
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
                      hintText: 'How do you identify yourself?',
                      hintStyle: TextStyle(
                        color: customTheme['secondaryTextColor'],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "Male",
                        child: MainText(
                          text: 'Male',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Female",
                        child: MainText(
                          text: 'Female',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Other",
                        child: MainText(
                          text: 'Other',
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
                        return "Please select identify Type";
                      }
                      return null;
                    },
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
                                    updatePersonalDetails();
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

  Future<void> updatePersonalDetails() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      final User? auth = FirebaseAuth.instance.currentUser;
      try {
        _authController.isLoading.value = true;

        await auth!.updateDisplayName(nameController.text);
        await _authController.updatePersonalDetails(
          nameController.text,
          backGroundController.text,
          dOBController.text,
          typeDropdown,
        );

        _authController.isLoading.value = false;

        router.push(
          EditProfileContactView.path,
        );
      } catch (e) {
        _authController.isLoading.value = false;
        log("Error saving personal details: $e", name: "debug");
        Fluttertoast.showToast(
          msg: "Error saving Personal details",
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
