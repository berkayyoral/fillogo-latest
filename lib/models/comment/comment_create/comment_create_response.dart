// To parse this JSON data, do
//
//     final commentCreateResponse = commentCreateResponseFromJson(jsonString);

import 'dart:convert';

class CommentCreateResponse {
  int? success;
  List<Datum>? data;
  String? message;

  CommentCreateResponse({
    this.success,
    this.data,
    this.message,
  });

  factory CommentCreateResponse.fromRawJson(String str) =>
      CommentCreateResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentCreateResponse.fromJson(Map<String, dynamic> json) =>
      CommentCreateResponse(
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
  CommentedPost? commentedPost;

  Datum({
    this.commentedPost,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        commentedPost: json["commentedPost"] == null
            ? null
            : CommentedPost.fromJson(json["commentedPost"]),
      );

  Map<String, dynamic> toJson() => {
        "commentedPost": commentedPost?.toJson(),
      };
}

class CommentedPost {
  int? id;
  int? userId;
  int? postId;
  String? comment;
  DateTime? updatedAt;
  DateTime? createdAt;

  CommentedPost({
    this.id,
    this.userId,
    this.postId,
    this.comment,
    this.updatedAt,
    this.createdAt,
  });

  factory CommentedPost.fromRawJson(String str) =>
      CommentedPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentedPost.fromJson(Map<String, dynamic> json) => CommentedPost(
        id: json["id"],
        userId: json["userID"],
        postId: json["postID"],
        comment: json["comment"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "postID": postId,
        "comment": comment,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
