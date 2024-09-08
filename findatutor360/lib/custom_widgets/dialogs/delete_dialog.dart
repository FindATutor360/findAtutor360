import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends PopupRoute<void> {
  DeleteDialog({
    required this.removeTap,
  });
  final VoidCallback? removeTap;

  @override
  Color? get barrierColor => const Color(0xFFE0E0E0).withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Delete dialog';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return StatefulBuilder(
      builder: (BuildContext context, setInnerState) {
        return UnconstrainedBox(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const MainText(
                  text: 'Are you sure?',
                  fontSize: 18,
                ),
                const SizedBox(
                  height: 8,
                ),
                MainText(
                  text:
                      'This action will delete your card permanently. This action is irrevisible',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: customTheme['secondaryTextColor'],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _handleAccept(context);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0XFF0476AF),
                            ),
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Cancel',
                              fontSize: 18,
                              color: customTheme['primaryColor'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: removeTap,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0XFFFC392E),
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Remove',
                              fontSize: 18,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Duration get transitionDuration => Duration.zero;

  void _handleAccept(BuildContext context) {
    Navigator.pop(context);
  }
}
