// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String?,
      comment: json['comment'] as String?,
      rating: json['rating'],
      senderName: json['senderName'] as String?,
      profileImage: json['profileImage'] as String?,
      courseName: json['courseName'] as String?,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'comment': instance.comment,
      'rating': instance.rating,
      'senderName': instance.senderName,
      'profileImage': instance.profileImage,
      'courseName': instance.courseName,
    };
