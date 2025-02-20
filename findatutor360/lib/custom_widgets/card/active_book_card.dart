import 'dart:io';

import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class ActiveBookCard extends StatelessWidget {
  const ActiveBookCard({
    required this.image,
    required this.title,
    required this.author,
    required this.lessonPecent,
    super.key,
  });
  final String image;
  final String title;
  final String author;
  final String lessonPecent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC3C8CC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image.isEmpty
              ? Container(
                  width: MediaQuery.sizeOf(context).width / 2.2,
                  height: MediaQuery.sizeOf(context).height / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: customTheme['fieldColor'],
                  ),
                  child: const Icon(
                    Icons.error_outline_sharp,
                    color: Colors.red,
                  ),
                )
              : Container(
                  width: MediaQuery.sizeOf(context).width / 2.2,
                  height: MediaQuery.sizeOf(context).height / 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: customTheme['fieldColor'],
                    image: DecorationImage(
                      image: FileImage(
                        File(image),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText(
                    text: title,
                    fontSize: 15,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MainText(
                    text: author,
                    fontSize: 14,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            Container(
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.77,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          lessonPecent,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF79848E),
                          ),
                        ),
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
