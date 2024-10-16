import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
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
import 'package:findatutor360/views/main/home/category/category_view.dart';
import 'package:findatutor360/views/main/home/recommeded_tutors/recommended_tutors_view.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const path = '/homeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<Book>>? fetchBooks;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final booksController =
          Provider.of<BooksController>(context, listen: false);
      booksController.fetchBooks('flutter'); // Trigger fetching books
    });

    fetchBooks = BooksController().fetchBooks('flutter');
  }

  Future<void> _refreshBooks() async {
    setState(() {
      fetchBooks = BooksController().fetchBooks('flutter');
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
                        physics: const NeverScrollableScrollPhysics(),
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
                          return Center(
                            child: MainText(
                              text: 'Error: ${snapshot.error}',
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
