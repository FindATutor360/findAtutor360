import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: customTheme['whiteColor'],
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const MainText(text: 'Categories', fontSize: 20)),
      body: const Center(
        child: Text('Course Categories'),
      ),
    );
  }
}
