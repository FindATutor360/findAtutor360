import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Settings Screen',
        style: GoogleFonts.manrope(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      )),
    );
  }
}
