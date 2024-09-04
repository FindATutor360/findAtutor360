import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BookShopCard extends StatelessWidget {
  const BookShopCard({
    super.key,
  });

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
          const MainText(
            text: 'The science of leadership',
            fontSize: 14,
          ),
          const SizedBox(height: 5),
          MainText(
            text: 'Marcelos Ramequin',
            fontSize: 10,
            color: customTheme['secondaryTextColor']!,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomRatingBar(),
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
          Row(
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
                    text: '\$6 Join',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: customTheme['whiteColor']!,
                  ),
                ),
              ),
              const CustomLikeButton(),
            ],
          ),
        ],
      ),
    );
  }
}
