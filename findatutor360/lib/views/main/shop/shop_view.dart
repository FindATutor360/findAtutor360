import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/views/main/shop/shop_books.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/drawer/custom_drawer.dart';
import '../../../custom_widgets/slider/custom_carousel_view.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});
  static const path = '/shopView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const AppHeader(),
      drawer: const CustomDrawer(),
      body: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          const CustomCarouselView(),
          const SizedBox(
            height: 30,
          ),
          const CategoryScrollview(),
          const SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
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
