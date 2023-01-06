import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData? iconName;
  final bool? isIconPresent;
  final FontWeight? fontWeight;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final GestureTapCallback? onPressed;
  const PrimaryButton(
      {Key? key,
      this.buttonColor,
      this.textColor,
      this.iconColor,
      this.iconName,
      this.fontWeight,
      required this.text,
      required this.isIconPresent,
      this.height,
      this.width,
      this.fontSize,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.85,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        child: isIconPresent == true
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? customTheme['primaryColor'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color: buttonColor ?? customTheme['primaryColor']!,
                        width: 2),
                  ),
                ),
                onPressed: onPressed,
                child: Row(
                  children: [
                    Icon(
                      iconName,
                      color: iconColor ?? customTheme['whiteColor']!,
                    ),
                    const SizedBox(width: 60),
                    Text(text,
                        style: GoogleFonts.manrope(
                            fontSize: fontSize ?? 18,
                            fontWeight: fontWeight ?? FontWeight.w400,
                            color: textColor ?? customTheme['whiteColor']!)),
                  ],
                ))
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor ?? customTheme['primaryColor'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color: buttonColor ?? customTheme['primaryColor']!,
                        width: 2),
                  ),
                ),
                onPressed: onPressed,
                child: Text(text,
                    style: GoogleFonts.manrope(
                        fontSize: fontSize ?? 20,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        color: textColor ?? customTheme['whiteColor']!))),
      ),
    );
  }
}
