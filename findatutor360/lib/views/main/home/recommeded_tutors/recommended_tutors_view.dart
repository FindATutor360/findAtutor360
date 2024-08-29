import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:flutter/material.dart';

class RecommendedTutorsView extends StatelessWidget {
  const RecommendedTutorsView({super.key});
  static const path = 'recommendedTutors';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const BackIconHeader(
        header: 'Recommended Tutors',
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemBuilder: ((BuildContext context, int index) {
                return const RecommededTutorCard();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
