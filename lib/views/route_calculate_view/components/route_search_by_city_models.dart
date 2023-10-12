import 'dart:convert';

class GetRouteSearchByCityRequestModel {
    GetRouteSearchByCityRequestModel({
        this.startLocation,
        this.endLocation,
    });

    String? startLocation;
    String? endLocation;

    factory GetRouteSearchByCityRequestModel.fromRawJson(String str) => GetRouteSearchByCityRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetRouteSearchByCityRequestModel.fromJson(Map<String, dynamic> json) => GetRouteSearchByCityRequestModel(
        startLocation: json["startLocation"],
        endLocation: json["endLocation"],
    );

    Map<String, dynamic> toJson() => {
        "startLocation": startLocation,
        "endLocation": endLocation,
    };
}



class GetRouteSearchByCityResponseModel {
    GetRouteSearchByCityResponseModel({
        this.success,
        this.data,
        this.message,
    });

    int? success;
    List<List<SearchByCityDatum>>? data;
    String? message;

    factory GetRouteSearchByCityResponseModel.fromRawJson(String str) => GetRouteSearchByCityResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetRouteSearchByCityResponseModel.fromJson(Map<String, dynamic> json) => GetRouteSearchByCityResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<List<SearchByCityDatum>>.from(json["data"]!.map((x) => List<SearchByCityDatum>.from(x.map((x) => SearchByCityDatum.fromJson(x))))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "message": message,
    };
}

class SearchByCityDatum {
    SearchByCityDatum({
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
        this.user,
    });

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
    SearchByCityUser? user;

    factory SearchByCityDatum.fromRawJson(String str) => SearchByCityDatum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SearchByCityDatum.fromJson(Map<String, dynamic> json) => SearchByCityDatum(
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
        user: json["user"] == null ? null : SearchByCityUser.fromJson(json["user"]),
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
        "user": user?.toJson(),
    };
}

class SearchByCityUser {
    SearchByCityUser({
        this.username,
    });

    String? username;

    factory SearchByCityUser.fromRawJson(String str) => SearchByCityUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SearchByCityUser.fromJson(Map<String, dynamic> json) => SearchByCityUser(
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
    };
}