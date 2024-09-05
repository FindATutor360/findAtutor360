import 'package:findatutor360/custom_widgets/card/expansionTile.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});
  static const path = '/reViews';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          closeIcon: Icons.close,
          header: 'Reviews',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0XFF79848E),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        MainText(
                          text: '4.6',
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: MainText(
                            text: '\\5',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    MainText(
                      text: 'Based on 29 reviews',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    CustomRatingBar(
                      itemSize: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    RatingDialog(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.add_square,
                          color: customTheme['primaryColor'],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        MainText(
                          text: 'Add Review',
                          fontSize: 16,
                          color: customTheme['primaryColor'],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: 'User reviews',
                    fontSize: 18,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.setting_4,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      MainText(
                        text: 'Most Relevant',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextExpansionTile(
                initiallyExpanded: true,
                title: 'Reviews',
                description: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: 4,
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
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewData extends StatelessWidget {
  const ReviewData({
    required this.userImage,
    required this.userName,
    required this.review,
    required this.date,
    super.key,
  });
  final String userImage;
  final String userName;
  final String review;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF0476AF),
              radius: 20,
              child: MainText(
                text: userImage,
                fontSize: 16,
                color: customTheme['whiteColor'],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            MainText(
              text: userName,
              fontSize: 14,
            ),
            const SizedBox(
              width: 12,
            ),
            const CustomRatingBar(
              itemSize: 25,
            ),
          ],
        ),
        const SizedBox(
          height: 19,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: review,
                color: customTheme['secondaryTextColor'],
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              MainText(
                text: date,
                color: customTheme['secondaryTextColor'],
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingDialog extends PopupRoute<void> {
  RatingDialog(
      // this.selectedRating,
      // this.requestId,
      );

  // int selectedRating;
  // String? requestId;

  @override
  Color? get barrierColor => const Color(0xFFE0E0E0).withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Rating dialog';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return StatefulBuilder(
      builder: (BuildContext context, setInnerState) {
        return Align(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.90,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      MainText(
                        text: 'How would you rate this book',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CustomRatingBar(
                        itemSize: 40,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MainText(
                        text: 'Add a Review',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 16,
                          color: customTheme['mainTextColor'],
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Type to add a note',
                          hintStyle: TextStyle(
                            color: customTheme['secondaryTextColor'],
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0XFF8D969F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0XFF8D969F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0XFF8D969F),
                            ),
                          ),
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
                                color: const Color(0XFF0476AF),
                              ),
                              child: Align(
                                child: MainText(
                                  text: 'Done',
                                  fontSize: 18,
                                  color: customTheme['whiteColor'],
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
                                border: Border.all(
                                  color: const Color(0XFF0476AF),
                                ),
                              ),
                              child: Align(
                                child: MainText(
                                  text: 'Cancel',
                                  fontSize: 18,
                                  color: customTheme['primaryColor'],
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
            ),
          ),
        );
      },
    );
  }

  @override
  Duration get transitionDuration => Duration.zero;

  void _handleAccept(BuildContext context) {
    Navigator.pop(context);

    // Navigator.of(context).pushNamedAndRemoveUntil(
    //   AppRoutes.v2HomeNavigationRoute,
    //   (Route<dynamic> route) => false,
    // );
  }
}
