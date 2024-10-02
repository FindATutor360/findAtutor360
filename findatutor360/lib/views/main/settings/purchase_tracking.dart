import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class PurchaseTracking extends StatelessWidget {
  const PurchaseTracking({super.key});
  static const path = '/purchase_tracking';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Tracking',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF0476AF),
                    ),
                    child: Icon(
                      Icons.check_outlined,
                      color: customTheme['whiteColor'],
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'Order received',
                        fontSize: 12,
                        color: customTheme['primaryColor'],
                      ),
                      MainText(
                        text: 'You purchased the item',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Image.asset(
                  'assets/images/line2.png',
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF0476AF),
                    ),
                    child: Icon(
                      Icons.check_outlined,
                      color: customTheme['whiteColor'],
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'Processed',
                        fontSize: 12,
                        color: customTheme['primaryColor'],
                      ),
                      MainText(
                        text: 'Your Item has been been processed for shipping',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Image.asset(
                  'assets/images/line2.png',
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF0476AF),
                    ),
                    child: Icon(
                      Icons.check_outlined,
                      color: customTheme['whiteColor'],
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'In transit',
                        fontSize: 12,
                        color: customTheme['primaryColor'],
                      ),
                      MainText(
                        text: 'Item is been delivered to a courier',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Image.asset(
                  'assets/images/line2.png',
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0XFF0476AF),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.circle,
                      size: 12,
                      color: customTheme['primaryColor'],
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'Drop-off',
                        fontSize: 12,
                        color: customTheme['primaryColor'],
                      ),
                      MainText(
                        text:
                            'Avenida teorodo, 45 Bloco 5 apto 34, Zip code 07025200',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Image.asset(
                  'assets/images/line2.png',
                  color: customTheme['grayColor'],
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0XFFC3C8CC),
                        width: 2,
                      ),
                    ),
                    child: MainText(
                      text: '5',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: customTheme['grayColor'],
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'Pickup',
                        fontSize: 12,
                        color: customTheme['grayColor'],
                      ),
                      MainText(
                        text:
                            'Avenida teorodo, 45 Bloco 5 apto 34, Zip code 07025200',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['grayColor'],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                child: Image.asset(
                  'assets/images/line2.png',
                  color: customTheme['grayColor'],
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0XFFC3C8CC),
                        width: 2,
                      ),
                    ),
                    child: MainText(
                      text: '6',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: customTheme['grayColor'],
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainText(
                        text: 'Done',
                        fontSize: 12,
                        color: customTheme['grayColor'],
                      ),
                      MainText(
                        text: 'You have received Your item. Yaayy!',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['grayColor'],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
