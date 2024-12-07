import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/view_models/main/review_controller.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Abstract class defining the contract for the review service
abstract class ReviewService {
  // Saves a review to Firestore
  Future<void> saveReview(
    String? courseName,
    String? comment,
    String? page,
    dynamic rating,
    BuildContext context,
  );

  // Fetches reviews for a specific course
  Stream<List<Review>> fetchReviews(String courseName);
}

// Implementation of the ReviewService
class ReviewServiceImpl implements ReviewService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save a review to Firestore
  @override
  Future<void> saveReview(
    String? courseName,
    String? comment,
    String? page,
    dynamic rating,
    BuildContext context,
  ) async {
    // Normalize the course name to ensure consistent data
    final name = normalizeCourseName(courseName);

    // Create a Review object
    Review review = Review(
      id: null, // ID will be assigned later
      comment: comment!,
      rating: rating,
      courseName: name,
      senderName:
          _auth.currentUser?.displayName, // Fetch the current user's name
      profileImage:
          _auth.currentUser?.photoURL, // Fetch the current user's photo URL
      createdAt: null, // Timestamp will be added when saving to Firestore
    );

    debugPrint('Photo URL: ${_auth.currentUser?.photoURL}');

    final reviewsCollection = _fireStore.collection('Reviews');

    // Check if a review from this user for the same course already exists
    final existingReview = await reviewsCollection
        .where('courseName', isEqualTo: name)
        .where('senderName', isEqualTo: review.senderName)
        .limit(1) // Limit to one result to optimize query
        .get();

    if (existingReview.docs.isNotEmpty) {
      // If a review already exists, show an error message
      showSnackMessage(
        // ignore: use_build_context_synchronously
        context,
        "You have already submitted a review for this $page.",
        isError: true,
      );
      throw Exception('You have already submitted a review for this $page.');
    }

    // Assign a unique document ID and save the review
    final docRef = reviewsCollection.doc();
    review.id = docRef.id; // Assign the generated ID to the review
    await docRef.set({
      ...review.toJson(), // Convert the review object to JSON
      // ignore: sdk_version_since
      'createdAt': DateTime.timestamp().toUtc(), // Add the current timestamp
    });
  }

  // Fetch reviews for a specific course
  @override
  Stream<List<Review>> fetchReviews(String courseName) {
    // Normalize the course name
    final name = normalizeCourseName(courseName);
    final reviewsCollection = _fireStore.collection('Reviews');

    return reviewsCollection
        .where('courseName', isEqualTo: name) // Filter reviews by course name
        .orderBy('createdAt',
            descending: true) // Order reviews by creation time (newest first)
        .snapshots() // Listen for real-time updates
        .map(
      (snapshot) {
        // Map Firestore documents to a list of Review objects
        return snapshot.docs.map((doc) {
          final data = doc.data(); // Get the document data
          return Review.fromJson({
            ...data,
            'id': doc.id
          }); // Convert to Review and include the document ID
        }).toList();
      },
    );
  }
}
