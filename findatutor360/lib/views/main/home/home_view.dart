import 'dart:developer';

import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/models/main/tutors_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/core/view_models/main/tutors_controller.dart';
import 'package:findatutor360/custom_widgets/card/active_course_card.dart';
import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/card/trending_books_card.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/slider/custom_carousel_view.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/home/active_courses/active_courses.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
//import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const path = '/homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  User? auth = FirebaseAuth.instance.currentUser;

  Future<List<Book>>? fetchBooks;

  Future<List<Course>>? fetchCourses;

  Future<List<Data>>? fetchTutors;

  @override
  void initState() {
    super.initState();

    Provider.of<AuthController>(context, listen: false)
        .getUserInfo(auth?.uid ?? 'gg');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final booksController =
          Provider.of<BooksController>(context, listen: false);
      booksController.fetchBooks('flutter');

      final coursesController =
          Provider.of<CoursesController>(context, listen: false);
      coursesController.fetchCourses();

      final tutorsController =
          Provider.of<TutorsController>(context, listen: false);
      tutorsController.fetchTutors();
    });

    fetchBooks = BooksController().fetchBooks('flutter');
    fetchCourses = CoursesController().fetchCourses();
    fetchTutors = TutorsController().fetchTutors();
  }

  Future<void> _refreshBooks() async {
    setState(() {
      fetchBooks = BooksController().fetchBooks('flutter');
      fetchCourses = CoursesController().fetchCourses();
      fetchTutors = TutorsController().fetchTutors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppHeader(),
        drawer: const CustomDrawer(),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshBooks,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const CustomCarouselView(),
                    const SizedBox(
                      height: 20,
                    ),
                    TextOption(
                      mainText: 'Category',
                      subText: '',
                      onPressed: () {},
                    ),
                    const CategoryScrollview(),
                    const SizedBox(
                      height: 40,
                    ),
                    TextOption(
                      mainText: 'Recommended Tutors',
                      onPressed: () {
                        router.push('${HomeView.path}/recommendedTutors');
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //const RecommededTutorCard(),
                    FutureBuilder<List<Data>>(
                      future: fetchTutors,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.red),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No tutors found',
                                style: TextStyle(fontSize: 14)),
                          );
                        } else {
                          final tutors = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              final tutor = tutors[index];
                              double extractRating(String? ratings) {
                                if (ratings == null || ratings.isEmpty) {
                                  return 0.0;
                                }

                                // Extract numeric rating from the string (e.g., "5 (14 Reviews)")
                                final numericPart = RegExp(r'^\d+(\.\d+)?')
                                    .firstMatch(ratings)
                                    ?.group(0); // Get the first numeric part
                                return double.tryParse(numericPart ?? '0') ??
                                    0.0;
                              }

                              return InkWell(
                                onTap: () async {
                                  final tutorUrl = tutor.source ?? '';
                                  final sanitizedTutorName =
                                      (tutor.tutorName ?? '')
                                          .replaceAll('©', '(C)')
                                          .replaceAll('&', 'and')
                                          .replaceAll('%', 'percent')
                                          .replaceAll(RegExp(r'[^\w\s-]'), '');
                                  final tutorName =
                                      Uri.encodeComponent(sanitizedTutorName);

                                  final encodedUrl = (tutorUrl.isEmpty)
                                      ? Uri.encodeComponent(
                                          'https://www.superprof.co.in/senior-data-scientist-amazon-economics-iit-kanpur-provides-mentoring-basics-advanced-level-statistics.html')
                                      : Uri.encodeComponent(tutorUrl);

                                  router.push(
                                      '/enrollView/$tutorName/$encodedUrl');
                                },
                                child: RecommededTutorCard(
                                  tutorImage: tutor.tutorImage,
                                  tutorName: tutor.tutorName,
                                  tutorStatus: tutor.status,
                                  tutorRate: extractRating(tutor.ratings),
                                  isOnline: tutor.location
                                          ?.toLowerCase()
                                          .contains('online') ??
                                      false,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    TextOption(
                      mainText: 'Active Courses',
                      onPressed: () {
                        router.push('${HomeView.path}/${ActiveCourse.path}');
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // ActiveCourse(),

                    FutureBuilder<List<Course>>(
                      future: fetchCourses,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          log('${snapshot.error}', name: 'debugs');
                          return const Center(
                            child: MainText(
                              text: 'Error: Network error',
                              fontSize: 12,
                              softWrap: true,
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: MainText(
                              text: 'No courses found',
                              fontSize: 12,
                            ),
                          );
                        } else {
                          final courses = snapshot.data!;

                          return Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20);
                              },
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final Course course = courses[index];

                                return InkWell(
                                  onTap: () {
                                    router.push(CourseDetails.path,
                                        extra: course);
                                  },
                                  child: ActiveCourseCard(
                                    image: course.image ?? '',
                                    title: course.name ?? '',
                                    lessonNum: '1/3',
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    TextOption(
                      mainText: 'Trending Books',
                      onPressed: () {
                        const header = 'Trending Books';
                        const bookQuery = 'flutter';
                        router.push(
                            '${HomeView.path}/booksCategory/$header/$bookQuery');
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    FutureBuilder<List<Book>>(
                      future: fetchBooks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: MainText(
                              text: 'Error: Network error',
                              fontSize: 12,
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: MainText(
                              text: 'No books found',
                              fontSize: 12,
                            ),
                          );
                        } else {
                          final books = snapshot.data!;
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 20);
                              },
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final Book book = books[index];
                                return InkWell(
                                  onTap: () {
                                    router.push(
                                      BookDetails.path,
                                      extra: book,
                                    );
                                  },
                                  child: TrendingBookWidget(
                                    image: book.thumbnail ??
                                        'https://via.placeholder.com/150',
                                    title: book.title,
                                    author: book.author ?? 'Unknown Author',
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
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
