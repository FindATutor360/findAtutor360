import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class DrawerElement extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final IconData? icon;
  const DrawerElement({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Icon(icon!, size: 28, color: customTheme['whiteColor']),
            const SizedBox(
              width: 20,
            ),
            MainText(
                text: text!, color: customTheme['whiteColor'], fontSize: 16),
          ],
        ),
      ),
    );
  }
}
