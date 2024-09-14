import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class PaymentCardView extends StatefulWidget {
  const PaymentCardView({super.key});
  static const path = '/payment_card';

  @override
  State<PaymentCardView> createState() => _PaymentCardViewState();
}

class _PaymentCardViewState extends State<PaymentCardView> {
  bool showDescriptions = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Add New Card',
          showIcon: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              TextOption(
                mainText: 'Payment Methods',
                subText: 'Add new',
                horizPad: 24,
                onPressed: () {
                  _showAddNewPayment(context, setState);
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 24),
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: 1,
                      onChanged: (value) {},
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.29,
                      height: MediaQuery.of(context).size.height / 13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: customTheme['primaryColor'],
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.16,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/paymentMTN.png'),
                          ),
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
                            text: 'MTN MoMo',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          MainText(
                            text: '+233 25 ********',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: customTheme['secondaryTextColor'],
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _showEditPaymentDetails(context);
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height / 28,
                        width: MediaQuery.sizeOf(context).width / 10,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: customTheme['primaryColor'],
                        ),
                        child: Icon(
                          Iconsax.edit,
                          size: 20,
                          color: customTheme['whiteColor'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimaryButton(
                  text: 'Update Payment Method',
                  textColor: customTheme['secondaryColor'],
                  buttonColor: const Color(0xFFE6F6FE),
                  isIconPresent: false,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditPaymentDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
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
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        context.pop();
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
                                  Icons.keyboard_arrow_up_outlined,
                                  color: customTheme['whiteColor'],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            color: customTheme[
                                                'secondaryTextColor'],
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
                                            color: customTheme[
                                                'secondaryTextColor'],
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: const Color(0XFF0476AF),
                                          ),
                                        ),
                                        child: Align(
                                          child: MainText(
                                            text: 'Cancel',
                                            fontSize: 16,
                                            color: customTheme['primaryColor'],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: const Color(0XFF0476AF),
                                        ),
                                        child: Align(
                                          child: MainText(
                                            text: 'Save Changes',
                                            fontSize: 16,
                                            color: customTheme['whiteColor'],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                PrimaryButton(
                                  text: 'Remove',
                                  isIconPresent: true,
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                      context,
                                    );
                                  },
                                  buttonColor: customTheme['badgeColor'],
                                  borderRadius: BorderRadius.circular(8),
                                  iconName: Iconsax.trash,
                                  iconColor: customTheme['whiteColor'],
                                  spaceBetweenIconAndText: 8,
                                ),
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
          },
        );
      },
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: customTheme['whiteColor'],
        title: const MainText(
          text: 'Are you sure?',
          fontSize: 18,
        ),
        content: MainText(
          text:
              'This action will delete your card \npermanently. This action is irrevisible',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
          color: customTheme['secondaryTextColor'],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 20,
                  width: MediaQuery.sizeOf(context).width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0XFF0476AF),
                    ),
                  ),
                  child: Align(
                    child: MainText(
                      text: 'Cancel',
                      fontSize: 18,
                      color: customTheme['primaryColor'],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.sizeOf(context).width / 3.8,
                  // padding:
                  //     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0XFFFC392E),
                  ),
                  child: Align(
                    child: MainText(
                      text: 'Remove',
                      fontSize: 18,
                      color: customTheme['whiteColor'],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

void _showAddNewPayment(BuildContext context, StateSetter setState) {
  List<bool> showDescriptions = [true, false];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter innerSetState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.25,
            maxChildSize: 0.85,
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
                      const SizedBox(height: 24),
                      const MainText(
                        text: 'Add New Payment Method',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () {
                          innerSetState(() {
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
                                const SizedBox(width: 6),
                                const MainText(
                                  text: 'Mobile Money',
                                  fontSize: 14,
                                ),
                                const SizedBox(width: 16),
                                Image.asset(
                                  'assets/images/paymentMTN.png',
                                  height:
                                      MediaQuery.of(context).size.height / 32,
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
                            const SizedBox(height: 7),
                            if (showDescriptions[0])
                              Row(
                                children: [
                                  const SizedBox(width: 44),
                                  Image.asset(
                                    'assets/images/paymentMTN.png',
                                    height:
                                        MediaQuery.of(context).size.height / 28,
                                  ),
                                  const SizedBox(width: 16),
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
                      const SizedBox(height: 24),
                      InkWell(
                        onTap: () {
                          innerSetState(() {
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
                                const SizedBox(width: 6),
                                const MainText(
                                  text: 'Credit/Debit Card',
                                  fontSize: 14,
                                ),
                                const SizedBox(width: 16),
                                Image.asset(
                                  'assets/images/payVisa.png',
                                  height:
                                      MediaQuery.of(context).size.height / 28,
                                ),
                                const SizedBox(width: 6),
                                Image.asset(
                                  'assets/images/payBank.png',
                                  height:
                                      MediaQuery.of(context).size.height / 28,
                                ),
                                const SizedBox(width: 6),
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
                            const SizedBox(height: 20),
                            if (showDescriptions[1])
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MainText(
                                      text: 'Card Number',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: customTheme['secondaryTextColor'],
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextFormField(
                                      hint: 'Enter Card Number',
                                      suffixIcon: Icon(
                                        Iconsax.camera,
                                        color: customTheme['fieldColor'],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                color: customTheme[
                                                    'secondaryTextColor'],
                                              ),
                                              const SizedBox(height: 8),
                                              CustomTextFormField(
                                                hint: 'CVV',
                                                prefixIcon: Icon(
                                                  Iconsax.card,
                                                  color:
                                                      customTheme['fieldColor'],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 32),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MainText(
                                                text: 'Expiry',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: customTheme[
                                                    'secondaryTextColor'],
                                              ),
                                              const SizedBox(height: 8),
                                              CustomTextFormField(
                                                hint: 'MM / YY',
                                                prefixIcon: Icon(
                                                  Iconsax.calendar_1,
                                                  color:
                                                      customTheme['fieldColor'],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
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
