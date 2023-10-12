// To parse this JSON data, do
//
//     final getMyFriendsMatchingRoutesResponse = getMyFriendsMatchingRoutesResponseFromJson(jsonString);

import 'dart:convert';

class GetMyFriendsMatchingRoutesResponse {
    int? success;
    List<GetMyFriendsMatchingResDatum>? data;
    String? message;

    GetMyFriendsMatchingRoutesResponse({
        this.success,
        this.data,
        this.message,
    });

    factory GetMyFriendsMatchingRoutesResponse.fromRawJson(String str) => GetMyFriendsMatchingRoutesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsMatchingRoutesResponse.fromJson(Map<String, dynamic> json) => GetMyFriendsMatchingRoutesResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<GetMyFriendsMatchingResDatum>.from(json["data"]!.map((x) => GetMyFriendsMatchingResDatum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class GetMyFriendsMatchingResDatum {
    List<Matching>? matching;

    GetMyFriendsMatchingResDatum({
        this.matching,
    });

    factory GetMyFriendsMatchingResDatum.fromRawJson(String str) => GetMyFriendsMatchingResDatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsMatchingResDatum.fromJson(Map<String, dynamic> json) => GetMyFriendsMatchingResDatum(
        matching: json["matching"] == null ? [] : List<Matching>.from(json["matching"]!.map((x) => Matching.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "matching": matching == null ? [] : List<dynamic>.from(matching!.map((x) => x.toJson())),
    };
}

class Matching {
    Followed? followed;

    Matching({
        this.followed,
    });

    factory Matching.fromRawJson(String str) => Matching.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Matching.fromJson(Map<String, dynamic> json) => Matching(
        followed: json["followed"] == null ? null : Followed.fromJson(json["followed"]),
    );

    Map<String, dynamic> toJson() => {
        "followed": followed?.toJson(),
    };
}

class Followed {
    int? id;
    String? profilePicture;
    String? name;
    String? surname;
    List<Userpostroute>? userpostroutes;

    Followed({
        this.id,
        this.profilePicture,
        this.name,
        this.surname,
        this.userpostroutes,
    });

    factory Followed.fromRawJson(String str) => Followed.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Followed.fromJson(Map<String, dynamic> json) => Followed(
        id: json["id"],
        profilePicture: json["profilePicture"],
        name: json["name"],
        surname: json["surname"],
        userpostroutes: json["userpostroutes"] == null ? [] : List<Userpostroute>.from(json["userpostroutes"]!.map((x) => Userpostroute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "profilePicture": profilePicture,
        "name": name,
        "surname": surname,
        "userpostroutes": userpostroutes == null ? [] : List<dynamic>.from(userpostroutes!.map((x) => x.toJson())),
    };
}

class Userpostroute {
    int? id;
    int? userId;
    DateTime? departureDate;
    DateTime? arrivalDate;
    String? routeDescription;
    int? vehicleCapacity;
    bool? isActive;
    List<double>? startingCoordinates;
    String? startingOpenAdress;
    String? startingCity;
    List<double>? endingCoordinates;
    String? endingOpenAdress;
    String? endingCity;
    int? distance;
    int? travelTime;
    String? polylineEncode;
    List<List<double>>? polylineDecode;
    DateTime? createdAt;
    DateTime? updatedAt;

    Userpostroute({
        this.id,
        this.userId,
        this.departureDate,
        this.arrivalDate,
        this.routeDescription,
        this.vehicleCapacity,
        this.isActive,
        this.startingCoordinates,
        this.startingOpenAdress,
        this.startingCity,
        this.endingCoordinates,
        this.endingOpenAdress,
        this.endingCity,
        this.distance,
        this.travelTime,
        this.polylineEncode,
        this.polylineDecode,
        this.createdAt,
        this.updatedAt,
    });

    factory Userpostroute.fromRawJson(String str) => Userpostroute.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Userpostroute.fromJson(Map<String, dynamic> json) => Userpostroute(
        id: json["id"],
        userId: json["userID"],
        departureDate: json["departureDate"] == null ? null : DateTime.parse(json["departureDate"]),
        arrivalDate: json["arrivalDate"] == null ? null : DateTime.parse(json["arrivalDate"]),
        routeDescription: json["routeDescription"],
        vehicleCapacity: json["vehicleCapacity"],
        isActive: json["isActive"],
        startingCoordinates: json["startingCoordinates"] == null ? [] : List<double>.from(json["startingCoordinates"]!.map((x) => x?.toDouble())),
        startingOpenAdress: json["startingOpenAdress"],
        startingCity: json["startingCity"],
        endingCoordinates: json["endingCoordinates"] == null ? [] : List<double>.from(json["endingCoordinates"]!.map((x) => x?.toDouble())),
        endingOpenAdress: json["endingOpenAdress"],
        endingCity: json["endingCity"],
        distance: json["distance"],
        travelTime: json["travelTime"],
        polylineEncode: json["polylineEncode"],
        polylineDecode: json["polylineDecode"] == null ? [] : List<List<double>>.from(json["polylineDecode"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "departureDate": departureDate?.toIso8601String(),
        "arrivalDate": arrivalDate?.toIso8601String(),
        "routeDescription": routeDescription,
        "vehicleCapacity": vehicleCapacity,
        "isActive": isActive,
        "startingCoordinates": startingCoordinates == null ? [] : List<dynamic>.from(startingCoordinates!.map((x) => x)),
        "startingOpenAdress": startingOpenAdress,
        "startingCity": startingCity,
        "endingCoordinates": endingCoordinates == null ? [] : List<dynamic>.from(endingCoordinates!.map((x) => x)),
        "endingOpenAdress": endingOpenAdress,
        "endingCity": endingCity,
        "distance": distance,
        "travelTime": travelTime,
        "polylineEncode": polylineEncode,
        "polylineDecode": polylineDecode == null ? [] : List<dynamic>.from(polylineDecode!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class GetMyFriendsMatchingRoutesRequest {
    String? route;
    String? startingCity;
    String? endingCity;

    GetMyFriendsMatchingRoutesRequest({
        this.route,
        this.startingCity,
        this.endingCity,
    });

    factory GetMyFriendsMatchingRoutesRequest.fromRawJson(String str) => GetMyFriendsMatchingRoutesRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetMyFriendsMatchingRoutesRequest.fromJson(Map<String, dynamic> json) => GetMyFriendsMatchingRoutesRequest(
        route: json["route"],
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
    );

    Map<String, dynamic> toJson() => {
        "route": route,
        "startingCity": startingCity,
        "endingCity": endingCity,
    };
}
