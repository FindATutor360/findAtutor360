import 'dart:developer';

import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/view_models/main/message_controller.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/message/user_image_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ChatViews extends StatefulWidget {
  const ChatViews({
    required this.messages,
    super.key,
  });
  final Messages messages;

  static const path = 'chat_view';

  @override
  State<ChatViews> createState() => _ChatViewsState();
}

class _ChatViewsState extends State<ChatViews> {
  late MessageController _message;
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode(); // FocusNode for the text field
  final ValueNotifier<bool> _isButtonVisible = ValueNotifier(false);
  String? text;

  @override
  void initState() {
    super.initState();
    _message = context.read<MessageController>();
    _focusNode.addListener(() {
      // Show the send button when the text field is focused, hide it otherwise
      _isButtonVisible.value = _focusNode.hasFocus;

      setState(() {});
    });
  }

  Future<void> _refreshMessages() async {
    setState(
      () {
        _message.getMessages(FirebaseAuth.instance.currentUser!.email ?? '',
            widget.messages.recipientEmail ?? '');
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode when the widget is disposed
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
              imageUrl: widget.messages.recipientEmail != currentUser!.email
                  ? widget.messages.recipientPhotoUrl ??
                      'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg'
                  : widget.messages.senderPhotoUrl ??
                      'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                FittedBox(
                  child: Text(
                    widget.messages.recipientEmail != currentUser.email
                        ? widget.messages.recipientName ?? 'Unknown'
                        : widget.messages.senderName ?? 'Unknown',
                  ),
                ),
                Text(
                  'Programmer/Writer',
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
      body: RefreshIndicator(
        onRefresh: _refreshMessages,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Messages>>(
                stream: _message.getMessages(
                  currentUser.email ?? '',
                  widget.messages.recipientEmail ?? '',
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Error loading messages",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No messages yet"));
                  }

                  final messages = snapshot.data!;
                  return ListView.separated(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(bottom: 60),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isCurrentUser =
                          message.senderEmail == currentUser.email;
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
                                          Icons.check,
                                          size: 16,
                                          color: isCurrentUser
                                              ? message.readBy == false
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
                                          : const Color.fromRGBO(66, 73, 78, 1),
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
                        height: 15,
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
                            await sendMessage();
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

  Future<void> sendMessage() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (formKey.currentState != null &&
        formKey.currentState!.validate() &&
        auth.currentUser != null) {
      // Ensure correct assignment: sender is the current user, recipient is the other party.
      final senderEmail = auth.currentUser!.email;
      final senderPhotoUrl = auth.currentUser!.photoURL;
      final senderName = auth.currentUser!.displayName;
      final recipientEmail = widget.messages.senderEmail == senderEmail
          ? widget.messages.recipientEmail
          : widget.messages.senderEmail;
      final recipientName = widget.messages.senderName == senderName
          ? widget.messages.recipientName
          : widget.messages.senderName;
      final recipientPhotoUrl = widget.messages.senderPhotoUrl == senderPhotoUrl
          ? widget.messages.recipientPhotoUrl
          : widget.messages.senderPhotoUrl;

      await _message.sendMessage(
        senderEmail ?? '',
        _messageController.text,
        recipientEmail,
        recipientName,
        recipientPhotoUrl,
      );
      log(recipientEmail ?? '', name: 'debug');
      log(_messageController.text, name: 'debug');
      log(senderEmail ?? '', name: 'debug');
      _messageController.clear();
    }
  }

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
