// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_model.dart';

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title:
          json['volumeInfo']?['title'] as String? ?? json['title'] as String?,
      author: (json['volumeInfo']?['authors'] as List<dynamic>?)?.join(', ') ??
          json['authors'] as String?,
      price: json['price'] as String?,
      description: json['volumeInfo']?['description'] as String? ??
          json['description'] as String?,
      thumbnail: json['volumeInfo']?['imageLinks']?['thumbnail'] as String? ??
          json['thumbnail'] as String?,
      publisher: json['volumeInfo']?['publisher'] as String? ??
          json['publisher'] as String?,
      category:
          (json['volumeInfo']?['categories'] as List<dynamic>?)?.join(', ') ??
              json['categories'] as String?,
      pageCount: json['volumeInfo']?['pageCount'] as int? ?? 0,
      textSnippet: json['searchInfo']?['textSnippet'] as String? ??
          json['textSnippet'] as String?,
      smallThumbnail:
          json['volumeInfo']?['imageLinks']?['smallThumbnail'] as String? ??
              json['smallThumbnail'] as String?,
      quantity: 1,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'author': instance.author,
      'price': instance.price,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'publisher': instance.publisher,
      'category': instance.category,
      'pageCount': instance.pageCount,
      'textSnippet': instance.textSnippet,
      'smallThumbnail': instance.smallThumbnail,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

UserBooks _$UserBooksFromJson(Map<String, dynamic> json) => UserBooks(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      author: json['author'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      publisher: json['publisher'] as String?,
      category: json['category'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      smallImage: json['smallImage'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$UserBooksToJson(UserBooks instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'publisher': instance.publisher,
      'category': instance.category,
      'smallImage': instance.smallImage,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
