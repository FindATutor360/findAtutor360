import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/header.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const path = '/chatView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: customTheme['whiteColor'],
            appBar: const Header(),
            drawer: const CustomDrawer(),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Cart Items',
                      style: GoogleFonts.manrope(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  //background image
                  Image.asset('assets/images/cart.png',
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width),
                  const SizedBox(height: 15),
                  const Center(
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Ooops!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        )),
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
                  )
                ]))));
  }
}
