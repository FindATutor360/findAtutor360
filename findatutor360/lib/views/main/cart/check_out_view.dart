import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/cart/edit_address_view.dart';
import 'package:findatutor360/views/main/cart/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});
  static const path = '/checkOutView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Checkout',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const ProgressBar(
                firstText: 'Checkout',
                secondText: 'Payment',
                thirdText: 'Done',
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainText(
                    text: 'Delivery Information',
                    fontSize: 16,
                  ),
                  InkWell(
                    onTap: () {
                      router.push(EditAddressView.path);
                    },
                    child: MainText(
                      text: 'Edit',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0XFFE09208),
                  child: Icon(
                    Iconsax.user_tag,
                    color: customTheme['whiteColor'],
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color(0xFFFDEFD5)),
                      child: const Align(
                        child: MainText(
                          text: 'Home',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFF7AD2B),
                        ),
                      ),
                    ),
                    const MainText(
                      text: 'Martinelli',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MainText(
                      text: '+62 8123-4567-8910',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MainText(
                      text: '871 kenangan Street',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainText(
                    text: 'Order Summary',
                    fontSize: 16,
                  ),
                  MainText(
                    text: 'Edit',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: customTheme['secondaryTextColor'],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                        color: customTheme['secondaryColor'],
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/activeImg.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                            text: 'The science of leadership',
                            fontSize: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MainText(
                                text: 'Marcelos Ramequin',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: customTheme['secondaryTextColor'],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 90),
                                child: MainText(
                                  text: 'x1',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: customTheme['secondaryTextColor'],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          MainText(
                            text: '\$100.00',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: customTheme['smainTextSecondaryColor'],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const MainText(
                text: 'Voucher',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      prefixIcon: Icon(
                        Iconsax.receipt_disscount4,
                        color: customTheme['fieldColor'],
                      ),
                      hint: 'Enter Voucher Code',
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: customTheme['primaryColor'],
                    ),
                    child: Align(
                      child: MainText(
                        text: 'Use',
                        fontSize: 18,
                        color: customTheme['whiteColor'],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'Proceed to Payment',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                isIconPresent: false,
                onPressed: () {
                  router.push(
                    PaymentView.path,
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              OutlineButton(
                text: 'Cancel',
                buttonColor: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                isIconPresent: false,
                textColor: customTheme['primaryColor'],
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
