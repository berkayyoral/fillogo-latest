// To parse this JSON data, do
//
//     final userGetMyProfileResponse = userGetMyProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fillogo/models/post/get_home_post.dart';

class UserGetMyProfileResponse {
  UserGetMyProfileResponse({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  Data? data;
  String? message;

  factory UserGetMyProfileResponse.fromRawJson(String str) =>
      UserGetMyProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserGetMyProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserGetMyProfileResponse(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.users,
    this.stories,
    this.followerCount,
    this.followingCount,
    this.doIfollow,
    this.posts,
    this.carInformations,
    this.routeCount,
  });

  Users? users;
  List<dynamic>? stories;
  int? followerCount;
  int? followingCount;
  bool? doIfollow;
  Posts? posts;
  CarInformations? carInformations;
  int? routeCount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        stories: json["stories"] == null
            ? []
            : List<dynamic>.from(json["stories"]!.map((x) => x)),
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        doIfollow: json["doIfollow"],
        posts: json["posts"] == null ? null : Posts.fromJson(json["posts"]),
        carInformations: json["carInformations"] == null
            ? null
            : CarInformations.fromJson(json["carInformations"]),
        routeCount: json["routeCount"],
      );

  Map<String, dynamic> toJson() => {
        "users": users?.toJson(),
        "stories":
            stories == null ? [] : List<dynamic>.from(stories!.map((x) => x)),
        "followerCount": followerCount,
        "followingCount": followingCount,
        "doIfollow": doIfollow,
        "posts": posts?.toJson(),
        "carInformations": carInformations?.toJson(),
        "routeCount": routeCount,
      };
}

class CarInformations {
  CarInformations({
    this.carTypeId,
    this.carBrand,
    this.carModel,
    this.cartypetousercartypes,
  });

  int? carTypeId;
  String? carBrand;
  String? carModel;
  Cartypetousercartypes? cartypetousercartypes;

  factory CarInformations.fromRawJson(String str) =>
      CarInformations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarInformations.fromJson(Map<String, dynamic> json) =>
      CarInformations(
        carTypeId: json["carTypeID"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        cartypetousercartypes: json["cartypetousercartypes"] == null
            ? null
            : Cartypetousercartypes.fromJson(json["cartypetousercartypes"]),
      );

  Map<String, dynamic> toJson() => {
        "carTypeID": carTypeId,
        "carBrand": carBrand,
        "carModel": carModel,
        "cartypetousercartypes": cartypetousercartypes?.toJson(),
      };
}

class Cartypetousercartypes {
  Cartypetousercartypes({
    this.id,
    this.carType,
    this.driverType,
  });

  int? id;
  String? carType;
  String? driverType;

  factory Cartypetousercartypes.fromRawJson(String str) =>
      Cartypetousercartypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cartypetousercartypes.fromJson(Map<String, dynamic> json) =>
      Cartypetousercartypes(
        id: json["id"],
        carType: json["carType"],
        driverType: json["driverType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carType": carType,
        "driverType": driverType,
      };
}

class Posts {
  Posts({
    this.result,
    this.pagination,
  });

  List<Result>? result;
  Pagination? pagination;

  factory Posts.fromRawJson(String str) => Posts.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
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

class Result {
  Result({
    this.post,
    this.likedNum,
    this.didILiked,
    this.commentNum,
  });

  Post? post;
  int? likedNum;
  int? didILiked;
  int? commentNum;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
        likedNum: json["likedNum"],
        didILiked: json["didILiked"],
        commentNum: json["commentNum"],
      );

  Map<String, dynamic> toJson() => {
        "post": post?.toJson(),
        "likedNum": likedNum,
        "didILiked": didILiked,
        "commentNum": commentNum,
      };
}

class Post {
  Post({
    this.id,
    this.userId,
    this.text,
    this.media,
    this.createdAt,
    this.postemojis,
    this.postpostlabels,
    this.postroute,
  });

  int? id;
  int? userId;
  String? text;
  String? media;
  DateTime? createdAt;
  List<Postemoji>? postemojis;
  List<Postpostlabel>? postpostlabels;
  Postroute? postroute;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        userId: json["userID"],
        text: json["text"],
        media: json["media"] ?? "",
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        postemojis: json["postemojis"] == null
            ? []
            : List<Postemoji>.from(
                json["postemojis"]!.map((x) => Postemoji.fromJson(x))),
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
        "userID": userId,
        "text": text,
        "media": media,
        "createdAt": createdAt?.toIso8601String(),
        "postemojis": postemojis == null
            ? []
            : List<dynamic>.from(postemojis!.map((x) => x.toJson())),
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

class Userpostlabels {
  Userpostlabels({
    this.id,
    this.name,
    this.surname,
  });

  int? id;
  String? name;
  String? surname;

  factory Userpostlabels.fromRawJson(String str) =>
      Userpostlabels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Userpostlabels.fromJson(Map<String, dynamic> json) => Userpostlabels(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
      };
}

// To parse this JSON data, do
//
//     final postroute = postrouteFromJson(jsonString);


class Postroute {
    int? id;
    String? startingCity;
    String? endingCity;

    Postroute({
        this.id,
        this.startingCity,
        this.endingCity,
    });

    factory Postroute.fromRawJson(String str) => Postroute.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Postroute.fromJson(Map<String, dynamic> json) => Postroute(
        id: json["id"],
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startingCity": startingCity,
        "endingCity": endingCity,
    };
}


class Users {
  Users({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.profilePicture,
    this.isPrivate,
    this.banner,
  });

  int? id;
  String? name;
  String? surname;
  String? username;
  String? profilePicture;
  bool? isPrivate;
  String? banner;

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        profilePicture: json["profilePicture"],
        isPrivate: json["isPrivate"],
        banner: json["banner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "username": username,
        "profilePicture": profilePicture,
        "isPrivate": isPrivate,
        "banner": banner,
      };
}
