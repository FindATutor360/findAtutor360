import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/cart/cart_view.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:findatutor360/views/main/shop/book_shop_course.dart';
import 'package:findatutor360/views/main/shop/shop_books.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/drawer/custom_drawer.dart';
import '../../../custom_widgets/slider/custom_carousel_view.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});
  static const path = '/shopView';

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  Future<List<Book>>? fetchBooks;
  late BooksController _booksController;

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
    _booksController = context.watch<BooksController>();

    return SafeArea(
      child: Scaffold(
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
                      height: 30,
                    ),
                    const CategoryScrollview(),
                    const SizedBox(
                      height: 40,
                    ),
                    TextOption(
                      mainText: '',
                      onPressed: () {
                        router.push(
                          '${ShopView.path}/${BookShopView.path}',
                        );
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
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            separatorBuilder: (context, i) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: 3,
                            itemBuilder: (context, i) {
                              final Book book = books[i];
                              return InkWell(
                                onTap: () {
                                  router.push(
                                    BookDetails.path,
                                    extra: book,
                                  );
                                },
                                child: ShopBookWidget(
                                  image: book.thumbnail ??
                                      'https://via.placeholder.com/150',
                                  title: book.title,
                                  author: book.author ?? 'Unknown Author',
                                  buyTap: () {
                                    _booksController.addToCart(book);
                                    router.go(CartView.path);
                                  },
                                ),
                              );
                            },
                          );
                        }
                      },
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
