import 'package:json_annotation/json_annotation.dart';

part 'tutors_model.g.dart';

@JsonSerializable()
class TutorData {
  final List<Data>? data;
  TutorData({this.data});

  // Factory method to parse JSON into a Dart object
  factory TutorData.fromJson(Map<String, dynamic> json) =>
      _$TutorDataFromJson(json);

  // Method to convert Dart object into JSON
  Map<String, dynamic> toJson() => _$TutorDataToJson(this);
}

@JsonSerializable()
class Data {
  String? tutorName;
  String? tutorImage;
  String? location;
  String? ratings;
  String? status;
  String? description;
  String? pricing;
  String? source;

  Data({
    this.tutorName,
    this.tutorImage,
    this.location,
    this.ratings,
    this.status,
    this.description,
    this.pricing,
    this.source,
  });

  /// Factory method for JSON deserialization
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  /// Method for JSON serialization
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
