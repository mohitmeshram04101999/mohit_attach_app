// To parse this JSON data, do
//
//     final verifyOtpResponceModel = verifyOtpResponceModelFromJson(jsonString);

import 'dart:convert';

import 'package:attach/modles/all_language_responce_model.dart';

import 'all_language_responce_model.dart';

VerifyOtpResponceModel verifyOtpResponceModelFromJson(String str) => VerifyOtpResponceModel.fromJson(json.decode(str));

String verifyOtpResponceModelToJson(VerifyOtpResponceModel data) => json.encode(data.toJson());

class VerifyOtpResponceModel {
  bool? success;
  String? message;
  User? data;
  bool? profileComplete;

  VerifyOtpResponceModel({
    this.success,
    this.message,
    this.data,
    this.profileComplete
  });

  factory VerifyOtpResponceModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponceModel(
    success: json["success"],
    message: json["message"],
    profileComplete: json["profileComplete"],
    data: json["data"] == null ? null : User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    'profileComplete':profileComplete,
    "data": data?.toJson(),
  };
}

class User {
  SetAvailability? setAvailability;
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  bool? userVerified;
  String? userType;
  double? rating;
  List<dynamic>? follower;
  List<dynamic>? following;
  String? count;
  String? countOfRating;
  String? otp;
  String? gender;
  List<Language>? languages;
  int? wallet;
  String? referralCode;
  int? totalRefralEearning;
  bool? online;
  String? experience;
  List<dynamic>? notify;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? monthlyEstimatedEarning;
  double? todayEarning;
  String? listeningToday;
  int? v;
  String? image;
  String? token;
  int? age;
  String? bio;
  bool? isFollowing;
  bool? isBellOn;
  String? becomeAListenerForm;
  int? sessionChargeChat;
  String? status;  // ["PENDING", "REJECTED", "APPROVED"]

  User({
    this.age,
    this.bio,
    this.setAvailability,
    this.id,
    this.monthlyEstimatedEarning,
    this.name,
    this.phoneNumber,
    this.email,
    this.userVerified,
    this.userType,
    this.rating,
    this.follower,
    this.following,
    this.count,
    this.countOfRating,
    this.otp,
    this.gender,
    this.languages,
    this.wallet,
    this.referralCode,
    this.totalRefralEearning,
    this.online,
    this.experience,
    this.notify,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.token,
    this.listeningToday,
    this.todayEarning,
    this.isFollowing,
    this.isBellOn,
    this.becomeAListenerForm,
    this.sessionChargeChat,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    setAvailability: json["setAvailability"] == null ? null : SetAvailability.fromJson(json["setAvailability"]),
    id: json["_id"],
    bio: json["bio"],
    age: json["age"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    userVerified: json["userVerified"],
    userType: json["userType"],
    rating: json["rating"]==null?0:double.parse(json["rating"].toString()),
    follower: json["follower"] == null ? [] : List<dynamic>.from(json["follower"]!.map((x) => x)),
    following: json["following"] == null ? [] : List<dynamic>.from(json["following"]!.map((x) => x)),
    count: json["count"]==null?null:json["count"].toString(),
    countOfRating: json["countOfRating"]==null?null:json["countOfRating"].toString(),
    otp: json["otp"],
    gender: json["gender"],
    languages: json["languages"] == null ? [] : List<Language>.from(json["languages"]!.map((x) => Language.fromJson(x))),
    wallet: json["wallet"],
    referralCode: json["referralCode"],
    totalRefralEearning: json["totalRefralEearning"],
    online: json["online"],
    experience: json["experience"],
    notify: json["notify"] == null ? [] : List<dynamic>.from(json["notify"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    image: json["image"],
    token: json["token"],
    monthlyEstimatedEarning: json['monthlyEstimatedEarning']==null?null:double.parse(json['monthlyEstimatedEarning'].toString()),
    todayEarning: json['todayEarning']==null?null:double.parse(json['todayEarning'].toString()),
    listeningToday: json['listeningToday'],
    isFollowing: json['isFollowing'],
    isBellOn: json['isBellOn'],
    becomeAListenerForm: json['becomeAListenerForm'],
    sessionChargeChat: json['sessionChargeChat'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    "setAvailability": setAvailability?.toJson(),
    "_id": id,
    "name": name,
    "age": age,
    "bio": bio,
    "phoneNumber": phoneNumber,
    "email": email,
    "userVerified": userVerified,
    "userType": userType,
    "rating": rating,
    "follower": follower == null ? [] : List<dynamic>.from(follower!.map((x) => x)),
    "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x)),
    "count": count,
    "countOfRating": countOfRating,
    "otp": otp,
    "gender": gender,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x.toJson())),
    "wallet": wallet,
    "referralCode": referralCode,
    "totalRefralEearning": totalRefralEearning,
    "online": online,
    "experience": experience,
    "notify": notify == null ? [] : List<dynamic>.from(notify!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "image": image,
    "token": token,
    'monthlyEstimatedEarning':monthlyEstimatedEarning,
    'listeningToday':listeningToday,
    'todayEarning':todayEarning,
    'isFollowing':isFollowing,
    'isBellOn':isBellOn,
    'becomeAListenerForm':becomeAListenerForm,
    'sessionChargeChat':sessionChargeChat,
    'status':status
  };
}

class SetAvailability {
  bool? chat;
  bool? audioCall;
  bool? videoCall;

  SetAvailability({
    this.chat,
    this.audioCall,
    this.videoCall,
  });

  factory SetAvailability.fromJson(Map<String, dynamic> json) => SetAvailability(
    chat: json["chat"],
    audioCall: json["audioCall"],
    videoCall: json["videoCall"],
  );

  Map<String, dynamic> toJson() => {
    "chat": chat,
    "audioCall": audioCall,
    "videoCall": videoCall,
  };
}
