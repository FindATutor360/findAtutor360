import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    this.isFirstActive = true,
    this.isSecondActive = false,
    this.isThirdActive = false,
    this.isFirstDone = false,
    this.isSecondDone = false,
    super.key,
  });

  final bool isFirstActive;
  final bool isSecondActive;
  final bool isThirdActive;
  final bool isFirstDone;
  final bool isSecondDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !isFirstDone
                      ? Colors.transparent
                      : const Color(0XFF0476AF),
                  border: isFirstActive
                      ? Border.all(
                          color: const Color(0XFF0476AF),
                          width: 2,
                        )
                      : const Border(),
                ),
                child: !isFirstDone
                    ? Icon(
                        Icons.circle,
                        size: 12,
                        color: customTheme['primaryColor'],
                      )
                    : Icon(
                        Icons.check_outlined,
                        color: customTheme['whiteColor'],
                      ),
              ),
              const SizedBox(
                height: 7,
              ),
              MainText(
                text: 'Checkout',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: !isFirstDone
                    ? customTheme['secondaryTextColor']
                    : customTheme['primaryColor'],
              ),
            ],
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Divider(
                thickness: 2,
                color: !isFirstDone
                    ? customTheme['grayColor']
                    : customTheme['primaryColor'],
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: !isSecondDone
                      ? Colors.transparent
                      : const Color(0XFF0476AF),
                  border: !isSecondActive
                      ? Border.all(
                          color: const Color(0XFFC3C8CC),
                          width: 2,
                        )
                      : Border.all(
                          color: const Color(0XFF0476AF),
                          width: 2,
                        ),
                ),
                child: !isSecondActive
                    ? MainText(
                        text: '2',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['grayColor'],
                      )
                    : !isSecondDone
                        ? Icon(
                            Icons.circle,
                            size: 12,
                            color: customTheme['primaryColor'],
                          )
                        : Icon(
                            Icons.check_outlined,
                            color: customTheme['whiteColor'],
                          ),
              ),
              const SizedBox(
                height: 7,
              ),
              MainText(
                text: 'Payment',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: !isSecondDone
                    ? customTheme['secondaryTextColor']
                    : customTheme['primaryColor'],
              ),
            ],
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Divider(
                thickness: 2,
                color: !isSecondDone
                    ? customTheme['grayColor']
                    : customTheme['primaryColor'],
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: !isThirdActive
                      ? Border.all(
                          color: const Color(0XFFC3C8CC),
                          width: 2,
                        )
                      : Border.all(
                          color: const Color(0XFF0476AF),
                          width: 2,
                        ),
                ),
                child: !isThirdActive
                    ? MainText(
                        text: '3',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['grayColor'],
                      )
                    : Icon(
                        Icons.circle,
                        size: 12,
                        color: customTheme['primaryColor'],
                      ),
              ),
              const SizedBox(
                height: 7,
              ),
              MainText(
                text: 'Done',
                fontSize: 10,
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
