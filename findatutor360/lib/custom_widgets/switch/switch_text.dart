import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class SwitchAndText extends StatelessWidget {
  const SwitchAndText({
    super.key,
    required this.title,
    required this.description,
    required this.notifier,
  });
  final String title;
  final String description;
  final ValueNotifier<bool> notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: notifier,
            builder: (context, value, child) {
              return Switch(
                activeColor: customTheme['whiteColor'],
                activeTrackColor: customTheme['primaryColor'],
                inactiveTrackColor: customTheme['grayColor'],
                inactiveThumbColor: customTheme['whiteColor'],
                value: value,
                onChanged: (bool newValue) {
                  notifier.value = newValue;
                },
              );
            },
          ),
          const SizedBox(
            width: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainText(
                text: title,
                fontSize: 16,
              ),
              MainText(
                text: description,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: customTheme['secondaryTextColor'],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
