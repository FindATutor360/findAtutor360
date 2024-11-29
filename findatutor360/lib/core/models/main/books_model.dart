import 'package:json_annotation/json_annotation.dart';

part 'books_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Book {
  final String? id;
  final String? userId;
  final String? title;
  final String? author;
  final String? price;
  final String? description;
  final String? thumbnail;
  final String? publisher;
  final String? category;
  final int? pageCount;
  final String? textSnippet;
  final String? smallThumbnail;
  int quantity;
  final DateTime? createdAt;

  Book({
    this.id,
    this.userId,
    this.title,
    this.author,
    this.price,
    this.description,
    this.thumbnail,
    this.publisher,
    this.category,
    this.pageCount,
    this.textSnippet,
    this.smallThumbnail,
    this.quantity = 1,
    this.createdAt,
  });

  /// Factory constructor for creating a new `Book` instance from a map.
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  /// Method for converting a `Book` instance to a map.
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class UserBooks {
  final String? id;
  final String? userId;
  final String? title;
  final String? author;
  final String? description;
  final String? image;
  final String? price;
  final String? publisher;
  final String? category;
  final String? smallImage;
  final int quantity;
  final DateTime? createdAt;

  UserBooks({
    this.id,
    this.userId,
    this.title,
    this.author,
    this.description,
    this.image,
    this.price,
    this.publisher,
    this.category,
    this.createdAt,
    this.smallImage,
    this.quantity = 1,
  });

  factory UserBooks.fromJson(Map<String, dynamic> json) =>
      _$UserBooksFromJson(json);

  Map<String, dynamic> toJson() => _$UserBooksToJson(this);
}
