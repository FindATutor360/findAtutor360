import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class Messages {
  final String? id;
  final String? senderEmail;
  final String? senderName;
  final String? senderPhotoUrl;
  final String? recipientPhotoUrl;
  final String? recipientEmail;
  final String? recipientName;
  final List<String>? participants;
  final String? message;
  final DateTime? createdAt;
  late final bool? readBy;

  Messages({
    this.id,
    this.senderEmail,
    this.senderName,
    this.senderPhotoUrl,
    this.recipientPhotoUrl,
    this.recipientEmail,
    this.recipientName,
    this.participants,
    this.message,
    this.createdAt,
    this.readBy = false,
  });

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}
