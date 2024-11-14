import 'dart:developer';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/message/user_image_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ChatViews extends StatefulWidget {
  const ChatViews({
    this.user,
    // this.messages,
    required this.tutorEmail,
    super.key,
  });

  final Users? user;

  final String tutorEmail;
  // final Messages? messages;

  static const path = 'chat_view';

  @override
  State<ChatViews> createState() => _ChatViewsState();
}

class _ChatViewsState extends State<ChatViews> {
  late MessageController _message;
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isButtonVisible = ValueNotifier(false);
  String? text;

  @override
  void initState() {
    super.initState();

    _message = context.read<MessageController>();
    _focusNode.addListener(() {
      _isButtonVisible.value = _focusNode.hasFocus;

      setState(() {});
    });
  }

  Future<void> _refreshMessages() async {
    setState(
      () {
        _message.getMessages(
            FirebaseAuth.instance.currentUser!.email ?? '', widget.tutorEmail);
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customTheme['primaryColor'],
        elevation: 0.4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            UserImage(
                radius: 18,
                imageUrl: widget.tutorEmail == 'asanteadarkwa.usman@gmail.com'
                    ? 'https://lh3.googleusercontent.com/a/ACg8ocLhSv1F-cAdR6P48IduPxSlErYukLX8GAqCc_gy8mtnoKn7tIyy=s96-c'
                    : widget.user?.photoUrl ??
                        'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg'),
            const SizedBox(width: 8),
            Column(
              children: [
                FittedBox(
                  child: Text(
                    widget.tutorEmail == 'asanteadarkwa.usman@gmail.com'
                        ? 'Usman Asante'
                        : widget.user?.fullName ?? 'Unknown',
                  ),
                ),
                Text(
                  widget.tutorEmail == 'asanteadarkwa.usman@gmail.com'
                      ? 'Programmer'
                      : widget.user?.backGround ?? 'Programmer/Writer',
                  style: TextStyle(
                    fontSize: 12,
                    color: customTheme['whiteColor'],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: RefreshIndicator(
          onRefresh: _refreshMessages,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Messages>>(
                  stream: _message.getMessages(
                    currentUser?.email ?? '',
                    widget.tutorEmail,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: MainText(
                          text: "Error loading messages",
                          fontSize: 20,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: MainText(
                          text: "No message yet",
                          fontSize: 20,
                        ),
                      );
                    }

                    final messages = snapshot.data!;
                    return ListView.separated(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16)
                          .copyWith(bottom: 60),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isCurrentUser =
                            message.senderEmail == currentUser?.email;
                        final textWidth = _getTextWidth(message.message ?? '');

                        return Align(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: textWidth + 120,
                            ),
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 8,
                              left: 12,
                              right: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isCurrentUser
                                  ? customTheme['primaryColor']
                                  : const Color(0xFFF2F3F4),
                              borderRadius: BorderRadius.only(
                                topRight: isCurrentUser
                                    ? const Radius.circular(0)
                                    : const Radius.circular(16),
                                topLeft: isCurrentUser
                                    ? const Radius.circular(16)
                                    : const Radius.circular(0),
                                bottomLeft: const Radius.circular(16),
                                bottomRight: const Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Expanded(
                                  child: MainText(
                                    overflow: TextOverflow.clip,
                                    text: message.message ?? '',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: isCurrentUser
                                        ? customTheme['whiteColor']
                                        : const Color.fromRGBO(66, 73, 78, 1),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    isCurrentUser
                                        ? Icon(
                                            message.readBy == true
                                                ? MdiIcons.checkAll
                                                : Icons.check,
                                            size: 16,
                                            color: isCurrentUser
                                                ? message.readBy == true
                                                    ? customTheme['whiteColor']
                                                    : const Color.fromRGBO(
                                                        66, 73, 78, 1)
                                                : customTheme['secondaryColor'],
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatMessageTime(message.createdAt),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isCurrentUser
                                            ? customTheme['whiteColor']
                                            : const Color.fromRGBO(
                                                66, 73, 78, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: 60,
          color: const Color(0xFFF2F3F4),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: _focusNode.hasFocus ? 300 : 350,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: _focusNode.hasFocus
                      ? Colors.transparent
                      : const Color(0xFFDEE0E3),
                  border: Border.all(
                    color: _focusNode.hasFocus
                        ? Colors.blue
                        : const Color(0xFFDEE0E3),
                  ),
                ),
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: _messageController,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: customTheme['mainTextSecondaryColor'],
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter message',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: customTheme['secondaryTextColor'],
                    ),
                    prefixIcon: InkWell(
                      onTap: () {
                        _handleAttachmentPressed();
                      },
                      child: const Icon(
                        Iconsax.sticker,
                      ),
                    ),
                    prefixIconColor: customTheme['secondaryTextColor'],
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (nameController) {
                    text = nameController;
                  },
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isButtonVisible,
                builder: (context, isVisible, child) {
                  return isVisible
                      ? InkWell(
                          onTap: () async {
                            await sendMessage(
                              currentUser?.email ?? '',
                              currentUser?.displayName ?? '',
                              currentUser?.photoURL ?? '',
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: customTheme['primaryColor'],
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              size: 20,
                              color: customTheme['whiteColor'],
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String _formatMessageTime(DateTime? timestamp) {
    if (timestamp == null) return '';
    final time = TimeOfDay.fromDateTime(timestamp);
    return time.format(context);
  }

  double _getTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
    textPainter.layout();
    return textPainter.size.width;
  }

  Future<void> sendMessage(String otherUserEmail, String otherUserName,
      String otherUserPhotoUrl) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final authController = Provider.of<AuthController>(context, listen: false);
    final Users users = Users();

    if (formKey.currentState != null && formKey.currentState!.validate()) {
      const tutorEmail = 'asanteadarkwa.usman@gmail.com';

      // Current user details
      final currentUserEmail = auth.currentUser?.email ?? '';
      final currentUserDisplayName = auth.currentUser?.displayName ?? '';

      // Determine if the current user is the tutor
      final isTutor = currentUserEmail == tutorEmail;

      // Set sender and recipient details based on context
      final senderEmail = currentUserEmail;
      final senderPhotoUrl = auth.currentUser!.photoURL ?? users.photoUrl;

      // Adjust recipient details based on whether the current user is the tutor
      final recipientEmail = isTutor ? otherUserEmail : tutorEmail;
      final recipientName = isTutor ? otherUserName : 'Usman Asante';
      final recipientPhotoUrl = isTutor
          ? otherUserPhotoUrl
          : 'https://graph.facebook.com/451133794590900/picture'; // Default image URL for tutor

      // Send the message with the correctly set recipient and sender information
      await _message.sendMessage(
        senderEmail,
        _messageController.text,
        recipientEmail,
        recipientName,
        recipientPhotoUrl,
        '',
        '',
      );

      // Clear the message input after sending
      _messageController.clear();
    }
  }

  // Future<void> sendMessage() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final authController = Provider.of<AuthController>(context, listen: false);
  //   final Users users = Users();
  //   if (formKey.currentState != null && formKey.currentState!.validate()) {
  //     const tutorEmail = 'asanteadarkwa.usman@gmail.com';

  //     // Get the current user email and display name
  //     final currentUserEmail = auth.currentUser?.email ?? '';
  //     final currentUserDisplayName = auth.currentUser?.displayName ?? '';

  //     // Determine sender and recipient details
  //     final isTutor = currentUserEmail == tutorEmail;
  //     final senderEmail = isTutor ? tutorEmail : currentUserEmail;
  //     final recipientEmail = isTutor ? auth.currentUser?.email : tutorEmail;
  //     final recipientName =
  //         isTutor ? auth.currentUser?.displayName : 'Usman Asante';

  //     // Get or set recipient and sender photo URLs
  //     final senderPhotoUrl = auth.currentUser!.photoURL ?? users.photoUrl;
  //     final recipientPhotoUrl = isTutor
  //         ? auth.currentUser?.photoURL
  //         : 'https://lh3.googleusercontent.com/a/ACg8ocLhSv1F-cAdR6P48IduPxSlErYukLX8GAqCc_gy8mtnoKn7tIyy=s96-c';

  //     // Send the message with prepared data
  //     await _message.sendMessage(
  //       senderEmail,
  //       _messageController.text,
  //       recipientEmail,
  //       recipientName,
  //       recipientPhotoUrl,
  //       '',
  //       '',
  //     );
  //     log(recipientEmail ?? '', name: 'debug');
  //     log(_messageController.text, name: 'debugs');
  //     log(senderEmail, name: 'debugss');
  //     // log(senderBackground ?? '', name: 'debugsss');

  //     log(recipientName ?? '', name: 'debugssss');

  //     log(recipientPhotoUrl ?? '', name: 'debugssssss');
  //     _messageController.clear();
  //   }
  // }

  void _handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // _handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // _handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
