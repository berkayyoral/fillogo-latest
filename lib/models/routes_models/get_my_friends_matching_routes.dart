// To parse this JSON data, do
//
//     final getMyFriendsMatchingRoutesResponse = getMyFriendsMatchingRoutesResponseFromJson(jsonString);

import 'dart:convert';

GetMyFriendsMatchingRoutesResponse getMyFriendsMatchingRoutesResponseFromJson(
        String str) =>
    GetMyFriendsMatchingRoutesResponse.fromJson(json.decode(str));

String getMyFriendsMatchingRoutesResponseToJson(
        GetMyFriendsMatchingRoutesResponse data) =>
    json.encode(data.toJson());

class GetMyFriendsMatchingRoutesResponse {
  int? success;
  List<GetMyFriendsMatchingResDatum>? data;
  String? message;

  GetMyFriendsMatchingRoutesResponse({
    this.success,
    this.data,
    this.message,
  });

  factory GetMyFriendsMatchingRoutesResponse.fromJson(
          Map<String, dynamic> json) =>
      GetMyFriendsMatchingRoutesResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<GetMyFriendsMatchingResDatum>.from(json["data"]!
                .map((x) => GetMyFriendsMatchingResDatum.fromJson(x))),
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

class GetMyFriendsMatchingResDatum {
  List<Matching>? matching;

  GetMyFriendsMatchingResDatum({
    this.matching,
  });

  factory GetMyFriendsMatchingResDatum.fromJson(Map<String, dynamic> json) =>
      GetMyFriendsMatchingResDatum(
        matching: json["matching"] == null
            ? []
            : List<Matching>.from(
                json["matching"]!.map((x) => Matching.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "matching": matching == null
            ? []
            : List<dynamic>.from(matching!.map((x) => x.toJson())),
      };
}

class Matching {
  int? id;
  String? profilePicture;
  String? name;
  String? surname;
  List<Userpostroute>? userpostroutes;
  List<Usertousercartype>? usertousercartypes;

  Matching({
    this.id,
    this.profilePicture,
    this.name,
    this.surname,
    this.userpostroutes,
    this.usertousercartypes,
  });

  factory Matching.fromJson(Map<String, dynamic> json) => Matching(
        id: json["id"],
        profilePicture: json["profilePicture"],
        name: json["name"],
        surname: json["surname"],
        userpostroutes: json["userpostroutes"] == null
            ? []
            : List<Userpostroute>.from(
                json["userpostroutes"]!.map((x) => Userpostroute.fromJson(x))),
        usertousercartypes: json["usertousercartypes"] == null
            ? []
            : List<Usertousercartype>.from(json["usertousercartypes"]!
                .map((x) => Usertousercartype.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profilePicture": profilePicture,
        "name": name,
        "surname": surname,
        "userpostroutes": userpostroutes == null
            ? []
            : List<dynamic>.from(userpostroutes!.map((x) => x.toJson())),
        "usertousercartypes": usertousercartypes == null
            ? []
            : List<dynamic>.from(usertousercartypes!.map((x) => x.toJson())),
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
  dynamic userLocation;
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

  Userpostroute({
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

  factory Userpostroute.fromJson(Map<String, dynamic> json) => Userpostroute(
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

class Usertousercartype {
  int? id;
  int? userId;
  int? carTypeId;
  String? carBrand;
  String? carModel;
  int? carCapacity;
  String? plateNumber;
  DateTime? createdAt;
  DateTime? updatedAt;
  Cartypetousercartypes? cartypetousercartypes;

  Usertousercartype({
    this.id,
    this.userId,
    this.carTypeId,
    this.carBrand,
    this.carModel,
    this.carCapacity,
    this.plateNumber,
    this.createdAt,
    this.updatedAt,
    this.cartypetousercartypes,
  });

  factory Usertousercartype.fromJson(Map<String, dynamic> json) =>
      Usertousercartype(
        id: json["id"],
        userId: json["userID"],
        carTypeId: json["carTypeID"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        carCapacity: json["carCapacity"],
        plateNumber: json["plateNumber"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        cartypetousercartypes: json["cartypetousercartypes"] == null
            ? null
            : Cartypetousercartypes.fromJson(json["cartypetousercartypes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "carTypeID": carTypeId,
        "carBrand": carBrand,
        "carModel": carModel,
        "carCapacity": carCapacity,
        "plateNumber": plateNumber,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "cartypetousercartypes": cartypetousercartypes?.toJson(),
      };
}

class Cartypetousercartypes {
  int? id;
  String? carType;
  String? driverType;

  Cartypetousercartypes({
    this.id,
    this.carType,
    this.driverType,
  });

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

class GetMyFriendsMatchingRoutesRequest {
  String? route;
  String? startingCity;
  String? endingCity;
  List<String>? carType;

  GetMyFriendsMatchingRoutesRequest({
    this.route,
    this.startingCity,
    this.endingCity,
    this.carType,
  });

  factory GetMyFriendsMatchingRoutesRequest.fromRawJson(String str) =>
      GetMyFriendsMatchingRoutesRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMyFriendsMatchingRoutesRequest.fromJson(
          Map<String, dynamic> json) =>
      GetMyFriendsMatchingRoutesRequest(
        route: json["route"],
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
        carType: json["carType"],
      );

  Map<String, dynamic> toJson() => {
        "route": route,
        "startingCity": startingCity,
        "endingCity": endingCity,
        "carType": carType,
      };
}
