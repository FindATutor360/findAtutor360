import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: MainText(text: 'Chat here')));
  }
}
