import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/custom_widgets/card/book_shop_card.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BookShopView extends StatefulWidget {
  const BookShopView({super.key});
  static const path = 'bookShopView';

  @override
  State<BookShopView> createState() => _BookShopViewState();
}

class _BookShopViewState extends State<BookShopView> {
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
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black);
    return SafeArea(
      child: Scaffold(
        appBar: const AppHeader(),
        drawer: const CustomDrawer(),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshCourse,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                const Align(
                  child: MainText(
                    text: 'Learn Something New',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  child: CustomTextFormField(
                    hint: 'Find a book or a course',
                    prefixIcon: CustomIconButton(
                      onPressed: null,
                      icon: Icon(
                        Iconsax.search_normal_1,
                        color: dynamicColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const CategoryScrollview(),
                const SizedBox(
                  height: 40,
                ),
                FutureBuilder<List<Course>>(
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
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: ((BuildContext context, int index) {
                          final Course course = courses[index];
                          return InkWell(
                            onTap: () {
                              router.push(
                                CourseDetails.path,
                                extra: course,
                              );
                            },
                            child: BookShopCard(
                              name: course.name ?? '',
                              price: course.actualPriceUsd,
                            ),
                          );
                        }),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
