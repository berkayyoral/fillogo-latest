// To parse this JSON data, do
//
//     final searchFollowingResponse = searchFollowingResponseFromJson(jsonString);

import 'dart:convert';

class SearchFollowingResponse {
  SearchFollowingResponse({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<Datum>? data;
  String? message;

  factory SearchFollowingResponse.fromRawJson(String str) =>
      SearchFollowingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFollowingResponse.fromJson(Map<String, dynamic> json) =>
      SearchFollowingResponse(
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
    this.searchResult,
  });

  SearchResult? searchResult;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

  List<FollowingResult>? result;
  Pagination? pagination;

  factory SearchResult.fromRawJson(String str) =>
      SearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        result: json["result"] == null
            ? []
            : List<FollowingResult>.from(
                json["result"]!.map((x) => FollowingResult.fromJson(x))),
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
  int? nextPage;
  int? previousPage;

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

class FollowingResult {
  FollowingResult({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.profilePicture,
    this.title,
    this.amIafollower,
    this.routeCount,
  });

  int? id;
  String? name;
  String? surname;
  String? username;
  String? profilePicture;
  String? title;
  bool? amIafollower;
  int? routeCount;

  factory FollowingResult.fromRawJson(String str) =>
      FollowingResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowingResult.fromJson(Map<String, dynamic> json) =>
      FollowingResult(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        profilePicture: json["profilePicture"],
        title: json["title"],
        amIafollower: json["amIafollower"],
        routeCount: json["routeCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "username": username,
        "profilePicture": profilePicture,
        "title": title,
        "amIafollower": amIafollower,
        "routeCount": routeCount,
      };
}
