import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final Color? color;
  final TextAlign? textAlign;
  final bool softWrap;

  const MainText({
    super.key,
    required this.text,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.color,
    this.overflow,
    this.textAlign,
    this.softWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = color ??
        (Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black);

    return Text(
      softWrap: softWrap,
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: GoogleFonts.manrope(
        color: dynamicColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
