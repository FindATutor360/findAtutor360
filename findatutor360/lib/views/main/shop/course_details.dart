import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/shop/reviews_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    required this.course,
    super.key,
  });
  static const path = '/courseDetailsView';

  final Course course;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  Future<List<Course>>? fetchCourses;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coursesController =
          Provider.of<CoursesController>(context, listen: false);
      coursesController.fetchCourses(); // Trigger fetching books
    });

    fetchCourses = CoursesController().fetchCourses();
  }

  Future<void> _refreshCourses() async {
    setState(() {
      fetchCourses = CoursesController().fetchCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Course Details',
          icon: Iconsax.heart,
          iconColor: Color(0XFF79848E),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshCourses,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      MainText(
                        text: widget.course.name ?? '',
                        fontWeight: FontWeight.w700,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFF0476AF),
                            radius: 12,
                            child: Text(
                              'A',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ), //Text
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          MainText(
                            text: 'Marcelos Ramequin',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: customTheme['secondaryTextColor'],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const CustomRatingBar(
                        itemSize: 25,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 40,
                      ),
                      TextExpansionTile(
                        title: const MainText(
                          text: 'About the Tutor',
                          fontSize: 18,
                        ),
                        description: MainText(
                          text: 'This is the description for Title 1.',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextExpansionTile(
                        title: const MainText(
                          text: 'Reviews',
                          fontSize: 18,
                        ),
                        description: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, i) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                              itemCount: 2,
                              itemBuilder: (context, i) {
                                return const ReviewData(
                                  userImage: 'A',
                                  userName: 'Anthony Rudiger',
                                  review:
                                      'The most interesting read I’ve had so far on this app. Pure passion from the writer. He makes this look like an explanation to a 12-year-old. I really like his style',
                                  date: '15.11.2022',
                                );
                              },
                            ),
                            const SizedBox(
                              height: 19,
                            ),
                            InkWell(
                              onTap: () {
                                router.push(
                                  Reviews.path,
                                );
                              },
                              child: Row(
                                children: [
                                  MainText(
                                    text: 'More Reviews',
                                    fontSize: 15,
                                    color: customTheme['primaryColor'],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    color: customTheme['primaryColor'],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0XFF0476AF),
                          ),
                        ),
                        child: Align(
                          child: MainText(
                            text: 'Add to cart',
                            fontSize: 18,
                            color: customTheme['primaryColor'],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0XFF0476AF),
                        ),
                        child: Align(
                          child: MainText(
                            text: widget.course.actualPriceUsd != null
                                ? '\$${widget.course.actualPriceUsd!.toStringAsFixed(2)} | Join'
                                : '\$${0.0} | Join',
                            fontSize: 18,
                            color: customTheme['whiteColor'],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 34,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
