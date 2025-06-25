





// To parse this JSON data, do
//
//     final notificationResponce = notificationResponceFromJson(jsonString);

import 'dart:convert';

NotificationResponce notificationResponceFromJson(String str) => NotificationResponce.fromJson(json.decode(str));

String notificationResponceToJson(NotificationResponce data) => json.encode(data.toJson());

class NotificationResponce {
  bool? success;
  String? message;
  List<NotificationModel>? data;

  NotificationResponce({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationResponce.fromJson(Map<String, dynamic> json) => NotificationResponce(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationModel {
  String? id;
  String? userId;
  String? title;
  String? message;
  bool? seen;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.seen,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["_id"],
    userId: json["userId"],
    title:  json["title"],
    message:  json["message"],
    seen: json["seen"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "message": message,
    "seen": seen,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}



