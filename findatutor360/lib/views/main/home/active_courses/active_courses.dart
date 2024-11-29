import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/card/active_course_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveCourse extends StatefulWidget {
  const ActiveCourse({
    super.key,
  });
  static const path = 'activeCourses';

  @override
  State<ActiveCourse> createState() => _ActiveCourseState();
}

class _ActiveCourseState extends State<ActiveCourse> {
  Future<List<Course>>? fetchCourses;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coursesController =
          Provider.of<CoursesController>(context, listen: false);
      coursesController.fetchCourses();
    });

    fetchCourses = CoursesController().fetchCourses();
  }

  Future<void> _refreshCourse() async {
    setState(() {
      fetchCourses = CoursesController().fetchCourses();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Active Courses',
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshCourse,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: FutureBuilder<List<Course>>(
                  future: fetchCourses,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: MainText(
                          text: 'Error: ${snapshot.error}',
                          fontSize: 12,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: MainText(
                          text: 'No courses found',
                          fontSize: 12,
                        ),
                      );
                    } else {
                      final courses = snapshot.data!;
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        shrinkWrap: true,
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          final Course course = courses[index];

                          return InkWell(
                            onTap: () {
                              router.push(CourseDetails.path, extra: course);
                            },
                            child: ActiveCourseCard(
                              image: course.image ?? '',
                              title: course.name ?? '',
                              lessonNum: '1/3',
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
