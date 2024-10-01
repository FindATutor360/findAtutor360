import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});
  static const path = '/wishlistView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Wishlist',
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          separatorBuilder: (context, i) {
            return const SizedBox(
              height: 16,
            );
          },
          itemCount: 7,
          itemBuilder: (context, i) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFDEE0E3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2.5,
                    height: MediaQuery.sizeOf(context).height / 5.5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      color: customTheme['secondaryColor'],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/activeImg.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                            text: 'The science of leadership',
                            fontSize: 16,
                            color: Color(0XFF303539),
                            overflow: TextOverflow.clip,
                            softWrap: true,
                          ),
                          MainText(
                            text: 'Marcelos Ramequin',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor'],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          MainText(
                            text: '\$256.50',
                            fontSize: 16,
                            color: customTheme['primaryColor'],
                          ),
                          const CustomRatingBar(),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: customTheme['primaryColor'],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const MainText(
                                  text: 'Add to Cart',
                                  fontSize: 14,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              Icon(
                                Iconsax.heart5,
                                color: customTheme['badgeColor'],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
