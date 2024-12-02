import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/message/message_field.dart';
import 'package:flutter/material.dart';

class ExpandTextFormField extends StatelessWidget {
  const ExpandTextFormField({
    required this.hint,
    this.controller,
    this.validator,
    super.key,
  });
  final String hint;

  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: [NoLeadingWhitespaceFormatter()],
        maxLines: 4,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).brightness != Brightness.dark
              ? customTheme['mainTextColor']
              : customTheme['whiteColor'],
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: customTheme['secondaryTextColor'],
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0XFF8D969F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0XFF8D969F),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0XFF8D969F),
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
