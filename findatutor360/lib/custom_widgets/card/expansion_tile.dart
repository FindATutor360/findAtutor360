import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class TextExpansionTile extends StatelessWidget {
  final Widget title;
  final Widget description;
  final bool initiallyExpanded;
  final Color? iconColor;

  const TextExpansionTile(
      {super.key,
      required this.title,
      required this.description,
      this.initiallyExpanded = false,
      this.iconColor});

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
        initiallyExpanded: initiallyExpanded,
        shape: const Border(),
        collapsedShape: const Border(),
        dense: true,
        collapsedIconColor: customTheme['mainTextColor'],
        iconColor: iconColor ?? customTheme['mainTextColor'],
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: title,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        expandedAlignment: Alignment.centerLeft,
        children: [
          description,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
