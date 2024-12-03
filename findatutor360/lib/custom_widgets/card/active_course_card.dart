import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class ActiveCourseCard extends StatelessWidget {
  const ActiveCourseCard({
    this.image,
    this.title,
    this.lessonNum,
    super.key,
  });
  final String? image;
  final String? title;
  final String? lessonNum;

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white);

    final isFile = image != null && File(image!).existsSync();

    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2,
      height: title!.length > 190
          ? MediaQuery.of(context).size.height * 0.17
          : MediaQuery.of(context).size.height * 0.29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: dynamicColor,
        border: Border.all(
          color: const Color(0xFFC3C8CC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isFile
              ? RepaintBoundary(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height / 7.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: customTheme['fieldColor'],
                      image: DecorationImage(
                        image: FileImage(
                          File(image ?? ''),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : RepaintBoundary(
                  child: CachedNetworkImage(
                    imageUrl: image!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height / 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: customTheme['fieldColor'],
                          image: DecorationImage(
                            image: NetworkImage(image ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        width: double.infinity,
                        color: Colors.grey,
                        height: MediaQuery.sizeOf(context).height / 7.5,
                        child: const Icon(
                          Icons.error_outline_sharp,
                          color: Colors.red,
                        ),
                      );
                    },
                    placeholder: (context, image) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey,
                          height: MediaQuery.sizeOf(context).height / 7.5,
                        ),
                      );
                    },
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: MainText(
                      text: title ?? '',
                      fontSize: 14,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(
                        text: lessonNum ?? '',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: customTheme['secondaryTextColor'],
                      ),
                      Icon(
                        Iconsax.play_circle5,
                        color: customTheme['primaryColor'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
