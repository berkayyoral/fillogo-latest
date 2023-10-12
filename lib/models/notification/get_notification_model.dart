// To parse this JSON data, do
//
//     final getNotificationModel = getNotificationModelFromJson(jsonString);

import 'dart:convert';

class GetNotificationResponseModel {
    int? success;
    List<Datum>? data;
    String? message;

    GetNotificationResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory GetNotificationResponseModel.fromRawJson(String str) => GetNotificationResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetNotificationResponseModel.fromJson(Map<String, dynamic> json) => GetNotificationResponseModel(
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
    Formatted? formatted;

    Datum({
        this.formatted,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        formatted: json["formatted"] == null ? null : Formatted.fromJson(json["formatted"]),
    );

    Map<String, dynamic> toJson() => {
        "formatted": formatted?.toJson(),
    };
}

class Formatted {
    List<Older>? today;
    List<Older>? thisWeek;
    List<Older>? thisMonth;
    List<Older>? older;

    Formatted({
        this.today,
        this.thisWeek,
        this.thisMonth,
        this.older,
    });

    factory Formatted.fromRawJson(String str) => Formatted.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Formatted.fromJson(Map<String, dynamic> json) => Formatted(
        today: json["today"] == null ? [] : List<Older>.from(json["today"]!.map((x) => Older.fromJson(x))),
        thisWeek: json["thisWeek"] == null ? [] : List<Older>.from(json["thisWeek"]!.map((x) => Older.fromJson(x))),
        thisMonth: json["thisMonth"] == null ? [] : List<Older>.from(json["thisMonth"]!.map((x) => Older.fromJson(x))),
        older: json["older"] == null ? [] : List<Older>.from(json["older"]!.map((x) => Older.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "today": today == null ? [] : List<dynamic>.from(today!.map((x) => x.toJson())),
        "thisWeek": thisWeek == null ? [] : List<dynamic>.from(thisWeek!.map((x) => x.toJson())),
        "thisMonth": thisMonth == null ? [] : List<dynamic>.from(thisMonth!.map((x) => x.toJson())),
        "older": older == null ? [] : List<dynamic>.from(older!.map((x) => x.toJson())),
    };
}

class Older {
    int? id;
    int? userId;
    int? senderId;
    int? type;
    String? username;
    String? content;
    String? link;
    List<dynamic>? params;
    bool? seen;
    DateTime? createdAt;
    Sender? sender;

    Older({
        this.id,
        this.userId,
        this.senderId,
        this.type,
        this.username,
        this.content,
        this.link,
        this.params,
        this.seen,
        this.createdAt,
        this.sender,
    });

    factory Older.fromRawJson(String str) => Older.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Older.fromJson(Map<String, dynamic> json) => Older(
        id: json["id"],
        userId: json["userID"],
        senderId: json["senderID"],
        type: json["type"],
        username: json["username"],
        content: json["content"],
        link: json["link"],
        params: json["params"] == null ? [] : List<dynamic>.from(json["params"]!.map((x) => x)),
        seen: json["seen"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "senderID": senderId,
        "type": type,
        "username": username,
        "content": content,
        "link": link,
        "params": params == null ? [] : List<dynamic>.from(params!.map((x) => x)),
        "seen": seen,
        "createdAt": createdAt?.toIso8601String(),
        "sender": sender?.toJson(),
    };
}

class Sender {
    int? id;
    String? username;
    String? profilePicture;

    Sender({
        this.id,
        this.username,
        this.profilePicture,
    });

    factory Sender.fromRawJson(String str) => Sender.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        username: json["username"],
        profilePicture: json["profilePicture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profilePicture": profilePicture,
    };
}
