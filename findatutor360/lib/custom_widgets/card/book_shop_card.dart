import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BookShopCard extends StatelessWidget {
  const BookShopCard({
    this.name,
    this.price,
    super.key,
  });
  final String? name;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromRGBO(195, 200, 204, 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MainText(
              text: name ?? '',
              fontSize: 14,
              softWrap: true,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: MainText(
              text: 'Marcelos Ramequin',
              fontSize: 10,
              color: customTheme['secondaryTextColor']!,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRatingBar(
                initialRating: 3,
                onRatingUpdate: (double) {},
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Iconsax.clock,
                      size: 11,
                      color: customTheme['secondaryTextColor']!,
                    ),
                    const SizedBox(width: 2),
                    MainText(
                      text: 'Sunday-3pm',
                      fontSize: 8,
                      color: customTheme['secondaryTextColor']!,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: 70,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color: customTheme['primaryColor'],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: customTheme['primaryColor']!,
                    ),
                  ),
                  child: Align(
                    child: MainText(
                      text: price != null
                          ? '\$${price!.toStringAsFixed(2)} | Join'
                          : ' Join',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: customTheme['whiteColor']!,
                    ),
                  ),
                ),
                const CustomLikeButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
