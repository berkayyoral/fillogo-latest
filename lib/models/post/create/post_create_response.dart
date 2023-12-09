// To parse this JSON data, do
//
//     final postCreateResponse = postCreateResponseFromJson(jsonString);

import 'dart:convert';

class PostCreateResponse {
  PostCreateResponse({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<Datum>? data;
  String? message;

  factory PostCreateResponse.fromRawJson(String str) =>
      PostCreateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostCreateResponse.fromJson(Map<String, dynamic> json) =>
      PostCreateResponse(
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
    this.post,
  });

  Post? post;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "post": post?.toJson(),
      };
}

class Post {
  Post({
    this.id,
    this.userId,
    this.routeId,
    this.text,
    this.media,
    this.createdAt,
  });

  int? id;
  int? userId;
  int? routeId;
  String? text;
  String? media;
  DateTime? createdAt;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        userId: json["userID"],
        routeId: json["routeID"],
        text: json["text"],
        media: json["media"] ?? "",
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "routeID": routeId,
        "text": text,
        "media": media,
        "createdAt": createdAt?.toIso8601String(),
      };
}
