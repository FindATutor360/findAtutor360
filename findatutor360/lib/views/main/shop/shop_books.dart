import 'package:findatutor360/custom_widgets/button/custom_like_button.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ShopBookWidget extends StatelessWidget {
  const ShopBookWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: customTheme['whiteColor'],
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
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                image: const DecorationImage(
                    image: AssetImage('assets/images/activeImg.png'),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const MainText(
                      text: 'The Science of Leader',
                      fontSize: 16,
                      overflow: TextOverflow.visible),
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainText(
                            text: 'GH₵ 50.0',
                            fontSize: 16,
                            color: customTheme['mainTextColor']),
                        Container(width: 30),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const CustomRatingBar(),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 120,
                          height: MediaQuery.of(context).size.width * 0.11,
                          decoration: BoxDecoration(
                              color: customTheme['primaryColor'],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: customTheme['primaryColor']!)),
                          child: Row(
                            children: [
                              TextButton.icon(
                                  onPressed: (() {}),
                                  icon: Icon(
                                    Iconsax.buy_crypto,
                                    color: customTheme['whiteColor'],
                                    size: 18,
                                  ),
                                  label: Text("GH6 Buy",
                                      style: TextStyle(
                                        color: customTheme['whiteColor'],
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ))),
                            ],
                          )),
                      const CustomLikeButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
