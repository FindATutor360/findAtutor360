import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        // padding: EdgeInsets.all(0),
        onPressed: null,
        icon: Icon(Iconsax.heart, size: 24, color: customTheme['errorColor']!));
  }
}
