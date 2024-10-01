import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:flutter/material.dart';

class PurchaseTracking extends StatelessWidget {
  const PurchaseTracking({super.key});
  static const path = '/purchase_tracking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BackIconHeader(
        header: 'Tracking',
        showIcon: false,
      ),
    );
  }
}
