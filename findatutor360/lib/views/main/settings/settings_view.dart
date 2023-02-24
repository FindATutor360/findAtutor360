import 'package:findatutor360/views/main/settings/settings_viewCard.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/drawer/custom_drawer.dart';
import '../../../custom_widgets/header/header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const Header(),
            drawer: const CustomDrawer(),
            body: SingleChildScrollView(
                padding: EdgeInsets.only(top: 20),
                child: settings_viewCard())));
  }
}
