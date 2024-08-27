import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/switch/switch_text.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class SettingsNotification extends StatefulWidget {
  const SettingsNotification({super.key});
  static const path = 'settingsNotification';

  @override
  State<SettingsNotification> createState() => _SettingsNotificationState();
}

class _SettingsNotificationState extends State<SettingsNotification> {
// Initializing a list of ValueNotifiers for the switches
  final List<ValueNotifier<bool>> switchNotifiers =
      List.generate(8, (_) => ValueNotifier<bool>(false));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BackIconHeader(
        header: 'Notification Settings',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            const MainText(
              text: 'Email Notifications',
              fontSize: 19,
            ),
            MainText(
              text:
                  'Get updates in our email inbox even when you’re not using our app.',
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: customTheme['secondaryTextColor'],
            ),
            const SizedBox(
              height: 14,
            ),
            SwitchAndText(
              title: 'News and updates',
              description: 'News about our product and feature updates',
              notifier: switchNotifiers[0],
            ),
            SwitchAndText(
              title: 'Account Activity',
              description: 'Updates about your account activity',
              notifier: switchNotifiers[1],
            ),
            SwitchAndText(
              title: 'Special Offers',
              description: 'Receive special offers and promotions',
              notifier: switchNotifiers[2],
            ),
            SwitchAndText(
              title: 'Reminders',
              description: 'Reminders about upcoming events',
              notifier: switchNotifiers[3],
            ),
            const SizedBox(
              height: 25,
            ),
            Divider(
              color: customTheme['dividerColor'],
              thickness: 1,
            ),
            const SizedBox(
              height: 25,
            ),
            const MainText(
              text: 'Push Notifications',
              fontSize: 19,
            ),
            MainText(
              text:
                  'Get in-app updates so you don’t miss out on any information.',
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: customTheme['secondaryTextColor'],
            ),
            const SizedBox(
              height: 14,
            ),
            SwitchAndText(
              title: 'Feedback Requests',
              description: 'Receive requests to provide feedback',
              notifier: switchNotifiers[4],
            ),
            SwitchAndText(
              title: 'News and updates',
              description: 'News about our product and feature updates',
              notifier: switchNotifiers[5],
            ),
            SwitchAndText(
              title: 'News and updates',
              description: 'News about our product and feature updates',
              notifier: switchNotifiers[6],
            ),
            SwitchAndText(
              title: 'News and updates',
              description: 'News about our product and feature updates',
              notifier: switchNotifiers[7],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final notifier in switchNotifiers) {
      notifier.dispose();
    }
    super.dispose();
  }
}
