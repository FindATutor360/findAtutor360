// ignore_for_file: sdk_version_since

import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Abstract class defining the contract for book services
abstract class BooksService {
  /// Fetches a list of books from an external API based on a search query
  Future<List<Book>> fetchBooks(String query);

  /// Searches books by query (currently reuses fetchBooks)
  Future<List<Book>> searchBooks(String query);

  /// Adds a book to the Firestore database
  Future<Book?> addBook(
    String? title,
    String? authorName,
    String? description,
    String? image,
    String? price,
    String? publisher,
    String? category,
    String? smallImage,
    String? textSnippet,
  );
}

/// Implementation of the BooksService interface
class BooksServiceImpl implements BooksService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final User? _auth = FirebaseAuth.instance.currentUser;
  final String apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';

  /// Fetch a list of books from Google Books API
  @override
  Future<List<Book>> fetchBooks(String query) async {
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&key=$apiKey';

    // Make a GET request to the Google Books API
    final response = await http.get(Uri.parse(url));

    // If the request is successful
    if (response.statusCode == 200) {
      log(response.body, name: 'debug'); // Log the response for debugging
      final data = json.decode(response.body); // Parse the JSON response
      List books = data['items'] ?? []; // Extract the list of books
      // Map the book data to a list of Book objects
      return books.map((bookData) => Book.fromJson(bookData)).toList();
    } else {
      // Throw an exception if the request fails
      throw Exception('Failed to load books');
    }
  }

  /// Search for books (currently identical to fetchBooks)
  @override
  Future<List<Book>> searchBooks(String query) async {
    return fetchBooks(query); // Delegates to fetchBooks
  }

  /// Add a book to the Firestore database
  @override
  Future<Book?> addBook(
    String? title,
    String? authorName,
    String? description,
    String? image,
    String? price,
    String? publisher,
    String? category,
    String? smallImage,
    String? textSnippet,
  ) async {
    try {
      // Create a new Book object
      final bookData = Book(
        id: null,
        userId: _auth?.uid, // Set the current user's ID
        title: title,
        authorName: authorName,
        description: description,
        thumbnail: image,
        price: price,
        publisher: publisher,
        category: category,
        smallThumbnail: smallImage,
        textSnippet: textSnippet,
        createdAt: DateTime.now().toUtc(), // Use UTC timestamp
      );

      // Add the book to Firestore and retrieve the document reference
      DocumentReference docRef =
          await _fireStore.collection('Books').add(bookData.toJson());

      // Update the document with its ID
      await _fireStore
          .collection('Books')
          .doc(docRef.id)
          .update({'id': docRef.id});

      log("Book added to DB successfully!", name: 'debug');
    } catch (e) {
      // Log any errors that occur during the operation
      log("Error adding book to DB: $e", name: 'debug');
      rethrow; // Rethrow the error for further handling
    }
    return null; // Return null if no book is added
  }

  /// Fetches the list of books added by the current user
  Stream<List<Book>> fetchUserBooks() {
    try {
      return _fireStore
          .collection('Books') // Reference the 'Books' collection
          .where('userId',
              isEqualTo: _auth?.uid) // Filter by the current user's ID
          .orderBy('createdAt',
              descending: true) // Order by creation date (newest first)
          .snapshots() // Listen to real-time updates
          .map((snapshots) {
        // Map the snapshots to a list of Book objects
        List<Book> userBooks =
            snapshots.docs.map((doc) => Book.fromJson(doc.data())).toList();

        return userBooks; // Return the list of books
      });
    } catch (e) {
      // Log any errors that occur during the operation
      log("Error fetching user books: $e", name: 'debug');
      rethrow; // Rethrow the error for further handling
    }
  }
}
