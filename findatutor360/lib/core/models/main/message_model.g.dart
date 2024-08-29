// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      id: json['id'] as String?,
      senderEmail: json['senderEmail'] as String?,
      senderName: json['senderName'] as String?,
      senderPhotoUrl: json['senderPhotoUrl'] as String?,
      recipientPhotoUrl: json['recipientPhotoUrl'] as String?,
      recipientEmail: json['recipientEmail'] as String?,
      recipientName: json['recipientName'] as String?,
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      message: json['message'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      readBy:
          (json['readBy'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'id': instance.id,
      'senderEmail': instance.senderEmail,
      'senderName': instance.senderName,
      'senderPhotoUrl': instance.senderPhotoUrl,
      'recipientPhotoUrl': instance.recipientPhotoUrl,
      'recipientEmail': instance.recipientEmail,
      'recipientName': instance.recipientName,
      'participants': instance.participants,
      'message': instance.message,
      'createdAt': instance.createdAt?.toIso8601String(),
      'readBy': instance.readBy,
    };
