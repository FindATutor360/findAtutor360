import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customTheme['whiteColor'],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                  child: Text(
                'Home Screen',
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
