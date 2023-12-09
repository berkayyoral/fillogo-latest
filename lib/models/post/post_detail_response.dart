// To parse this JSON data, do
//
//     final postDetailResponse = postDetailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fillogo/models/post/get_home_post.dart';

class PostDetailResponse {
  PostDetailResponse({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<Datum>? data;
  String? message;

  factory PostDetailResponse.fromRawJson(String str) =>
      PostDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostDetailResponse.fromJson(Map<String, dynamic> json) =>
      PostDetailResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.onlyPost,
    this.post,
    this.didILiked,
    this.likedNum,
    this.commentedNum,
  });

  bool? onlyPost;
  PostDetail? post;
  int? didILiked;
  int? likedNum;
  int? commentedNum;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        onlyPost: json["onlyPost"],
        post: json["post"] == null ? null : PostDetail.fromJson(json["post"]),
        didILiked: json["didILiked"],
        likedNum: json["likedNum"],
        commentedNum: json["commentedNum"],
      );

  Map<String, dynamic> toJson() => {
        "onlyPost": onlyPost,
        "post": post?.toJson(),
        "didILiked": didILiked,
        "likedNum": likedNum,
        "commentedNum": commentedNum,
      };
}

class PostDetail {
  PostDetail({
    this.id,
    this.text,
    this.media,
    this.createdAt,
    this.postemojis,
    this.user,
    this.postpostlabels,
    this.postroute,
  });

  int? id;
  String? text;
  String? media;
  DateTime? createdAt;
  List<Postemoji>? postemojis;
  User? user;
  List<Postpostlabel>? postpostlabels;
  Postroute? postroute;

  factory PostDetail.fromRawJson(String str) =>
      PostDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
        id: json["id"],
        text: json["text"],
        media: json["media"] ?? "",
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        postemojis: json["postemojis"] == null
            ? []
            : List<Postemoji>.from(
                json["postemojis"]!.map((x) => Postemoji.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        postpostlabels: json["postpostlabels"] == null
            ? []
            : List<Postpostlabel>.from(
                json["postpostlabels"]!.map((x) => Postpostlabel.fromJson(x))),
        postroute: json["postroute"] == null
            ? null
            : Postroute.fromJson(json["postroute"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "media": media,
        "createdAt": createdAt?.toIso8601String(),
        "postemojis": postemojis == null
            ? []
            : List<dynamic>.from(postemojis!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "postpostlabels": postpostlabels == null
            ? []
            : List<dynamic>.from(postpostlabels!.map((x) => x.toJson())),
        "postroute": postroute?.toJson(),
      };
}

class Postemoji {
  Postemoji({
    this.id,
    this.emojis,
  });

  int? id;
  Emojis? emojis;

  factory Postemoji.fromRawJson(String str) =>
      Postemoji.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Postemoji.fromJson(Map<String, dynamic> json) => Postemoji(
        id: json["id"],
        emojis: json["emojis"] == null ? null : Emojis.fromJson(json["emojis"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emojis": emojis?.toJson(),
      };
}

class Emojis {
  Emojis({
    this.id,
    this.name,
    this.emoji,
  });

  int? id;
  String? name;
  String? emoji;

  factory Emojis.fromRawJson(String str) => Emojis.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Emojis.fromJson(Map<String, dynamic> json) => Emojis(
        id: json["id"],
        name: json["name"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "emoji": emoji,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.surname,
    this.profilePicture,
  });

  int? id;
  String? name;
  String? surname;
  String? profilePicture;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "profilePicture": profilePicture,
      };
}

class Postroute {
  Postroute({
    this.id,
    this.userId,
    this.departureDate,
    this.arrivalDate,
    this.routeDescription,
    this.vehicleCapacity,
    this.isActive,
    this.startingCoordinates,
    this.startingOpenAdress,
    this.startingCity,
    this.endingCoordinates,
    this.endingOpenAdress,
    this.endingCity,
    this.distance,
    this.travelTime,
    this.polylineEncode,
    this.polylineDecode,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  DateTime? departureDate;
  DateTime? arrivalDate;
  String? routeDescription;
  int? vehicleCapacity;
  bool? isActive;
  List<double>? startingCoordinates;
  String? startingOpenAdress;
  String? startingCity;
  List<double>? endingCoordinates;
  String? endingOpenAdress;
  String? endingCity;
  int? distance;
  int? travelTime;
  String? polylineEncode;
  List<List<double>>? polylineDecode;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Postroute.fromRawJson(String str) =>
      Postroute.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Postroute.fromJson(Map<String, dynamic> json) => Postroute(
        id: json["id"],
        userId: json["userID"],
        departureDate: json["departureDate"] == null
            ? null
            : DateTime.parse(json["departureDate"]),
        arrivalDate: json["arrivalDate"] == null
            ? null
            : DateTime.parse(json["arrivalDate"]),
        routeDescription: json["routeDescription"],
        vehicleCapacity: json["vehicleCapacity"],
        isActive: json["isActive"],
        startingCoordinates: json["startingCoordinates"] == null
            ? []
            : List<double>.from(
                json["startingCoordinates"]!.map((x) => x?.toDouble())),
        startingOpenAdress: json["startingOpenAdress"],
        startingCity: json["startingCity"],
        endingCoordinates: json["endingCoordinates"] == null
            ? []
            : List<double>.from(
                json["endingCoordinates"]!.map((x) => x?.toDouble())),
        endingOpenAdress: json["endingOpenAdress"],
        endingCity: json["endingCity"],
        distance: json["distance"],
        travelTime: json["travelTime"],
        polylineEncode: json["polylineEncode"],
        polylineDecode: json["polylineDecode"] == null
            ? []
            : List<List<double>>.from(json["polylineDecode"]!
                .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "departureDate": departureDate?.toIso8601String(),
        "arrivalDate": arrivalDate?.toIso8601String(),
        "routeDescription": routeDescription,
        "vehicleCapacity": vehicleCapacity,
        "isActive": isActive,
        "startingCoordinates": startingCoordinates == null
            ? []
            : List<dynamic>.from(startingCoordinates!.map((x) => x)),
        "startingOpenAdress": startingOpenAdress,
        "startingCity": startingCity,
        "endingCoordinates": endingCoordinates == null
            ? []
            : List<dynamic>.from(endingCoordinates!.map((x) => x)),
        "endingOpenAdress": endingOpenAdress,
        "endingCity": endingCity,
        "distance": distance,
        "travelTime": travelTime,
        "polylineEncode": polylineEncode,
        "polylineDecode": polylineDecode == null
            ? []
            : List<dynamic>.from(polylineDecode!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
