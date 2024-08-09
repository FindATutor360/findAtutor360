import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Color? buttonColor;
  final double? height;
  final double? width;
  final String imageSrc;
  final GestureTapCallback? onPressed;
  const SecondaryButton(
      {super.key,
      this.buttonColor,
      this.height,
      this.width,
      required this.imageSrc,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.23,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color:
                        buttonColor ?? const Color.fromRGBO(175, 181, 185, 1),
                    width: 1),
              ),
            ),
            onPressed: onPressed,
            child: Center(
              child: Image.asset(
                imageSrc,
              ),
            )),
      ),
    );
  }
}
