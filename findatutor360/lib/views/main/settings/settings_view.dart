import 'package:findatutor360/views/main/settings/settings_view_content.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/drawer/custom_drawer.dart';
import '../../../custom_widgets/header/header.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const path = '/settingsView';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            appBar: Header(),
            drawer: CustomDrawer(),
            body: SingleChildScrollView(child: SettingsViewContent())));
  }
}
