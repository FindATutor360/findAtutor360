import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/dialogs/log_out_dialog.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:provider/provider.dart';

class SettingsUserLogoutCard extends StatefulWidget {
  const SettingsUserLogoutCard({
    super.key,
  });

  @override
  State<SettingsUserLogoutCard> createState() => _SettingsUserLogoutCardState();
}

class _SettingsUserLogoutCardState extends State<SettingsUserLogoutCard> {
  late AuthController _authController;

  @override
  Widget build(BuildContext context) {
    _authController = context.watch<AuthController>();
    return InkWell(
      onTap: () async {
        // await _authController.logout().then(
        //       (value) => context.pushReplacement(LoginView.path),
        //     );
        Navigator.of(context).push(
          LogOutDialog(
            context,
            logOutTap: () async {
              await _authController.logout(context).then(
                    (value) => context.pushReplacement(LoginView.path),
                  );
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.12,
        padding: const EdgeInsets.all(10.0),
        child: Card(
            color: customTheme['badgeColor'],
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: Text('Logout',
                        style: TextStyle(
                            fontSize: 18, color: customTheme['whiteColor']))),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: customTheme['whiteColor'],
                    radius: 23,
                    child:
                        Icon(Iconsax.logout, color: customTheme['badgeColor']),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
