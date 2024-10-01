import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:flutter/material.dart';

class PurchaseView extends StatelessWidget {
  const PurchaseView({super.key});
  static const path = '/purchase';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Purchased Items',
        ),
      ),
    );
  }
}
