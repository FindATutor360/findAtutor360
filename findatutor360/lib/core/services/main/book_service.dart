import 'dart:convert';
import 'dart:developer';
import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BooksService {
  Future<List<Book>> fetchBooks(String query);
  // Future<void> addBook(
  //   String title,
  //   String author,
  //   String description,
  //   String bookImage,
  //   String amount,
  //   String publisher,
  //   String category,
  //   String pageCount,
  // );

  Future<List<Book>> searchBooks(String query);
}

class BooksServiceImpl implements BooksService {
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

  // Add a new book (mockup as the real Google Books API doesn't support adding books)
  // @override
  // Future<void> addBook(
  //   String title,
  //   String author,
  //   String description,
  //   String bookImage,
  //   String amount,
  //   String publisher,
  //   String category,
  //   String pageCount,
  // ) async {
  //   // Mockup API request for adding a book
  //   const url = 'https://example.com/api/addBook';
  //   final response = await http.post(
  //     Uri.parse(url),
  //     body: jsonEncode({
  //       'title': title,
  //       'author': author,
  //       'description': description,
  //       'thumbnail': bookImage,
  //       'listPrice': amount,
  //     }),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to add book');
  //   }
  // }
}
