import 'dart:convert';
import 'dart:developer';
import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class CoursesService {
  Future<List<Course>> fetchCourses();

  Future<List<Course>> searchCourses();
}

class CoursesServiceImpl implements CoursesService {
  final String apiKey = dotenv.env['UDEMY_COURSES_API_KEY'] ?? '';

  // Fetch a list of Courses
  @override
  Future<List<Course>> fetchCourses() async {
    const url =
        'https://udemy-paid-courses-for-free-api.p.rapidapi.com/rapidapi/courses/?page=1&page_size=10';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': apiKey,
        'X-RapidAPI-Host': 'udemy-paid-courses-for-free-api.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      log('Response data: ${response.body}', name: 'APIResponse');
      final data = json.decode(response.body);

      // Inspect what 'data' looks like
      log('Parsed data: $data', name: 'ParsedData');

      List courses = data['courses'] ?? [];
      log('$courses', name: 'debugss');
      return courses.map((courseData) => Course.fromJson(courseData)).toList();
    } else {
      log('Failed to load courses with status: ${response.statusCode}',
          name: 'APIError');
      throw Exception('Failed to load Courses');
    }
  }

  // Search Courses by query
  @override
  Future<List<Course>> searchCourses() async {
    return fetchCourses(); // Same as fetchCourses for now
  }
}
