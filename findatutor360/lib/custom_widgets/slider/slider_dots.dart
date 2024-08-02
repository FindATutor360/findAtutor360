import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class SliderDots extends StatelessWidget {
  const SliderDots({
    super.key,
    required List<Widget> carouselTextList,
    required int current,
  })  : _carouselTextList = carouselTextList,
        _current = current;

  final List<Widget> _carouselTextList;
  final int _current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _carouselTextList.map((e) {
        int index = _carouselTextList.indexOf(e);
        return Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? customTheme['activeSliderColor']
                  : customTheme['secondaryColor']),
        );
      }).toList(),
    );
  }
}
