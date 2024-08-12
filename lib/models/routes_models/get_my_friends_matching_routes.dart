// To parse this JSON data, do
//
//     final getMatchingRoutesResponse = getMatchingRoutesResponseFromJson(jsonString);

import 'dart:convert';

GetMatchingRoutesResponse getMatchingRoutesResponseFromJson(String str) =>
    GetMatchingRoutesResponse.fromJson(json.decode(str));

String getMatchingRoutesResponseToJson(GetMatchingRoutesResponse data) =>
    json.encode(data.toJson());

class GetMatchingRoutesResponse {
  int? success;
  List<MatchingRoutes>? matchingRoutes;
  String? message;

  GetMatchingRoutesResponse({
    this.success,
    this.matchingRoutes,
    this.message,
  });

  GetMatchingRoutesResponse copyWith({
    int? success,
    List<MatchingRoutes>? data,
    String? message,
  }) =>
      GetMatchingRoutesResponse(
        success: success ?? this.success,
        matchingRoutes: data ?? this.matchingRoutes,
        message: message ?? this.message,
      );

  factory GetMatchingRoutesResponse.fromJson(Map<String, dynamic> json) =>
      GetMatchingRoutesResponse(
        success: json["success"],
        matchingRoutes: json["data"] == null
            ? []
            : List<MatchingRoutes>.from(
                json["data"]!.map((x) => MatchingRoutes.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": matchingRoutes == null
            ? []
            : List<dynamic>.from(matchingRoutes!.map((x) => x.toJson())),
        "message": message,
      };
}

class MatchingRoutes {
  List<Matching>? matching;

  MatchingRoutes({
    this.matching,
  });

  MatchingRoutes copyWith({
    List<Matching>? matching,
  }) =>
      MatchingRoutes(
        matching: matching ?? this.matching,
      );

  factory MatchingRoutes.fromJson(Map<String, dynamic> json) => MatchingRoutes(
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
  MatchedOn? matchedOn;

  Matching({
    this.id,
    this.profilePicture,
    this.name,
    this.surname,
    this.userpostroutes,
    this.usertousercartypes,
    this.matchedOn,
  });

  Matching copyWith({
    int? id,
    String? profilePicture,
    String? name,
    String? surname,
    List<Userpostroute>? userpostroutes,
    List<Usertousercartype>? usertousercartypes,
    MatchedOn? matchedOn,
  }) =>
      Matching(
        id: id ?? this.id,
        profilePicture: profilePicture ?? this.profilePicture,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        userpostroutes: userpostroutes ?? this.userpostroutes,
        usertousercartypes: usertousercartypes ?? this.usertousercartypes,
        matchedOn: matchedOn ?? this.matchedOn,
      );

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
        matchedOn: json["matchedOn"] == null
            ? null
            : MatchedOn.fromJson(json["matchedOn"]),
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
        "matchedOn": matchedOn?.toJson(),
      };
}

class MatchedOn {
  String? city;
  String? district;

  MatchedOn({
    this.city,
    this.district,
  });

  MatchedOn copyWith({
    String? city,
    String? district,
  }) =>
      MatchedOn(
        city: city ?? this.city,
        district: district ?? this.district,
      );

  factory MatchedOn.fromJson(Map<String, dynamic> json) => MatchedOn(
        city: json["city"],
        district: json["district"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "district": district,
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

  Userpostroute copyWith({
    int? id,
    int? userId,
    DateTime? departureDate,
    DateTime? arrivalDate,
    String? routeDescription,
    int? vehicleCapacity,
    bool? isActive,
    dynamic userLocation,
    List<double>? startingCoordinates,
    String? startingOpenAdress,
    String? startingCity,
    List<double>? endingCoordinates,
    String? endingOpenAdress,
    String? endingCity,
    int? distance,
    int? travelTime,
    String? polylineEncode,
    List<List<double>>? polylineDecode,
    bool? isInvisible,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Userpostroute(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        departureDate: departureDate ?? this.departureDate,
        arrivalDate: arrivalDate ?? this.arrivalDate,
        routeDescription: routeDescription ?? this.routeDescription,
        vehicleCapacity: vehicleCapacity ?? this.vehicleCapacity,
        isActive: isActive ?? this.isActive,
        userLocation: userLocation ?? this.userLocation,
        startingCoordinates: startingCoordinates ?? this.startingCoordinates,
        startingOpenAdress: startingOpenAdress ?? this.startingOpenAdress,
        startingCity: startingCity ?? this.startingCity,
        endingCoordinates: endingCoordinates ?? this.endingCoordinates,
        endingOpenAdress: endingOpenAdress ?? this.endingOpenAdress,
        endingCity: endingCity ?? this.endingCity,
        distance: distance ?? this.distance,
        travelTime: travelTime ?? this.travelTime,
        polylineEncode: polylineEncode ?? this.polylineEncode,
        polylineDecode: polylineDecode ?? this.polylineDecode,
        isInvisible: isInvisible ?? this.isInvisible,
        isAvailable: isAvailable ?? this.isAvailable,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

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

  Usertousercartype copyWith({
    int? id,
    int? userId,
    int? carTypeId,
    String? carBrand,
    String? carModel,
    int? carCapacity,
    String? plateNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    Cartypetousercartypes? cartypetousercartypes,
  }) =>
      Usertousercartype(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        carTypeId: carTypeId ?? this.carTypeId,
        carBrand: carBrand ?? this.carBrand,
        carModel: carModel ?? this.carModel,
        carCapacity: carCapacity ?? this.carCapacity,
        plateNumber: plateNumber ?? this.plateNumber,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        cartypetousercartypes:
            cartypetousercartypes ?? this.cartypetousercartypes,
      );

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

  Cartypetousercartypes copyWith({
    int? id,
    String? carType,
    String? driverType,
  }) =>
      Cartypetousercartypes(
        id: id ?? this.id,
        carType: carType ?? this.carType,
        driverType: driverType ?? this.driverType,
      );

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
