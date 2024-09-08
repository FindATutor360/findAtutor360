import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/progress_indicator/progress_bar.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/cart/payment_success_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});
  static const path = '/paymentView';

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  List<bool> showDescriptions = [true, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Payment',
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
                isFirstDone: true,
                isSecondActive: true,
              ),
              const SizedBox(
                height: 44,
              ),
              const MainText(
                text: 'Your payment methods',
                fontSize: 18,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showDescriptions[0] = !showDescriptions[0];
                  });
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: 1,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const MainText(
                          text: 'Credit/Debit Card',
                          fontSize: 14,
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: customTheme['primaryColor'],
                          radius: 13,
                          child: Icon(
                            showDescriptions[0]
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            color: customTheme['whiteColor'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    if (showDescriptions[0])
                      Row(
                        children: [
                          const SizedBox(
                            width: 44,
                          ),
                          Image.asset(
                            'assets/images/payBank.png',
                            height: MediaQuery.of(context).size.height / 28,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          MainText(
                            text: '88************021',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor'],
                          )
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              const MainText(
                text: 'Add New Payment Method',
                fontSize: 18,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showDescriptions[1] = !showDescriptions[1];
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: 1,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const MainText(
                          text: 'Credit/Debit Card',
                          fontSize: 14,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Image.asset(
                          'assets/images/payVisa.png',
                          height: MediaQuery.of(context).size.height / 28,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Image.asset(
                          'assets/images/payBank.png',
                          height: MediaQuery.of(context).size.height / 28,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.more_horiz_outlined,
                          color: customTheme['primaryColor'],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: customTheme['primaryColor'],
                          radius: 13,
                          child: Icon(
                            showDescriptions[1]
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            color: customTheme['whiteColor'],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (showDescriptions[1])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MainText(
                              text: 'Card Number',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: customTheme['secondaryTextColor'],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormField(
                              hint: 'Enter Card Number',
                              suffixIcon: Icon(
                                Iconsax.camera,
                                color: customTheme['fieldColor'],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MainText(
                                        text: 'CVV',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            customTheme['secondaryTextColor'],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CustomTextFormField(
                                        hint: 'CVV',
                                        prefixIcon: Icon(
                                          Iconsax.card,
                                          color: customTheme['fieldColor'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MainText(
                                        text: 'Expiry',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            customTheme['secondaryTextColor'],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CustomTextFormField(
                                        hint: 'MM / YY',
                                        prefixIcon: Icon(
                                          Iconsax.calendar_1,
                                          color: customTheme['fieldColor'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            PrimaryButton(
                              text: 'Add Card',
                              isIconPresent: false,
                              onPressed: () {},
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
              PrimaryButton(
                text: 'Confrim \$20 Payment',
                isIconPresent: false,
                onPressed: () {
                  router.push(
                    PaymentSuccessView.path,
                  );
                },
              ),
              const SizedBox(
                height: 15,
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
