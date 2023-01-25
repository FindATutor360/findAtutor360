import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

import 'main_text.dart';

class TextOption extends StatelessWidget {
  final void Function()? onPressed;
  final String? mainText;

  const TextOption({
    Key? key,
    required this.onPressed,
    required this.mainText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MainText(text: mainText!, fontSize: 16),
          TextButton(
              onPressed: onPressed,
              child: MainText(
                  text: 'See All',
                  fontSize: 12,
                  color: customTheme['secondaryTextColor']))
        ],
      ),
    );
  }
}
