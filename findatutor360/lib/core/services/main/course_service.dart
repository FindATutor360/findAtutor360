import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Abstract class defining the contract for course-related operations
abstract class CoursesService {
  /// Fetches a list of courses from an external API
  Future<List<Course>> fetchCourses();

  /// Searches for courses (currently reuses fetchCourses)
  Future<List<Course>> searchCourses();

  /// Fetches the list of courses added by the current user
  Stream<List<Course>> fetchUserCourses();

  /// Adds a course to the Firestore database
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

/// Implementation of the CoursesService interface
class CoursesServiceImpl implements CoursesService {
  final String apiKey =
      dotenv.env['UDEMY_COURSES_API_KEY'] ?? ''; // Udemy API key

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? _auth =
      FirebaseAuth.instance.currentUser; // Current authenticated user

  /// Fetch a list of courses from an external API
  @override
  Future<List<Course>> fetchCourses() async {
    // Udemy API endpoint for fetching courses
    const url =
        'https://udemy-paid-courses-for-free-api.p.rapidapi.com/rapidapi/courses/?page=1&page_size=10';

    // Send an HTTP GET request to the API
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-RapidAPI-Key': apiKey, // Include the API key in the headers
        'X-RapidAPI-Host': 'udemy-paid-courses-for-free-api.p.rapidapi.com',
      },
    );

    // If the API call is successful
    if (response.statusCode == 200) {
      log('Response data: ${response.body}',
          name: 'APIResponse'); // Log the response
      final data = json.decode(response.body); // Decode the JSON response

      List courses = data['courses'] ?? []; // Extract courses from the response
      log('$courses', name: 'debugss');
      // Map the course data to a list of Course objects
      return courses.map((courseData) => Course.fromJson(courseData)).toList();
    } else {
      // Log and throw an exception if the request fails
      log('Failed to load courses with status: ${response.statusCode}',
          name: 'APIError');
      throw Exception('Failed to load Courses');
    }
  }

  /// Adds a new course to the Firestore database
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
      // Create a Course object with the provided details
      final courseData = Course(
        id: null, // ID will be set after adding to Firestore
        userId: _auth?.uid, // Current user's ID
        userEmail: _auth?.email, // Current user's email
        image: image,
        name: name,
        actualPriceUsd: actualPriceUsd,
        description: description,
        category: category,
        duration: duration,
        day: day,
        availability: availability,
        createdAt: DateTime.now().toUtc(), // Set creation timestamp
      );

      // Add the course to Firestore
      DocumentReference docRef =
          await _fireStore.collection('Courses').add(courseData.toJson());

      // Update the document to include its ID
      await _fireStore
          .collection('Courses')
          .doc(docRef.id)
          .update({'id': docRef.id});

      log("Course added to DB successfully!", name: 'debug'); // Log success
    } catch (e) {
      // Log and rethrow any errors
      log("Error adding course to DB: $e", name: 'debug');
      rethrow;
    }
  }

  /// Fetches the list of courses added by the current user
  @override
  Stream<List<Course>> fetchUserCourses() {
    try {
      // Query Firestore for courses matching the current user's ID and email
      return _fireStore
          .collection('Courses') // Reference the 'Courses' collection
          .where('userId', isEqualTo: _auth?.uid) // Filter by user ID
          .where('userEmail', isEqualTo: _auth?.email) // Filter by user email
          .orderBy('createdAt', descending: true) // Order by creation date
          .snapshots() // Listen to real-time updates
          .map((snapshots) {
        // Map the Firestore snapshots to a list of Course objects
        List<Course> userCourses =
            snapshots.docs.map((doc) => Course.fromJson(doc.data())).toList();
        log(snapshots.docs.length.toString(),
            name: 'debug'); // Log the number of courses

        return userCourses; // Return the list of courses
      });
    } catch (e) {
      // Log and rethrow any errors
      log("Error fetching user Course: $e", name: 'debug');
      rethrow;
    }
  }

  /// Search for courses (currently identical to fetchCourses)
  @override
  Future<List<Course>> searchCourses() async {
    return fetchCourses(); // Delegates to fetchCourses
  }
}
