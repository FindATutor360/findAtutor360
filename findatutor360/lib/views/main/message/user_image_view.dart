import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const UserImage({super.key, required this.imageUrl, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ??
          'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
      placeholder: (context, url) => CircleAvatar(
        backgroundColor: customTheme['secondaryColor']!,
        radius: radius,
      ),
      imageBuilder: (context, image) => CircleAvatar(
        backgroundImage: image,
        backgroundColor: customTheme['secondaryColor']!,
        radius: radius,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
