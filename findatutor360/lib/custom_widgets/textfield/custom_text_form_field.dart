import 'package:findatutor360/views/main/message/message_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hint;
  final bool? autofocus;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextFormField(
          controller: controller,
          textCapitalization: textCapitalization,
          inputFormatters: [NoLeadingWhitespaceFormatter()],
          style: GoogleFonts.manrope(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(4, 118, 175, 1),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            label: label,
            labelStyle:
                const TextStyle(color: Color.fromRGBO(121, 132, 142, 1)),
            hintText: hint,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(141, 150, 159, 1), width: 1)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Color.fromRGBO(4, 118, 175, 1))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color.fromRGBO(241, 4, 4, 1), width: 1)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Color.fromRGBO(4, 118, 175, 1))),
          ),
        ));
  }
}
