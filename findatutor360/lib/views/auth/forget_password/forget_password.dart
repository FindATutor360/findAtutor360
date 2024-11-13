import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/auth/forget_password/password_confirmation_screen.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});
  static const path = '/forget_password';

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  late AuthController _authController;

  String? email;

  @override
  Widget build(BuildContext context) {
    _authController = context.read<AuthController>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackIconHeader(
          header: '',
          showIcon: false,
          backTap: () {
            router.pushReplacement(LoginView.path);
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Align(
                child: MainText(text: 'Reset Password'),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _emailController,
                      textCapitalization: TextCapitalization.none,
                      label: Text('Email',
                          style: TextStyle(
                              color: customTheme['secondaryTextColor'])),
                      hint: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _authController.isLoading,
                  builder: (context, isLoading, child) {
                    return isLoading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                            isIconPresent: false,
                            text: 'Reset Password',
                            fontWeight: FontWeight.w600,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _authController.isLoading.value = true;

                                await Future.delayed(
                                    const Duration(seconds: 2));

                                _authController.resetPassword(
                                    email: _emailController.text);

                                _authController.isLoading.value = false;

                                router.push(ResetPasswordConfirmationView.path);
                              }
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
