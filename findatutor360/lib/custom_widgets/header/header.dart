import 'package:badges/badges.dart';
import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String? imageUrl;
  final String? badgeCount;
  //final bool? isHome;
  const Header({
    Key? key,
    this.imageUrl,
    this.badgeCount,
    //required this.isHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                onPressed: (() {
                  Scaffold.of(context).openDrawer();
                }),
                icon: const Icon(Iconsax.menu_1),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    CustomIconButton(
                      onPressed: null,
                      icon: Badge(
                          position: const BadgePosition(top: -5, end: -2),
                          badgeContent: Text(badgeCount ?? '1',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: customTheme['whiteColor'])),
                          badgeColor: customTheme['badgeColor']!,
                          child: const Icon(Iconsax.notification)),
                    ),
                    const SizedBox(width: 5),
                    const Center(
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF0476AF),
                        radius: 20,
                        child: Text(
                          'A',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ), //Text
                      ), //CircleAvatar
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Divider(
            color: customTheme['dividerColor'],
            thickness: 1,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        65,
      );
}
