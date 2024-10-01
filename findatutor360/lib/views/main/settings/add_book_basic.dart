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
import 'package:go_router/go_router.dart';

class AddBookBasicView extends StatefulWidget {
  const AddBookBasicView({super.key});
  static const path = '/add_book_basic';

  @override
  State<AddBookBasicView> createState() => _AddBookBasicViewState();
}

class _AddBookBasicViewState extends State<AddBookBasicView> {
  String typeDropdown = '';

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
              const CustomTextFormField(
                hint: 'Enter Book Title',
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
              const CustomTextFormField(
                hint: 'Enter Your Name',
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
              const CustomTextFormField(
                hint: 'Enter Book Price',
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
              const ExpandTextFormField(
                hint: 'Describe Book',
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: 'Format',
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
                    hintText: 'Select Format',
                    hintStyle: TextStyle(
                      color: customTheme['secondaryTextColor'],
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "Option 1",
                      child: MainText(
                        text: 'Option 1',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Option 2",
                      child: MainText(
                        text: 'Option 2',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 16,
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Option 3",
                      child: MainText(
                        text: 'Option 3',
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
                      return "Please select identify Type";
                    }
                    return null;
                  },
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
                    AddBookPublishView.path,
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
