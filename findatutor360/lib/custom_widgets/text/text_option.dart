import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

import 'main_text.dart';

class TextOption extends StatelessWidget {
  final void Function()? onPressed;
  final String? mainText;
  final String subText;
  final double horizPad;

  const TextOption({
    super.key,
    required this.onPressed,
    required this.mainText,
    this.subText = 'See All',
    this.horizPad = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizPad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MainText(text: mainText!, fontSize: 16),
          TextButton(
              onPressed: onPressed,
              child: MainText(
                  text: subText,
                  fontSize: 12,
                  color: customTheme['secondaryTextColor']))
        ],
      ),
    );
  }
}
