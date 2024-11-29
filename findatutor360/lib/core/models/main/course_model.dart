// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart'; // This will be generated

@JsonSerializable()
class Course {
  String? id;
  String? userId;
  String? userEmail;
  String? image;
  String? name;
  double? actualPriceUsd;
  String? description;
  String? category;
  String? duration;
  String? url;
  final String? day;
  List<String>? availability;
  final int quantity;
  final DateTime? createdAt;

  Course({
    this.id,
    this.userId,
    this.userEmail,
    this.image,
    this.name,
    this.actualPriceUsd,
    this.description,
    this.category,
    this.duration,
    this.url,
    this.day,
    this.availability,
    this.createdAt,
    this.quantity = 1,
  });

  // Factory method for creating a Course instance from JSON
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  // Method for converting a Course instance to JSON
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

@JsonSerializable()
class Availability {
  final String? startTime;
  final String? endTime;
  final String? day;

  Availability({
    this.startTime,
    this.endTime,
    this.day,
  });

  // Factory method for creating a Availability instance from JSON
  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  // Method for converting a Availability instance to JSON
  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}
