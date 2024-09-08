import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/card/trending_books_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/shop/reviews_view.dart';
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
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: customTheme['secondaryColor'],
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/activeImg.png'),
                                      fit: BoxFit.contain),
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
                      title: const MainText(
                        text: 'Reviews',
                        fontSize: 18,
                      ),
                      description: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, i) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: 2,
                            itemBuilder: (context, i) {
                              return const ReviewData(
                                userImage: 'A',
                                userName: 'Anthony Rudiger',
                                review:
                                    'The most interesting read I’ve had so far on this app. Pure passion from the writer. He makes this look like an explanation to a 12-year-old. I really like his style',
                                date: '15.11.2022',
                              );
                            },
                          ),
                          const SizedBox(
                            height: 19,
                          ),
                          InkWell(
                            onTap: () {
                              router.push(
                                Reviews.path,
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
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            width: 8,
                          );
                        }),
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              router.push(
                                BookDetails.path,
                              );
                            },
                            child: const TrendingBookWidget(),
                          );
                        },
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
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
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
