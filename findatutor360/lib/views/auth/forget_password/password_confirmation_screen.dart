// ignore_for_file: use_build_context_synchronously

import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:flutter/material.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:go_router/go_router.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ResetPasswordConfirmationView extends StatefulWidget {
  const ResetPasswordConfirmationView({super.key});
  static const path = '/reset_password_confirmation';

  @override
  State<ResetPasswordConfirmationView> createState() =>
      _ResetPasswordConfirmationViewState();
}

class _ResetPasswordConfirmationViewState
    extends State<ResetPasswordConfirmationView> {
  @override
  void initState() {
    super.initState();
    // Automatically open the mail app when this page loads
    Future.delayed(Duration.zero, () async {
      var result = await OpenMailApp.openMailApp();
      if (!result.didOpen && !result.canOpen) {
        showNoMailAppsDialog(context);
      } else if (!result.didOpen && result.canOpen) {
        showDialog(
          context: context,
          builder: (_) => MailAppPickerDialog(mailApps: result.options),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackIconHeader(
          header: '',
          showIcon: false,
          backTap: () {
            context.pop();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Align(
              child: MainText(text: 'Password Reset'),
            ),
            const Align(
              child: MainText(
                text: "Check your email to reset your password.",
                textAlign: TextAlign.center,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              child: PrimaryButton(
                isIconPresent: false,
                text: 'Back to Login',
                fontWeight: FontWeight.w600,
                onPressed: () async {
                  router.pushReplacement(LoginView.path);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Open Mail App"),
        content: const Text("No mail apps installed"),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
