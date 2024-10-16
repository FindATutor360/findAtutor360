import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShopBookWidget extends StatelessWidget {
  const ShopBookWidget({
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
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: dynamicColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: customTheme['lightGrayColor']!, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.38,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: customTheme['secondaryColor'],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
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
                    height: 15,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MainText(
                          text: 'GH₵ 50.0',
                          fontSize: 16,
                        ),
                        Container(width: 30),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const CustomRatingBar(),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 120,
                          height: MediaQuery.of(context).size.width * 0.11,
                          decoration: BoxDecoration(
                              color: customTheme['primaryColor'],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: customTheme['primaryColor']!)),
                          child: Row(
                            children: [
                              TextButton.icon(
                                onPressed: (() {}),
                                icon: Icon(
                                  Iconsax.buy_crypto,
                                  color: customTheme['whiteColor'],
                                  size: 18,
                                ),
                                label: Text(
                                  "GH6 Buy",
                                  style: TextStyle(
                                    color: customTheme['whiteColor'],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const CustomLikeButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
