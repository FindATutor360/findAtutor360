import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:findatutor360/core/models/main/tutors_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class TutorsService {
  /// Fetches a list of courses from an external API
  Future<List<Data>> fetchTutors();
}

class TutorsServiceImpl implements TutorsService {
  final String apiKey = dotenv.env['UDEMY_COURSES_API_KEY'] ?? '';

  @override
  Future<List<Data>> fetchTutors() async {
    const url =
        'https://tutors-api.p.rapidapi.com/search?subject=programming&location=online&country=India&pageNumber=1';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-RapidAPI-Key':
              '3bc149b553msh0816c85795bb64ep1a2a65jsn1a59c811e907',
          'X-RapidAPI-Host': 'tutors-api.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.body}', name: 'API Response');

        final data = json.decode(response.body);

        List tutors =
            data[0]['data'] ?? []; // Extract courses from the response
        log('$tutors', name: 'Tutors');
        // Map the course data to a list of Course objects
        return tutors.map((tutorData) => Data.fromJson(tutorData)).toList();
      } else {
        // Log and throw an exception if the request fails
        log('Failed to load tutors with status: ${response.statusCode}',
            name: 'APIError');
        throw Exception('Failed to load Tutors');
      }
    } catch (e) {
      log('Error fetching tutors: $e', name: 'API Error');
      rethrow;
    }
  }
}
