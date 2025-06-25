// To parse this JSON data, do
//
//     final allTransectionResponceModel = allTransectionResponceModelFromJson(jsonString);

import 'dart:convert';

AllTransectionResponceModel allTransectionResponceModelFromJson(String str) => AllTransectionResponceModel.fromJson(json.decode(str));

String allTransectionResponceModelToJson(AllTransectionResponceModel data) => json.encode(data.toJson());

class AllTransectionResponceModel {
  bool? success;
  String? message;
  List<TransectionInfo>? data;
  int? currentPage;
  int? page;

  AllTransectionResponceModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.page,
  });

  factory AllTransectionResponceModel.fromJson(Map<String, dynamic> json) => AllTransectionResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TransectionInfo>.from(json["data"]!.map((x) => TransectionInfo.fromJson(x))),
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

class TransectionInfo {
  String? id;
  String? userId;
  String? amount;
  String? type;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? TypeCheck;
  AmountCutId? amountCutId;

  TransectionInfo({
    this.id,
    this.userId,
    this.amount,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.TypeCheck,
    this.amountCutId
  });

  factory TransectionInfo.fromJson(Map<String, dynamic> json) => TransectionInfo(
    id: json["_id"],
    userId: json["userId"],
    amount: json["amount"],
    type:  json["Type"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    TypeCheck: json["TypeCheck"],
    amountCutId: json["AmountCutId"] == null ? null : AmountCutId.fromJson(json["AmountCutId"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "amount": amount,
    "Type":  type,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "TypeCheck": TypeCheck,
    "AmountCutId": amountCutId?.toJson(),
  };
}



class AmountCutId {
  String? id;
  String? name;
  String? image;

  AmountCutId({
    this.id,
    this.name,
    this.image,
  });

  factory AmountCutId.fromJson(Map<String, dynamic> json) => AmountCutId(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
  };
}



class TransectionStatuse
{
  static String approved = "APPROVED";
  static String panding = '"PENDING"';

}


class TransectionTypeCheck
{
  static String approved = "OTHER";
  static String panding = 'USER';

}

class TransectionType
{
  static String CREDIT = 'CREDIT';
  static String DEBIT = 'DEBIT';
}





