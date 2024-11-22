import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatefulWidget {
  final double itemSize;
  final double initialRating;
  final Function(double) onRatingUpdate;

  const CustomRatingBar({
    required this.onRatingUpdate,
    this.itemSize = 15.0,
    this.initialRating = 0.0,
    super.key,
  });

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: widget.initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: const Color.fromARGB(255, 96, 95, 93).withAlpha(50),
      itemCount: 5,
      itemSize: widget.itemSize,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: customTheme['ratingColor']!,
      ),
      onRatingUpdate: widget.onRatingUpdate,
    );
  }
}
