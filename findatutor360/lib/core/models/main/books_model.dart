import 'package:json_annotation/json_annotation.dart';

part 'books_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Book {
  String? id;
  String? userId;
  String? title;
  String? authorName;
  String? author;
  String? price;
  String? description;
  String? thumbnail;
  String? publisher;
  String? category;
  int? pageCount;
  String? textSnippet;
  String? smallThumbnail;
  int quantity;
  DateTime? createdAt;

  Book({
    this.id,
    this.userId,
    this.title,
    this.author,
    this.authorName,
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
