import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class TrendingBookWidget extends StatelessWidget {
  const TrendingBookWidget({
    required this.image,
    required this.title,
    required this.author,
    super.key,
  });
  final String? image;
  final String? title;
  final String? author;

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white);
    return SizedBox(
      height: title!.length > 120
          ? MediaQuery.of(context).size.height * 0.17
          : MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: dynamicColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: customTheme['lightGrayColor']!, width: 1),
        ),
        child: Row(
          children: [
            RepaintBoundary(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.34,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: customTheme['secondaryColor'],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    MainText(
                      text: title ?? '',
                      fontSize: 16,
                      softWrap: true,
                      // overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MainText(
                      text: author ?? '',
                      fontSize: 10,
                      color: customTheme['secondaryTextColor']!,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomRatingBar(),
                    const Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainText(
                            text: 'GH₵ 50.0',
                            fontSize: 16,
                          ),
                          //Container(width: 30),
                          CustomLikeButton()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
