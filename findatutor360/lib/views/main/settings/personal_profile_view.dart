import 'dart:io';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/core/view_models/main/courses_controller.dart';
import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/card/active_course_card.dart';
import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/card/statistics_card.dart';
import 'package:findatutor360/custom_widgets/dialogs/pop_up_dialog.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_book_basic.dart';
import 'package:findatutor360/views/main/settings/add_course_general.dart';
import 'package:findatutor360/views/main/settings/edit_personal_profile_view.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class PersonalProfileView extends StatefulWidget {
  const PersonalProfileView({super.key});
  static const path = '/personal_profile';

  @override
  State<PersonalProfileView> createState() => _PersonalProfileViewState();
}

class _PersonalProfileViewState extends State<PersonalProfileView> {
  final User? auth = FirebaseAuth.instance.currentUser;
  late CoursesController _coursesController;
  @override
  void initState() {
    _coursesController = context.read<CoursesController>();
    super.initState();
  }

  Future<void> _refreshMessages() async {
    setState(
      () {
        _coursesController.fetchUserCourses();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Profile info',
          showIcon: false,
        ),
        body: StreamBuilder<Users?>(
          stream: authController.getUserInfo(auth!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final user = snapshot.data;
            final isFile =
                user?.photoUrl != null && File(user!.photoUrl!).existsSync();

            if (user == null) {
              return const Center(child: Text('No user data available.'));
            }

            return RefreshIndicator.adaptive(
              onRefresh: _refreshMessages,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      child: Column(
                        children: [
                          !isFile
                              ? CircleAvatar(
                                  backgroundColor: customTheme['primaryColor'],
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                    user.photoUrl ??
                                        'https://images.freeimages.com/images/large-previews/7cb/woman-05-1241044.jpg',
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: customTheme['primaryColor'],
                                  radius: 20,
                                  backgroundImage: FileImage(
                                    File(
                                      user.photoUrl ?? '',
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          MainText(
                            text: user.fullName ?? 'Unknown',
                            fontSize: 14,
                          ),
                          if (user.backGround != null)
                            MainText(
                              text: user.backGround ?? 'Educationist/Writer',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: customTheme['secondaryTextColor'],
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          PrimaryButton(
                            text: 'Edit profile',
                            fontWeight: FontWeight.w600,
                            borderRadius: BorderRadius.circular(8),
                            isIconPresent: false,
                            isForwardIconPresent: true,
                            iconColor: customTheme['whiteColor'],
                            iconName: Icons.arrow_forward,
                            fontSize: 16,
                            onPressed: () {
                              router.push(
                                EditPersonalProfileView.path,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          OutlineButton(
                            text: 'Add New Item to Store',
                            textColor: customTheme['primaryColor'],
                            fontWeight: FontWeight.w600,
                            borderRadius: BorderRadius.circular(8),
                            buttonColor: customTheme['whiteColor'],
                            isIconPresent: true,
                            iconColor: customTheme['primaryColor'],
                            iconName: Iconsax.shop_add,
                            spaceBetweenIconAndText: 6,
                            fontSize: 16,
                            onPressed: () {
                              Navigator.of(context).push(
                                PopUpDialog(
                                  firstText: 'Book',
                                  secondText: 'Course',
                                  firstTextTap: () {
                                    context.pop();
                                    router.push(
                                      AddBookBasicView.path,
                                    );
                                  },
                                  secondTextTap: () {
                                    context.pop();
                                    router.push(
                                      AddCourseGeneralView.path,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextOption(
                      horizPad: 0,
                      mainText: 'Statistics',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatisticsCard(
                            value: '25',
                            achievement: 'Courses Completed',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          StatisticsCard(
                            value: '61',
                            achievement: 'Books Sold',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          StatisticsCard(
                            value: '10',
                            achievement: 'Courses not completed',
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextOption(
                      horizPad: 0,
                      mainText: 'Your Active Courses',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder<List<Course>>(
                        stream: _coursesController.fetchUserCourses(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: MainText(
                                text: "You haven't added any course yet",
                                fontSize: 20,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: MainText(
                                text: "Error loading User courses",
                                fontSize: 20,
                              ),
                            );
                          }
                          final userCourses = snapshot.data!;
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height / 3.6,
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, i) {
                                return const SizedBox(
                                  width: 12,
                                );
                              },
                              itemCount: userCourses.length > 3
                                  ? 3
                                  : userCourses.length,
                              itemBuilder: (context, i) {
                                final userCourse = userCourses[i];
                                return InkWell(
                                  onTap: () {
                                    router.push(CourseDetails.path,
                                        extra: userCourse);
                                  },
                                  child: ActiveCourseCard(
                                    image: userCourse.image ?? '',
                                    title: userCourse.name ?? '',
                                    lessonNum: '1/5 Lessons',
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
