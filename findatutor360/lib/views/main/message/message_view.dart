import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/views/main/message/chat.dart';
import 'package:findatutor360/views/main/message/empty_message_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'message_tile.dart';

class MessageView extends StatelessWidget {
  final String? imageUrl;
  const MessageView({
    super.key,
    this.imageUrl,
  });
  static const path = '/messageView';
  @override
  Widget build(BuildContext context) {
    final String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

    return SafeArea(
      child: Scaffold(
        appBar: const AppHeader(
          showIcon: false,
        ),
        drawer: const CustomDrawer(),
        body: StreamBuilder<List<Messages>>(
          stream: MessageController().getLatestMessages(currentUserEmail!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData ||
                snapshot.data!.isEmpty ||
                snapshot.hasError) {
              return const EmptyMessageView();
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Messages message = snapshot.data![index];
                int unreadCount = snapshot.data!
                    .where((msg) =>
                        msg.recipientEmail == currentUserEmail &&
                        !msg.readBy!.contains(currentUserEmail))
                    .length;

                return MessageTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => ChatViews(messages: message)),
                      ),
                    );
                  },
                  imageUrl: message.recipientEmail != currentUserEmail
                      ? message.recipientPhotoUrl ?? imageUrl
                      : message.senderPhotoUrl ?? imageUrl,
                  userName: message.recipientEmail != currentUserEmail
                      ? message.recipientName ?? 'Unknown'
                      : message.senderName ?? '',
                  message: message.message ?? '',
                  time: message.createdAt != null
                      ? TimeOfDay.fromDateTime(message.createdAt!)
                          .format(context)
                      : '',
                  messageNumber: unreadCount.toString(),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 60);
              },
            );
          },
        ),
      ),
    );
  }
}
