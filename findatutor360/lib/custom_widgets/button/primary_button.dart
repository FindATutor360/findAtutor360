import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PrimaryButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData? iconName;
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
      required this.text,
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
        width: width ?? MediaQuery.of(context).size.width * 0.8,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  buttonColor ?? const Color.fromRGBO(4, 118, 175, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: buttonColor ?? const Color.fromRGBO(4, 118, 175, 1),
                    width: 2),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(
                  iconName ?? Iconsax.arrow_right_1,
                  color: iconColor ?? Colors.white,
                ),
                const SizedBox(width: 60),
                Text(text,
                    style: TextStyle(
                        fontSize: fontSize ?? 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Manrope',
                        color: textColor ?? Colors.white)),
              ],
            )),
      ),
    );
  }
}
