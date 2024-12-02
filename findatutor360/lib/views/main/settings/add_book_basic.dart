import 'dart:developer';

import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_book_publish.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddBookBasicView extends StatefulWidget {
  const AddBookBasicView({super.key});
  static const path = '/add_book_basic';

  @override
  State<AddBookBasicView> createState() => _AddBookBasicViewState();
}

class _AddBookBasicViewState extends State<AddBookBasicView> {
  late BooksController _booksController;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String typeDropdown = '';

  @override
  Widget build(BuildContext context) {
    _booksController = context.watch<BooksController>();
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
          child: Form(
            key: formKey,
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
                  hint: 'Enter Book Title',
                  controller: _titleController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter book title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Author',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'Enter Author Name',
                  controller: _authorController,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter book author';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Price',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'Enter Book Price',
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter book price';
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
                  hint: 'Describe Book',
                  controller: _descriptionController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter book description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                ValueListenableBuilder(
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
                                  addBookBasicDetails();
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

  Future<void> addBookBasicDetails() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        _booksController.isLoading.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          _booksController.isLoading.value =
              false; // Set loading back to false after 2 seconds
        });
        await _booksController.addBookBasicDetails(
          _titleController.text,
          _authorController.text,
          _descriptionController.text,
          _priceController.text,
          context,
        );
        _booksController.isLoading.value = false;

        router.push(
          AddBookPublishView.path,
        );
      } catch (e) {
        _booksController.isLoading.value = false;
        log("Error saving book Basic details: $e", name: "debug");
        Fluttertoast.showToast(
          msg: "Error saving book Basic details",
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
