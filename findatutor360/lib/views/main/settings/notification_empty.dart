import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/settings/settings_view.dart';
import 'package:flutter/material.dart';

class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({super.key});
  static const path = '/notify_empty';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const BackIconHeader(
          header: 'Notifications',
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //background image
              Image.asset('assets/images/cart.png',
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width),
              const SizedBox(height: 15),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: MainText(
                    text: 'Ooops!',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: const Text(
                    "Looks like you’ve disabled notifications. Change in settings",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Color(0xFF79848E),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ),
              const SizedBox(
                height: 40,
              ),
              //button
              Center(
                child: PrimaryButton(
                    isIconPresent: false,
                    text: 'Go to settigs',
                    onPressed: () {
                      router.go(SettingsView.path);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
