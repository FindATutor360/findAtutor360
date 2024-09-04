import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});
  static const path = '/bookDetailsView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Book Details',
          icon: Iconsax.heart,
          iconColor: Color(0XFFFC392E),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: ListView(
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
                              image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/activeImg.png'),
                                  fit: BoxFit.contain),
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
                                const MainText(
                                  text:
                                      'The science of leadership: Leadership in the Millenia',
                                  fontSize: 18,
                                ),
                                MainText(
                                  text: 'Marcelos Ramequin',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: customTheme['secondaryTextColor'],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                MainText(
                                  text: '\$256.50',
                                  fontSize: 16,
                                  color: customTheme['primaryColor'],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const CustomRatingBar(
                                  itemSize: 32,
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
                      text:
                          'This is the book! If you’ve ever thought of becoming a leder in this messed up lillenia, grab a copy of this book',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
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
                      title: 'More Photos',
                      description: MainText(
                        text: 'This is the description for Title 1.',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextExpansionTile(
                      title: 'About the Seller',
                      description: MainText(
                        text: 'This is the description for Title 1.',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextExpansionTile(
                      title: 'Book Details',
                      description: MainText(
                        text: 'This is the description for Title 1.',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextExpansionTile(
                      title: 'Reviews',
                      description: MainText(
                        text: 'This is the description for Title 1.',
                        color: customTheme['secondaryTextColor'],
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
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
                    child: Container(
                      height: 60,
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
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      height: 60,
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
                ],
              ),
              const SizedBox(
                height: 34,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
