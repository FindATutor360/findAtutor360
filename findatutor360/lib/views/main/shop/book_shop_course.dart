import 'package:findatutor360/custom_widgets/button/custom_icon_button.dart';
import 'package:findatutor360/custom_widgets/card/book_shop_card.dart';
import 'package:findatutor360/custom_widgets/drawer/custom_drawer.dart';
import 'package:findatutor360/custom_widgets/header/app_header.dart';
import 'package:findatutor360/custom_widgets/tabs/categrory_tabs.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/custom_widgets/textfield/custom_text_form_field.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/course_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BookShopView extends StatelessWidget {
  const BookShopView({super.key});
  static const path = 'bookShopView';

  @override
  Widget build(BuildContext context) {
    Color dynamicColor = (Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black);
    return SafeArea(
      child: Scaffold(
        appBar: const AppHeader(),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const Align(
                child: MainText(
                  text: 'Learn Something New',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Align(
                child: CustomTextFormField(
                  hint: 'Find a book or a course',
                  prefixIcon: CustomIconButton(
                    onPressed: null,
                    icon: Icon(
                      Iconsax.search_normal_1,
                      color: dynamicColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const CategoryScrollview(),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: ((BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        router.push(
                          CourseDetails.path,
                        );
                      },
                      child: const BookShopCard(),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
