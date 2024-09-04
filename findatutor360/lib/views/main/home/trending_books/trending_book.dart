import 'package:findatutor360/custom_widgets/card/trending_books_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:flutter/material.dart';

class TrendingBooksView extends StatelessWidget {
  const TrendingBooksView({super.key});
  static const path = 'trendingBooks';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Trending Books',
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 12);
                },
                itemCount: 10,
                itemBuilder: (context, i) {
                  return const TrendingBookWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
