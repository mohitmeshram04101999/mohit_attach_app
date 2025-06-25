// To parse this JSON data, do
//
//     final callHisteryApiResponse = callHisteryApiResponseFromJson(jsonString);

import 'dart:convert';

CallHisteryApiResponse callHisteryApiResponseFromJson(String str) => CallHisteryApiResponse.fromJson(json.decode(str));

String callHisteryApiResponseToJson(CallHisteryApiResponse data) => json.encode(data.toJson());

class CallHisteryApiResponse {
  bool? success;
  String? message;
  List<CallHistory>? data;
  int? totalPages;

  CallHisteryApiResponse({
    this.success,
    this.message,
    this.data,

    this.totalPages,
  });

  factory CallHisteryApiResponse.fromJson(Map<String, dynamic> json) => CallHisteryApiResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CallHistory>.from(json["data"]!.map((x) => CallHistory.fromJson(x))),
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),

    "totalPages": totalPages,
  };
}


CallHistory callHisteryFromJson(String str) => CallHistory.fromJson(json.decode(str));

String callHisteryToJson(CallHistory data) => json.encode(data.toJson());


// To parse this JSON data, do
//
//     final callHistory = callHistoryFromJson(jsonString);


CallHistory callHistoryFromJson(String str) => CallHistory.fromJson(json.decode(str));

String callHistoryToJson(CallHistory data) => json.encode(data.toJson());

class CallHistory {
  String? callType;
  String? threadId;
  String? status;
  UserCall? user;
  String? call;
  String? dateTime;
  String? TypeCheck; //OTHER,USER

  CallHistory({
    this.callType,
    this.threadId,
    this.status,
    this.user,
    this.call,
    this.dateTime,
  });

  factory CallHistory.fromJson(Map<String, dynamic> json) => CallHistory(
    callType: json["callType"],
    threadId: json["threadId"],
    status: json["status"],
    user: json["user"] == null ? null : UserCall.fromJson(json["user"]),
    call: json["call"],
    dateTime: json["dateTime"],


  );

  Map<String, dynamic> toJson() => {
    "callType": callType,
    "threadId": threadId,
    "status": status,
    "user": user?.toJson(),
    "call": call,
    "dateTime": dateTime,
  };
}

class UserCall {
  String? id;
  String? name;
  String? image;
  bool? verified;

  UserCall({
    this.id,
    this.name,
    this.image,
    this.verified
  });

  factory UserCall.fromJson(Map<String, dynamic> json) => UserCall(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    verified: json["userVerified"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "userVerified": verified
  };
}










