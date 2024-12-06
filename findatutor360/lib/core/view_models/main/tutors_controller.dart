import 'dart:developer';

import 'package:findatutor360/core/models/main/tutors_model.dart';
import 'package:findatutor360/core/services/main/tutor_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:flutter/material.dart';

/// Controller class for managing course-related operations.
/// Inherits from [BaseProvider] for state management.
class TutorsController extends BaseProvider {
  // Dependency injection for CoursesService implementation.
  final TutorsServiceImpl _tutorsServiceImpl = locator.get<TutorsServiceImpl>();

  // List of all available tutors.
  List<Data> tutors = [];

  // State notifiers for loading and pagination.
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  // Getter for the loading state notifier.
  ValueNotifier<bool> get isLoading => _isLoading;

  /// Fetches all available tutors.
  /// Returns the list of tutors.
  Future<List<Data>> fetchTutors() async {
    _isLoading.value = true;

    try {
      // Fetch tutors via the service and update the local list.
      tutors = await _tutorsServiceImpl.fetchTutors();

      _isLoading.value = false;
      notifyListeners();
      log('Fetched ${tutors.length} tutors', name: 'fetched Tutors');
      return tutors;
    } catch (e) {
      _isLoading.value = false;
      notifyListeners();
      log('Error fetching tutors: $e', name: "debug");
      rethrow;
    }
  }
}
