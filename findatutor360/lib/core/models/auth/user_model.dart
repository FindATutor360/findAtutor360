import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class Users {
  final String? uId;
  final String? fullName;
  final String? photoUrl;
  final String? email;
  final String? phoneNumber;
  final String? dOB;
  final String? sex;
  final String? backGround;
  final String? eduLevel;
  final String? college;
  final String? certificate;
  final String? certificateDetails;
  final String? certImageUrl;
  final String? award;
  final String? awardDetails;
  final String? awardImageUrl;
  final bool emailVerified;

  Users({
    this.uId,
    this.fullName,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.dOB,
    this.award,
    this.awardDetails,
    this.awardImageUrl,
    this.backGround,
    this.certImageUrl,
    this.certificate,
    this.certificateDetails,
    this.college,
    this.eduLevel,
    this.sex,
    this.emailVerified = false,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}
