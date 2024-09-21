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
  final BorderRadiusGeometry borderRadius;
  final String text;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? spaceBetweenIconAndText;
  final GestureTapCallback? onPressed;
  final bool isForwardIconPresent;
  const PrimaryButton({
    super.key,
    this.buttonColor,
    this.textColor,
    this.iconColor,
    this.iconName,
    this.fontWeight,
    this.spaceBetweenIconAndText,
    this.borderRadius = BorderRadius.zero,
    required this.text,
    required this.isIconPresent,
    this.height,
    this.width,
    this.fontSize,
    required this.onPressed,
    this.isForwardIconPresent = false,
  });

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
                    borderRadius: borderRadius == BorderRadius.zero
                        ? borderRadius
                        : BorderRadius.circular(8),
                    side: BorderSide(
                        color: buttonColor ?? customTheme['primaryColor']!,
                        width: 2),
                  ),
                ),
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconName,
                      color: iconColor ?? customTheme['whiteColor']!,
                    ),
                    SizedBox(width: spaceBetweenIconAndText ?? 60),
                    Text(
                      text,
                      style: GoogleFonts.manrope(
                        fontSize: fontSize ?? 18,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        color: textColor ?? customTheme['whiteColor']!,
                      ),
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: GoogleFonts.manrope(
                        fontSize: fontSize ?? 20,
                        fontWeight: fontWeight ?? FontWeight.w400,
                        color: textColor ?? customTheme['whiteColor']!,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (isForwardIconPresent) ...[
                      Icon(
                        iconName,
                        color: iconColor ?? customTheme['whiteColor']!,
                      ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
