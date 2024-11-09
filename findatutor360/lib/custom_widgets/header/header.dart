import 'dart:io';

import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/settings/notification_not_setup.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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
    final authController = Provider.of<AuthController>(context);

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
                        onPressed: () {
                          router.push(
                            NotificationNotSetup.path,
                          );
                        },
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
                    Center(
                      child: authController.user?.photoUrl == null
                          ? CircleAvatar(
                              backgroundColor: const Color(0xFF0476AF),
                              radius: 20,
                              backgroundImage: NetworkImage(
                                authController.user?.photoUrl ??
                                    'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: const Color(0xFF0476AF),
                              radius: 20,
                              backgroundImage: FileImage(
                                File(
                                  authController.user?.photoUrl ?? '',
                                ),
                              ),
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
