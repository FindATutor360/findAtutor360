import 'dart:developer';

import 'package:findatutor360/core/models/main/tutors_model.dart';
import 'package:findatutor360/core/view_models/main/tutors_controller.dart';
import 'package:findatutor360/custom_widgets/card/recommended_tutor_card.dart';
import 'package:findatutor360/custom_widgets/header/back_icon_header.dart';
import 'package:findatutor360/custom_widgets/text/main_text.dart';
import 'package:findatutor360/routes/routes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecommendedTutorsView extends StatefulWidget {
  const RecommendedTutorsView({super.key});
  static const path = 'recommendedTutors';

  @override
  State<RecommendedTutorsView> createState() => _RecommendedTutorsViewState();
}

class _RecommendedTutorsViewState extends State<RecommendedTutorsView> {
  Future<List<Data>>? fetchTutors;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tutorsController =
          Provider.of<TutorsController>(context, listen: false);
      tutorsController.fetchTutors();
    });

    fetchTutors = TutorsController().fetchTutors();
  }

  Future<void> _refreshTutors() async {
    setState(() {
      fetchTutors = TutorsController().fetchTutors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator.adaptive(
        onRefresh: _refreshTutors,
        child: Scaffold(
          appBar: const BackIconHeader(
            header: 'Recommended Tutors',
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: _refreshTutors,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  RefreshIndicator.adaptive(
                    onRefresh: _refreshTutors,
                    child: FutureBuilder<List<Data>>(
                      future: fetchTutors,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: MainText(
                              text: 'Error: ${snapshot.error}',
                              fontSize: 14,
                              color: Colors.red,
                              softWrap: true,
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No tutors found',
                                style: TextStyle(fontSize: 14)),
                          );
                        } else {
                          final tutors = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tutors.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                            ),
                            itemBuilder: (context, index) {
                              final tutor = tutors[index];
                              double extractRating(String? ratings) {
                                if (ratings == null || ratings.isEmpty) {
                                  return 0.0;
                                }

                                // Extract numeric rating from the string (e.g., "5 (14 Reviews)")
                                final numericPart = RegExp(r'^\d+(\.\d+)?')
                                    .firstMatch(ratings)
                                    ?.group(0); // Get the first numeric part
                                return double.tryParse(numericPart ?? '0') ??
                                    0.0;
                              }

                              return InkWell(
                                onTap: () async {
                                  log('print', name: 'Tapss');
                                  final tutorUrl = tutor.source ?? '';
                                  final sanitizedTutorName =
                                      (tutor.tutorName ?? '')
                                          .replaceAll('©', '(C)')
                                          .replaceAll('&', 'and')
                                          .replaceAll('%', 'percent')
                                          .replaceAll(RegExp(r'[^\w\s-]'), '');
                                  final tutorName =
                                      Uri.encodeComponent(sanitizedTutorName);

                                  final encodedUrl = (tutorUrl.isEmpty)
                                      ? Uri.encodeComponent(
                                          'https://www.superprof.co.in/senior-data-scientist-amazon-economics-iit-kanpur-provides-mentoring-basics-advanced-level-statistics.html')
                                      : Uri.encodeComponent(tutorUrl);

                                  router.push(
                                      '/enrollView/$tutorName/$encodedUrl');
                                },
                                child: RecommededTutorCard(
                                  tutorImage: tutor.tutorImage,
                                  tutorName: tutor.tutorName,
                                  tutorStatus: tutor.status,
                                  tutorRate: extractRating(tutor.ratings),
                                  isOnline: tutor.location
                                          ?.toLowerCase()
                                          .contains('online') ??
                                      false,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
