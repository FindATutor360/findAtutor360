import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/expand_text_form_field.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class RatingDialog extends PopupRoute<void> {
  RatingDialog(this.context,{
    required this.initialRating,
    required this.onSubmit,
  });

  final double initialRating;
  final Function(double rating, String comment) onSubmit;
   final BuildContext context;

  @override
  Color? get barrierColor => Theme.of(context).brightness != Brightness.dark
      ? Colors.black.withOpacity(0.5)
      : Colors.white.withOpacity(0.2);

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
    final TextEditingController commentController = TextEditingController();
    double ratingValue = initialRating;
    final formKey = GlobalKey<FormState>();

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        Color dynamicColor = (Theme.of(context).brightness != Brightness.dark
            ? Colors.white
            : Colors.black);
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
                  color: dynamicColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      MainText(
                        text: 'How would you rate this book',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      const SizedBox(height: 8),
                      CustomRatingBar(
                        initialRating: ratingValue,
                        itemSize: 40,
                        onRatingUpdate: (rating) {
                          setState(() {
                            ratingValue = rating;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      MainText(
                        text: 'Add a Review',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      const SizedBox(height: 8),
                      Form(
                        key: formKey,
                        child: ExpandTextFormField(
                          hint: 'Type to add a note',
                          controller: commentController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                commentController.text.isEmpty) {
                              return 'Please enter a comment';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  onSubmit(ratingValue, commentController.text);
                                  Navigator.pop(context);
                                }
                              },
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
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 34),
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
}
