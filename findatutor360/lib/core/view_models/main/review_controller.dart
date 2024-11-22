import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/services/main/review_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:flutter/material.dart';

class ReviewController extends BaseProvider {
  final ReviewServiceImpl _reviewServiceImpl = locator.get<ReviewServiceImpl>();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get isLoading => _isLoading;

  Future<void> saveReview(
    String? courseName,
    String? comment,
    String? page,
    dynamic rating,
    BuildContext context,
  ) async {
    isLoading.value = true;
    notifyListeners();

    try {
      await _reviewServiceImpl.saveReview(
        courseName,
        comment,
        page,
        rating,
        context,
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
      notifyListeners();
    }
  }

  Stream<List<Review>> fetchReviews(String courseName) {
    return _reviewServiceImpl.fetchReviews(courseName);
  }
}

String normalizeCourseName(String? courseName) {
  if (courseName == null) return '';
  return courseName
      .replaceAll('©', '(C)')
      .replaceAll('&', 'and')
      .replaceAll('%', 'percent')
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .trim();
}
