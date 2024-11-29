import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/card/active_book_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBooksView extends StatefulWidget {
  const MyBooksView({super.key});
  static const path = '/myBooksView';

  @override
  State<MyBooksView> createState() => _MyBooksViewState();
}

class _MyBooksViewState extends State<MyBooksView> {
  late BooksController _booksController;

  @override
  void initState() {
    super.initState();
    _booksController = context.read<BooksController>();
  }

  Future<void> _refreshMessages() async {
    setState(
      () {
        _booksController.fetchUserBooks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'My Books',
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: _refreshMessages,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                const MainText(
                  text: 'Active Books',
                  fontSize: 16,
                ),
                const SizedBox(
                  height: 24,
                ),
                StreamBuilder<List<Book>>(
                    stream: _booksController.fetchUserBooks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: MainText(
                            text: "You haven't added any book yet",
                            fontSize: 20,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: MainText(
                            text: "Error loading User books",
                            fontSize: 20,
                          ),
                        );
                      }
                      final userBooks = snapshot.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userBooks.length,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16),
                        itemBuilder: ((BuildContext context, i) {
                          final userBook = userBooks[i];

                          return InkWell(
                            onTap: () {
                              router.push(
                                BookDetails.path,
                                extra: userBook,
                              );
                              //   extra: userBook,
                              // );
                            },
                            child: ActiveBookCard(
                              image: userBook.thumbnail ?? '',
                              title: userBook.title ?? '',
                              lessonPecent: '77%',
                            ),
                          );
                        }),
                      );
                    }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
