import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/drawer/drawer_element.dart';
import 'package:findatutor360/routes/index.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: customTheme['drawerColor'],
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              IconButton(
                onPressed: () {
                  router.pop();
                },
                icon: Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: Icon(
                    Iconsax.close_square4,
                    color: customTheme['whiteColor'],
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              DrawerElement(
                text: 'My Profile',
                icon: Iconsax.profile_circle,
                onPressed: () {
                  router.push('/profile');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'My Books',
                icon: Iconsax.book_1,
                onPressed: () {
                  router.push('/my_courses');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'My Courses',
                icon: Iconsax.play_circle,
                onPressed: () {
                  router.push('/my_courses');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Wishlist',
                icon: Iconsax.heart,
                onPressed: () {
                  router.push('/my_wallet');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Purchases',
                icon: Iconsax.bag_tick_2,
                onPressed: () {
                  router.push('/my_wallet');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Shedules',
                icon: Iconsax.calendar_2,
                onPressed: () {
                  router.push('/my_wallet');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Color.fromRGBO(1, 72, 110, 1),
                thickness: 1,
                indent: 20,
                endIndent: 40,
              ),
              const SizedBox(
                height: 15,
              ),
              DrawerElement(
                text: 'Feedback',
                icon: Iconsax.message_question,
                onPressed: () {
                  router.push('/my_wallet');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Invite a friend',
                icon: Iconsax.directbox_send,
                onPressed: () {
                  router.push('/my_wallet');
                },
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: PrimaryButton(
                      text: 'Logout',
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      spaceBetweenIconAndText: 20,
                      isIconPresent: true,
                      onPressed: () {
                        router.push('/login');
                      },
                      iconName: Iconsax.logout,
                      buttonColor: customTheme['badgeColor'],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
