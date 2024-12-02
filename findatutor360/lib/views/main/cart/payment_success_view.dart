import 'package:findatutor360/core/view_models/main/books_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentSuccessView extends StatefulWidget {
  const PaymentSuccessView({super.key});
  static const path = '/paymentSuccess';

  @override
  State<PaymentSuccessView> createState() => _PaymentSuccessViewState();
}

class _PaymentSuccessViewState extends State<PaymentSuccessView> {
  late BooksController booksController;

  @override
  Widget build(BuildContext context) {
    booksController = context.read<BooksController>();
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Complete',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const ProgressBar(
                firstText: 'Checkout',
                secondText: 'Payment',
                thirdText: 'Done',
                isFirstDone: true,
                isSecondActive: true,
                isSecondDone: true,
                isThirdActive: true,
              ),
              const SizedBox(
                height: 30,
              ),
              //background image
              Align(
                child: Image.asset('assets/images/cart.png',
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width),
              ),
              const SizedBox(height: 15),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MainText(
                    text: 'Congratulations',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "Your purchase was successful. Your Item will be delivered to you  shortly",
                    textAlign: TextAlign.center,
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
                  text: 'Continue',
                  onPressed: () {
                    booksController.removeAllFromCart();

                    router.go(ShopView.path);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
