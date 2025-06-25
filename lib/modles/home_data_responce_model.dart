// To parse this JSON data, do
//
//     final homeDataResponceModel = homeDataResponceModelFromJson(jsonString);

import 'dart:convert';

HomeDataResponceModel homeDataResponceModelFromJson(String str) => HomeDataResponceModel.fromJson(json.decode(str));

String homeDataResponceModelToJson(HomeDataResponceModel data) => json.encode(data.toJson());

class HomeDataResponceModel {
  String? event;
  HomePageData? data;

  HomeDataResponceModel({
    this.event,
    this.data,
  });

  factory HomeDataResponceModel.fromJson(Map<String, dynamic> json) => HomeDataResponceModel(
    event: json["event"],
    data: json["data"] == null ? null : HomePageData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "data": data?.toJson(),
  };
}

class HomePageData {
  int? notificationCount;
  List<String>? homeBanner;
  List<HomeListener>? listeners;
  List<StoryModel>? stories;

  HomePageData({
    this.notificationCount,
    this.homeBanner,
    this.listeners,
    this.stories,
  });

  factory HomePageData.fromJson(Map<String, dynamic> json) => HomePageData(
    notificationCount: json['notificationCount'],
    homeBanner: json["homeBanner"] == null ? [] : List<String>.from(json["homeBanner"]!.map((x) => x)),
    listeners: json["listeners"] == null ? [] : List<HomeListener>.from(json["listeners"]!.map((x) => HomeListener.fromJson(x))),
    stories: json["stories"] == null ? [] : List<StoryModel>.from(json["stories"]!.map((x) => StoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'notificationCount':notificationCount,
    "homeBanner": homeBanner == null ? [] : List<dynamic>.from(homeBanner!.map((x) => x)),
    "listeners": listeners == null ? [] : List<dynamic>.from(listeners!.map((x) => x.toJson())),
    "stories": stories == null ? [] : List<dynamic>.from(stories!.map((x) => x.toJson())),
  };
}


class HomeListener {
  String? id;
  String? name;
  bool? userVerified;
  double? rating;
  String? count;
  String? countOfRating;
  String? gender;
  SetAvailability? setAvailability;
  bool? online;
  String? experience;
  bool? isFollowing;
  int? age;
  String? bio;
  String? image;
  bool? isBusy;

  HomeListener({
    this.id,
    this.name,
    this.userVerified,
    this.rating,
    this.count,
    this.countOfRating,
    this.gender,
    this.setAvailability,
    this.online,
    this.experience,
    this.isFollowing,
    this.age,
    this.bio,
    this.image,
    this.isBusy,
  });

  factory HomeListener.fromJson(Map<String, dynamic> json) => HomeListener(
    id: json["_id"],
    name: json["name"],
    userVerified: json["userVerified"],
    rating: json["rating"]?.toDouble(),
    count: json["count"].toString(),
    countOfRating: json["countOfRating"].toString(),
    gender: json["gender"],
    setAvailability: json["setAvailability"] == null ? null : SetAvailability.fromJson(json["setAvailability"]),
    online: json["online"],
    experience: json["experience"],
    isFollowing: json["isFollowing"],
    age: json["age"],
    bio: json['bio'],
    image:json['image'] ,
    isBusy:json['isBusy'] ,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "userVerified": userVerified,
    "rating": rating,
    "count": count,
    "countOfRating": countOfRating,
    "gender": gender,
    "setAvailability": setAvailability?.toJson(),
    "online": online,
    "experience": experience,
    "isFollowing": isFollowing,
    'age':age,
    'bio':bio,
    'image':image,
    'isBusy':isBusy
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



class StoryModel {
  final Listener? listener;
  final List<Story>? stories;

  StoryModel({this.listener, this.stories});

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      listener: json['listener'] != null
          ? Listener.fromJson(json['listener'])
          : null,
      stories: (json['stories'] ==null)?null:List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x)))
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listener': listener?.toJson(),
      'stories': stories?.map((story) => story.toJson()).toList(),
    };
  }
}

class Listener {
  final String? id;
  final String? name;
  final String? image;
  final SetAvailability? setAvailability;

  Listener({this.id, this.name,this.image,this.setAvailability});

  factory Listener.fromJson(Map<String, dynamic> json) {
    return Listener(
      id: json['_id'] ,
      name: json['name'],
      image: json['image'] ,
      setAvailability: json['setAvailability'] == null
          ? null
          : SetAvailability.fromJson(json['setAvailability']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image':image,
      'setAvailability': setAvailability?.toJson(),
    };
  }
}

class Story {
  final String? id;
  final String? imageOrVideo;
  final String? mediaType;
  final bool? seen;
  final int? seenCount;
  final int? likeCount;
  final int? v;
  final bool? isLike;
  final DateTime? createdAt;

  Story({
    this.id,
    this.isLike,
    this.imageOrVideo,
    this.mediaType,
    this.seen,
    this.seenCount,
    this.likeCount,
    this.v,
    this.createdAt
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['_id'] ,
      imageOrVideo: json['imageOrVideo']  ,
      mediaType: json['mediaType'] ,
      seen: json['seen'] ,
      isLike: json['isLike'],
      seenCount: json['seenCount']  ,
      likeCount: json['likeCount']  ,
      v: json['__v'] ,
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageOrVideo': imageOrVideo,
      'mediaType': mediaType,
      'seen': seen,
      'isLike':isLike,
      'seenCount': seenCount,
      'likeCount': likeCount,
      '__v': v,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}



class SelfStoryModel {
  final String? id;
  final String? imageOrVideo;
  final String? mediaType;
  final List<SeenBy>? seen;
  final int? seenCount;
  final int? likeCount;
  final String? timeAgo;
  final int? v;
  final bool? isLike;

  SelfStoryModel({
    this.id,
    this.isLike,
    this.imageOrVideo,
    this.mediaType,
    this.timeAgo,
    this.seen,
    this.seenCount,
    this.likeCount,
    this.v,
  });

  factory SelfStoryModel.fromJson(Map<String, dynamic> json) {
    return SelfStoryModel(
      id: json['_id'] ,
      imageOrVideo: json['imageOrVideo']  ,
      mediaType: json['mediaType'] ,
      seen: json['seen']==null?null:List<SeenBy>.from(json['seen']!.map((e)=>SeenBy.fromJson(e))) ,
      isLike: json['isLike'],
      seenCount: json['seenCount']  ,
      likeCount: json['likeCount']  ,
      v: json['__v'] ,
      timeAgo: json['timeAgo'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageOrVideo': imageOrVideo,
      'mediaType': mediaType,
      'seen': seen,
      'isLike':isLike,
      'seenCount': seenCount,
      'likeCount': likeCount,
      '__v': v,
      'timeAgo':timeAgo

    };
  }
}


class SeenBy {
  UserId? userId;
  bool? like;
  String? id;
  DateTime? seenTime;

  SeenBy({
    this.userId,
    this.like,
    this.id,
    this.seenTime,
  });

  factory SeenBy.fromJson(Map<String, dynamic> json) => SeenBy(
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    like: json["like"],
    id: json["_id"],
    seenTime: json["seenTime"] == null ? null : DateTime.parse(json["seenTime"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId?.toJson(),
    "like": like,
    "_id": id,
    "seenTime": seenTime?.toIso8601String(),
  };
}

class UserId {
  String? id;
  String? image;
  String? name;

  UserId({
    this.id,
    this.image,
    this.name,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "name": name,
  };
}











