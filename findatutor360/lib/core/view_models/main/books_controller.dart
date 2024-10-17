import 'dart:developer';

import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/services/main/book_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:flutter/material.dart';

class BooksController extends BaseProvider {
  final BooksServiceImpl _booksServiceImpl = locator.get<BooksServiceImpl>();
  List<Book> books = [];
  // bool isLoading = false;
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  int currentPage = 1;

  // Fetch all books (default or based on a query)
  Future<List<Book>> fetchBooks(String query) async {
    isLoading.value = true;
    // notifyListeners();

    try {
      books = await _booksServiceImpl.fetchBooks(query);

      isLoading.value = false;
      notifyListeners();
      log('Fetched ${books.length} books');
      return books;
    } catch (e) {
      isLoading.value = false;
      notifyListeners();
      log('Error fetching books: $e', name: 'debug');
      rethrow;
    }
  }

  // Add a new book
  // Future<void> addBook(String title, String author) async {
  //   try {
  //     await _booksServiceImpl.addBook(title, author);
  //     // Optionally refresh the book list after adding
  //     await fetchBooks();
  //   } catch (e) {
  //     print('Error adding book: $e');
  //   }
  // }
}
