import 'dart:developer';

import 'package:findatutor360/core/models/main/books_model.dart';
import 'package:findatutor360/core/services/main/book_service.dart';
import 'package:findatutor360/theme/index.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BooksController extends BaseProvider {
  final BooksServiceImpl _booksServiceImpl = locator.get<BooksServiceImpl>();

  AppPreferences appPreferences = AppPreferences();
  List<Book> books = [];
  List<Book> cart = [];
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get isLoading => _isLoading;
  int currentPage = 1;

  double totalPrice = 0.0;

  String? _title;
  String? _author;
  String? _description;
  String? _price;
  String? _publisher;
  String? _category;
  String? _image;
  String? _smallImage;

  Future<void> addBookBasicDetails(
      String? title, String? author, String? description, String? price) async {
    _isLoading.value = true;
    try {
      _title = title;
      _author = author;
      _description = description;
      _price = price;
      _isLoading.value = false;
      notifyListeners();
      log("BookBasicDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false;
      throw Exception("Basic details are missing");
    }
  }

  Future<void> addBookPublishDetails(
      String? publisher, String? category) async {
    _isLoading.value = true;
    try {
      _publisher = publisher;
      _category = category;
      _isLoading.value = false;
      notifyListeners();
      log("BookPublishDetails saved successfully", name: "debug");
    } catch (e) {
      _isLoading.value = false;
      log('Publishing details are missing', name: 'debug');
      throw Exception("Publishing details are missing");
    }
  }

  Future<void> addBookImage(String? image, String? smallImage) async {
    _isLoading.value = true;
    try {
      _image = image;
      _smallImage = smallImage;
      _isLoading.value = false;
      notifyListeners();
    } catch (e) {
      _isLoading.value = false;
      throw Exception("Images are missing");
    }
  }

  Future<void> saveBookDetails() async {
    _isLoading.value = true;
    if (_title == null ||
        _author == null ||
        _description == null ||
        _price == null) {
      _isLoading.value = false;
      throw Exception("Basic details are missing");
    }
    if (_publisher == null || _category == null) {
      _isLoading.value = false;
      throw Exception("Publishing details are missing");
    }
    if (_image == null) {
      _isLoading.value = false;
      throw Exception("Images are missing");
    }

    // Attempt to save the complete book details to the database
    try {
      await _booksServiceImpl.addBook(
        _title,
        _author,
        _description,
        _image,
        _price,
        _publisher,
        _category,
        _smallImage,
      );
      _isLoading.value = false;
      log("Book saved successfully", name: "debug");
      resetBookDetails();
    } catch (e) {
      _isLoading.value = false;
      log("Error saving book: $e", name: "debug");
      rethrow;
    }
  }

  void resetBookDetails() {
    _title = null;
    _author = null;
    _description = null;
    _price = null;
    _publisher = null;
    _category = null;
    _image = null;
    _smallImage = null;
    notifyListeners();
  }

  // Fetch all books (default or based on a query)
  Future<List<Book>> fetchBooks(String query) async {
    _isLoading.value = true;
    // notifyListeners();

    try {
      books = await _booksServiceImpl.fetchBooks(query);

      _isLoading.value = false;
      notifyListeners();
      // log('Fetched ${books.length} books');
      return books;
    } catch (e) {
      isLoading.value = false;
      notifyListeners();
      log('Error fetching books: $e', name: 'debug');
      rethrow;
    }
  }

  Stream<List<UserBooks>> fetchUserBooks() {
    return _booksServiceImpl.fetchUserBooks();
  }

  // Add a method to change item quantity
  void updateItemQuantity(Book book, int quantity) {
    int index = cart.indexOf(book);
    if (index != -1) {
      cart[index].quantity = quantity;
      notifyListeners();
    }
  }

  void addToCart(Book data) async {
    bool isAlreadyInCart = cart.any((book) => book.id == data.id);

    if (!isAlreadyInCart) {
      cart.add(data);
      await appPreferences.setBool('addedToCart', true);
      log('Book added to cart: ${data.title}', name: 'debug');
      notifyListeners();
    } else {
      log('Book is already in the cart: ${data.title}', name: 'debug');
      Fluttertoast.showToast(
        msg: "${data.title} Book is already in the cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: customTheme['primaryColor'],
        textColor: customTheme['whiteColor'],
        fontSize: 16.0,
      );
    }
  }

  void removeFromCart(Book book) async {
    cart.removeWhere((item) => item.id == book.id);
    await appPreferences.setBool('removedFromCart', true);
    notifyListeners();
  }

  void updateBookQuantity(Book book, int newQuantity) {
    var bookInCart = cart.firstWhere((item) => item.id == book.id);
    bookInCart.quantity = newQuantity;
    notifyListeners();
  }

  // Get the list of books in the cart
  List<Book> getCartBooks() {
    return cart;
  }
}
