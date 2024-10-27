// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      actual_price_usd: (json['actual_price_usd'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      duration: json['duration'] as String?,
      day: json['day'] as String?,
      availability: (json['availability'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'image': instance.image,
      'name': instance.name,
      'actual_price_usd': instance.actual_price_usd,
      'description': instance.description,
      'category': instance.category,
      'duration': instance.duration,
      'day': instance.day,
      'availability': instance.availability,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      day: json['day'] as String?,
    );

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'day': instance.day,
    };
