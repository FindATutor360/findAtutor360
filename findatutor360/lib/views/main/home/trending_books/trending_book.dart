import 'dart:developer';

import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/card/trending_books_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksCategorView extends StatefulWidget {
  const BooksCategorView({
    required this.header,
    required this.bookQuery,
    super.key,
  });
  static const path = 'booksCategory';
  final String header;
  final String bookQuery;

  @override
  State<BooksCategorView> createState() => _BooksCategorViewState();
}

class _BooksCategorViewState extends State<BooksCategorView> {
  Future<List<Book>>? fetchBooks;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final booksController =
          Provider.of<BooksController>(context, listen: false);
      booksController.fetchBooks(widget.bookQuery); // Trigger fetching books
    });

    fetchBooks = BooksController().fetchBooks(widget.bookQuery);
  }

  Future<void> _refreshBooks() async {
    setState(() {
      fetchBooks = BooksController().fetchBooks('flutter');
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
        appBar: BackIconHeader(
          header: widget.header,
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshBooks,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: FutureBuilder<List<Book>>(
                  future: fetchBooks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: MainText(
                          text: 'Error: ${snapshot.error}',
                          fontSize: 12,
                          softWrap: true,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: MainText(
                          text: 'No books found',
                          fontSize: 12,
                        ),
                      );
                    } else {
                      final books = snapshot.data!;
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        shrinkWrap: true,
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final Book book = books[index];
                          log('${books.length}', name: 'debug');
                          return InkWell(
                            onTap: () {
                              router.push(
                                BookDetails.path,
                                extra: book,
                              );
                              log(book.id ?? '', name: 'debug');
                            },
                            child: TrendingBookWidget(
                              image: book.thumbnail ??
                                  'https://via.placeholder.com/150',
                              title: book.title,
                              author: book.author ?? 'Unknown Author',
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
