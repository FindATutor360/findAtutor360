import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
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
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
