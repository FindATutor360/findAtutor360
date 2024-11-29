import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/card/active_course_card.dart';
import 'package:findatutor360/custom_widgets/card/finish_course_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({super.key});
  static const path = '/myCoursesView';

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView> {
  late CoursesController _coursesController;
  Future<List<Course>>? fetchCourses;

  @override
  void initState() {
    super.initState();
    _coursesController = context.read<CoursesController>();
    fetchCourses = CoursesController().fetchCourses();
  }

  Future<void> _refreshMessages() async {
    setState(
      () {
        _coursesController.fetchUserCourses();
        fetchCourses = CoursesController().fetchCourses();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'My Courses',
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshMessages,
          child: SingleChildScrollView(
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
                StreamBuilder<List<Course>>(
                    stream: _coursesController.fetchUserCourses(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: MainText(
                            text: "You haven't added any course yet",
                            fontSize: 20,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: MainText(
                            text: "Error loading User courses",
                            fontSize: 20,
                          ),
                        );
                      }
                      final userCourses = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userCourses.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16),
                        itemBuilder: ((BuildContext context, i) {
                          final userCourse = userCourses[i];
                          return InkWell(
                            onTap: () {
                              router.push(CourseDetails.path,
                                  extra: userCourse);
                            },
                            child: ActiveCourseCard(
                              image: userCourse.image ?? '',
                              title: userCourse.name ?? '',
                              lessonNum: '1/5 Lessons',
                            ),
                          );
                        }),
                      );
                    }),
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
                FutureBuilder<List<Course>>(
                    future: fetchCourses,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                          child: MainText(
                            text: 'No courses found',
                            fontSize: 12,
                          ),
                        );
                      } else {
                        final courses = snapshot.data!;
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          separatorBuilder: (context, i) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: 3,
                          itemBuilder: (context, i) {
                            final Course course = courses[i];
                            return InkWell(
                              onTap: () {
                                router.push(CourseDetails.path, extra: course);
                              },
                              child: FinishedCourseCard(
                                image: course.image ??
                                    'assets/images/activeImg.png',
                                title:
                                    course.name ?? 'The science of leadership',
                                author: 'Rabatoir Amtics',
                                lessonNum: '1/5 Lessons',
                              ),
                            );
                          },
                        );
                      }
                    }),
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
}
