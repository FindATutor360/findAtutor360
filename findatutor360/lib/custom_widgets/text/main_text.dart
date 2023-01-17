import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final Color? color;
  const MainText({
    Key? key,
    required this.text,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        style: GoogleFonts.manrope(
            color: color ?? customTheme['mainTextColor'],
            fontSize: fontSize,
            fontWeight: fontWeight));
  }
}
