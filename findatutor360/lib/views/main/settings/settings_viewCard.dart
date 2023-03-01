import 'package:findatutor360/views/main/settings/setting_userProfileCard.dart';
import 'package:findatutor360/views/main/settings/settings_userLogoutCard.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class settings_viewCard extends StatelessWidget {
  const settings_viewCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: ListView(
        children: [
          ///User Profile Card
          setting_userCard(),

          //Settins List
          _SingleSection(
            title: "General",
            children: [
              const _CustomListTile(
                title: "Language",
                icon: Iconsax.language_circle,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Notification",
                icon: Iconsax.notification,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Dark Mode",
                icon: Iconsax.moon,
                trailing: Icon(Iconsax.moon),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(
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
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Payment Methods",
                icon: Iconsax.card,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Payment history",
                icon: Iconsax.money,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ],
          ),
          const _SingleSection(
            title: "About & Help",
            children: [
              const _CustomListTile(
                title: "Frequently Asked Questions",
                icon: Iconsax.message,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Contact Support",
                icon: Iconsax.headphone,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Privacy Policy",
                icon: Iconsax.shield_security2,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                  title: "Terms of Service", icon: Iconsax.book),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "Community Guidleines",
                icon: Iconsax.flag,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const _CustomListTile(
                title: "About the App",
                icon: Iconsax.information,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ],
          ),
          //Setting List End

          ///User LogOut Card
          settings_userLogoutCard(),
          SizedBox(
            height: 20,
          ) // End of User LogOut Card
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
  }) : super(key: key);

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
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
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
