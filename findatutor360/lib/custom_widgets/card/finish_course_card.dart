import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FinishedCourseCard extends StatelessWidget {
  const FinishedCourseCard({
    required this.image,
    required this.title,
    required this.author,
    required this.lessonNum,
    super.key,
  });
  final String image;
  final String title;
  final String author;
  final String lessonNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) {
            return Container(
              width: MediaQuery.sizeOf(context).width / 4,
              height: MediaQuery.sizeOf(context).height / 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: customTheme['fieldColor'],
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (context, image) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width / 4,
                height: MediaQuery.sizeOf(context).height / 8,
              ),
            );
          },
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: title,
                fontSize: 17,
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
              MainText(
                text: author,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF545C64),
              ),
              const SizedBox(
                height: 8,
              ),
              FractionallySizedBox(
                widthFactor: 0.25,
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: customTheme['successTextColor'],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainText(
                    text: lessonNum,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: customTheme['secondaryTextColor'],
                  ),
                  MainText(
                    text: '100%',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: customTheme['secondaryTextColor'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
