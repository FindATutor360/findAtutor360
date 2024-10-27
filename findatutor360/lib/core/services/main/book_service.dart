// ignore_for_file: sdk_version_since

import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BooksService {
  Future<List<Book>> fetchBooks(String query);

  Future<List<Book>> searchBooks(String query);

  Future<void> addBook(
    String? title,
    String? author,
    String? description,
    String? image,
    String? price,
    String? publisher,
    String? category,
    String? smallImage,
  );
}

class BooksServiceImpl implements BooksService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? _auth = FirebaseAuth.instance.currentUser;
  final String apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';

  // Fetch a list of books
  @override
  Future<List<Book>> fetchBooks(String query) async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log(response.body, name: 'debug');
      final data = json.decode(response.body);
      List books = data['items'] ?? [];
      return books.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Search books by query
  @override
  Future<List<Book>> searchBooks(String query) async {
    return fetchBooks(query); // Same as fetchBooks for now
  }

  @override
  Future<void> addBook(
    String? title,
    String? author,
    String? description,
    String? image,
    String? price,
    String? publisher,
    String? category,
    String? smallImage,
  ) async {
    try {
      final bookData = UserBooks(
        id: null,
        userId: _auth?.uid,
        title: title,
        author: author,
        description: description,
        image: image,
        price: price,
        publisher: publisher,
        category: category,
        smallImage: smallImage,
        createdAt: DateTime.now().toUtc(),
      );

      DocumentReference docRef =
          await _fireStore.collection('Books').add(bookData.toJson());
      await _fireStore
          .collection('Books')
          .doc(docRef.id)
          .update({'id': docRef.id});
      log("Book added to DB successfully!", name: 'debug');
    } catch (e) {
      log("Error adding book to DB: $e", name: 'debug');
      rethrow;
    }
  }

  Stream<List<UserBooks>> fetchUserBooks() {
    try {
      return _fireStore
          .collection('Books')
          .where('userId', isEqualTo: _auth?.uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshots) {
        List<UserBooks> userBooks = snapshots.docs
            .map((doc) => UserBooks.fromJson(doc.data()))
            .toList();

        return userBooks;
      });
    } catch (e) {
      log("Error fetching user books: $e", name: 'debug');
      rethrow;
    }
  }
}
