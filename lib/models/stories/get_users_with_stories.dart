// To parse this JSON data, do
//
//     final getUsersWithStories = getUsersWithStoriesFromJson(jsonString);

import 'dart:convert';

class GetUsersWithStories {
    int? success;
    List<Datum>? data;
    String? message;

    GetUsersWithStories({
        this.success,
        this.data,
        this.message,
    });

    factory GetUsersWithStories.fromRawJson(String str) => GetUsersWithStories.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetUsersWithStories.fromJson(Map<String, dynamic> json) => GetUsersWithStories(
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
    Followed? followed;

    Datum({
        this.followed,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        followed: json["followed"] == null ? null : Followed.fromJson(json["followed"]),
    );

    Map<String, dynamic> toJson() => {
        "followed": followed?.toJson(),
    };
}

class Followed {
    int? id;
    String? username;
    String? profilePicture;
    String? name;
    String? surname;
    List<Story>? stories;

    Followed({
        this.id,
        this.username,
        this.profilePicture,
        this.name,
        this.surname,
        this.stories,
    });

    factory Followed.fromRawJson(String str) => Followed.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Followed.fromJson(Map<String, dynamic> json) => Followed(
        id: json["id"],
        username: json["username"],
        profilePicture: json["profilePicture"],
        name: json["name"],
        surname: json["surname"],
        stories: json["stories"] == null ? [] : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profilePicture": profilePicture,
        "name": name,
        "surname": surname,
        "stories": stories == null ? [] : List<dynamic>.from(stories!.map((x) => x.toJson())),
    };
}

class Story {
    int? id;
    String? url;

    Story({
        this.id,
        this.url,
    });

    factory Story.fromRawJson(String str) => Story.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
    };
}
