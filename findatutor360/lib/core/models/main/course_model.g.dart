// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      image: json['image'] as String?,
      name: json['name'] as String?,
      actual_price_usd: (json['actual_price_usd'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'actual_price_usd': instance.actual_price_usd,
      'description': instance.description,
      'category': instance.category,
    };
