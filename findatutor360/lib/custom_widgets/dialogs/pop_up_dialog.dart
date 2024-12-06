import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class PopUpDialog extends PopupRoute<void> {
  PopUpDialog(
    this.context, {
    required this.firstText,
    required this.secondText,
    this.firstTextTap,
    this.secondTextTap,
  });
  String firstText;
  String secondText;
  VoidCallback? firstTextTap;
  VoidCallback? secondTextTap;
  final BuildContext context;

  @override
  Color? get barrierColor => Theme.of(context).brightness != Brightness.dark
      ? Colors.black.withOpacity(0.5)
      : Colors.white.withOpacity(0.2);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'PopUp dialog';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: StatefulBuilder(
        builder: (BuildContext context, setInnerState) {
          Color dynamicColor = (Theme.of(context).brightness != Brightness.dark
              ? Colors.white
              : Colors.black);
          return Padding(
            padding: const EdgeInsets.only(left: 100, bottom: 250),
            child: UnconstrainedBox(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: dynamicColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: firstTextTap,
                      child: MainText(
                        text: firstText,
                        fontSize: 14,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: secondTextTap,
                      child: MainText(
                        text: secondText,
                        fontSize: 14,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Duration get transitionDuration => Duration.zero;
}
