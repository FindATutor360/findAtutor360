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
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class AddBookConditionView extends StatefulWidget {
  const AddBookConditionView({super.key});
  static const path = '/add_book_condition';

  @override
  State<AddBookConditionView> createState() => _AddBookConditionViewState();
}

class _AddBookConditionViewState extends State<AddBookConditionView> {
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
                isFirstDone: true,
                isSecondActive: true,
                isSecondDone: true,
                isThirdActive: true,
              ),
              const SizedBox(
                height: 40,
              ),
              MainText(
                text: 'Condition',
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
                    hintText: 'Select Book Condition',
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
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      text: 'Save and Continue',
                      isIconPresent: false,
                      fontWeight: FontWeight.w600,
                      borderRadius: BorderRadius.circular(8),
                      onPressed: () {
                        router.push(
                          AddBookSuccessView.path,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
