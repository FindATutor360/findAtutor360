import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/notification_empty.dart';
import 'package:findatutor360/views/main/settings/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationNotSetup extends StatelessWidget {
  const NotificationNotSetup({super.key});
  static const path = '/notify_not_setup';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Notifications',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const MainText(
                text: 'Don’t miss an update',
                fontSize: 18,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                color: customTheme['primaryColor'],
                child: Row(
                  children: [
                    Icon(
                      Iconsax.info_circle5,
                      color: customTheme['whiteColor'],
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: MainText(
                        textAlign: TextAlign.start,
                        softWrap: true,
                        text:
                            'You can modify and turn off individual notifications at any time in settings',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: customTheme['whiteColor'],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF0476AF),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.box,
                      color: customTheme['primaryColor'],
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            text: 'Order Status',
                            fontSize: 16,
                            color: customTheme['primaryColor'],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          MainText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text:
                                'Get notifications about your most recent orders',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: customTheme['primaryColor'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF0476AF),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.notification_bing,
                      color: customTheme['primaryColor'],
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainText(
                            text: 'Announcements',
                            fontSize: 16,
                            color: customTheme['primaryColor'],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          MainText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            text:
                                'We are constantly updating our product and providing personlised recommendations to our users. Turn on notification to see these',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: customTheme['primaryColor'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Divider(),
              const SizedBox(
                height: 40,
              ),
              PrimaryButton(
                text: 'Turn on Notifications',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                isIconPresent: false,
                onPressed: () {
                  router.push(
                    NotificationView.path,
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              OutlineButton(
                text: 'No, thanks',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                textColor: customTheme['primaryColor'],
                isIconPresent: false,
                borderSideColor: customTheme['primaryColor'],
                buttonColor: customTheme['whiteColor'],
                onPressed: () {
                  router.push(
                    NotificationEmpty.path,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
