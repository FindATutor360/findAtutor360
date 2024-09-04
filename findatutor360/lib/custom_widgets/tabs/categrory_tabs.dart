import 'package:findatutor360/custom_widgets/card/category_widget.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/book_shop_course.dart';
import 'package:findatutor360/views/main/shop/shop_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryScrollview extends StatefulWidget {
  const CategoryScrollview({super.key});

  @override
  State<CategoryScrollview> createState() => _CategoryScrollviewState();
}

class _CategoryScrollviewState extends State<CategoryScrollview> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, index, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CategoryWidget(
                icon: Iconsax.microscope,
                text: 'Geography',
                isSelected: index == 0,
                onTap: () => selectedIndex.value = 0,
              ),
              CategoryWidget(
                icon: Iconsax.music_play,
                text: 'Music',
                isSelected: index == 1,
                onTap: () {
                  selectedIndex.value = 1;
                  router.push(
                    '${ShopView.path}/${BookShopView.path}',
                  );
                },
              ),
              CategoryWidget(
                icon: Iconsax.graph,
                text: 'Mathematics',
                isSelected: index == 2,
                onTap: () => selectedIndex.value = 2,
              ),
              CategoryWidget(
                text: 'Health',
                icon: Iconsax.health,
                isSelected: index == 3,
                onTap: () => selectedIndex.value = 3,
              ),
              CategoryWidget(
                text: 'Finance',
                icon: Iconsax.chart_1,
                isSelected: index == 4,
                onTap: () => selectedIndex.value = 4,
              ),
              CategoryWidget(
                text: 'Programming',
                icon: Iconsax.code,
                isSelected: index == 5,
                onTap: () => selectedIndex.value = 5,
              ),
              CategoryWidget(
                text: 'Crypto',
                icon: Iconsax.money_send,
                isSelected: index == 6,
                onTap: () => selectedIndex.value = 6,
              ),
            ],
          ),
        );
      },
    );
  }
}
