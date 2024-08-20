// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TestModel> testModelFromJson(String str) =>
    List<TestModel>.from(json.decode(str).map((x) => TestModel.fromJson(x)));

String testModelToJson(List<TestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestModel {
  final bool isActive;
  final bool isDeleted;
  final String id;
  final String doctorId;
  final String testName;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  TestModel({
    required this.isActive,
    required this.isDeleted,
    required this.id,
    required this.doctorId,
    required this.testName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        doctorId: json["doctorId"] ?? "",
        testName: json["testName"] ?? "",
        price: json["price"] ?? "",
        createdAt:
            DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt:
            DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "doctorId": doctorId,
        "testName": testName,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
