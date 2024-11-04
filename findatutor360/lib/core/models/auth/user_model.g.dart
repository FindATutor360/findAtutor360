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
      phoneNumber: json['phoneNumber'] as String?,
      dOB: json['dOB'] as String?,
      award: json['award'] as String?,
      awardDetails: json['awardDetails'] as String?,
      awardImageUrl: json['awardImageUrl'] as String?,
      backGround: json['backGround'] as String?,
      certImageUrl: json['certImageUrl'] as String?,
      certificate: json['certificate'] as String?,
      certificateDetails: json['certificateDetails'] as String?,
      college: json['college'] as String?,
      eduLevel: json['eduLevel'] as String?,
      sex: json['sex'] as String?,
    );

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'uId': instance.uId,
      'fullName': instance.fullName,
      'photoUrl': instance.photoUrl,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dOB': instance.dOB,
      'sex': instance.sex,
      'backGround': instance.backGround,
      'eduLevel': instance.eduLevel,
      'college': instance.college,
      'certificate': instance.certificate,
      'certificateDetails': instance.certificateDetails,
      'certImageUrl': instance.certImageUrl,
      'award': instance.award,
      'awardDetails': instance.awardDetails,
      'awardImageUrl': instance.awardImageUrl,
    };
