import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/review_model.dart';
import 'package:findatutor360/core/view_models/main/review_controller.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class ReviewService {
  Future<void> saveReview(
    String? courseName,
    String? comment,
    String? page,
    dynamic rating,
    BuildContext context,
  );
  Stream<List<Review>> fetchReviews(String courseName);
}

class ReviewServiceImpl implements ReviewService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> saveReview(
    String? courseName,
    String? comment,
    String? page,
    dynamic rating,
    BuildContext context,
  ) async {
    final name = normalizeCourseName(courseName);
    Review review = Review(
      id: null,
      comment: comment!,
      rating: rating,
      courseName: name,
      senderName: _auth.currentUser?.displayName,
      profileImage: _auth.currentUser?.photoURL,
      createdAt: null,
    );

    final reviewsCollection = _fireStore.collection('Reviews');

    // Check for existing reviews with the same courseName and senderName
    final existingReview = await reviewsCollection
        .where('courseName', isEqualTo: name)
        .where('senderName', isEqualTo: review.senderName)
        .limit(1)
        .get();

    if (existingReview.docs.isNotEmpty) {
      // Show a message if the review already exists
      showSnackMessage(
        // ignore: use_build_context_synchronously
        context,
        "You have already submitted a review for this $page.",
        isError: true,
      );
      throw Exception('You have already submitted a review for this $page.');
    }

    final docRef = reviewsCollection.doc();
    review.id = docRef.id;
    await docRef.set({
      ...review.toJson(),
      // ignore: sdk_version_since
      'createdAt': DateTime.timestamp().toUtc(),
    });
  }

  @override
  Stream<List<Review>> fetchReviews(String courseName) {
    final name = normalizeCourseName(courseName);
    final reviewsCollection = _fireStore.collection('Reviews');

    return reviewsCollection
        .where('courseName', isEqualTo: name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Review.fromJson({...data, 'id': doc.id});
        }).toList();
      },
    );
  }
}
