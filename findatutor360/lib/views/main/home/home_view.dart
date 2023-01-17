import 'package:findatutor360/custom_widgets/card/category_widget.dart';
import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/rating/custom_rating_bar.dart';
import 'package:findatutor360/custom_widgets/slider/custom_carousel_view.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/index.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: customTheme['whiteColor'],
          appBar: const AppHeader(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  color: customTheme['dividerColor'],
                  thickness: 1,
                ),
                const CustomCarouselView(),
                const SizedBox(
                  height: 20,
                ),
                TextOption(
                  mainText: 'Category',
                  onPressed: () {
                    router.push('/category');
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: const [
                    CategoryWidget(
                      text: 'Geography',
                      icon: Iconsax.microscope,
                    ),
                    CategoryWidget(
                      text: 'Music',
                      icon: Iconsax.music_play,
                    ),
                    SizedBox(width: 5),
                    CategoryWidget(
                      text: 'Mathematics',
                      icon: Iconsax.graph,
                    ),
                    CategoryWidget(
                      text: 'Health',
                      icon: Iconsax.health,
                    ),
                    CategoryWidget(
                      text: 'Finance',
                      icon: Iconsax.money_send,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextOption(
                  mainText: 'Recommended Tutors',
                  onPressed: () {
                    router.push('/recommended_tutors');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                //const RecommededTutorCard(),
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                    itemBuilder: ((BuildContext context, int index) {
                      return const RecommededTutorCard();
                    })),
                const SizedBox(
                  height: 40,
                ),
                TextOption(
                  mainText: 'Active Courses',
                  onPressed: () {
                    router.push('/recommended_tutors');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // ActiveCourse(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      SizedBox(width: 20),
                      ActiveCourse(),
                      SizedBox(width: 20),
                      ActiveCourse(),
                      SizedBox(width: 20),
                      ActiveCourse(),
                      SizedBox(width: 20),
                      ActiveCourse()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextOption(
                  mainText: 'Trending Books',
                  onPressed: () {
                    router.push('/recommended_tutors');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      TrendingBookWidget(),
                      SizedBox(width: 20),
                      TrendingBookWidget(),
                      SizedBox(width: 20),
                      TrendingBookWidget(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}

class TrendingBookWidget extends StatelessWidget {
  const TrendingBookWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: customTheme['whiteColor'],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: customTheme['lightGrayColor']!, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.38,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: customTheme['secondaryColor'],
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/activeImg.png'),
                    fit: BoxFit.contain),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const MainText(
                      text: 'The Secret of love',
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 5,
                  ),
                  MainText(
                    text: 'John Joanie Doe',
                    fontSize: 12,
                    color: customTheme['secondaryTextColor']!,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomRatingBar(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainText(
                          text: 'GH₵ 50.0',
                          fontSize: 16,
                          color: customTheme['mainTextColor']),
                      Container(width: 30),
                      const CustomLikeButton()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveCourse extends StatelessWidget {
  const ActiveCourse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // router.push('/tutor_profile');
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.27,
          decoration: BoxDecoration(
              color: customTheme['whiteColor'],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: customTheme['lightGrayColor']!)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: customTheme['secondaryColor'],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/activeImg.png'),
                        fit: BoxFit.contain),
                  ),
                  height: MediaQuery.of(context).size.height * 0.14,
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: MainText(
                    text: 'Introduction to Computer Science',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const MainText(
                        text: '1/5 Lessons',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const CustomLikeButton()
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        // padding: EdgeInsets.all(0),
        onPressed: null,
        icon: Icon(Iconsax.heart, size: 24, color: customTheme['errorColor']!));
  }
}

class TextOption extends StatelessWidget {
  final void Function()? onPressed;
  final String? mainText;

  const TextOption({
    Key? key,
    required this.onPressed,
    required this.mainText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MainText(text: mainText!, fontSize: 16),
          TextButton(
              onPressed: onPressed,
              child: MainText(
                  text: 'See All',
                  fontSize: 12,
                  color: customTheme['secondaryTextColor']))
        ],
      ),
    );
  }
}
