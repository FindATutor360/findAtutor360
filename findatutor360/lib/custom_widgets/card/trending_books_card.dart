import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class TrendingBookWidget extends StatelessWidget {
  const TrendingBookWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: dynamicColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: customTheme['lightGrayColor']!, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.38,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: customTheme['secondaryColor'],
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/activeImg.png'),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const MainText(
                      text: 'The Secret of love',
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 5,
                  ),
                  MainText(
                    text: 'John Joanie Doe',
                    fontSize: 12,
                    color: customTheme['secondaryTextColor']!,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomRatingBar(),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                          text: 'GH₵ 50.0',
                          fontSize: 16,
                        ),
                        //Container(width: 30),
                        CustomLikeButton()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
