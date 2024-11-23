import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'review_model.g.dart';

@JsonSerializable()
class Review {
  String? id;
  dynamic createdAt;
  String? comment;
  dynamic rating;
  String? senderName;
  String? profileImage;
  String? courseName;
  Review({
    this.id,
    this.comment,
    this.rating,
    this.senderName,
    this.profileImage,
    this.courseName,
    this.createdAt,

    // ignore: invalid_annotation_target
    @JsonKey(includeFromJson: false) QueryDocumentSnapshot? snapshot,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  // Method for converting a Course instance to JSON
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
