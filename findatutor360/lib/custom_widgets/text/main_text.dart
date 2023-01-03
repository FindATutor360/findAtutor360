import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainText extends StatelessWidget {
  final String text;
  const MainText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.manrope(
            color: const Color.fromRGBO(48, 53, 57, 1),
            fontSize: 24,
            fontWeight: FontWeight.w600));
  }
}
