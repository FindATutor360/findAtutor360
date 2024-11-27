import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EnrollCourseScreen extends StatefulWidget {
  final String url;
  final String title;

  const EnrollCourseScreen({
    required this.url,
    this.title = 'Web View',
    super.key,
  });

  static const path = '/enrollView';

  @override
  State<EnrollCourseScreen> createState() => _EnrollCourseScreenState();
}

class _EnrollCourseScreenState extends State<EnrollCourseScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: '',
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
