import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/core/view_models/main/review_controller.dart';
import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/message/chat.dart';
import 'package:findatutor360/views/main/shop/reviews_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final User? auth = FirebaseAuth.instance.currentUser;

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
    final reviewController = Provider.of<ReviewController>(context);

    final normalizedCourseName = normalizeCourseName(widget.course.name);
    final courseName = Uri.encodeComponent(normalizedCourseName);

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
                      CustomRatingBar(
                        itemSize: 25,
                        initialRating: 3.5,
                        onRatingUpdate: (p0) {},
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
                          text: 'Coruse Description',
                          fontSize: 18,
                        ),
                        description: MainText(
                          text: widget.course.description ?? '',
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
                            StreamBuilder<List<Review>>(
                              stream: reviewController
                                  .fetchReviews(normalizedCourseName),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: MainText(
                                      text: 'No Review yet',
                                      fontSize: 12,
                                    ),
                                  );
                                }
                                final reviews = snapshot.data ?? [];
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, i) {
                                    return const SizedBox(
                                      height: 16,
                                    );
                                  },
                                  itemCount: reviews.length,
                                  itemBuilder: (context, i) {
                                    final review = reviews[i];
                                    final createdAt =
                                        (review.createdAt as Timestamp)
                                            .toDate();
                                    final formattedDate = formatDate(createdAt);

                                    return ReviewData(
                                      userImage: review.profileImage ?? '',
                                      userName: review.senderName ?? '',
                                      review: review.comment ?? '',
                                      date: formattedDate,
                                      rate: review.rating ?? 0,
                                      onRatingUpdate: (double) {},
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 19,
                            ),
                            InkWell(
                              onTap: () {
                                router.push('/reViews/$courseName/Course');
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const ChatViews(
                                    // user: user,
                                    tutorEmail: 'asanteadarkwa.usman@gmail.com',
                                  )),
                            ),
                          );
                        },
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
                              text: 'Chat Tutor',
                              fontSize: 18,
                              color: customTheme['primaryColor'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final sanitizedCourseName = (widget.course.name ?? '')
                              .replaceAll('©', '(C)')
                              .replaceAll('&', 'and')
                              .replaceAll('%', 'percent')
                              .replaceAll(RegExp(r'[^\w\s-]'), '');
                          final courseName =
                              Uri.encodeComponent(sanitizedCourseName);
                          final searchQuery = Uri.encodeComponent(courseName);
                          final url = Uri.encodeComponent(
                              'https://www.udemy.com/courses/search/?src=ukw&q=$searchQuery');

                          router.push('/enrollView/$courseName/$url');
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0XFF0476AF),
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Enroll',
                              fontSize: 18,
                              color: customTheme['whiteColor'],
                            ),
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

  String formatDate(DateTime createdAt) {
    final now = DateTime.now();

    if (createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day) {
      final difference = now.difference(createdAt);
      if (difference.inHours < 1) {
        return '${difference.inMinutes}mins ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}hr ago';
      } else {
        return 'Today';
      }
    } else {
      final yesterday = now.subtract(const Duration(days: 1));
      if (createdAt.year == yesterday.year &&
          createdAt.month == yesterday.month &&
          createdAt.day == yesterday.day) {
        return 'Yesterday';
      } else {
        return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
      }
    }
  }
}
