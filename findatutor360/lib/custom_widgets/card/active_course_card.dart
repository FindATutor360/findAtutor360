import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActiveCourseCard extends StatelessWidget {
  const ActiveCourseCard({
    required this.image,
    required this.title,
    required this.lessonNum,
    super.key,
  });
  final String image;
  final String title;
  final String lessonNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC3C8CC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width / 2.2,
            height: MediaQuery.sizeOf(context).height / 7.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: customTheme['fieldColor'],
              image: DecorationImage(
                image: AssetImage(image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: title,
                  fontSize: 16,
                  color: const Color(0XFF303539),
                  overflow: TextOverflow.clip,
                  softWrap: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainText(
                      text: lessonNum,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
                    ),
                    Icon(
                      Iconsax.play_circle5,
                      color: customTheme['primaryColor'],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
