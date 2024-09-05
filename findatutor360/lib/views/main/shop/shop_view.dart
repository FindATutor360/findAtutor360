import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/custom_widgets/text/text_option.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:findatutor360/views/main/shop/book_shop_course.dart';
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
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const CustomCarouselView(),
                  const SizedBox(
                    height: 30,
                  ),
                  const CategoryScrollview(),
                  const SizedBox(
                    height: 40,
                  ),
                  TextOption(
                    mainText: '',
                    onPressed: () {
                      router.push(
                        '${ShopView.path}/${BookShopView.path}',
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, i) {
                      return const SizedBox(
                        height: 16,
                      );
                    },
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          router.push(
                            BookDetails.path,
                          );
                        },
                        child: const ShopBookWidget(),
                      );
                    },
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
