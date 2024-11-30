import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dash_container/dash_conatiner.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_book_success.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AddBookImageView extends StatefulWidget {
  const AddBookImageView({super.key});
  static const path = '/add_book_condition';

  @override
  State<AddBookImageView> createState() => _AddBookImageViewState();
}

class _AddBookImageViewState extends State<AddBookImageView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PlatformFile? selectedFile, selectedFile2;

  late BooksController _booksController;

  @override
  void initState() {
    super.initState();
    _booksController = context.read<BooksController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Add New book',
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
                firstText: 'Basic',
                secondText: 'Publishing',
                thirdText: 'Condition',
                isFirstDone: true,
                isSecondActive: true,
                isSecondDone: true,
                isThirdActive: true,
              ),
              const SizedBox(
                height: 40,
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
                                            color: customTheme['primaryColor'],
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
                height: 12,
              ),
              MainText(
                text: 'Add More Images',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
              const SizedBox(
                height: 10,
              ),
              selectedFile2 != null
                  ? Container(
                      width: MediaQuery.sizeOf(context).width / 1.5,
                      height: MediaQuery.sizeOf(context).height / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(
                              selectedFile2?.path ?? '',
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
                              selectedFile2 = file;

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
                                            color: customTheme['primaryColor'],
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
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: ValueListenableBuilder(
                  valueListenable: _booksController.isLoading,
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
                                  addBookImage();
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addBookImage() async {
    try {
      _booksController.isLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () {
        _booksController.isLoading.value =
            false; // Set loading back to false after 2 seconds
      });

      await _booksController.addBookImage(
        selectedFile?.path,
        selectedFile2?.path,
      );

      _booksController.isLoading.value = false;

      router.push(
        AddBookSuccessView.path,
      );
    } catch (e) {
      _booksController.isLoading.value = false;
      log("Error saving book images: $e", name: "debug");
      Fluttertoast.showToast(
        msg: "Error saving book images",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['badgeColor'],
        textColor: customTheme['whiteColor'],
        fontSize: 16.0,
      );
    }
  }
}
