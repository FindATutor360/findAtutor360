import 'package:flutter/material.dart';

class RecommendedTutorsView extends StatelessWidget {
  const RecommendedTutorsView({super.key});
  static const path = '/recommendedTutors';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Recommended Tutors')),
    );
  }
}
