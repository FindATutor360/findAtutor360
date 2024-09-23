import 'package:findatutor360/custom_widgets/button/outline_button.dart';
import 'package:findatutor360/custom_widgets/button/primary_button.dart';
import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/dialogs/pop_up_dialog.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/settings/add_book_basic.dart';
import 'package:findatutor360/views/main/settings/edit_personal_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class PersonalProfileView extends StatefulWidget {
  const PersonalProfileView({super.key});
  static const path = '/personal_profile';

  @override
  State<PersonalProfileView> createState() => _PersonalProfileViewState();
}

class _PersonalProfileViewState extends State<PersonalProfileView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'Profile info',
          showIcon: false,
        ),
        body: SingleChildScrollView(
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
                    CircleAvatar(
                      backgroundColor: customTheme['primaryColor'],
                      radius: 20,
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 18,
                          color: customTheme['whiteColor'],
                        ),
                      ), //Text
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const MainText(
                      text: 'Anthony Rudiger',
                      fontSize: 14,
                    ),
                    MainText(
                      text: 'Educationist/Writer',
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
                onPressed: () {
                  // router.push(
                  //     '${HomeView.path}/${RecommendedTutorsView.path}');
                },
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
                onPressed: () {
                  // router.push(
                  //     '${HomeView.path}/${RecommendedTutorsView.path}');
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 3.6,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      width: 12,
                    );
                  },
                  itemCount: 3,
                  itemBuilder: (context, i) {
                    return const RecommededTutorCard();
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    required this.value,
    required this.achievement,
    super.key,
  });
  final String value;
  final String achievement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2.2,
      height: MediaQuery.sizeOf(context).height / 8.8,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFC3C8CC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: customTheme['primaryColor'],
                child: Icon(
                  Iconsax.award,
                  color: customTheme['whiteColor'],
                  size: 18,
                ),
              ),
              MainText(
                text: value,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
            child: MainText(
              text: achievement,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
