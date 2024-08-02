import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: IconButton(
          padding: const EdgeInsets.all(2),
          onPressed: null,
          icon:
              Icon(Iconsax.heart, size: 20, color: customTheme['errorColor']!)),
    );
  }
}
