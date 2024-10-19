// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart'; // This will be generated

@JsonSerializable()
class Course {
  final String? image;
  final String? name;
  final double? actual_price_usd;
  final String? description;
  final String? category;

  Course({
    this.image,
    this.name,
    this.actual_price_usd,
    this.description,
    this.category,
  });

  // Factory method for creating a Course instance from JSON
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  // Method for converting a Course instance to JSON
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
