import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/personal_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? badgeCount;
  final bool showIcon;
  //final bool? isHome;
  const AppHeader({
    super.key,
    this.badgeCount,
    this.showIcon = true,
    //required this.isHome,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final User? auth = FirebaseAuth.instance.currentUser;

    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black);
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
                    if (showIcon) ...[
                      CustomIconButton(
                        onPressed: null,
                        icon: Icon(
                          Iconsax.search_normal_1,
                          color: dynamicColor,
                        ),
                      ),
                    ],
                    const SizedBox(width: 5),
                    CustomIconButton(
                      onPressed: null,
                      icon: Badge(
                        label: const Text('1',
                            style:
                                TextStyle(fontSize: 10, color: Colors.white)),
                        backgroundColor: const Color.fromRGBO(252, 57, 46, 1),
                        child: Icon(
                          Iconsax.notification,
                          color: dynamicColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    StreamBuilder<Users?>(
                      stream: authController.getUserInfo(auth!.uid),
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

                        if (user == null) {
                          return const Center(
                              child: Text('No user data available.'));
                        }
                        return DashedCircle(
                          dashes: 20,
                          color: customTheme['secondaryColor']!,
                          child: InkWell(
                            onTap: () {
                              router.push(
                                PersonalProfileView.path,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: user.photoUrl == null
                                  ? CachedNetworkImage(
                                      imageUrl: user.photoUrl ??
                                          'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                        backgroundColor:
                                            customTheme['secondaryColor']!,
                                        radius: 20,
                                      ),
                                      imageBuilder: (context, image) =>
                                          CircleAvatar(
                                        backgroundImage: image,
                                        backgroundColor:
                                            customTheme['secondaryColor']!,
                                        radius: 20,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          customTheme['secondaryColor']!,
                                      backgroundImage: FileImage(
                                        File(
                                          user.photoUrl ?? '',
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: Divider(),
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
