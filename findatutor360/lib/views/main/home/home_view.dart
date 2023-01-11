import 'package:findatutor360/custom_widgets/card/category_widget.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
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
    return Scaffold(
      backgroundColor: customTheme['whiteColor'],
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          const AppHeader(),
          Divider(
            color: customTheme['dividerColor'],
            thickness: 1,
          ),
          const CustomCarouselView(),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const MainText(text: 'Categories', fontSize: 16),
                TextButton(
                    onPressed: (() {
                      router.go('/category');
                    }),
                    child: MainText(
                        text: 'See All',
                        fontSize: 12,
                        color: customTheme['secondaryTextColor']))
              ],
            ),
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
        ],
      ))),
    );
  }
}
