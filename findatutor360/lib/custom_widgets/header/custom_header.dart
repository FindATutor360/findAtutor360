import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.13,
      color: const Color.fromRGBO(4, 118, 175, 1),
      child: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 30),
          child: Image.asset(
            'assets/images/headerLogo.png',
            scale: 1.0,
            //height: 25,
          )),
    );
  }
}
