import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class Users {
  final String? uId;
  final String? fullName;
  final String? photoUrl;
  final String? email;

  Users({
    this.uId,
    this.fullName,
    this.photoUrl,
    this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
