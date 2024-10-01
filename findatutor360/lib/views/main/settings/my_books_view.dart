import 'package:findatutor360/custom_widgets/card/active_book_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:findatutor360/views/main/shop/book_details.dart';
import 'package:flutter/material.dart';

class MyBooksView extends StatelessWidget {
  const MyBooksView({super.key});
  static const path = '/myBooksView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const BackIconHeader(
          header: 'My Books',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const MainText(
                text: 'Active Books',
                fontSize: 16,
              ),
              const SizedBox(
                height: 24,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemBuilder: ((BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      router.push(
                        BookDetails.path,
                      );
                    },
                    child: const ActiveBookCard(
                      image: 'assets/images/activeImg.png',
                      title: 'The science of leadership',
                      lessonPecent: '77%',
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
