import 'dart:io';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/notification_not_setup.dart';
import 'package:findatutor360/views/main/settings/personal_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final User? auth = FirebaseAuth.instance.currentUser;

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
                    auth != null
                        ? StreamBuilder<Users?>(
                            stream: authController.getUserInfo(auth.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              }

                              final user = snapshot.data;

                              final isFile = user?.photoUrl != null &&
                                  File(user!.photoUrl!).existsSync();

                              final image = user?.photoUrl ?? '';

                              bool isNetworkImage = image.startsWith('http') ||
                                  image.startsWith('https');

                              if (user == null) {
                                return const Center(
                                    child: Text('No user data available.'));
                              }
                              return InkWell(
                                onTap: () {
                                  router.push(
                                    PersonalProfileView.path,
                                  );
                                },
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFF0476AF),
                                    radius: 20,
                                    backgroundImage: isNetworkImage
                                        ? NetworkImage(user.photoUrl ?? '')
                                        : FileImage(File(user.photoUrl ?? ''))
                                            as ImageProvider,
                                    child: !isNetworkImage && !isFile
                                        ? const Icon(Icons.person,
                                            color: Colors.white)
                                        : null, // Placeholder icon if no image is available
                                  ),
                                ),
                              );
                            },
                          )
                        : CircleAvatar(
                            backgroundColor: const Color(0xFF0476AF),
                            radius: 20,
                            child: Icon(
                              Icons.person_2,
                              color: customTheme['secondaryColor'],
                            ),
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
