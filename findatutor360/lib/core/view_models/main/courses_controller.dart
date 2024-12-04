// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/services/main/course_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:flutter/material.dart';

/// Controller class for managing course-related operations.
/// Inherits from [BaseProvider] for state management.
class CoursesController extends BaseProvider {
  // Dependency injection for CoursesService implementation.
  final CoursesServiceImpl _coursesServiceImpl =
      locator.get<CoursesServiceImpl>();

  // List of all available courses.
  List<Course> courses = [];

  // State notifiers for loading and pagination.
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  // Getter for the loading state notifier.
  ValueNotifier<bool> get isLoading => _isLoading;

  // Private variables to store course details.
  String? _image;
  String? _name;
  double? _actualPriceUsd;
  String? _description;
  String? _category;
  String? _duration;
  String? _day;
  List<String>? _availability;

  /// Saves the basic details of a course.
  /// Throws an exception if details are missing.
  Future<void> addCourseBasicDetails(
    String? image,
    String? name,
    String? description,
    String? category,
    BuildContext context,
  ) async {
    _isLoading.value = true;
    try {
      // Save basic details to private variables.
      _name = name;
      _description = description;
      _category = category;
      _image = image;

      _isLoading.value = false;
      notifyListeners();
      log("CourseBasicDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false;

      // Notify the user about missing details.
      showSnackMessage(context, "Basic details are missing", isError: true);
      throw Exception("Basic details are missing");
    }
  }

  /// Saves pricing details of a course.
  /// Throws an exception if details are missing.
  Future<void> addCoursePricingDetails(
    String? duration,
    double? actualPriceUsd,
    String? day,
    List<String>? availability,
    BuildContext context,
  ) async {
    _isLoading.value = true;
    try {
      // Save pricing details to private variables.
      _duration = duration;
      _availability = availability;
      _day = day;
      _actualPriceUsd = actualPriceUsd;

      _isLoading.value = false;
      notifyListeners();
      log("CoursePricingDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false;

      // Notify the user about missing pricing details.
      showSnackMessage(context, "Pricing details are missing", isError: true);
      throw Exception("Pricing details are missing");
    }
  }

  /// Saves all course details to the database.
  /// Throws an exception if any required detail is missing.
  Future<void> saveCourseDetails(BuildContext context) async {
    _isLoading.value = true;

    // Validate basic details.
    if (_name == null || _description == null || _category == null) {
      _isLoading.value = false;
      throw Exception("Basic details are missing");
    }

    // Validate pricing details.
    if (_duration == null ||
        _availability == null ||
        _actualPriceUsd == null ||
        _day == null) {
      _isLoading.value = false;
      throw Exception("Pricing details are missing");
    }

    try {
      // Save course details via the service.
      await _coursesServiceImpl.addCourse(
        _image,
        _name,
        _actualPriceUsd,
        _description,
        _category,
        _duration,
        _day,
        _availability,
      );

      _isLoading.value = false;
      log("Course saved successfully", name: "debug");

      // Reset course details after saving.
      resetCourseDetails();
    } catch (e) {
      _isLoading.value = false;

      // Notify the user about the error.
      showSnackMessage(context, "Error saving course: $e", isError: true);
      log("Error saving course: $e", name: "debug");
      rethrow;
    }
  }

  /// Fetches a stream of user-specific courses.
  Stream<List<Course>> fetchUserCourses() {
    return _coursesServiceImpl.fetchUserCourses();
  }

  /// Fetches all available courses.
  /// Returns the list of courses.
  Future<List<Course>> fetchCourses() async {
    _isLoading.value = true;

    try {
      // Fetch courses via the service and update the local list.
      courses = await _coursesServiceImpl.fetchCourses();

      _isLoading.value = false;
      notifyListeners();
      log('Fetched ${courses.length} courses');
      return courses;
    } catch (e) {
      _isLoading.value = false;
      notifyListeners();
      log('Error fetching courses: $e', name: "debug");
      rethrow;
    }
  }

  /// Resets all course details.
  void resetCourseDetails() {
    _actualPriceUsd = null;
    _availability = null;
    _category = null;
    _description = null;
    _name = null;
    _image = null;
    _duration = null;
    _day = null;
  }
}
