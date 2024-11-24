// import 'dart:io';

// import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class EnrollCourseScreen extends StatefulWidget {
//   final String url;
//   final String title;

//   const EnrollCourseScreen({
//     required this.url,
//     this.title = 'Web View',
//     super.key,
//   });

//   static const path = '/enrollView';

//   @override
//   State<EnrollCourseScreen> createState() => _EnrollCourseScreenState();
// }

// class _EnrollCourseScreenState extends State<EnrollCourseScreen> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   void init() {
//     if (kIsWeb) {
//       _controller = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..loadRequest(Uri.parse(widget.url));
//     } else if (Platform.isAndroid || Platform.isIOS) {
//       _controller = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..loadRequest(Uri.parse(widget.url));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (kIsWeb) {
//       return SafeArea(
//         child: Scaffold(
//           appBar: const BackIconHeader(
//             header: '',
//           ),
//           body: WebViewWidget(controller: _controller),
//         ),
//       );
//     } else if (Platform.isAndroid || Platform.isIOS) {
//       return SafeArea(
//         child: Scaffold(
//           appBar: const BackIconHeader(
//             header: '',
//           ),
//           body: WebViewWidget(controller: _controller),
//         ),
//       );
//     } else {
//       return Center(
//         child: Text('WebView is not supported on this platform'),
//       );
//     }
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

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
    if (kIsWeb) {
      WebViewPlatform.instance = WebWebViewPlatform();
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url));
    } else if (Platform.isAndroid || Platform.isIOS) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: WebViewWidget(controller: _controller),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(
          child: Text('WebView is not supported on this platform'),
        ),
      );
    }
  }
}
