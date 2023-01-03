import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? label;
  final Widget? suffixIcon;
  final String? hint;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    this.label,
    this.suffixIcon,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          controller: controller,
          style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(4, 118, 175, 1)),
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
              label: label,
              labelStyle:
                  const TextStyle(color: Color.fromRGBO(121, 132, 142, 1)),
              hintText: hint,
              suffixIcon: suffixIcon,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(141, 150, 159, 1), width: 1)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: Color.fromRGBO(4, 118, 175, 1)))),
        ));
  }
}
