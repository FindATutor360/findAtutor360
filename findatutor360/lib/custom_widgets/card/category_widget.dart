import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryWidget extends StatefulWidget {
  final IconData? icon;
  final String? text;
  const CategoryWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  bool buttonActive = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.32,
      height: MediaQuery.of(context).size.width * 0.11,
      decoration: BoxDecoration(
          color: buttonActive
              ? customTheme['primaryColor']
              : customTheme['whiteColor'],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: customTheme['primaryColor']!)),
      child: TextButton.icon(
          onPressed: (() {
            setState(() {
              buttonActive = !buttonActive;
            });
          }),
          icon: Icon(
            widget.icon ?? Iconsax.microscope,
            color: buttonActive
                ? customTheme['whiteColor']
                : customTheme['primaryColor'],
            size: 16,
          ),
          label: Text(widget.text!,
              style: TextStyle(
                color: buttonActive
                    ? customTheme['whiteColor']
                    : customTheme['primaryColor'],
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ))),
    );
  }
}
