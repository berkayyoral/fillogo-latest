import 'dart:convert';

class GetRoutesResponseModel {
  GetRoutesResponseModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<RoutesDatum>? data;
  String? message;

  factory GetRoutesResponseModel.fromRawJson(String str) =>
      GetRoutesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetRoutesResponseModel.fromJson(Map<String, dynamic> json) =>
      GetRoutesResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<RoutesDatum>.from(
                json["data"]!.map((x) => RoutesDatum.fromJson(x))),
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

class RoutesDatum {
  RoutesDatum({
    this.allRoutes,
  });

  AllRoutes? allRoutes;

  factory RoutesDatum.fromRawJson(String str) =>
      RoutesDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoutesDatum.fromJson(Map<String, dynamic> json) => RoutesDatum(
        allRoutes: json["allRoutes"] == null
            ? null
            : AllRoutes.fromJson(json["allRoutes"]),
      );

  Map<String, dynamic> toJson() => {
        "allRoutes": allRoutes?.toJson(),
      };
}

class AllRoutes {
  AllRoutes({
    this.past,
    this.active,
  });

  List<Active>? past;
  List<Active>? active;

  factory AllRoutes.fromRawJson(String str) =>
      AllRoutes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllRoutes.fromJson(Map<String, dynamic> json) => AllRoutes(
        past: json["past"] == null
            ? []
            : List<Active>.from(json["past"]!.map((x) => Active.fromJson(x))),
        active: json["active"] == null
            ? []
            : List<Active>.from(json["active"]!.map((x) => Active.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "past": past == null
            ? []
            : List<dynamic>.from(past!.map((x) => x.toJson())),
        "active": active == null
            ? []
            : List<dynamic>.from(active!.map((x) => x.toJson())),
      };
}

class Active {
  Active({
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

  factory Active.fromRawJson(String str) => Active.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Active.fromJson(Map<String, dynamic> json) => Active(
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
