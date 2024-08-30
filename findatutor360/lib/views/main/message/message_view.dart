import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/views/main/message/chat.dart';
import 'package:findatutor360/views/main/message/empty_message_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'message_tile.dart';

class MessageView extends StatefulWidget {
  final String? imageUrl;
  const MessageView({
    super.key,
    this.imageUrl,
  });
  static const path = '/messageView';

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  final String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;
  Future<void> _refreshMessages() async {
    setState(
      () {
        MessageController().getLatestMessages(currentUserEmail!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppHeader(
          showIcon: false,
        ),
        drawer: const CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: _refreshMessages,
          child: StreamBuilder<List<Map<String, dynamic>>>(
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

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data![index];
                  Messages latestMessage = data['latestMessage'];
                  int unreadCount = data['unreadCount'];

                  return MessageTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              ChatViews(messages: latestMessage)),
                        ),
                      );
                    },
                    imageUrl: latestMessage.recipientEmail != currentUserEmail
                        ? latestMessage.recipientPhotoUrl ?? widget.imageUrl
                        : latestMessage.senderPhotoUrl ?? widget.imageUrl,
                    userName: latestMessage.recipientEmail != currentUserEmail
                        ? latestMessage.recipientName ?? 'Unknown'
                        : latestMessage.senderName ?? '',
                    message: latestMessage.message ?? '',
                    time: latestMessage.createdAt != null
                        ? TimeOfDay.fromDateTime(latestMessage.createdAt!)
                            .format(context)
                        : '',
                    messageNumber:
                        unreadCount > 0 ? unreadCount.toString() : '0',
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
