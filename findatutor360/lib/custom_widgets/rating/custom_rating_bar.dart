import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatefulWidget {
  const CustomRatingBar({
    this.itemSize = 15.0,
    super.key,
  });
  final double itemSize;

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  late double rateValue;

  final double _initialRating = 3;

  @override
  void initState() {
    super.initState();
    rateValue = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: const Color.fromARGB(255, 96, 95, 93).withAlpha(50),
      itemCount: 5,
      itemSize: widget.itemSize,
      // itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: customTheme['ratingColor']!,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          rateValue = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
