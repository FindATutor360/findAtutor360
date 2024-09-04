import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryWidget extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.32,
      height: MediaQuery.of(context).size.width * 0.11,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: isSelected
            ? customTheme['primaryColor']
            : customTheme['whiteColor'],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: customTheme['primaryColor']!),
      ),
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon ?? Iconsax.microscope,
          color: isSelected
              ? customTheme['whiteColor']
              : customTheme['primaryColor'],
          size: 16,
        ),
        label: Text(
          text!,
          style: TextStyle(
            color: isSelected
                ? customTheme['whiteColor']
                : customTheme['primaryColor'],
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
