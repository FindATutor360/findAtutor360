import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/card/trending_books_card.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/slider/custom_carousel_view.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/home/active_courses/active_courses.dart';
import 'package:findatutor360/views/main/home/category/category_view.dart';
import 'package:findatutor360/views/main/home/recommeded_tutors/recommended_tutors_view.dart';
import 'package:findatutor360/views/main/home/trending_books/trending_book.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const path = '/homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppHeader(),
        drawer: const CustomDrawer(),
        body: CustomScrollView(
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
                    onPressed: () {
                      router.push(CategoryView.path);
                    },
                  ),
                  const CategoryScrollview(),
                  const SizedBox(
                    height: 40,
                  ),
                  TextOption(
                    mainText: 'Recommended Tutors',
                    onPressed: () {
                      router.push(
                          '${HomeView.path}/${RecommendedTutorsView.path}');
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //const RecommededTutorCard(),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15),
                      itemBuilder: ((BuildContext context, int index) {
                        return const RecommededTutorCard();
                      })),
                  const SizedBox(
                    height: 40,
                  ),
                  TextOption(
                    mainText: 'Active Courses',
                    onPressed: () {
                      router.push(
                          '${HomeView.path}/${RecommendedTutorsView.path}');
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // ActiveCourse(),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        ActiveCourse(),
                        SizedBox(width: 20),
                        ActiveCourse(),
                        SizedBox(width: 20),
                        ActiveCourse(),
                        SizedBox(width: 20),
                        ActiveCourse()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextOption(
                    mainText: 'Trending Books',
                    onPressed: () {
                      router.push('${HomeView.path}/${TrendingBooksView.path}');
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        TrendingBookWidget(),
                        SizedBox(width: 20),
                        TrendingBookWidget(),
                        SizedBox(width: 20),
                        TrendingBookWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            // SliverList(
            //     delegate: SliverChildListDelegate([

            // ])),
            // SliverList(
            //   delegate: SliverChildListDelegate(
            //     [

            //     ],
            //   ),
            // ),
            // SliverList(
            //     delegate: SliverChildListDelegate([

            // ])),
          ],
        ),
      ),
    );
  }
}
