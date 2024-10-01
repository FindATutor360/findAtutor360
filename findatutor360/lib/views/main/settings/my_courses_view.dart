import 'package:findatutor360/custom_widgets/card/active_course_card.dart';
import 'package:findatutor360/custom_widgets/card/finish_course_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:flutter/material.dart';

class MyCoursesView extends StatelessWidget {
  const MyCoursesView({super.key});
  static const path = '/myCoursesView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'My Courses',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextOption(
                mainText: 'Active Courses',
                onPressed: () {},
              ),
              const SizedBox(
                height: 16,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemBuilder: ((BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      router.push(
                        CourseDetails.path,
                      );
                    },
                    child: const ActiveCourseCard(
                      image: 'assets/images/activeImg.png',
                      title: 'The science of leadership',
                      lessonNum: '1/5 Lessons',
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 40,
              ),
              const MainText(
                text: 'Finished Courses',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: 5,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      router.push(
                        CourseDetails.path,
                      );
                    },
                    child: const FinishedCourseCard(
                      image: 'assets/images/activeImg.png',
                      title: 'The science of leadership',
                      subTitle: 'Rabatoir Amtics',
                      lessonNum: '1/5 Lessons',
                    ),
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
