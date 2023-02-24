import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:findatutor360/theme/index.dart';

class SettingsUserLogoutCard extends StatelessWidget {
  const SettingsUserLogoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Icon(Iconsax.logout, color: customTheme['badgeColor']),
                ),
              ),
            ],
          )),
    );
  }
}
