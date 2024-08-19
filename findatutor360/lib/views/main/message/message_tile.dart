import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

import 'user_image_view.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key,
      required this.imageUrl,
      required this.userName,
      required this.message,
      required this.time,
      required this.messageNumber,
      required this.onTap});

  final String? imageUrl;
  final String? userName;
  final String? message;
  final String? time;
  final String? messageNumber;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: ListTile(
            leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: UserImage(imageUrl: imageUrl)),
            title: MainText(
                text: userName!, fontSize: 18, fontWeight: FontWeight.bold),
            subtitle: MainText(
                text: message!,
                fontSize: 15,
                color: customTheme['mainTextSecondaryColor'],
                fontWeight: FontWeight.w600),
            trailing: Column(
              children: [
                MainText(
                    text: time!,
                    fontSize: 15,
                    color: customTheme['mainTextSecondaryColor'],
                    fontWeight: FontWeight.w600),
                const SizedBox(height: 8),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: customTheme['primaryColor'],
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: MainText(
                        text: messageNumber!,
                        fontSize: 15,
                        color: customTheme['whiteColor'],
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
