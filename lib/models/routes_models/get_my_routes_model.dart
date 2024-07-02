// To parse this JSON data, do
//
//     final getMyRouteResponseModel = getMyRouteResponseModelFromJson(jsonString);

import 'dart:convert';

GetMyRouteResponseModel getMyRouteResponseModelFromJson(String str) =>
    GetMyRouteResponseModel.fromJson(json.decode(str));

String getMyRouteResponseModelToJson(GetMyRouteResponseModel data) =>
    json.encode(data.toJson());

class GetMyRouteResponseModel {
  int success;
  List<Datum> data;
  String message;

  GetMyRouteResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetMyRouteResponseModel.fromJson(Map<String, dynamic> json) =>
      GetMyRouteResponseModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  AllRoutes allRoutes;

  Datum({
    required this.allRoutes,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        allRoutes: AllRoutes.fromJson(json["allRoutes"]),
      );

  Map<String, dynamic> toJson() => {
        "allRoutes": allRoutes.toJson(),
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
        notStartedRoutes: List<MyRoutesDetails>.from(
            json["notStartedRoutes"].map((x) => MyRoutesDetails.fromJson(x))),
        activeRoutes: List<MyRoutesDetails>.from(
            json["activeRoutes"].map((x) => MyRoutesDetails.fromJson(x))),
        pastRoutes: List<MyRoutesDetails>.from(
            json["pastRoutes"].map((x) => MyRoutesDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notStartedRoutes":
            List<dynamic>.from(notStartedRoutes!.map((x) => x.toJson())),
        "activeRoutes": List<dynamic>.from(activeRoutes!.map((x) => x)),
        "pastRoutes": List<dynamic>.from(pastRoutes!.map((x) => x)),
      };
}

class MyRoutesDetails {
  int id;
  int userId;
  DateTime departureDate;
  DateTime arrivalDate;
  String routeDescription;
  int vehicleCapacity;
  dynamic isActive;
  dynamic userLocation;
  List<double> startingCoordinates;
  String startingOpenAdress;
  String startingCity;
  List<double> endingCoordinates;
  String endingOpenAdress;
  String endingCity;
  int distance;
  int travelTime;
  String polylineEncode;
  List<List<double>> polylineDecode;
  bool isInvisible;
  bool isAvailable;
  DateTime createdAt;
  DateTime updatedAt;

  MyRoutesDetails({
    required this.id,
    required this.userId,
    required this.departureDate,
    required this.arrivalDate,
    required this.routeDescription,
    required this.vehicleCapacity,
    required this.isActive,
    required this.userLocation,
    required this.startingCoordinates,
    required this.startingOpenAdress,
    required this.startingCity,
    required this.endingCoordinates,
    required this.endingOpenAdress,
    required this.endingCity,
    required this.distance,
    required this.travelTime,
    required this.polylineEncode,
    required this.polylineDecode,
    required this.isInvisible,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyRoutesDetails.fromJson(Map<String, dynamic> json) =>
      MyRoutesDetails(
        id: json["id"],
        userId: json["userID"],
        departureDate: DateTime.parse(json["departureDate"]),
        arrivalDate: DateTime.parse(json["arrivalDate"]),
        routeDescription: json["routeDescription"],
        vehicleCapacity: json["vehicleCapacity"],
        isActive: json["isActive"],
        userLocation: json["userLocation"],
        startingCoordinates: List<double>.from(
            json["startingCoordinates"].map((x) => x?.toDouble())),
        startingOpenAdress: json["startingOpenAdress"],
        startingCity: json["startingCity"],
        endingCoordinates: List<double>.from(
            json["endingCoordinates"].map((x) => x?.toDouble())),
        endingOpenAdress: json["endingOpenAdress"],
        endingCity: json["endingCity"],
        distance: json["distance"],
        travelTime: json["travelTime"],
        polylineEncode: json["polylineEncode"],
        polylineDecode: List<List<double>>.from(json["polylineDecode"]
            .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        isInvisible: json["isInvisible"],
        isAvailable: json["isAvailable"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "departureDate": departureDate.toIso8601String(),
        "arrivalDate": arrivalDate.toIso8601String(),
        "routeDescription": routeDescription,
        "vehicleCapacity": vehicleCapacity,
        "isActive": isActive,
        "userLocation": userLocation,
        "startingCoordinates":
            List<dynamic>.from(startingCoordinates.map((x) => x)),
        "startingOpenAdress": startingOpenAdress,
        "startingCity": startingCity,
        "endingCoordinates":
            List<dynamic>.from(endingCoordinates.map((x) => x)),
        "endingOpenAdress": endingOpenAdress,
        "endingCity": endingCity,
        "distance": distance,
        "travelTime": travelTime,
        "polylineEncode": polylineEncode,
        "polylineDecode": List<dynamic>.from(
            polylineDecode.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "isInvisible": isInvisible,
        "isAvailable": isAvailable,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
