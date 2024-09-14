import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const path = '/notify_view';

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
                text: 'Today',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 14,
                  );
                },
                itemCount: 4,
                itemBuilder: (context, i) {
                  return const NotificationCard(
                    senderName: 'Denzel',
                    message: 'Welcome to Accra charlie :lol',
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              const MainText(
                text: 'Yesterday',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 14,
                  );
                },
                itemCount: 4,
                itemBuilder: (context, i) {
                  return const NotificationCard(
                    senderName: 'Denzel',
                    message: 'Welcome to Accra charlie :lol',
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(
                height: 16,
              ),
              const MainText(
                text: 'Wednesday',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, i) {
                  return const SizedBox(
                    height: 14,
                  );
                },
                itemCount: 4,
                itemBuilder: (context, i) {
                  return const NotificationCard(
                    senderName: 'Denzel',
                    message: 'Welcome to Accra charlie :lol',
                  );
                },
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.senderName,
    required this.message,
    super.key,
  });
  final String senderName;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: customTheme['primaryColor'],
          radius: 20,
          child: const MainText(
            text: 'A',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFFF2F3F4),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MainText(
                  text: senderName,
                  fontSize: 14,
                ),
                MainText(
                  text: ' commented on your post:',
                  fontSize: 14,
                  color: customTheme['secondaryTextColor'],
                ),
              ],
            ),
            MainText(
              text: message,
              fontSize: 14,
              color: customTheme['secondaryTextColor'],
            ),
            const SizedBox(
              height: 2,
            ),
            MainText(
              text: '1 sec ago',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: customTheme['secondaryTextColor'],
            ),
          ],
        ),
        const Spacer(),
        Icon(
          Iconsax.more,
          color: customTheme['secondaryTextColor'],
        ),
      ],
    );
  }
}
