// To parse this JSON data, do
//
//     final getMyRouteResponseModel = getMyRouteResponseModelFromJson(jsonString);

import 'dart:convert';

GetMyRouteResponseModel getMyRouteResponseModelFromJson(String str) =>
    GetMyRouteResponseModel.fromJson(json.decode(str));

String getMyRouteResponseModelToJson(GetMyRouteResponseModel data) =>
    json.encode(data.toJson());

class GetMyRouteResponseModel {
  int? success;
  List<Datum>? data;
  String? message;

  GetMyRouteResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetMyRouteResponseModel.fromJson(Map<String, dynamic> json) =>
      GetMyRouteResponseModel(
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
  AllRoutes? allRoutes;

  Datum({
    this.allRoutes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        allRoutes: json["allRoutes"] == null
            ? null
            : AllRoutes.fromJson(json["allRoutes"]),
      );

  Map<String, dynamic> toJson() => {
        "allRoutes": allRoutes?.toJson(),
      };
}

class AllRoutes {
  List<MyRoutesDetails>? notStartedRoutes;
  List<MyRoutesDetails>? activeRoutes;
  List<MyRoutesDetails>? pastRoutes;

  AllRoutes({
    this.notStartedRoutes,
    this.activeRoutes,
    this.pastRoutes,
  });

  factory AllRoutes.fromJson(Map<String, dynamic> json) => AllRoutes(
        notStartedRoutes: json["notStartedRoutes"] == null
            ? []
            : List<MyRoutesDetails>.from(
                json["notStartedRoutes"]!.map((x) => x)),
        activeRoutes: json["activeRoutes"] == null
            ? []
            : List<MyRoutesDetails>.from(
                json["activeRoutes"]!.map((x) => MyRoutesDetails.fromJson(x))),
        pastRoutes: json["pastRoutes"] == null
            ? []
            : List<MyRoutesDetails>.from(
                json["pastRoutes"]!.map((x) => MyRoutesDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notStartedRoutes": notStartedRoutes == null
            ? []
            : List<dynamic>.from(notStartedRoutes!.map((x) => x)),
        "activeRoutes": activeRoutes == null
            ? []
            : List<dynamic>.from(activeRoutes!.map((x) => x.toJson())),
        "pastRoutes": pastRoutes == null
            ? []
            : List<dynamic>.from(pastRoutes!.map((x) => x.toJson())),
      };
}

class MyRoutesDetails {
  int? id;
  int? userId;
  DateTime? departureDate;
  DateTime? arrivalDate;
  String? routeDescription;
  int? vehicleCapacity;
  bool? isActive;
  String? userLocation;
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
  bool? isInvisible;
  bool? isAvailable;
  DateTime? createdAt;
  DateTime? updatedAt;

  MyRoutesDetails({
    this.id,
    this.userId,
    this.departureDate,
    this.arrivalDate,
    this.routeDescription,
    this.vehicleCapacity,
    this.isActive,
    this.userLocation,
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
    this.isInvisible,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory MyRoutesDetails.fromJson(Map<String, dynamic> json) =>
      MyRoutesDetails(
        id: json["id"],
        userId: json["userID"],
        departureDate: json["departureDate"] == null
            ? null
            : DateTime.parse(json["departureDate"]),
        arrivalDate: json["arrivalDate"] == null
            ? null
            : DateTime.parse(json["arrivalDate"]),
        routeDescription: json["routeDescription"],
        vehicleCapacity: json["vehicleCapacity"],
        isActive: json["isActive"],
        userLocation: json["userLocation"],
        startingCoordinates: json["startingCoordinates"] == null
            ? []
            : List<double>.from(
                json["startingCoordinates"]!.map((x) => x?.toDouble())),
        startingOpenAdress: json["startingOpenAdress"],
        startingCity: json["startingCity"],
        endingCoordinates: json["endingCoordinates"] == null
            ? []
            : List<double>.from(
                json["endingCoordinates"]!.map((x) => x?.toDouble())),
        endingOpenAdress: json["endingOpenAdress"],
        endingCity: json["endingCity"],
        distance: json["distance"],
        travelTime: json["travelTime"],
        polylineEncode: json["polylineEncode"],
        polylineDecode: json["polylineDecode"] == null
            ? []
            : List<List<double>>.from(json["polylineDecode"]!
                .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        isInvisible: json["isInvisible"],
        isAvailable: json["isAvailable"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "departureDate": departureDate?.toIso8601String(),
        "arrivalDate": arrivalDate?.toIso8601String(),
        "routeDescription": routeDescription,
        "vehicleCapacity": vehicleCapacity,
        "isActive": isActive,
        "userLocation": userLocation,
        "startingCoordinates": startingCoordinates == null
            ? []
            : List<dynamic>.from(startingCoordinates!.map((x) => x)),
        "startingOpenAdress": startingOpenAdress,
        "startingCity": startingCity,
        "endingCoordinates": endingCoordinates == null
            ? []
            : List<dynamic>.from(endingCoordinates!.map((x) => x)),
        "endingOpenAdress": endingOpenAdress,
        "endingCity": endingCity,
        "distance": distance,
        "travelTime": travelTime,
        "polylineEncode": polylineEncode,
        "polylineDecode": polylineDecode == null
            ? []
            : List<dynamic>.from(polylineDecode!
                .map((x) => List<dynamic>.from(x.map((x) => x)))),
        "isInvisible": isInvisible,
        "isAvailable": isAvailable,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
