// To parse this JSON data, do
//
//     final searchFollowersResponse = searchFollowersResponseFromJson(jsonString);

import 'dart:convert';

class SearchFollowersResponse {
  SearchFollowersResponse({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<FollowersDatum>? data;
  String? message;

  factory SearchFollowersResponse.fromRawJson(String str) =>
      SearchFollowersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFollowersResponse.fromJson(Map<String, dynamic> json) =>
      SearchFollowersResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<FollowersDatum>.from(
                json["data"]!.map((x) => FollowersDatum.fromJson(x))),
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

class FollowersDatum {
  FollowersDatum({
    this.searchResult,
  });

  SearchResult? searchResult;

  factory FollowersDatum.fromRawJson(String str) =>
      FollowersDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowersDatum.fromJson(Map<String, dynamic> json) => FollowersDatum(
        searchResult: json["searchResult"] == null
            ? null
            : SearchResult.fromJson(json["searchResult"]),
      );

  Map<String, dynamic> toJson() => {
        "searchResult": searchResult?.toJson(),
      };
}

class SearchResult {
  SearchResult({
    this.result,
    this.pagination,
  });

  List<FollowersResult>? result;
  Pagination? pagination;

  factory SearchResult.fromRawJson(String str) =>
      SearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        result: json["result"] == null
            ? []
            : List<FollowersResult>.from(
                json["result"]!.map((x) => FollowersResult.fromJson(x))),
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
  Pagination({
    this.totalRecords,
    this.totalPerpage,
    this.totalPage,
    this.currentPage,
    this.nextPage,
    this.previousPage,
  });

  int? totalRecords;
  int? totalPerpage;
  int? totalPage;
  int? currentPage;
  dynamic nextPage;
  dynamic previousPage;

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

class FollowersResult {
  FollowersResult({
    this.id,
    this.userId,
    this.followingId,
    this.createdAt,
    this.follower,
    this.amIfollowing,
    this.routeCount,
  });

  int? id;
  int? userId;
  int? followingId;
  DateTime? createdAt;
  Follower? follower;
  bool? amIfollowing;
  int? routeCount;

  factory FollowersResult.fromRawJson(String str) =>
      FollowersResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowersResult.fromJson(Map<String, dynamic> json) =>
      FollowersResult(
        id: json["id"],
        userId: json["userID"],
        followingId: json["followingID"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        follower: json["follower"] == null
            ? null
            : Follower.fromJson(json["follower"]),
        amIfollowing: json["amIfollowing"],
        routeCount: json["routeCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "followingID": followingId,
        "createdAt": createdAt?.toIso8601String(),
        "follower": follower?.toJson(),
        "amIfollowing": amIfollowing,
        "routeCount": routeCount,
      };
}

class Follower {
  Follower({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.profilePicture,
    this.title,
  });

  int? id;
  String? name;
  String? surname;
  String? username;
  String? profilePicture;
  String? title;

  factory Follower.fromRawJson(String str) =>
      Follower.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        profilePicture: json["profilePicture"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "username": username,
        "profilePicture": profilePicture,
        "title": title,
      };
}
