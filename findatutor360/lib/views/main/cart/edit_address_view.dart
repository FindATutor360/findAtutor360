import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditAddressView extends StatelessWidget {
  const EditAddressView({super.key});
  static const path = '/editAddress';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Add New Address',
          showIcon: false,
          closeIcon: Icons.close,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              TextOption(
                onPressed: () {},
                mainText: 'Payment Methods',
                subText: 'Add new',
                horizPad: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: 1,
                    onChanged: (value) {},
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0XFF0476AF),
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
                              color: const Color(0xFFE6F6FE),
                            ),
                            child: const Align(
                              child: MainText(
                                text: 'Home',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF0476AF),
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
                          Row(
                            children: [
                              const MainText(
                                text: '+62 8123-4567-8910',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              const Spacer(),
                              Container(
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
                            ],
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
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(),
              const SizedBox(
                height: 12,
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
                          text: 'Office',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFF7AD2B),
                        ),
                      ),
                    ),
                    const MainText(
                      text: 'Budunburan Medical Center',
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
              PrimaryButton(
                text: 'Update Payment Method',
                textColor: customTheme['secondaryColor'],
                buttonColor: const Color(0xFFE6F6FE),
                isIconPresent: false,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
