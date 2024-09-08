import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class RatingDialog extends PopupRoute<void> {
  RatingDialog();

  @override
  Color? get barrierColor => const Color(0xFFE0E0E0).withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Rating dialog';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return StatefulBuilder(
      builder: (BuildContext context, setInnerState) {
        return Align(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.90,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      MainText(
                        text: 'How would you rate this book',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CustomRatingBar(
                        itemSize: 40,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MainText(
                        text: 'Add a Review',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 16,
                          color: customTheme['mainTextColor'],
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Type to add a note',
                          hintStyle: TextStyle(
                            color: customTheme['secondaryTextColor'],
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0XFF8D969F),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0XFF8D969F),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0XFF8D969F),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0XFF0476AF),
                              ),
                              child: Align(
                                child: MainText(
                                  text: 'Done',
                                  fontSize: 18,
                                  color: customTheme['whiteColor'],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Container(
                              height: 60,
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
                        ],
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                    ],
                  ),
                ),
              ),
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

    // Navigator.of(context).pushNamedAndRemoveUntil(
    //   AppRoutes.v2HomeNavigationRoute,
    //   (Route<dynamic> route) => false,
    // );
  }
}
