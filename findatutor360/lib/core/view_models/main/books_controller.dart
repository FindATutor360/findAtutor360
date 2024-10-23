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
  // bool isLoading = false;
  final ValueNotifier<bool> canLoadMore = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  int currentPage = 1;

  double totalPrice = 0.0;

  // Fetch all books (default or based on a query)
  Future<List<Book>> fetchBooks(String query) async {
    isLoading.value = true;
    // notifyListeners();

    try {
      books = await _booksServiceImpl.fetchBooks(query);

      isLoading.value = false;
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
