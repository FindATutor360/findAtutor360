import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Message Screen',
        style: GoogleFonts.manrope(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      )),
    );
  }
}
