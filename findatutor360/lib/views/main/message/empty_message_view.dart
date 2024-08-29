import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class EmptyMessageView extends StatelessWidget {
  const EmptyMessageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Align(
            child: Image.asset(
              'assets/images/emptyMessage.png',
              width: 353,
              height: 363,
            ),
          ),
          const SizedBox(
            height: 53,
          ),
          const MainText(text: 'Ooops! Inbox Empty'),
          const SizedBox(
            height: 16,
          ),
          MainText(
            text: 'When you send a message, you’ll see them here',
            textAlign: TextAlign.center,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: customTheme['secondaryTextColor'],
          ),
        ],
      ),
    );
  }
}
