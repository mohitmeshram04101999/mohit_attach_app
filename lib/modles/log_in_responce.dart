// To parse this JSON data, do
//
//     final logInResponceModel = logInResponceModelFromJson(jsonString);

import 'dart:convert';

LogInResponceModel logInResponceModelFromJson(String str) => LogInResponceModel.fromJson(json.decode(str));

String logInResponceModelToJson(LogInResponceModel data) => json.encode(data.toJson());

class LogInResponceModel {
  bool? success;
  String? message;
  int? otp;
  bool? check;
  DateTime? otpExpiry;

  LogInResponceModel({
    this.success,
    this.message,
    this.otp,
    this.check,
    this.otpExpiry,
  });

  factory LogInResponceModel.fromJson(Map<String, dynamic> json) => LogInResponceModel(
    success: json["success"],
    message: json["message"],
    otp: json["otp"],
    check: json["check"],
    otpExpiry: json["otpExpiry"] == null ? null : DateTime.parse(json["otpExpiry"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "otp": otp,
    "check": check,
    "otpExpiry": otpExpiry?.toIso8601String(),
  };
}
