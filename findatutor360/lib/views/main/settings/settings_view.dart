import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/settings_view_content.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/drawer/custom_drawer.dart';
import '../../../custom_widgets/header/header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: customTheme['whiteColor'],
            appBar: const Header(),
            drawer: const CustomDrawer(),
            body: const SingleChildScrollView(child: SettingsViewContent())));
  }
}
