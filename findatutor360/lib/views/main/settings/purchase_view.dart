import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/card/expansion_tile.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/purchase_tracking.dart';
import 'package:findatutor360/views/main/settings/report_dispute_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class PurchaseView extends StatelessWidget {
  const PurchaseView({super.key});
  static const path = '/purchase';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Purchased Items',
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
                  MainText(
                    text: 'Recent',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: customTheme['mainTextColor'],
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0XFF303539),
                  ),
                  const Spacer(),
                  MainText(
                    text: 'Pending Items',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: customTheme['mainTextColor'],
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0XFF303539),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextExpansionTile(
                initiallyExpanded: true,
                title: Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 6,
                      height: MediaQuery.sizeOf(context).height / 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: customTheme['fieldColor'],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/activeImg.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                            text: 'Leadership',
                            fontSize: 14,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          MainText(
                            text: 'July 20, 2020',
                            fontSize: 12,
                            color: customTheme['secondaryTextColor'],
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MainText(
                          text: '+\$144',
                          fontSize: 14,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0XFFD3FFE7),
                          ),
                          child: const MainText(
                            text: 'Delivered',
                            fontSize: 12,
                            color: Color(0XFF00AA4E),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height / 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.99,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: customTheme['successTextColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const MainText(
                      text: 'Delivering to:',
                      fontSize: 12,
                      softWrap: true,
                    ),
                    MainText(
                      text:
                          'Avenida teorodo, 45 Bloco 5 apto 34, Zip code 07025200',
                      fontSize: 12,
                      color: customTheme['secondaryTextColor'],
                      fontWeight: FontWeight.w400,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          width: MediaQuery.sizeOf(context).width / 2.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: customTheme['primaryColor'],
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Review',
                              fontSize: 14,
                              softWrap: true,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            router.push(ReportDisputeView.path);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            width: MediaQuery.sizeOf(context).width / 2.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: const Color(0XFF0476AF))),
                            child: Align(
                              child: MainText(
                                text: 'Send Dispute',
                                fontSize: 14,
                                softWrap: true,
                                color: customTheme['primaryColor'],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryButton(
                      buttonColor: const Color(0xFFE6F6FE),
                      text: 'Confirm Receipt',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      textColor: customTheme['primaryColor'],
                      isIconPresent: false,
                      onPressed: () {
                        _showReceipt(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextExpansionTile(
                title: Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 6,
                      height: MediaQuery.sizeOf(context).height / 16,
                      decoration: BoxDecoration(
                        color: customTheme['primaryColor'],
                        shape: BoxShape.circle,
                      ),
                      child: Align(
                        child: MainText(
                          text: 'A',
                          color: customTheme['whiteColor'],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                            text: 'Gabriel Franco',
                            fontSize: 14,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          MainText(
                            text: 'July 20, 2020',
                            fontSize: 12,
                            color: customTheme['secondaryTextColor'],
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MainText(
                          text: '+\$144',
                          fontSize: 14,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0XFFFFE7ED),
                          ),
                          child: MainText(
                            text: 'Failed',
                            fontSize: 12,
                            color: customTheme['badgeColor'],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height / 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.70,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: customTheme['successTextColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const MainText(
                      text: 'Delivering to:',
                      fontSize: 12,
                      softWrap: true,
                    ),
                    MainText(
                      text:
                          'Avenida teorodo, 45 Bloco 5 apto 34, Zip code 07025200',
                      fontSize: 12,
                      color: customTheme['secondaryTextColor'],
                      fontWeight: FontWeight.w400,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          width: MediaQuery.sizeOf(context).width / 2.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: customTheme['primaryColor'],
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Review',
                              fontSize: 14,
                              softWrap: true,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            router.push(ReportDisputeView.path);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            width: MediaQuery.sizeOf(context).width / 2.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: const Color(0XFF0476AF))),
                            child: Align(
                              child: MainText(
                                text: 'Send Dispute',
                                fontSize: 14,
                                softWrap: true,
                                color: customTheme['primaryColor'],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryButton(
                      buttonColor: const Color(0xFFE6F6FE),
                      text: 'Confirm Receipt',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      textColor: customTheme['primaryColor'],
                      isIconPresent: false,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextExpansionTile(
                title: Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 6,
                      height: MediaQuery.sizeOf(context).height / 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: customTheme['fieldColor'],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/activeImg.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                            text: 'Leadership',
                            fontSize: 14,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          MainText(
                            text: 'July 20, 2020',
                            fontSize: 12,
                            color: customTheme['secondaryTextColor'],
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MainText(
                          text: '+\$144',
                          fontSize: 14,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0XFFF2F3F4),
                          ),
                          child: MainText(
                            text: 'In transit',
                            fontSize: 12,
                            color: customTheme['secondaryTextColor'],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height / 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.55,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: customTheme['successTextColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const MainText(
                      text: 'Delivering to:',
                      fontSize: 12,
                      softWrap: true,
                    ),
                    MainText(
                      text:
                          'Avenida teorodo, 45 Bloco 5 apto 34, Zip code 07025200',
                      fontSize: 12,
                      color: customTheme['secondaryTextColor'],
                      fontWeight: FontWeight.w400,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          width: MediaQuery.sizeOf(context).width / 2.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: customTheme['primaryColor'],
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Review',
                              fontSize: 14,
                              softWrap: true,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          width: MediaQuery.sizeOf(context).width / 2.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: const Color(0XFF0476AF))),
                          child: Align(
                            child: MainText(
                              text: 'Send Dispute',
                              fontSize: 14,
                              softWrap: true,
                              color: customTheme['primaryColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryButton(
                      buttonColor: const Color(0xFFE6F6FE),
                      text: 'Track item',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      textColor: customTheme['primaryColor'],
                      isIconPresent: true,
                      iconName: Iconsax.box,
                      iconColor: customTheme['primaryColor'],
                      spaceBetweenIconAndText: 5,
                      onPressed: () {
                        context.push(PurchaseTracking.path);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextExpansionTile(
                title: Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 6,
                      height: MediaQuery.sizeOf(context).height / 13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: customTheme['fieldColor'],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/activeImg.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(
                            text: 'Leadership',
                            fontSize: 14,
                            softWrap: true,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          MainText(
                            text: 'July 20, 2020',
                            fontSize: 12,
                            color: customTheme['secondaryTextColor'],
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MainText(
                          text: '+\$144',
                          fontSize: 14,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color(0XFFD3FFE7),
                          ),
                          child: const MainText(
                            text: 'Delivered',
                            fontSize: 12,
                            color: Color(0XFF00AA4E),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height / 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.70,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: customTheme['successTextColor'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const MainText(
                      text: 'Delivering to:',
                      fontSize: 12,
                      softWrap: true,
                    ),
                    MainText(
                      text:
                          'Avenida teorodo, 45 Bloco 5 apto 34, Zip code 07025200',
                      fontSize: 12,
                      color: customTheme['secondaryTextColor'],
                      fontWeight: FontWeight.w400,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          width: MediaQuery.sizeOf(context).width / 2.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: customTheme['primaryColor'],
                          ),
                          child: Align(
                            child: MainText(
                              text: 'Review',
                              fontSize: 14,
                              softWrap: true,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            router.push(ReportDisputeView.path);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            width: MediaQuery.sizeOf(context).width / 2.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: const Color(0XFF0476AF))),
                            child: Align(
                              child: MainText(
                                text: 'Send Dispute',
                                fontSize: 14,
                                softWrap: true,
                                color: customTheme['primaryColor'],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PrimaryButton(
                      buttonColor: const Color(0xFFE6F6FE),
                      text: 'Confirm Receipt',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      textColor: customTheme['primaryColor'],
                      isIconPresent: false,
                      onPressed: () {
                        _showReceipt(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showReceipt(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter innerSetState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.25,
            maxChildSize: 0.55,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: customTheme['whiteColor'],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
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
                      const SizedBox(height: 12),
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
                        child: Image.asset('assets/images/cart.png',
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 2),
                      ),

                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: MainText(
                            text: 'Your package is here',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: const Text(
                            "Confirm the receipt of your package and sure it is what you ordered",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                color: Color(0xFF79848E),
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                      //button
                      PrimaryButton(
                        isIconPresent: false,
                        text: 'Confirm',
                        onPressed: () {
                          context.pop();
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
    },
  );
}
