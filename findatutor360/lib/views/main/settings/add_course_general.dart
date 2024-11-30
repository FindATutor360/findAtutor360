import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dash_container/dash_conatiner.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_course_pricing.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AddCourseGeneralView extends StatefulWidget {
  const AddCourseGeneralView({super.key});
  static const path = '/add_course_general';

  @override
  State<AddCourseGeneralView> createState() => _AddCourseGeneralViewState();
}

class _AddCourseGeneralViewState extends State<AddCourseGeneralView> {
  String typeDropdown = '';

  PlatformFile? selectedFile;

  late CoursesController _coursesController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _coursesController = context.read<CoursesController>();
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Add New course',
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0XFF0476AF),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: 12,
                            color: customTheme['primaryColor'],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        MainText(
                            text: 'General Information',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor']),
                      ],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, right: 20),
                        child: Divider(
                          thickness: 2,
                          color: customTheme['grayColor'],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0XFFC3C8CC),
                              width: 2,
                            ),
                          ),
                          child: MainText(
                            text: '2',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: customTheme['grayColor'],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        MainText(
                            text: 'Pricing',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor']),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                MainText(
                  text: 'Title',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'Enter Course Title',
                  controller: _titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter course title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Description',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                ExpandTextFormField(
                  hint: 'Describe Course',
                  controller: _descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter course description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Category',
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
                      hintText: 'Choose a category',
                      hintStyle: TextStyle(
                        color: customTheme['secondaryTextColor'],
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "Promgramming",
                        child: MainText(
                          text: 'Promgramming',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Geography",
                        child: MainText(
                          text: 'Geography',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Music",
                        child: MainText(
                          text: 'Music',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Mathematics",
                        child: MainText(
                          text: 'Mathematics',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Health",
                        child: MainText(
                          text: 'Health',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Finance",
                        child: MainText(
                          text: 'Finance',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Crypto",
                        child: MainText(
                          text: 'Crypto',
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
                        return "Choose a category";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Upload Cover Image',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 10,
                ),
                selectedFile != null
                    ? Container(
                        width: MediaQuery.sizeOf(context).width / 1.5,
                        height: MediaQuery.sizeOf(context).height / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(
                                selectedFile?.path ?? '',
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                              allowMultiple: false,
                            );

                            if (result != null) {
                              PlatformFile file = result.files.first;

                              log('File Name: ${file.name}');
                              log('File Size: ${file.size}');
                              log('File Path: ${file.path}');
                              log('File Path: ${file.identifier}');

                              setState(() {
                                selectedFile = file;

                                formKey.currentState?.validate();
                              });
                            } else {
                              context.pop();
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
                                              color:
                                                  customTheme['primaryColor'],
                                            ),
                                          )
                                        ]),
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
                ValueListenableBuilder(
                  valueListenable: _coursesController.isLoading,
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
                                  addCourseBasicDetails();
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

  Future<void> addCourseBasicDetails() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        _coursesController.isLoading.value = true;
        await _coursesController.addCourseBasicDetails(
          selectedFile?.path,
          _titleController.text,
          _descriptionController.text,
          typeDropdown,
          context,
        );
        _coursesController.isLoading.value = false;

        router.push(
          AddCoursePricingView.path,
        );
      } catch (e) {
        _coursesController.isLoading.value = false;
        log("Error saving course Basic details: $e", name: "debug");
        Fluttertoast.showToast(
          msg: "Error saving course Basic details",
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
