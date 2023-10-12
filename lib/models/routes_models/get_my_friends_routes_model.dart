import 'dart:convert';

class GetMyFriendsRouteResponseModel {
    GetMyFriendsRouteResponseModel({
        this.success,
        this.data,
        this.message,
    });

    int? success;
    List<GetMyFriendsResDatum>? data;
    String? message;

    factory GetMyFriendsRouteResponseModel.fromRawJson(String str) => GetMyFriendsRouteResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsRouteResponseModel.fromJson(Map<String, dynamic> json) => GetMyFriendsRouteResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<GetMyFriendsResDatum>.from(json["data"]!.map((x) => GetMyFriendsResDatum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class GetMyFriendsResDatum {
    GetMyFriendsResDatum({
        this.followed,
    });

    GetMyFriendsResFollowed? followed;

    factory GetMyFriendsResDatum.fromRawJson(String str) => GetMyFriendsResDatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsResDatum.fromJson(Map<String, dynamic> json) => GetMyFriendsResDatum(
        followed: json["followed"] == null ? null : GetMyFriendsResFollowed.fromJson(json["followed"]),
    );

    Map<String, dynamic> toJson() => {
        "followed": followed?.toJson(),
    };
}

class GetMyFriendsResFollowed {
    GetMyFriendsResFollowed({
        this.id,
        this.profilePicture,
        this.name,
        this.surname,
        this.userpostroutes,
    });

    int? id;
    String? profilePicture;
    String? name;
    String? surname;
    List<GetMyFriendsResUserpostroute>? userpostroutes;

    factory GetMyFriendsResFollowed.fromRawJson(String str) => GetMyFriendsResFollowed.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsResFollowed.fromJson(Map<String, dynamic> json) => GetMyFriendsResFollowed(
        id: json["id"],
        profilePicture: json["profilePicture"],
        name: json["name"],
        surname: json["surname"],
        userpostroutes: json["userpostroutes"] == null ? [] : List<GetMyFriendsResUserpostroute>.from(json["userpostroutes"]!.map((x) => GetMyFriendsResUserpostroute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profilePicture": profilePicture,
        "name": name,
        "surname": surname,
        "userpostroutes": userpostroutes == null ? [] : List<dynamic>.from(userpostroutes!.map((x) => x.toJson())),
    };
}

class GetMyFriendsResUserpostroute {
    GetMyFriendsResUserpostroute({
        this.id,
        this.departureDate,
        this.arrivalDate,
        this.startingCity,
        this.endingCity,
        this.currentRoute,
    });

    int? id;
    DateTime? departureDate;
    DateTime? arrivalDate;
    String? startingCity;
    String? endingCity;
    List<double>? currentRoute;

    factory GetMyFriendsResUserpostroute.fromRawJson(String str) => GetMyFriendsResUserpostroute.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsResUserpostroute.fromJson(Map<String, dynamic> json) => GetMyFriendsResUserpostroute(
        id: json["id"],
        departureDate: json["departureDate"] == null ? null : DateTime.parse(json["departureDate"]),
        arrivalDate: json["arrivalDate"] == null ? null : DateTime.parse(json["arrivalDate"]),
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
        currentRoute: json["currentRoute"] == null ? [] : List<double>.from(json["currentRoute"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "departureDate": departureDate?.toIso8601String(),
        "arrivalDate": arrivalDate?.toIso8601String(),
        "startingCity": startingCity,
        "endingCity": endingCity,
        "currentRoute": currentRoute == null ? [] : List<dynamic>.from(currentRoute!.map((x) => x)),
    };
}