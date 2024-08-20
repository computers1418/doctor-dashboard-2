import 'dart:convert';

List<SetProblemModel> setProblemModelFromJson(String str) =>
    List<SetProblemModel>.from(
        json.decode(str).map((x) => SetProblemModel.fromJson(x)));

String setProblemModelToJson(List<SetProblemModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SetProblemModel {
  final bool isActive;
  final bool isDeleted;
  final String id;
  final String doctorId;
  final String problemName;
  final String price;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SetProblemModel({
    required this.isActive,
    required this.isDeleted,
    required this.id,
    required this.doctorId,
    required this.problemName,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SetProblemModel.fromJson(Map<String, dynamic> json) =>
      SetProblemModel(
        isActive: json["isActive"] ?? false,
        isDeleted: json["isDeleted"] ?? false,
        id: json["_id"] ?? "",
        doctorId: json["doctorId"] ?? "",
        problemName: json["problemName"] ?? "",
        price: json["price"] ?? "",
        description: json["description"]  ?? "",
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
        updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "isDeleted": isDeleted,
        "_id": id,
        "doctorId": doctorId,
        "problemName": problemName,
        "price": price,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
