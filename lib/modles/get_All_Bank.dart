// To parse this JSON data, do
//
//     final getAllBankResponceModel = getAllBankResponceModelFromJson(jsonString);

import 'dart:convert';

GetAllBankResponceModel getAllBankResponceModelFromJson(String str) => GetAllBankResponceModel.fromJson(json.decode(str));

String getAllBankResponceModelToJson(GetAllBankResponceModel data) => json.encode(data.toJson());

class GetAllBankResponceModel {
  bool? success;
  String? message;
  List<TransectionAccount>? data;
  int? currentPage;
  int? page;

  GetAllBankResponceModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.page,
  });

  factory GetAllBankResponceModel.fromJson(Map<String, dynamic> json) => GetAllBankResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TransectionAccount>.from(json["data"]!.map((x) => TransectionAccount.fromJson(x))),
    currentPage: json["currentPage"],
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "page": page,
  };
}

class TransectionAccount {
  String? id;
  String? fullName;
  String? bankName;
  String? ifscCode;
  String? type;
  String? accountNumber;
  String? userId;
  String? upiId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TransectionAccount({
    this.id,
    this.fullName,
    this.bankName,
    this.ifscCode,
    this.type,
    this.accountNumber,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.upiId,
    this.v,
  });

  factory TransectionAccount.fromJson(Map<String, dynamic> json) => TransectionAccount(
    id: json["_id"],
    fullName: json["fullName"],
    bankName: json["bankName"],
    ifscCode: json["ifscCode"],
    upiId: json["upiId"],
    type: json["type"],
    accountNumber: json["accountNumber"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "bankName": bankName,
    "ifscCode": ifscCode,
    "type": type,
    'upiId':upiId,
    "accountNumber": accountNumber,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
