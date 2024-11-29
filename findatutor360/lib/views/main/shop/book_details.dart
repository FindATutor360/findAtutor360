import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/core/view_models/main/review_controller.dart';
import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/card/trending_books_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/cart/cart_view.dart';
import 'package:findatutor360/views/main/shop/reviews_view.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({
    required this.books,
    super.key,
  });
  static const path = '/bookDetailsView';
  final Book books;

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  Future<List<Book>>? fetchBooks;
  late BooksController _booksController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final booksController =
          Provider.of<BooksController>(context, listen: false);
      booksController.fetchBooks('astronaut'); // Trigger fetching books
    });

    fetchBooks = BooksController().fetchBooks('astronaut');
  }

  Future<void> _refreshBooks() async {
    setState(() {
      fetchBooks = BooksController().fetchBooks('astronaut');
    });
  }

  @override
  Widget build(BuildContext context) {
    _booksController = context.watch<BooksController>();
    final reviewController = Provider.of<ReviewController>(context);

    final isFile = widget.books.thumbnail != null &&
        File(widget.books.thumbnail!).existsSync();
    final isUrl = widget.books.thumbnail != null &&
        Uri.tryParse(widget.books.thumbnail!)?.hasAbsolutePath == true;
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Book Details',
          icon: Iconsax.heart,
          iconColor: Color(0XFFFC392E),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshBooks,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      RepaintBoundary(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.20,
                              decoration: BoxDecoration(
                                color: customTheme['secondaryColor'],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                image: isFile
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(widget.books.thumbnail ?? ''),
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: NetworkImage(widget
                                                .books.thumbnail ??
                                            'https://via.placeholder.com/150'),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  MainText(
                                    text: widget.books.title ?? '',
                                    fontSize: 18,
                                    softWrap: true,
                                  ),
                                  MainText(
                                    text: widget.books.author ?? 'Unknown',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: customTheme['secondaryTextColor'],
                                    softWrap: true,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MainText(
                                    text: widget.books.price != null
                                        ? '\$${widget.books.price}'
                                        : '\$256.50',
                                    fontSize: 16,
                                    color: customTheme['primaryColor'],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  CustomRatingBar(
                                    initialRating: 4.0,
                                    itemSize: 26,
                                    onRatingUpdate: (value) {},
                                    canRate: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      MainText(
                        text: widget.books.textSnippet ?? '',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          MainText(
                            text: 'Condition:',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor'],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Iconsax.book_1,
                            color: customTheme['primaryColor'],
                          ),
                          MainText(
                            text: 'Slightly Used',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: customTheme['primaryColor'],
                          ),
                        ],
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
                          text: 'More Photos',
                          fontSize: 18,
                        ),
                        description: Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                              ),
                              itemBuilder: ((BuildContext context, int index) {
                                return RepaintBoundary(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: customTheme['secondaryColor'],
                                      borderRadius: BorderRadius.circular(10),
                                      image: isFile
                                          ? DecorationImage(
                                              image: FileImage(
                                                File(widget
                                                        .books.smallThumbnail ??
                                                    ''),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(widget
                                                      .books.smallThumbnail ??
                                                  'https://via.placeholder.com/150'),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.38,
                                        height:
                                            MediaQuery.of(context).size.height,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextExpansionTile(
                        title: const MainText(
                          text: 'About the Seller',
                          fontSize: 18,
                        ),
                        description: MainText(
                          text:
                              'King Gboza Aletsa is a medical scientist who graduated with honors in Xincology in China. \n He has a distinct style of writing that has over time been called the Xinting Mintin Simpin.',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextExpansionTile(
                        title: const MainText(
                          text: 'Book Details',
                          fontSize: 18,
                        ),
                        description: MainText(
                          text: widget.books.description ?? '',
                          color: customTheme['secondaryTextColor'],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          softWrap: true,
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
                                  .fetchReviews(widget.books.title ?? ''),
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
                                      rate: review.rating,
                                      onRatingUpdate: (p0) {},
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
                                final bookName = Uri.encodeComponent(
                                    widget.books.title ?? '');
                                router.push(
                                  '/reViews/$bookName/Book',
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
                      const SizedBox(
                        height: 19,
                      ),
                      TextOption(
                        mainText: 'Books you might like',
                        onPressed: () {
                          context.go(ShopView.path, extra: 1);
                        },
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _booksController.addToCart(widget.books);
                          Fluttertoast.showToast(
                            msg: "${widget.books.title} added to cart",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: customTheme['primaryColor'],
                            textColor: customTheme['whiteColor'],
                            fontSize: 16.0,
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
                              text: 'Add to cart',
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
                        onTap: () {
                          _booksController.addToCart(widget.books);
                          context.go(CartView.path);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0XFF0476AF),
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Buy Now',
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
