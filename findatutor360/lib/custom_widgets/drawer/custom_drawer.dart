import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/dialogs/log_out_dialog.dart';
import 'package:findatutor360/custom_widgets/drawer/drawer_element.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/auth/login/login_view.dart';
import 'package:findatutor360/views/main/cart/wishlist_view.dart';
import 'package:findatutor360/views/main/settings/feed_back_view.dart';
import 'package:findatutor360/views/main/settings/invite_friend_view.dart';
import 'package:findatutor360/views/main/settings/my_books_view.dart';
import 'package:findatutor360/views/main/settings/my_courses_view.dart';
import 'package:findatutor360/views/main/settings/personal_profile_view.dart';
import 'package:findatutor360/views/main/settings/purchase_view.dart';
import 'package:findatutor360/views/main/settings/schedules_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late AuthController _authController;
  @override
  Widget build(BuildContext context) {
    _authController = context.watch<AuthController>();
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
                  context.pop();
                  router.push(
                    PersonalProfileView.path,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'My Books',
                icon: Iconsax.book_1,
                onPressed: () {
                  context.pop();
                  router.push(
                    MyBooksView.path,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'My Courses',
                icon: Iconsax.play_circle,
                onPressed: () {
                  context.pop();
                  router.push(
                    MyCoursesView.path,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Wishlist',
                icon: Iconsax.heart,
                onPressed: () {
                  context.pop();
                  router.push(
                    WishlistView.path,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Purchases',
                icon: Iconsax.bag_tick_2,
                onPressed: () {
                  context.pop();
                  router.push(
                    PurchaseView.path,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Shedules',
                icon: Iconsax.calendar_2,
                onPressed: () {
                  context.pop();
                  router.push(
                    SchedulesView.path,
                  );
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
                  context.pop();
                  router.push(
                    FeedBackView.path,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              DrawerElement(
                text: 'Invite a friend',
                icon: Iconsax.directbox_send,
                onPressed: () {
                  context.pop();
                  router.push(
                    InviteFriendView.path,
                  );
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
                      onPressed: () async {
                        Navigator.of(context).push(
                          LogOutDialog(
                            context,
                            logOutTap: () async {
                              await _authController.logout(context).then(
                                    (value) =>
                                        context.pushReplacement(LoginView.path),
                                  );
                              //Show toast

                              // ignore: use_build_context_synchronously
                            },
                          ),
                        );
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

  Future<void> logOut() async {}
}
