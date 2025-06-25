// To parse this JSON data, do
//
//     final chatContact = chatContactFromJson(jsonString);

import 'dart:convert';

import 'package:attach/modles/home_data_responce_model.dart';

List<ChatContact> chatContactFromJson(String str) => List<ChatContact>.from(json.decode(str).map((x) => ChatContact.fromJson(x)));

String chatContactToJson(List<ChatContact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatContact {
  String? id;
  ErId? userId;
  ErId? adminId;
  ErId? listenerId;
  ErId? user;
  bool? isActive;
  LastMessage? lastMessage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? unseenCount;

  ChatContact({
    this.id,
    this.userId,
    this.adminId,
    this.listenerId,
    this.isActive,
    this.lastMessage,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.v,
    this.unseenCount,
  });

  factory ChatContact.fromJson(Map<String, dynamic> json) => ChatContact(
    id: json["_id"],
    userId: json["userId"] == null ? null : ErId.fromJson(json["userId"]),
    adminId: json["adminId"]== null ? null : ErId.fromJson(json["adminId"]),
    listenerId: json["listenerId"] == null ? null : ErId.fromJson(json["listenerId"]),
    user: json["user"] == null ? null : ErId.fromJson(json["user"]),
    isActive: json["isActive"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    unseenCount: json["unseenCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "adminId": adminId?.toJson(),
    "listenerId": listenerId?.toJson(),
    "isActive": isActive,
    "lastMessage": lastMessage?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    'user':user?.toJson(),
    "__v": v,
    "unseenCount": unseenCount,
  };
}

class LastMessage {
  String? id;
  Sender? sender;
  bool? seen;
  String? message;
  String? media;
  String? mediaType;
  String? status;
  DateTime? createdAt;

  LastMessage({
    this.id,
    this.sender,
    this.seen,
    this.message,
    this.media,
    this.mediaType,
    this.status,
    this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    seen: json["seen"],
    message: json["message"],
    media: json["media"],
    mediaType: json["mediaType"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender?.toJson(),
    "seen": seen,
    "message": message,
    "media": media,
    "mediaType": mediaType,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Sender {
  String? id;
  String? name;

  Sender({
    this.id,
    this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class ErId {
  String? id;
  String? image;
  String? name;
  bool? userVerified;
  String? userType;
  bool? online;
  bool? isBusy;
  DateTime? lastSeen;
  SetAvailability? setAvailability;

  ErId({
    this.id,
    this.name,
    this.isBusy,
    this.image,
    this.userVerified,
    this.userType,
    this.online,
    this.lastSeen,
    this.setAvailability
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
    id: json["_id"],
    name: json["name"],
    isBusy: json["isBusy"],
    image: json["image"],
    userVerified: json["userVerified"],
    userType: json["userType"],
    online: json["online"],
    lastSeen: json["lastSeen"]==null?null:DateTime.parse(json["lastSeen"]),
    setAvailability: json["setAvailability"] == null ? null : SetAvailability.fromJson(json["setAvailability"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    'image':image,
    "userVerified": userVerified,
    "userType": userType,
    "online": online,
    "lastSeen": lastSeen,
    "setAvailability": setAvailability?.toJson(),
  };
}
