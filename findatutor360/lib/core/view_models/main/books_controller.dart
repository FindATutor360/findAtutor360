// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/services/main/book_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:flutter/material.dart';

// Controller class for managing books, cart, and related operations
class BooksController extends BaseProvider {
  final BooksServiceImpl _booksServiceImpl = locator.get<BooksServiceImpl>();
  AppPreferences appPreferences = AppPreferences();

  List<Book> books = []; // List of all books
  List<Book> cart = []; // List of books added to the cart
  final ValueNotifier<bool> canLoadMore =
      ValueNotifier(false); // Controls pagination loading
  final ValueNotifier<bool> _isLoading =
      ValueNotifier(false); // Tracks loading state

  ValueNotifier<bool> get isLoading => _isLoading;
  int currentPage = 1; // Tracks the current page for pagination

  double totalPrice = 0.0; // Total price of items in the cart

  // Temporary variables to store book details before saving
  String? _title;
  String? _authorName;
  String? _description;
  String? _price;
  String? _publisher;
  String? _category;
  String? _image;
  String? _smallImage;
  String? _textSnippet;

  // Adds basic book details (title, author, description, price)
  Future<void> addBookBasicDetails(
    String? title,
    String? authorName,
    String? description,
    String? price,
    BuildContext context,
  ) async {
    _isLoading.value = true; // Set loading state
    try {
      _title = title;
      _authorName = authorName;
      _description = description;
      _price = price;
      _isLoading.value = false; // Reset loading state
      notifyListeners(); // Notify listeners of changes
      log("BookBasicDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false; // Reset loading state on error
      showSnackMessage(context, "Book Basic Details saved successfully",
          isError: true);
      throw Exception("Basic details are missing");
    }
  }

  // Adds publishing details for the book
  Future<void> addBookPublishDetails(
    String? publisher,
    String? textSnippet,
    String? category,
    BuildContext context,
  ) async {
    _isLoading.value = true; // Set loading state
    try {
      _publisher = publisher;
      _textSnippet = textSnippet;
      _category = category;
      _isLoading.value = false; // Reset loading state
      notifyListeners();
      log("BookPublishDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false; // Reset loading state on error
      log('Publishing details are missing', name: 'debug');
      showSnackMessage(context, "Publishing details are missing",
          isError: true);
      throw Exception("Publishing details are missing");
    }
  }

  // Adds book images
  Future<void> addBookImage(String? image, String? smallImage) async {
    _isLoading.value = true; // Set loading state
    try {
      _image = image;
      _smallImage = smallImage;
      _isLoading.value = false; // Reset loading state
      notifyListeners();
    } catch (e) {
      _isLoading.value = false; // Reset loading state on error
      throw Exception("Images are missing");
    }
  }

  // Saves the complete book details to the database
  Future<Book?> saveBookDetails(BuildContext context) async {
    _isLoading.value = true; // Set loading state
    if (_title == null ||
        _authorName == null ||
        _description == null ||
        _price == null) {
      _isLoading.value = false;
      throw Exception("Basic details are missing");
    }
    if (_publisher == null || _category == null) {
      _isLoading.value = false;
      throw Exception("Publishing details are missing");
    }

    try {
      await _booksServiceImpl.addBook(
        _title,
        _authorName,
        _description,
        _image,
        _price,
        _publisher,
        _category,
        _smallImage,
        _textSnippet,
      );
      _isLoading.value = false;
      log("Book saved successfully", name: "debug");
      resetBookDetails(); // Reset temporary variables after saving
    } catch (e) {
      _isLoading.value = false;
      log("Error saving book: $e", name: "debug");
      showSnackMessage(context, "Error saving book: $e", isError: true);
      rethrow;
    }
    return null;
  }

  // Resets all temporary book details
  void resetBookDetails() {
    _title = null;
    _authorName = null;
    _description = null;
    _price = null;
    _publisher = null;
    _category = null;
    _image = null;
    _smallImage = null;
    notifyListeners();
  }

  // Fetches books based on a query
  Future<List<Book>> fetchBooks(String query) async {
    _isLoading.value = true;
    try {
      books = await _booksServiceImpl.fetchBooks(query);
      _isLoading.value = false;
      notifyListeners();
      return books;
    } catch (e) {
      isLoading.value = false;
      notifyListeners();
      log('Error fetching books: $e', name: 'debug');
      rethrow;
    }
  }

  // Streams books added by a specific user
  Stream<List<Book>> fetchUserBooks() {
    return _booksServiceImpl.fetchUserBooks();
  }

  // Updates the quantity of a specific book in the cart
  void updateItemQuantity(Book book, int quantity) {
    int index = cart.indexOf(book);
    if (index != -1) {
      cart[index].quantity = quantity;
      notifyListeners();
    }
  }

  // Adds a book to the cart
  void addToCart(Book data, BuildContext context) async {
    bool isAlreadyInCart = cart.any((book) => book.id == data.id);
    if (!isAlreadyInCart) {
      cart.add(data);
      await appPreferences.setBool('addedToCart', true);
      log('Book added to cart: ${data.title}', name: 'debug');
      notifyListeners();
    } else {
      log('Book is already in the cart: ${data.title}', name: 'debug');
      showSnackMessage(context, "${data.title} Book is already in the cart",
          isError: true);
    }
  }

  // Removes a book from the cart
  void removeFromCart(Book book) async {
    cart.removeWhere((item) => item.id == book.id);
    await appPreferences.setBool('removedFromCart', true);
    notifyListeners();
  }

  // Clears all items from the cart
  void removeAllFromCart() async {
    cart.clear();
    notifyListeners();
  }

  // Updates the quantity of a book in the cart
  void updateBookQuantity(Book book, int newQuantity) {
    var bookInCart = cart.firstWhere((item) => item.id == book.id);
    bookInCart.quantity = newQuantity;
    notifyListeners();
  }

  // Returns the list of books in the cart
  List<Book> getCartBooks() {
    return cart;
  }
}
