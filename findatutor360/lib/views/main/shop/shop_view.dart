import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/views/main/shop/shop_books.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../custom_widgets/card/category_widget.dart';
import '../../../custom_widgets/card/shop_category_widget.dart';
import '../../../custom_widgets/drawer/custom_drawer.dart';
import '../../../custom_widgets/slider/custom_carousel_view.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: customTheme['whiteColor'],
      appBar: const AppHeader(),
      drawer: const CustomDrawer(),
      body: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          const CustomCarouselView(),
          const SizedBox(
            height: 30,
          ),
          const category_scrollview(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: const [
                SizedBox(height: 20),
                ShopBookWidget(),
                SizedBox(height: 20),
                ShopBookWidget(),
                SizedBox(height: 20),
                ShopBookWidget(),
              ],
            ),
          ),
        ]))
      ]),
    ));
  }
}

class category_scrollview extends StatelessWidget {
  const category_scrollview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          icon: Iconsax.chart_1,
        ),
        CategoryWidget(
          text: 'Programming',
          icon: Iconsax.code,
        ),
        CategoryWidget(
          text: 'Crypto',
          icon: Iconsax.money_send,
        ),
      ]),
    );
  }
}
