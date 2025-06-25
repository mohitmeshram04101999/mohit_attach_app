// To parse this JSON data, do
//
//     final allLanguageResponceModel = allLanguageResponceModelFromJson(jsonString);

import 'dart:convert';

AllLanguageResponceModel allLanguageResponceModelFromJson(String str) => AllLanguageResponceModel.fromJson(json.decode(str));

String allLanguageResponceModelToJson(AllLanguageResponceModel data) => json.encode(data.toJson());

class AllLanguageResponceModel {
  bool? success;
  String? message;
  List<Language>? data;

  AllLanguageResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory AllLanguageResponceModel.fromJson(Map<String, dynamic> json) => AllLanguageResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Language>.from(json["data"]!.map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Language {
  String? id;
  String? name;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  Language({
    this.id,
    this.name,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["_id"],
    name: json["name"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
