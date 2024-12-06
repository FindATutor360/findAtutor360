// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutors_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorData _$TutorDataFromJson(Map<String, dynamic> json) => TutorData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorDataToJson(TutorData instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tutorName: json['tutor_name'] as String?,
      tutorImage: json['tutor_image'] as String?,
      location: json['location'] as String?,
      ratings: json['ratings'] as String?,
      status: json['status'] as String?,
      description: json['description'] as String?,
      pricing: json['pricing'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tutorName': instance.tutorName,
      'tutorImage': instance.tutorImage,
      'location': instance.location,
      'ratings': instance.ratings,
      'status': instance.status,
      'description': instance.description,
      'pricing': instance.pricing,
      'source': instance.source,
    };
