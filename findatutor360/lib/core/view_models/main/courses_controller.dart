import 'dart:developer';

import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/services/main/course_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:flutter/material.dart';

class CoursesController extends BaseProvider {
  final CoursesServiceImpl _coursesServiceImpl =
      locator.get<CoursesServiceImpl>();
  List<Course> courses = [];
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  String? _image;
  String? _name;
  double? _actualPriceUsd;
  String? _description;
  String? _category;
  String? _duration;
  String? _day;
  List<String>? _availability;

  Future<void> addCourseBasicDetails(String? image, String? name,
      String? description, String? category, BuildContext context) async {
    _isLoading.value = true;
    try {
      _name = name;
      _description = description;
      _category = category;
      _image = image;
      _isLoading.value = false;
      notifyListeners();
      log("CourseBasicDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false;
      showSnackMessage(context, "Basic details are missing", isError: true);
      throw Exception("Basic details are missing");
    }
  }

  Future<void> addCoursePricingDetails(
    String? duration,
    double? actualPriceUsd,
    String? day,
    List<String>? availability,
    BuildContext context,
  ) async {
    _isLoading.value = true;
    try {
      _duration = duration;
      _availability = availability;
      _day = day;
      _actualPriceUsd = actualPriceUsd;
      _isLoading.value = false;
      notifyListeners();
      log("CoursePricingDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false;
      showSnackMessage(context, "Pricing details are missing", isError: true);
      throw Exception("Pricing details are missing");
    }
  }

  Future<void> saveCourseDetails(BuildContext context) async {
    _isLoading.value = true;

    if (_name == null || _description == null || _category == null) {
      _isLoading.value = false;
      throw Exception("Basic details are missing");
    }
    if (_duration == null ||
        _availability == null ||
        _actualPriceUsd == null ||
        _day == null) {
      _isLoading.value = false;
      throw Exception("Pricing details are missing");
    }
    try {
      await _coursesServiceImpl.addCourse(_image, _name, _actualPriceUsd,
          _description, _category, _duration, _day, _availability);
      _isLoading.value = false;
      log("Course saved successfully", name: "debug");
      // ignore: use_build_context_synchronously
      showSnackMessage(context, "Course added successfully", isError: true);
      resetBookDetails();
    } catch (e) {
      _isLoading.value = false;
      log("Error saving book: $e", name: "debug");
      rethrow;
    }
  }

  Stream<List<Course>> fetchUserCourses() {
    return _coursesServiceImpl.fetchUserCourses();
  }

  // Fetch all books (default or based on a query)
  Future<List<Course>> fetchCourses() async {
    _isLoading.value = true;
    // notifyListeners();

    try {
      courses = await _coursesServiceImpl.fetchCourses();

      _isLoading.value = false;
      notifyListeners();
      log('Fetched ${courses.length} Courses');
      return courses;
    } catch (e) {
      _isLoading.value = false;
      notifyListeners();
      log('Error fetching Courses: $e', name: 'debug');
      rethrow;
    }
  }

  void resetBookDetails() {
    _actualPriceUsd = null;
    _availability = null;
    _category = null;
    _description = null;
    _name = null;
    _availability = null;
    _duration = null;
  }
}
