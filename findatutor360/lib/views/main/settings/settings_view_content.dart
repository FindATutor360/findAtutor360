import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:findatutor360/core/view_models/main/theme_controller.dart';
import 'package:findatutor360/custom_widgets/dialogs/language_dialog.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/settings/payment_card_view.dart';
import 'package:findatutor360/views/main/settings/payment_history_view.dart';
import 'package:findatutor360/views/main/settings/setting_user_profile_card.dart';
import 'package:findatutor360/views/main/settings/settings_notification.dart';
import 'package:findatutor360/views/main/settings/settings_user_logout_card.dart';
import 'package:findatutor360/views/main/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingsViewContent extends StatefulWidget {
  const SettingsViewContent({
    super.key,
  });

  @override
  State<SettingsViewContent> createState() => _SettingsViewContentState();
}

class _SettingsViewContentState extends State<SettingsViewContent> {
  /// Whether dark mode is enabled.
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeController>(context);
    final isDarkModeEnabled = themeNotifier.isDarkMode;

    return SizedBox(
      // height: double.infinity,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ///User Profile Card
          const SettingUserCard(),

          //Settings List
          _SingleSection(
            title: "General",
            children: [
              _CustomListTile(
                title: "Language",
                icon: Iconsax.language_circle,
                onTap: () {
                  Navigator.of(context).push(
                    LanguageDialog(),
                  );
                },
              ),
              const Divider(),
              _CustomListTile(
                title: "Notification",
                icon: Iconsax.notification,
                onTap: () {
                  router.push(
                      '${SettingsView.path}/${SettingsNotification.path}');
                },
              ),
              const Divider(),
              _CustomListTile(
                title: "Dark Mode",
                icon: Iconsax.moon,
                trailing: SizedBox(
                  width: 60,
                  height: 55,
                  child: DayNightSwitcher(
                    isDarkModeEnabled: isDarkModeEnabled,
                    onStateChanged: (bool isDark) {
                      themeNotifier.toggleTheme(); // Update theme state
                    },
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              )
            ],
          ),
          _SingleSection(
            title: "Account & Security",
            children: [
              const _CustomListTile(
                title: "Security",
                icon: Iconsax.lock,
              ),
              const Divider(),
              _CustomListTile(
                title: "Payment Methods",
                icon: Iconsax.card,
                onTap: () {
                  router.push(
                    PaymentCardView.path,
                  );
                },
              ),
              const Divider(),
              _CustomListTile(
                title: "Payment history",
                icon: Iconsax.money,
                onTap: () {
                  router.push(
                    PaymentHistoryView.path,
                  );
                },
              ),
              const Divider(),
            ],
          ),
          const _SingleSection(
            title: "About & Help",
            children: [
              _CustomListTile(
                title: "Frequently Asked Questions",
                icon: Iconsax.message,
              ),
              Divider(),
              _CustomListTile(
                title: "Contact Support",
                icon: Iconsax.headphone,
              ),
              Divider(),
              _CustomListTile(
                title: "Privacy Policy",
                icon: Iconsax.shield_security2,
              ),
              Divider(),
              _CustomListTile(title: "Terms of Service", icon: Iconsax.book),
              Divider(),
              _CustomListTile(
                title: "Community Guidleines",
                icon: Iconsax.flag,
              ),
              Divider(),
              _CustomListTile(
                title: "About the App",
                icon: Iconsax.information,
              ),
              Divider(),
            ],
          ),
          //Setting List End

          ///User LogOut Card

          Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: const SettingsUserLogoutCard()),
        ],
      ),
    );
  }

  /// Called when the state (day / night) has changed.
  void onStateChanged(bool isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black);
    return ListTile(
      tileColor: dynamicColor,
      title: Text(
        title,
        style: TextStyle(
          color: dynamicColor,
        ),
      ),
      leading: Icon(
        icon,
        color: dynamicColor,
      ),
      onTap: onTap,
      trailing: trailing ??
          Icon(
            Iconsax.arrow_right_3,
            color: dynamicColor,
          ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainText(
            text: title.toUpperCase(),
            fontSize: 16,
          ),
        ),
        Container(
          width: double.infinity,
          color: dynamicColor,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
