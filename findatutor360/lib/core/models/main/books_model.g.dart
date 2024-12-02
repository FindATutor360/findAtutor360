// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title:
          json['volumeInfo']?['title'] as String? ?? json['title'] as String?,
      author: (json['volumeInfo']?['authors'] as List<dynamic>?)?.join(', ') ??
          (json['authors'] as List<dynamic>?)?.join(', '),
      authorName: json['authorName'] as String?,
      price: json['price'] as String?,
      description: json['volumeInfo']?['description'] as String? ??
          json['description'] as String?,
      thumbnail: json['volumeInfo']?['imageLinks']?['thumbnail'] as String? ??
          json['thumbnail'] as String?,
      publisher: json['volumeInfo']?['publisher'] as String? ??
          json['publisher'] as String?,
      category:
          (json['volumeInfo']?['categories'] as List<dynamic>?)?.join(', ') ??
              (json['categories'] as List<dynamic>?)?.join(', '),
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
      'authorName': instance.authorName,
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
