import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //background image
          Image.asset('assets/images/cart.png',
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width),
          const SizedBox(height: 15),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: MainText(
                text: 'Ooops!',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: const Text(
                "There’s nothing in your cart. Add a new item  from the shop to find it here.",
                style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Color(0xFF79848E),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
          //button
          Center(
            child: PrimaryButton(
                isIconPresent: false,
                text: 'Go to shop',
                onPressed: () {
                  router.go(ShopView.path);
                }),
          ),
        ],
      ),
    );
  }
}
