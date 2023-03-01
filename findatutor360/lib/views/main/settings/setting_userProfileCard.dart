import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class setting_userCard extends StatelessWidget {
  const setting_userCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xFF0476AF),
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFFE6F6FE),
                  radius: 20,
                  child: Text(
                    'A',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 92, 139, 234)),
                  ), //Text
                ),
                title: Text('Anthony Rudiger',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFE6F6FE),
                    )),
                subtitle: Text('Anthony Rudiger.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFE6F6FE),
                    )),
                trailing:
                    const Icon(Iconsax.arrow_right_3, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
