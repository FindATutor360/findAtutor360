import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class CardStatus extends StatelessWidget {
  final bool isOnline;
  const CardStatus({
    this.isOnline = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.height * 0.03,
      decoration: BoxDecoration(
          color: isOnline == true
              ? customTheme['primaryColor']
              : customTheme['whiteColor'],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: customTheme['primaryColor']!)),
      child: Center(
        child: MainText(
          text: isOnline == true ? 'ONLINE' : 'OFFLINE',
          fontSize: 12,
          color: isOnline == true
              ? customTheme['whiteColor']
              : customTheme['primaryColor']!,
        ),
      ),
    );
  }
}
