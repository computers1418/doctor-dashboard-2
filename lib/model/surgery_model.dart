// To parse this JSON data, do
//
//     final surgeryModel = surgeryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SurgeryModel> surgeryModelFromJson(String str) => List<SurgeryModel>.from(
    json.decode(str).map((x) => SurgeryModel.fromJson(x)));

String surgeryModelToJson(List<SurgeryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SurgeryModel {
  final bool isActive;
  final bool isDeleted;
  final String id;
  final String doctorId;
  final String surgeryName;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SurgeryModel({
    required this.isActive,
    required this.isDeleted,
    required this.id,
    required this.doctorId,
    required this.surgeryName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SurgeryModel.fromJson(Map<String, dynamic> json) => SurgeryModel(
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        doctorId: json["doctorId"],
        surgeryName: json["surgeryName"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "doctorId": doctorId,
        "surgeryName": surgeryName,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
