// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) => Users(
      uId: json['uId'] as String?,
      fullName: json['fullName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'uId': instance.uId,
      'fullName': instance.fullName,
      'photoUrl': instance.photoUrl,
      'email': instance.email,
    };
