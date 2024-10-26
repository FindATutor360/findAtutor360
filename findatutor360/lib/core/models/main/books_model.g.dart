// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
