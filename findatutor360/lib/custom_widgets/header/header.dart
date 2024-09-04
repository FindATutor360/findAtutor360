import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
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
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    CustomIconButton(
                        onPressed: null,
                        icon: Badge(
                            label: const Text('1',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white)),
                            backgroundColor:
                                const Color.fromRGBO(252, 57, 46, 1),
                            child: Icon(
                              Iconsax.notification,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ))),
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
        const Expanded(
          child: Divider(
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
