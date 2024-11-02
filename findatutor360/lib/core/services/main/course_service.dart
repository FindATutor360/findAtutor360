import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class CoursesService {
  Future<List<Course>> fetchCourses();

  Future<List<Course>> searchCourses();
  Stream<List<Course>> fetchUserCourses();

  Future<void> addCourse(
    String? image,
    String? name,
    double? actualPriceUsd,
    String? description,
    String? category,
    String? duration,
    String? day,
    List<String>? availability,
  );
}

class CoursesServiceImpl implements CoursesService {
  final String apiKey = dotenv.env['UDEMY_COURSES_API_KEY'] ?? '';

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? _auth = FirebaseAuth.instance.currentUser;

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

  @override
  Future<void> addCourse(
    String? image,
    String? name,
    double? actualPriceUsd,
    String? description,
    String? category,
    String? duration,
    String? day,
    List<String>? availability,
  ) async {
    try {
      final courseData = Course(
        id: null,
        userId: _auth?.uid,
        image: image,
        name: name,
        actualPriceUsd: actualPriceUsd,
        description: description,
        category: category,
        duration: duration,
        day: day,
        availability: availability,
      );

      DocumentReference docRef =
          await _fireStore.collection('Courses').add(courseData.toJson());
      await _fireStore
          .collection('Courses')
          .doc(docRef.id)
          .update({'id': docRef.id});

      log("Course added to DB successfully!", name: 'debug');
    } catch (e) {
      log("Error adding course to DB: $e", name: 'debug');
      rethrow;
    }
  }

  @override
  Stream<List<Course>> fetchUserCourses() {
    try {
      return _fireStore
          .collection('Courses')
          .where('userId', isEqualTo: _auth?.uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshots) {
        List<Course> userCourses =
            snapshots.docs.map((doc) => Course.fromJson(doc.data())).toList();
        log(snapshots.docs.length.toString(), name: 'debug');

        return userCourses;
      });
    } catch (e) {
      log("Error fetching user Course: $e", name: 'debug');
      rethrow;
    }
  }

  // Search Courses by query
  @override
  Future<List<Course>> searchCourses() async {
    return fetchCourses(); // Same as fetchCourses for now
  }
}
