import 'dart:developer';

import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/views/main/message/chat.dart';
import 'package:findatutor360/views/main/message/empty_message_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final User? auth = FirebaseAuth.instance.currentUser;
  final String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

  final Course course = Course();
  Future<void> _refreshMessages() async {
    setState(
      () {
        MessageController().getLatestMessages(currentUserEmail!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: const AppHeader(
          showIcon: false,
        ),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: RefreshIndicator(
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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
                            builder: ((context) => ChatViews(
                                  messages: latestMessage,
                                  // user: data,
                                  tutorEmail: 'asanteadarkwa.usman@gmail.com',
                                )),
                          ),
                        );

                        log("Recipient email: ${latestMessage.recipientEmail}",
                            name: 'debug');
                        log("Message text: ${latestMessage.senderName}",
                            name: 'debug');
                        log("Sender email: ${latestMessage.senderEmail}",
                            name: 'debug');

                        log("Recipient name: ${latestMessage.recipientName}",
                            name: 'debug');
                        // log("Recipient photo URL: $recipientPhotoUrl",
                        //     name: 'debug');
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
      ),
    );
  }
}
