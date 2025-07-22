

// To parse this JSON data, do
//
//     final questionForListenerModel = questionForListenerModelFromJson(jsonString);

import 'dart:convert';

QuestionForListenerModel questionForListenerModelFromJson(String str) => QuestionForListenerModel.fromJson(json.decode(str));

String questionForListenerModelToJson(QuestionForListenerModel data) => json.encode(data.toJson());

class QuestionForListenerModel {
  bool? success;
  String? message;
  List<QuestionForListener>? data;
  int? currentPage;
  int? page;

  QuestionForListenerModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.page,
  });

  factory QuestionForListenerModel.fromJson(Map<String, dynamic> json) => QuestionForListenerModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<QuestionForListener>.from(json["data"]!.map((x) => QuestionForListener.fromJson(x))),
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

class QuestionForListener {
  String? id;
  String? question;
  String? questionType;   //[MEDIA_TYPE, BOOLEAN_OPTION, SORT_QUESTION, LONG_QUESTION, MULTIPLE_CHOOSE_OPTION]
  List<String>? options;
  List<String>? mediaArray;
  int? mediaCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? required;

  QuestionForListener({
    this.id,
    this.question,
    this.questionType,
    this.options,
    this.mediaArray,
    this.mediaCount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.required,
  });

  factory QuestionForListener.fromJson(Map<String, dynamic> json) => QuestionForListener(
    id: json["_id"],
    question: json["question"],
    questionType: json["questionType"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    mediaArray: json["mediaArray"] == null ? [] : List<String>.from(json["mediaArray"]!.map((x) => x)),
    mediaCount: json["mediaCount"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    required: json["required"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "questionType": questionType,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "mediaArray": mediaArray == null ? [] : List<dynamic>.from(mediaArray!.map((x) => x)),
    "mediaCount": mediaCount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}



class AnswerModel {
  String id;
  String question;
  String questionType;  // //[MEDIA_TYPE, BOOLEAN_OPTION, SORT_QUESTION, LONG_QUESTION, MULTIPLE_CHOOSE_OPTION]


  String? mediaAnswer;
  List<String>? multipleMediaAnswer;
  String? booleanAnswer;
  String? sortAnswer;
  String? longAnswer;
  List<String>? multipleChooseAnswer;

  AnswerModel({
    required this.id,
    required this.question,
    required this.questionType,
    this.mediaAnswer,
    this.multipleMediaAnswer,
    this.booleanAnswer,
    this.sortAnswer,
    this.longAnswer,
    this.multipleChooseAnswer,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
    id: json["_id"],
    question: json["question"],
    questionType: json["questionType"],
    mediaAnswer: json["mediaAnswer"] as String?,
    booleanAnswer: json["booleanAnswer"],
    sortAnswer: json["sortAnswer"] as String?,
    longAnswer: json["longAnswer"] as String?,
    multipleMediaAnswer: json["multipleMediaAnswer"] == null
        ? null
        : List<String>.from(json["multipleMediaAnswer"] as List),
    multipleChooseAnswer: json["multipleChooseAnswer"] == null
        ? null
        : List<String>.from(json["multipleChooseAnswer"] as List),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "questionType": questionType,
    "mediaAnswer": mediaAnswer,
    "booleanAnswer": booleanAnswer,
    "sortAnswer": sortAnswer,
    "longAnswer": longAnswer,
    "multipleChooseAnswer": multipleChooseAnswer,
    "multipleMediaAnswer": multipleMediaAnswer,
  };
}
