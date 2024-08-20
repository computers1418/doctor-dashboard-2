// To parse this JSON data, do
//
//     final medicineModel = medicineModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<MedicineModel> medicineModelFromJson(String str) =>
    List<MedicineModel>.from(
        json.decode(str).map((x) => MedicineModel.fromJson(x)));

String medicineModelToJson(List<MedicineModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicineModel {
  final bool isActive;
  final bool isDeleted;
  final String id;
  final String doctorId;
  final String medicineName;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MedicineModel({
    required this.isActive,
    required this.isDeleted,
    required this.id,
    required this.doctorId,
    required this.medicineName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        id: json["_id"],
        doctorId: json["doctorId"],
        medicineName: json["medicineName"],
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
        "medicineName": medicineName,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
