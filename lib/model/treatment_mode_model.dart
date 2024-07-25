import 'dart:convert';

TreatmentModeModel treatmentModeFromJson(String str) =>
    TreatmentModeModel.fromJson(json.decode(str));

String treatmentModeToJson(TreatmentModeModel data) => json.encode(data.toJson());

class TreatmentModeModel {
  final Data data;
  final int status;
  final String type;
  final String message;

  TreatmentModeModel({
    required this.data,
    required this.status,
    required this.type,
    required this.message,
  });

  factory TreatmentModeModel.fromJson(Map<String, dynamic> json) => TreatmentModeModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "type": type,
        "message": message,
      };
}

class Data {
  final List<String> treatmentMode;
  final String id;
  final String doctorId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.treatmentMode,
    required this.id,
    required this.doctorId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        treatmentMode: List<String>.from(json["treatmentMode"].map((x) => x)),
        id: json["_id"],
        doctorId: json["doctorId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "treatmentMode": List<dynamic>.from(treatmentMode.map((x) => x)),
        "_id": id,
        "doctorId": doctorId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
