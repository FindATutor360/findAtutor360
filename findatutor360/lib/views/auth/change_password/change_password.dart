import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});
  static const path = '/change_password';

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _oldPasswordvisible = true;
  bool _newPasswordvisible = true;
  bool _confirmPasswordvisible = true;

  @override
  Widget build(BuildContext context) {
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
                child: MainText(text: 'Change Password'),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      textCapitalization: TextCapitalization.none,
                      controller: _oldPasswordController,
                      label: Text('Old Password',
                          style: TextStyle(
                              color: customTheme['secondaryTextColor'])),
                      hint: 'Enter your password',
                      obscureText: _oldPasswordvisible ? true : false,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _oldPasswordvisible = !_oldPasswordvisible;
                            },
                          );
                        },
                        child: Icon(_oldPasswordvisible == true
                            ? Iconsax.eye
                            : Iconsax.eye_slash),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      textCapitalization: TextCapitalization.none,
                      controller: _newPasswordController,
                      label: Text('Password',
                          style: TextStyle(
                              color: customTheme['secondaryTextColor'])),
                      hint: 'Enter your password',
                      obscureText: _newPasswordvisible ? true : false,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _newPasswordvisible = !_newPasswordvisible;
                            },
                          );
                        },
                        child: Icon(_newPasswordvisible == true
                            ? Iconsax.eye
                            : Iconsax.eye_slash),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      textCapitalization: TextCapitalization.none,
                      controller: _confirmPasswordController,
                      label: Text('Confirm Password',
                          style: TextStyle(
                              color: customTheme['secondaryTextColor'])),
                      hint: 'Confirm your password',
                      obscureText: _confirmPasswordvisible ? true : false,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              _confirmPasswordvisible =
                                  !_confirmPasswordvisible;
                            },
                          );
                        },
                        child: Icon(_confirmPasswordvisible == true
                            ? Iconsax.eye
                            : Iconsax.eye_slash),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                isIconPresent: false,
                text: 'Change Password',
                fontWeight: FontWeight.w600,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await changePassword(
                      oldPassword: _oldPasswordController.text,
                      newPassword: _newPasswordController.text,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    if (!checkPasswords(
      password: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
    )) {
      showSnackMessage(context, 'Passwords do not match', isError: true);
      return;
    }
    showSnackMessage(context, 'Password Change successful', isError: false);
    context.pushReplacement(LoginView.path);
  }

  bool checkPasswords({
    required String password,
    required String confirmPassword,
  }) {
    return password == confirmPassword;
  }
}
