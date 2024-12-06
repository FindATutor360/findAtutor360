import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/view_models/main/review_controller.dart';
import 'package:findatutor360/custom_widgets/card/expansion_tile.dart';
import 'package:findatutor360/custom_widgets/dialogs/review_dialog.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    this.courseName,
    this.page,
    super.key,
  });
  static const path = '/reViews';
  final String? courseName;
  final String? page;

  @override
  Widget build(BuildContext context) {
    final reviewController = Provider.of<ReviewController>(context);
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          closeIcon: Icons.close,
          header: 'Reviews',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0XFF79848E),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
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
                    const MainText(
                      text: 'Based on 29 reviews',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    CustomRatingBar(
                      itemSize: 25,
                      initialRating: 4.0,
                      onRatingUpdate: (value) {},
                      canRate: false,
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    RatingDialog(
                      context,
                      initialRating: 1,
                      onSubmit: (rating, comment) async {
                        await reviewController.saveReview(
                          courseName,
                          comment,
                          page,
                          rating,
                          context,
                        );
                      },
                    ),
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
                title: const MainText(
                  text: 'Reviews',
                  fontSize: 18,
                ),
                description: StreamBuilder<List<Review>>(
                  stream: reviewController.fetchReviews(courseName ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: MainText(
                          text: 'No Review yet',
                          fontSize: 12,
                        ),
                      );
                    }
                    final reviews = snapshot.data ?? [];
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, i) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: reviews.length,
                      itemBuilder: (context, i) {
                        final review = reviews[i];
                        final createdAt =
                            (review.createdAt as Timestamp).toDate();
                        final formattedDate = formatDate(createdAt);

                        return ReviewData(
                          userImage: review.profileImage ?? '',
                          userName: review.senderName ?? '',
                          review: review.comment ?? '',
                          date: formattedDate,
                          rate: review.rating ?? 0,
                          onRatingUpdate: (v) {},
                        );
                      },
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

  String formatDate(DateTime createdAt) {
    final now = DateTime.now();

    if (createdAt.year == now.year &&
        createdAt.month == now.month &&
        createdAt.day == now.day) {
      final difference = now.difference(createdAt);
      if (difference.inHours < 1) {
        return '${difference.inMinutes}mins ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}hr ago';
      } else {
        return 'Today';
      }
    } else {
      final yesterday = now.subtract(const Duration(days: 1));
      if (createdAt.year == yesterday.year &&
          createdAt.month == yesterday.month &&
          createdAt.day == yesterday.day) {
        return 'Yesterday';
      } else {
        return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
      }
    }
  }
}

class ReviewData extends StatelessWidget {
  const ReviewData({
    required this.userImage,
    required this.userName,
    required this.review,
    required this.date,
    required this.rate,
    required this.onRatingUpdate,
    super.key,
  });
  final String userImage;
  final String userName;
  final String review;
  final String date;
  final double rate;
  final void Function(double) onRatingUpdate;

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
            CustomRatingBar(
              itemSize: 25,
              initialRating: rate,
              onRatingUpdate: onRatingUpdate,
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
