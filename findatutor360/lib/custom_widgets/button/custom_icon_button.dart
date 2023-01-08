import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomIconButton extends StatelessWidget {
  final Color? iconColor;
  final Widget? icon;
  final void Function()? onPressed;
  const CustomIconButton(
      {Key? key, required this.onPressed, required this.icon, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: icon ??
            Icon(
              Iconsax.menu_1,
              color: iconColor ?? customTheme['mainTextColor'],
            ));
  }
}
