import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key});
  static const path = '/payment_history';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Payment History',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const Row(
                children: [
                  MainText(
                    text: 'Weekly',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  Spacer(),
                  MainText(
                    text: 'All Transactions',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const MainText(
                text: 'Today',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                separatorBuilder: ((context, index) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      Divider(),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  );
                }),
                itemCount: 10,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      _showPaymentDetails(context);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height / 10.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: customTheme['secondaryColor'],
                            image: const DecorationImage(
                              image: AssetImage('assets/images/activeImg.png'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MainText(
                              text: 'Leadership',
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            MainText(
                              text: 'June 20, 2021',
                              fontSize: 12,
                              color: customTheme['secondaryTextColor'],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MainText(
                              text: '+€120',
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            MainText(
                              text: 'Success',
                              fontSize: 12,
                              color: customTheme['successTextColor'],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                color: customTheme['whiteColor'],
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width / 7,
                          height: MediaQuery.sizeOf(context).height / 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: customTheme['primaryColor'],
                          ),
                          child: Align(
                            child: Icon(
                              Icons.close,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: MainText(
                        text: 'Transaction Details',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        width: MediaQuery.sizeOf(context).width / 3.5,
                        image: const AssetImage('assets/images/coin.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Divider(),
                            SizedBox(height: 24),
                          ],
                        );
                      },
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPaymentDetailRow('Date', 'March 22, 2022'),
                            _buildPaymentDetailRow(
                                'Address', '22 Winchester Street'),
                            _buildPaymentDetailRow(
                                'Payment method', 'Credit Card'),
                            _buildPaymentDetailRow(
                                'Credit Card type', 'Mastercard'),
                            _buildPaymentDetailRow(
                                'Credit Card Number', '56*********252'),
                            _buildPaymentDetailRow('Voucher Used', '-'),
                            _buildPaymentDetailRow('Number of Items', 'x1'),
                            _buildPaymentDetailRow('Total Price', '\$526.69'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentDetailRow(String title, String description) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: customTheme['secondaryTextColor'],
            ),
            MainText(
              text: description,
              fontSize: 14,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 24),
      ],
    );
  }
}
