import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String? imageUrl;
  final String? badgeCount;
  //final bool? isHome;
  const Header({
    super.key,
    this.imageUrl,
    this.badgeCount,
    //required this.isHome,
  });

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white);
    return Column(
      children: [
        Container(
          color: dynamicColor,
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
                color: dynamicColor,
                child: const Row(
                  children: [
                    SizedBox(width: 5),
                    CustomIconButton(
                        onPressed: null,
                        icon: Badge(
                            label: Text('1',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white)),
                            backgroundColor: Color.fromRGBO(252, 57, 46, 1),
                            child: Icon(Iconsax.notification))),
                    SizedBox(width: 5),
                    Center(
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
