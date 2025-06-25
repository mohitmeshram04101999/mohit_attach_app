// To parse this JSON data, do
//
//     final loadChatResponce = loadChatResponceFromJson(jsonString);

import 'dart:convert';

import 'package:attach/modles/chat_contect_model.dart';

LoadChatResponce loadChatResponceFromJson(String str) => LoadChatResponce.fromJson(json.decode(str));

String loadChatResponceToJson(LoadChatResponce data) => json.encode(data.toJson());


class LoadChatResponce {
  String? threadId;
  List<Message>? messages;
  ErId? user;


  LoadChatResponce({
    this.threadId,
    this.messages,
    this.user,
  });

  factory LoadChatResponce.fromJson(Map<String, dynamic> json) => LoadChatResponce(
    threadId: json["threadId"],
    messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromJson(x))),
    user:   json["user"] == null ? null : ErId.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "threadId": threadId,
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class Message {
  String? id;
  String? threadId;
  String? sender;
  bool? seen;
  String? message;
  String? media;
  String? mediaType;
  CallHistoryInChat? callHistory;
  String? status;
  DateTime? deliveredAt;
  DateTime? seenAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? messageType;  // CALLHISTORY,SIMPLE_MESSAGE,

  Message({
    this.id,
    this.threadId,
    this.sender,
    this.seen,
    this.message,
    this.media,
    this.mediaType,
    this.callHistory,
    this.status,
    this.deliveredAt,
    this.seenAt,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.messageType,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["_id"],
    threadId: json["threadId"],
    sender: json["sender"],
    seen: json["seen"],
    message: json["message"],
    media: json["media"],
    mediaType: json["mediaType"],
    callHistory: json["callHistory"] == null ? null : CallHistoryInChat.fromJson(json["callHistory"]),
    status: json["status"],
    deliveredAt: json["deliveredAt"] == null ? null : DateTime.parse(json["deliveredAt"]),
    seenAt: json["seenAt"] == null ? null : DateTime.parse(json["seenAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "threadId": threadId,
    "sender": sender,
    "seen": seen,
    "message": message,
    "media": media,
    "mediaType": mediaType,
    "callHistory": callHistory?.toJson(),
    "status": status,
    "deliveredAt": deliveredAt?.toIso8601String(),
    "seenAt": seenAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "messageType": messageType,
  };
}


class MessageStatus{
  static String SENT ="SENT";
  static String DELIVERED ="DELIVERED";
  static String SEEN ="SEEN";
}



class CallHistoryInChat {
  String? id;
  String? callRequestById;
  String? callEndedById;
  String? callToUserId;
  String? threadId;
  String? callType;
  String? callDirection;
  bool? answered;
  DateTime? startTime;
  DateTime? endTime;
  int? duration;
  String? recordingUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;

  CallHistoryInChat({
    this.id,
    this.callRequestById,
    this.callEndedById,
    this.callToUserId,
    this.threadId,
    this.callType,
    this.callDirection,
    this.answered,
    this.startTime,
    this.endTime,
    this.duration,
    this.recordingUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
  });

  factory CallHistoryInChat.fromJson(Map<String, dynamic> json) => CallHistoryInChat(
    id: json["_id"],
    callRequestById: json["callRequestById"],
    callEndedById: json["callEndedById"],
    callToUserId: json["callToUserId"],
    threadId: json["threadId"],
    callType: json["callType"],
    callDirection: json["callDirection"],
    answered: json["answered"],
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
    duration: json["duration"],
    recordingUrl: json["recordingUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "callRequestById": callRequestById,
    "callEndedById": callEndedById,
    "callToUserId": callToUserId,
    "threadId": threadId,
    "callType": callType,
    "callDirection": callDirection,
    "answered": answered,
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
    "duration": duration,
    "recordingUrl": recordingUrl,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "status": status,
  };
}
