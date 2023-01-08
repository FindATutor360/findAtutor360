import 'package:carousel_slider/carousel_slider.dart';
import 'package:findatutor360/custom_widgets/slider/slider_dots.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class CustomCarouselView extends StatefulWidget {
  const CustomCarouselView({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCarouselView> createState() => _CustomCarouselViewState();
}

class _CustomCarouselViewState extends State<CustomCarouselView> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  final List<Widget> _carouselTextList = [
    MainText(
        text: 'With FindATutor360',
        fontWeight: FontWeight.w700,
        color: customTheme['whiteColor']!,
        fontSize: 20),
    MainText(
        text: 'Everything is Learnable',
        fontWeight: FontWeight.w700,
        color: customTheme['whiteColor']!,
        fontSize: 20),
    MainText(
        text: 'Everything is Achievable',
        fontWeight: FontWeight.w700,
        color: customTheme['whiteColor']!,
        fontSize: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * 0.26,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: customTheme['primaryColor'],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //The Image
          Center(child: Image.asset('assets/images/carouselImg.png')),

          //The Carousel
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                child: CarouselSlider(
                  carouselController: _carouselController,
                  items: _carouselTextList,
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: MediaQuery.of(context).size.height * 0.04,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 7),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 900),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //The Dots
              SliderDots(
                current: _current,
                carouselTextList: _carouselTextList,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
