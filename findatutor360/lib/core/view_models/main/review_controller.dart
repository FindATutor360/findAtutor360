import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/services/main/review_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:flutter/material.dart';

/// Controller class to manage the review-related functionality.
/// Inherits from [BaseProvider] to manage state and notify listeners.
class ReviewController extends BaseProvider {
  // Dependency injection to get an instance of the ReviewServiceImpl.
  final ReviewServiceImpl _reviewServiceImpl = locator.get<ReviewServiceImpl>();

  // Private ValueNotifier to manage loading state during review operations.
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  // Public getter for the loading state. Used to inform UI about loading progress.
  ValueNotifier<bool> get isLoading => _isLoading;

  /// Saves a review for a specific course.
  ///
  /// [courseName] - The name of the course being reviewed.
  /// [comment] - The user's comment for the review.
  /// [page] - The page where the review is being posted.
  /// [rating] - The rating given to the course (e.g., 1-5).
  /// [context] - The BuildContext for UI updates or showing snackbars.
  Future<void> saveReview(
    String? courseName,
    String? comment,
    String? page,
    dynamic rating,
    BuildContext context,
  ) async {
    // Set loading state to true while the review is being saved.
    isLoading.value = true;
    notifyListeners();

    try {
      // Call the saveReview method from ReviewServiceImpl to save the review data.
      await _reviewServiceImpl.saveReview(
        courseName,
        comment,
        page,
        rating,
        context,
      );
    } catch (e) {
      // Catch any errors during the review save process and rethrow.
      rethrow;
    } finally {
      // Set loading state to false after the operation is complete.
      isLoading.value = false;
      notifyListeners();
    }
  }

  /// Fetches reviews for a specific course.
  ///
  /// [courseName] - The name of the course to fetch reviews for.
  /// Returns a stream of reviews for the given course.
  Stream<List<Review>> fetchReviews(String courseName) {
    return _reviewServiceImpl.fetchReviews(courseName);
  }
}

/// Utility function to normalize course names for use in URLs or identifiers.
/// Replaces certain characters and trims the name to avoid illegal characters.
String normalizeCourseName(String? courseName) {
  if (courseName == null) {
    return ''; // Return empty string if the course name is null.
  }

  // Normalize the course name by replacing specific characters and removing non-word characters.
  return courseName
      .replaceAll('©', '(C)') // Replace copyright symbol with "(C)".
      .replaceAll('&', 'and') // Replace "&" with "and".
      .replaceAll('%', 'percent') // Replace "%" with "percent".
      .replaceAll(RegExp(r'[^\w\s-]'),
          '') // Remove any non-alphanumeric, non-space, and non-hyphen characters.
      .trim(); // Trim leading and trailing whitespace.
}
