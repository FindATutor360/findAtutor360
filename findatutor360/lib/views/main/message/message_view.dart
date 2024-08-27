import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/message/chat_view.dart';
import 'package:flutter/material.dart';
import 'message_tile.dart';

class MessageView extends StatelessWidget {
  final String? imageUrl;
  final String? userName;
  final String? message;
  final String? time;
  final String? messageNumber;
  const MessageView({
    super.key,
    this.imageUrl,
    this.userName,
    this.message,
    this.time,
    this.messageNumber,
  });
  static const path = '/messageView';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: const Color.fromRGBO(225, 225, 225, 1),
          appBar: const AppHeader(),
          drawer: const CustomDrawer(),
          body: ListView.separated(
              itemBuilder: (context, index) {
                return MessageTile(
                  onTap: () =>
                      router.push('${MessageView.path}/${ChatView.path}'),
                  imageUrl: imageUrl,
                  userName: 'Asante Junior',
                  message: 'We meeting tonight?',
                  time: '18:22',
                  messageNumber: '2',
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 60);
              },
              itemCount: 5)),
    );
  }
}
