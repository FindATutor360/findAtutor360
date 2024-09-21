import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/settings/personal_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:findatutor360/theme/index.dart';

class SettingUserCard extends StatelessWidget {
  const SettingUserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white);
    return InkWell(
      onTap: () {
        router.push(
          PersonalProfileView.path,
        );
      },
      child: Container(
        width: 300,
        height: 100,
        color: dynamicColor,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: customTheme['primaryColor'],
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFE6F6FE),
                    radius: 20,
                    child: Text(
                      'A',
                      style: TextStyle(
                          fontSize: 18, color: customTheme['primaryColor']),
                    ), //Text
                  ),
                  title: const Text('Anthony Rudiger',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFE6F6FE),
                      )),
                  subtitle: const Text('Anthony Rudiger.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFE6F6FE),
                      )),
                  trailing:
                      const Icon(Iconsax.arrow_right_3, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
