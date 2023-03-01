import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class settings_userLogoutCard extends StatelessWidget {
  const settings_userLogoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      padding: new EdgeInsets.all(10.0),
      child: Card(
          color: Color(0xFFED0006),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: const Text('Logout',
                      style: TextStyle(fontSize: 18, color: Colors.white))),
              Container(
                padding: EdgeInsetsDirectional.only(start: 250),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 23,
                  child: Icon(Iconsax.logout, color: Colors.red),
                ),
              ),
            ],
          )),
    );
  }
}
