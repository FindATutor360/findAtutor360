import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/setting_user_profile_card.dart';
import 'package:findatutor360/views/main/settings/settings_user_logout_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
    return SizedBox(
      height: 610,
      child: ListView(
        children: [
          ///User Profile Card
          const SettingUserCard(),

          //Settins List
          _SingleSection(
            title: "General",
            children: [
              const _CustomListTile(
                title: "Language",
                icon: Iconsax.language_circle,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Notification",
                icon: Iconsax.notification,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              _CustomListTile(
                title: "Dark Mode",
                icon: Iconsax.moon,
                trailing: SizedBox(
                  width: 60,
                  height: 55,
                  child: DayNightSwitcher(
                    isDarkModeEnabled: isDarkModeEnabled,
                    onStateChanged: onStateChanged,
                  ),
                ),
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
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
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Payment Methods",
                icon: Iconsax.card,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Payment history",
                icon: Iconsax.money,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
            ],
          ),
          _SingleSection(
            title: "About & Help",
            children: [
              const _CustomListTile(
                title: "Frequently Asked Questions",
                icon: Iconsax.message,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Contact Support",
                icon: Iconsax.headphone,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Privacy Policy",
                icon: Iconsax.shield_security2,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                  title: "Terms of Service", icon: Iconsax.book),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Community Guidleines",
                icon: Iconsax.flag,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
              const _CustomListTile(
                title: "About the App",
                icon: Iconsax.information,
              ),
              Divider(
                color: customTheme['dividerColor'],
                thickness: 1,
              ),
            ],
          ),
          //Setting List End

          ///User LogOut Card

          Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: const SettingsUserLogoutCard()),
          // const SizedBox(
          //   height: 20,
          // ) // End of User LogOut Card
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
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: () {},
        trailing: trailing ?? const Icon(Iconsax.arrow_right_3));
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
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
