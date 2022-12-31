import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'Cart Screen',
        style: GoogleFonts.manrope(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      )),
    );
  }
}
