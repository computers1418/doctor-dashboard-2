// To parse this JSON data, do
//
//     final phoneEmailConsultModel = phoneEmailConsultModelFromJson(jsonString);

import 'dart:convert';

PhoneEmailConsultModel phoneEmailConsultModelFromJson(String str) =>
    PhoneEmailConsultModel.fromJson(json.decode(str));

String phoneEmailConsultModelToJson(PhoneEmailConsultModel data) =>
    json.encode(data.toJson());

class PhoneEmailConsultModel {
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? meds;
  List<String>? test;
  List<String>? problem;
  List<String>? surgery;
  int? otpAttempts;
  dynamic otpCooldownExpiresAt;
  String? id;
  String? name;
  String? doctorId;
  DateTime? dateTime;
  String? modeOfPayment;
  String? phoneNumber;
  String? emailId;
  String? userId;
  DateTime? otpSentAt;
  int? v;

  PhoneEmailConsultModel({
    this.createdAt,
    this.updatedAt,
    this.meds,
    this.test,
    this.problem,
    this.surgery,
    this.otpAttempts,
    this.otpCooldownExpiresAt,
    this.id,
    this.name,
    this.doctorId,
    this.dateTime,
    this.modeOfPayment,
    this.phoneNumber,
    this.emailId,
    this.userId,
    this.otpSentAt,
    this.v,
  });

  factory PhoneEmailConsultModel.fromJson(Map<String, dynamic> json) =>
      PhoneEmailConsultModel(
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        meds: json["meds"] == null
            ? []
            : List<String>.from(json["meds"]!.map((x) => x)),
        test: json["test"] == null
            ? []
            : List<String>.from(json["test"]!.map((x) => x)),
        problem: json["problem"] == null
            ? []
            : List<String>.from(json["problem"]!.map((x) => x)),
        surgery: json["surgery"] == null
            ? []
            : List<String>.from(json["surgery"]!.map((x) => x)),
        otpAttempts: json["otpAttempts"],
        otpCooldownExpiresAt: json["otpCooldownExpiresAt"],
        id: json["_id"],
        name: json["name"],
        doctorId: json["doctorId"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        modeOfPayment: json["modeOfPayment"],
        phoneNumber: json["phoneNumber"],
        emailId: json["emailId"],
        userId: json["userId"],
        otpSentAt: json["otpSentAt"] == null
            ? null
            : DateTime.parse(json["otpSentAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "meds": meds == null ? [] : List<dynamic>.from(meds!.map((x) => x)),
        "test": test == null ? [] : List<dynamic>.from(test!.map((x) => x)),
        "problem":
            problem == null ? [] : List<dynamic>.from(problem!.map((x) => x)),
        "surgery":
            surgery == null ? [] : List<dynamic>.from(surgery!.map((x) => x)),
        "otpAttempts": otpAttempts,
        "otpCooldownExpiresAt": otpCooldownExpiresAt,
        "_id": id,
        "name": name,
        "doctorId": doctorId,
        "dateTime": dateTime?.toIso8601String(),
        "modeOfPayment": modeOfPayment,
        "phoneNumber": phoneNumber,
        "emailId": emailId,
        "userId": userId,
        "otpSentAt": otpSentAt?.toIso8601String(),
        "__v": v,
      };
}
