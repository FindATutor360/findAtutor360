import 'dart:developer';

import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:findatutor360/core/services/main/course_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:flutter/material.dart';

class CoursesController extends BaseProvider {
  final CoursesServiceImpl _coursesServiceImpl =
      locator.get<CoursesServiceImpl>();
  List<Course> courses = [];
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Fetch all books (default or based on a query)
  Future<List<Course>> fetchCourses() async {
    isLoading.value = true;
    // notifyListeners();

    try {
      courses = await _coursesServiceImpl.fetchCourses();

      isLoading.value = false;
      notifyListeners();
      log('Fetched ${courses.length} Courses');
      return courses;
    } catch (e) {
      isLoading.value = false;
      notifyListeners();
      log('Error fetching Courses: $e', name: 'debug');
      rethrow;
    }
  }
}
