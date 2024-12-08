import 'dart:io';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/settings/personal_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:provider/provider.dart';

class SettingUserCard extends StatelessWidget {
  const SettingUserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? auth = FirebaseAuth.instance.currentUser;
    final authController = Provider.of<AuthController>(context);

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
              auth != null
                  ? StreamBuilder<Users?>(
                      stream: authController.getUserInfo(auth.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        final user = snapshot.data;

                        final isFile = user?.photoUrl != null &&
                            File(user!.photoUrl!).existsSync();

                        final image = user?.photoUrl ?? '';

                        bool isNetworkImage = image.startsWith('http') ||
                            image.startsWith('https');

                        if (user == null) {
                          return const Center(
                              child: Text('No user data available.'));
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF0476AF),
                            radius: 20,
                            backgroundImage: isNetworkImage
                                ? NetworkImage(user.photoUrl ?? '')
                                : FileImage(File(user.photoUrl ?? ''))
                                    as ImageProvider,
                            child: !isNetworkImage && !isFile
                                ? const Icon(Icons.person, color: Colors.white)
                                : null, // Placeholder icon if no image is available
                          ),
                          title: Text(
                            user.fullName ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Color(0xFFE6F6FE),
                            ),
                          ),
                          subtitle: Text(
                            user.backGround ?? '',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFFE6F6FE),
                            ),
                          ),
                          trailing: const Icon(Iconsax.arrow_right_3,
                              color: Colors.white),
                        );
                      },
                    )
                  : const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFF0476AF),
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                        ),
                      ),
                      title: Text(
                        'Usman Asante',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFE6F6FE),
                        ),
                      ),
                      subtitle: Text(
                        'Software Developer',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFFE6F6FE),
                        ),
                      ),
                      trailing:
                          Icon(Iconsax.arrow_right_3, color: Colors.white),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
