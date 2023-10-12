// To parse this JSON data, do
//
//     final getCommentsResponse = getCommentsResponseFromJson(jsonString);

import 'dart:convert';

class GetCommentsResponse {
  int? success;
  List<Datum>? data;
  String? message;

  GetCommentsResponse({
    this.success,
    this.data,
    this.message,
  });

  factory GetCommentsResponse.fromRawJson(String str) =>
      GetCommentsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCommentsResponse.fromJson(Map<String, dynamic> json) =>
      GetCommentsResponse(
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
  Comments? comments;

  Datum({
    this.comments,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        comments: json["comments"] == null
            ? null
            : Comments.fromJson(json["comments"]),
      );

  Map<String, dynamic> toJson() => {
        "comments": comments?.toJson(),
      };
}

class Comments {
  List<Result>? result;
  Pagination? pagination;

  Comments({
    this.result,
    this.pagination,
  });

  factory Comments.fromRawJson(String str) =>
      Comments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
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
  dynamic nextPage;
  dynamic previousPage;

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
  String? comment;
  DateTime? createdAt;
  Commentedposts? commentedposts;
  List<Commentlabel>? commentlabel;
  int? likedCount;
  bool? isLikedByMe;

  Result({
    this.id,
    this.comment,
    this.createdAt,
    this.commentedposts,
    this.commentlabel,
    this.likedCount,
    this.isLikedByMe,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        comment: json["comment"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        commentedposts: json["commentedposts"] == null
            ? null
            : Commentedposts.fromJson(json["commentedposts"]),
        commentlabel: json["commentlabel"] == null
            ? []
            : List<Commentlabel>.from(
                json["commentlabel"]!.map((x) => Commentlabel.fromJson(x))),
        likedCount: json["likedCount"],
        isLikedByMe: json["isLikedByMe"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "createdAt": createdAt?.toIso8601String(),
        "commentedposts": commentedposts?.toJson(),
        "commentlabel": commentlabel == null
            ? []
            : List<dynamic>.from(commentlabel!.map((x) => x.toJson())),
        "likedCount": likedCount,
        "isLikedByMe": isLikedByMe,
      };
}

class Commentedposts {
  int? id;
  String? name;
  String? surname;
  String? profilePicture;

  Commentedposts({
    this.id,
    this.name,
    this.surname,
    this.profilePicture,
  });

  factory Commentedposts.fromRawJson(String str) =>
      Commentedposts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Commentedposts.fromJson(Map<String, dynamic> json) => Commentedposts(
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

class Commentlabel {
  int? id;
  Commentedposts? usercommentlabel;

  Commentlabel({
    this.id,
    this.usercommentlabel,
  });

  factory Commentlabel.fromRawJson(String str) =>
      Commentlabel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Commentlabel.fromJson(Map<String, dynamic> json) => Commentlabel(
        id: json["id"],
        usercommentlabel: json["usercommentlabel"] == null
            ? null
            : Commentedposts.fromJson(json["usercommentlabel"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "usercommentlabel": usercommentlabel?.toJson(),
      };
}
