// To parse this JSON data, do
//
//     final postLikeListResponse = postLikeListResponseFromJson(jsonString);

import 'dart:convert';

class PostLikeListResponse {
  int? success;
  List<Datum>? data;
  String? message;

  PostLikeListResponse({
    this.success,
    this.data,
    this.message,
  });

  factory PostLikeListResponse.fromRawJson(String str) =>
      PostLikeListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostLikeListResponse.fromJson(Map<String, dynamic> json) =>
      PostLikeListResponse(
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
  Likes? likes;

  Datum({
    this.likes,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        likes: json["likes"] == null ? null : Likes.fromJson(json["likes"]),
      );

  Map<String, dynamic> toJson() => {
        "likes": likes?.toJson(),
      };
}

class Likes {
  List<Result>? result;
  Pagination? pagination;

  Likes({
    this.result,
    this.pagination,
  });

  factory Likes.fromRawJson(String str) => Likes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  int? totalRecords;
  int? totalPerpage;
  int? totalPage;
  int? currentPage;
  int? nextPage;
  int? previousPage;

  Pagination({
    this.totalRecords,
    this.totalPerpage,
    this.totalPage,
    this.currentPage,
    this.nextPage,
    this.previousPage,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalRecords: json["total_records"],
        totalPerpage: json["total_perpage"],
        totalPage: json["total_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_records": totalRecords,
        "total_perpage": totalPerpage,
        "total_page": totalPage,
        "current_page": currentPage,
        "next_page": nextPage,
        "previous_page": previousPage,
      };
}

class Result {
  int? id;
  Likedposts? likedposts;

  Result({
    this.id,
    this.likedposts,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        likedposts: json["likedposts"] == null
            ? null
            : Likedposts.fromJson(json["likedposts"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "likedposts": likedposts?.toJson(),
      };
}

class Likedposts {
  int? id;
  String? username;
  String? name;
  String? surname;
  String? profilePicture;
  bool? doIfollow;

  Likedposts({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.profilePicture,
    this.doIfollow,
  });

  factory Likedposts.fromRawJson(String str) =>
      Likedposts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Likedposts.fromJson(Map<String, dynamic> json) => Likedposts(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        profilePicture: json["profilePicture"],
        doIfollow: json["doIfollow"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "surname": surname,
        "profilePicture": profilePicture,
        "doIfollow": doIfollow,
      };
}
