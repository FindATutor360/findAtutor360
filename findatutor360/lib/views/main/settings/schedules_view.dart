import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:flutter/material.dart';

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});
  static const path = '/schedules';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackIconHeader(
          header: 'Your schedules',
        ),
      ),
    );
  }
}
