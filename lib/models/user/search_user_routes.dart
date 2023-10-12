// To parse this JSON data, do
//
//     final searchUserRoutesRequest = searchUserRoutesRequestFromJson(jsonString);

import 'dart:convert';

class SearchUserRoutesRequest {
    String? startingCity;
    String? endingCity;
    int? userId;

    SearchUserRoutesRequest({
        this.startingCity,
        this.endingCity,
        this.userId,
    });

    factory SearchUserRoutesRequest.fromRawJson(String str) => SearchUserRoutesRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SearchUserRoutesRequest.fromJson(Map<String, dynamic> json) => SearchUserRoutesRequest(
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
        userId: json["userID"],
    );

    Map<String, dynamic> toJson() => {
        "startingCity": startingCity,
        "endingCity": endingCity,
        "userID": userId,
    };
}

// To parse this JSON data, do
//
//     final searchUserRoutesResponse = searchUserRoutesResponseFromJson(jsonString);


// To parse this JSON data, do
//
//     final searchUserRoutesResponse = searchUserRoutesResponseFromJson(jsonString);


class SearchUserRoutesResponse {
    int? success;
    List<Datum>? data;
    String? message;

    SearchUserRoutesResponse({
        this.success,
        this.data,
        this.message,
    });

    factory SearchUserRoutesResponse.fromRawJson(String str) => SearchUserRoutesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SearchUserRoutesResponse.fromJson(Map<String, dynamic> json) => SearchUserRoutesResponse(
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
    List<Active>? active;
    List<dynamic>? future;
    List<dynamic>? past;

    Datum({
        this.active,
        this.future,
        this.past,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        active: json["active"] == null ? [] : List<Active>.from(json["active"]!.map((x) => Active.fromJson(x))),
        future: json["future"] == null ? [] : List<dynamic>.from(json["future"]!.map((x) => x)),
        past: json["past"] == null ? [] : List<dynamic>.from(json["past"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "active": active == null ? [] : List<dynamic>.from(active!.map((x) => x.toJson())),
        "future": future == null ? [] : List<dynamic>.from(future!.map((x) => x)),
        "past": past == null ? [] : List<dynamic>.from(past!.map((x) => x)),
    };
}

class Active {
    int? id;
    DateTime? departureDate;
    String? startingCity;
    DateTime? arrivalDate;
    String? endingCity;
    bool? isActive;
    User? user;

    Active({
        this.id,
        this.departureDate,
        this.startingCity,
        this.arrivalDate,
        this.endingCity,
        this.isActive,
        this.user,
    });

    factory Active.fromRawJson(String str) => Active.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Active.fromJson(Map<String, dynamic> json) => Active(
        id: json["id"],
        departureDate: json["departureDate"] == null ? null : DateTime.parse(json["departureDate"]),
        startingCity: json["startingCity"],
        arrivalDate: json["arrivalDate"] == null ? null : DateTime.parse(json["arrivalDate"]),
        endingCity: json["endingCity"],
        isActive: json["isActive"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "departureDate": departureDate?.toIso8601String(),
        "startingCity": startingCity,
        "arrivalDate": arrivalDate?.toIso8601String(),
        "endingCity": endingCity,
        "isActive": isActive,
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? surname;
    String? profilePicture;

    User({
        this.id,
        this.name,
        this.surname,
        this.profilePicture,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
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
