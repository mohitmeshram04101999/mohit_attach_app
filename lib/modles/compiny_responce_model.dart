// To parse this JSON data, do
//
//     final companyResponce = companyResponceFromJson(jsonString);

import 'dart:convert';

CompanyResponce companyResponceFromJson(String str) => CompanyResponce.fromJson(json.decode(str));

String companyResponceToJson(CompanyResponce data) => json.encode(data.toJson());

class CompanyResponce {
  bool? success;
  String? message;
  CompanyData? data;

  CompanyResponce({
    this.success,
    this.message,
    this.data,
  });

  factory CompanyResponce.fromJson(Map<String, dynamic> json) => CompanyResponce(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : CompanyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class CompanyData {
  String? id;
  String? name;
  String? icon;
  String? favIcon;
  String? loader;
  String? privacyPolicy;
  String? termsCondition;
  String? aboutUs;
  List<String>? homeBanner;
  String? gst;
  int? phoneNumber;
  String? email;
  String? address;
  String? bottomDescription;
  String? xUrl;
  String? instaUrl;
  String? facebookUrl;
  String? linkedineUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? referralEarning;

  CompanyData({
    this.id,
    this.name,
    this.icon,
    this.favIcon,
    this.loader,
    this.privacyPolicy,
    this.termsCondition,
    this.aboutUs,
    this.homeBanner,
    this.gst,
    this.phoneNumber,
    this.email,
    this.address,
    this.bottomDescription,
    this.xUrl,
    this.instaUrl,
    this.facebookUrl,
    this.linkedineUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.referralEarning,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
    id: json["_id"],
    name: json["name"],
    icon: json["icon"],
    favIcon: json["favIcon"],
    loader: json["loader"],
    privacyPolicy: json["privacyPolicy"],
    termsCondition: json["termsCondition"],
    aboutUs: json["aboutUs"],
    homeBanner: json["homeBanner"] == null ? [] : List<String>.from(json["homeBanner"]!.map((x) => x)),
    gst: json["gst"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    address: json["address"],
    bottomDescription: json["bottomDescription"],
    xUrl: json["xUrl"],
    instaUrl: json["instaUrl"],
    facebookUrl: json["facebookUrl"],
    linkedineUrl: json["linkedineUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    referralEarning: json["referralEarning"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "icon": icon,
    "favIcon": favIcon,
    "loader": loader,
    "privacyPolicy": privacyPolicy,
    "termsCondition": termsCondition,
    "aboutUs": aboutUs,
    "homeBanner": homeBanner == null ? [] : List<dynamic>.from(homeBanner!.map((x) => x)),
    "gst": gst,
    "phoneNumber": phoneNumber,
    "email": email,
    "address": address,
    "bottomDescription": bottomDescription,
    "xUrl": xUrl,
    "instaUrl": instaUrl,
    "facebookUrl": facebookUrl,
    "linkedineUrl": linkedineUrl,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "referralEarning": referralEarning,
  };
}
