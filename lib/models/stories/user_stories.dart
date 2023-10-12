// To parse this JSON data, do
//
//     final userStoriesResponse = userStoriesResponseFromJson(jsonString);

import 'dart:convert';

class UserStoriesResponse {
    int? success;
    List<Datum>? data;
    String? message;

    UserStoriesResponse({
        this.success,
        this.data,
        this.message,
    });

    factory UserStoriesResponse.fromRawJson(String str) => UserStoriesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserStoriesResponse.fromJson(Map<String, dynamic> json) => UserStoriesResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    DatumStories? stories;

    Datum({
        this.stories,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        stories: json["stories"] == null ? null : DatumStories.fromJson(json["stories"]),
    );

    Map<String, dynamic> toJson() => {
        "stories": stories?.toJson(),
    };
}

class DatumStories {
    List<Result>? result;
    Pagination? pagination;

    DatumStories({
        this.result,
        this.pagination,
    });

    factory DatumStories.fromRawJson(String str) => DatumStories.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DatumStories.fromJson(Map<String, dynamic> json) => DatumStories(
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
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

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

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
    int? userId;
    String? url;
    DateTime? createdAt;
    ResultStories? stories;

    Result({
        this.id,
        this.userId,
        this.url,
        this.createdAt,
        this.stories,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["userID"],
        url: json["url"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        stories: json["stories"] == null ? null : ResultStories.fromJson(json["stories"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "url": url,
        "createdAt": createdAt?.toIso8601String(),
        "stories": stories?.toJson(),
    };
}

class ResultStories {
    int? id;
    String? username;
    String? name;
    String? surname;
    String? profilePicture;

    ResultStories({
        this.id,
        this.username,
        this.name,
        this.surname,
        this.profilePicture,
    });

    factory ResultStories.fromRawJson(String str) => ResultStories.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResultStories.fromJson(Map<String, dynamic> json) => ResultStories(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        surname: json["surname"],
        profilePicture: json["profilePicture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "surname": surname,
        "profilePicture": profilePicture,
    };
}
