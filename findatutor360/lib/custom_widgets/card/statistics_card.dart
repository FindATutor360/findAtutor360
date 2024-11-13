import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    required this.value,
    required this.achievement,
    super.key,
  });
  final String value;
  final String achievement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2,
      // height: MediaQuery.sizeOf(context).height / 8.8,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFC3C8CC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: customTheme['primaryColor'],
                child: Icon(
                  Iconsax.award,
                  color: customTheme['whiteColor'],
                  size: 18,
                ),
              ),
              MainText(
                text: value,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          MainText(
            text: achievement,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
