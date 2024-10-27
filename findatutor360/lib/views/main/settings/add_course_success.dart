import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCourseSuccessView extends StatelessWidget {
  const AddCourseSuccessView({super.key});
  static const path = '/add_course_success';

  @override
  Widget build(BuildContext context) {
    final coursesController =
        Provider.of<CoursesController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Complete',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0XFF0476AF)),
                        child: Icon(
                          Icons.check,
                          size: 12,
                          color: customTheme['whiteColor'],
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
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0XFF0476AF)),
                        child: Icon(
                          Icons.check,
                          size: 12,
                          color: customTheme['whiteColor'],
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
                height: 40,
              ),
              Align(
                child: Image.asset('assets/images/cart.png',
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MainText(
                    text: 'Success',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "Your Course has been successfully added and is pending review",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Color(0xFF79848E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              //button

              ValueListenableBuilder(
                valueListenable: coursesController.isLoading,
                builder: (context, isLoading, child) {
                  return isLoading
                      ? const CircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryButton(
                              isIconPresent: false,
                              text: 'Continue',
                              onPressed: () async {
                                coursesController.isLoading.value = true;
                                Future.delayed(Duration(seconds: 2), () {
                                  coursesController.isLoading.value =
                                      false; // Set loading back to false after 2 seconds
                                });
                                coursesController.saveCourseDetails();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            OutlineButton(
                              text: 'Undo All Edit',
                              textColor: customTheme['badgeColor'],
                              fontWeight: FontWeight.w600,
                              borderRadius: BorderRadius.circular(8),
                              buttonColor: customTheme['whiteColor'],
                              borderSideColor: customTheme['badgeColor'],
                              isIconPresent: false,
                              fontSize: 16,
                              onPressed: () {
                                coursesController.resetBookDetails();
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
    );
  }
}
