import 'package:flutter/material.dart';

import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';

class TextExpansionTile extends StatelessWidget {
  final String title;
  final Widget description;

  const TextExpansionTile({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0XFFC3C8CC),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        dense: true,
        collapsedIconColor: customTheme['mainTextColor'],
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: MainText(
          text: title,
          fontSize: 18,
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        expandedAlignment: Alignment.centerLeft,
        children: [
          description,
        ],
      ),
    );
  }
}
