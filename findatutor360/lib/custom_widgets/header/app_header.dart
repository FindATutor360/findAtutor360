import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? imageUrl;
  final String? badgeCount;
  //final bool? isHome;
  const AppHeader({
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
              const CustomIconButton(
                onPressed: (null),
                icon: Icon(Iconsax.menu_1),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    const CustomIconButton(
                      onPressed: null,
                      icon: Icon(Iconsax.search_normal_1),
                    ),
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
                    DashedCircle(
                      dashes: 20,
                      color: customTheme['secondaryColor']!,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl ??
                              'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                          placeholder: (context, url) => CircleAvatar(
                            backgroundColor: customTheme['secondaryColor']!,
                            radius: 20,
                          ),
                          imageBuilder: (context, image) => CircleAvatar(
                            backgroundImage: image,
                            backgroundColor: customTheme['secondaryColor']!,
                            radius: 20,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
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
