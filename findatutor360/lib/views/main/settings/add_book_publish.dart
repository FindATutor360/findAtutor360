import 'dart:developer';

import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_book_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddBookPublishView extends StatefulWidget {
  const AddBookPublishView({super.key});
  static const path = '/add_book_publish';

  @override
  State<AddBookPublishView> createState() => _AddBookPublishViewState();
}

class _AddBookPublishViewState extends State<AddBookPublishView> {
  late BooksController _booksController;

  final _publisherController = TextEditingController();
  final _textSnippetController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String typeDropdown = '';
  String? text;

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
                  isFirstDone: true,
                  isSecondActive: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                MainText(
                  text: 'Publisher',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'Enter Book Publisher',
                  controller: _publisherController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter book publisher';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                MainText(
                  text: 'Book Details',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextFormField(
                  hint: 'Enter Book Details',
                  controller: _textSnippetController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter book details';
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
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? customTheme['secondaryTextColor']
                            : customTheme['whiteColor'],
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
                      hintText: 'Select Category',
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
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Geography",
                        child: MainText(
                          text: 'Geography',
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Music",
                        child: MainText(
                          text: 'Music',
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Mathematics",
                        child: MainText(
                          text: 'Mathematics',
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Health",
                        child: MainText(
                          text: 'Health',
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Finance",
                        child: MainText(
                          text: 'Finance',
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
                          fontSize: 16,
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Crypto",
                        child: MainText(
                          text: 'Crypto',
                          color: Theme.of(context).brightness != Brightness.dark
                              ? customTheme['secondaryTextColor']
                              : customTheme['whiteColor'],
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
                        return "Please select identify Type";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                                  addBookPublishDetails();
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

  Future<void> addBookPublishDetails() async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      try {
        _booksController.isLoading.value = true;
        await _booksController.addBookPublishDetails(
          _publisherController.text,
          _textSnippetController.text,
          typeDropdown,
          context,
        );
        log(typeDropdown, name: 'debug');
        _booksController.isLoading.value = false;

        router.push(
          AddBookImageView.path,
        );
      } catch (e) {
        _booksController.isLoading.value = false;
        log("Error saving book Publish details: $e", name: "debug");
        Fluttertoast.showToast(
          msg: "Error saving book Publish details",
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
