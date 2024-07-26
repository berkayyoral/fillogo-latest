// To parse this JSON data, do
//
//     final usersOnArea = usersOnAreaFromJson(jsonString);

import 'dart:convert';

UsersOnAreaModel usersOnAreaFromJson(String str) =>
    UsersOnAreaModel.fromJson(json.decode(str));

String usersOnAreaToJson(UsersOnAreaModel data) => json.encode(data.toJson());

class UsersOnAreaModel {
  int? succes;
  List<List<GetUsersOnAreaResDatum>>? data;
  String? message;

  UsersOnAreaModel({
    this.succes,
    this.data,
    this.message,
  });

  factory UsersOnAreaModel.fromJson(Map<String, dynamic> json) =>
      UsersOnAreaModel(
        succes: json["succes"],
        data: json["data"] == null
            ? []
            : List<List<GetUsersOnAreaResDatum>>.from(json["data"]!.map((x) =>
                List<GetUsersOnAreaResDatum>.from(
                    x.map((x) => GetUsersOnAreaResDatum.fromJson(x))))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "data": data == null
            ? []
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "message": message,
      };
}

class GetUsersOnAreaResDatum {
  int? userId;
  String? name;
  String? surname;
  String? mail;
  dynamic phoneNumber;
  String? title;
  bool? isOpen;
  String? profilePic;
  double? latitude;
  double? longitude;
  bool? isAvailable;
  bool? isInvisible;
  List<Userpostroute>? userpostroutes;
  List<Usertousercartype>? usertousercartypes;

  GetUsersOnAreaResDatum({
    this.userId,
    this.name,
    this.surname,
    this.mail,
    this.phoneNumber,
    this.title,
    this.isOpen,
    this.profilePic,
    this.latitude,
    this.longitude,
    this.isAvailable,
    this.isInvisible,
    this.userpostroutes,
    this.usertousercartypes,
  });

  factory GetUsersOnAreaResDatum.fromJson(Map<String, dynamic> json) =>
      GetUsersOnAreaResDatum(
        userId: json["userID"],
        name: json["name"],
        surname: json["surname"],
        mail: json["mail"],
        phoneNumber: json["phoneNumber"],
        title: json["title"],
        isOpen: json["isOpen"],
        profilePic: json["profilePic"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        isAvailable: json["isAvailable"],
        isInvisible: json["isInvisible"],
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
        "userID": userId,
        "name": name,
        "surname": surname,
        "mail": mail,
        "phoneNumber": phoneNumber,
        "title": title,
        "isOpen": isOpen,
        "profilePic": profilePic,
        "latitude": latitude,
        "longitude": longitude,
        "isAvailable": isAvailable,
        "isInvisible": isInvisible,
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
  int? carTypeId;
  String? carBrand;
  String? carModel;
  Cartypetousercartypes? cartypetousercartypes;

  Usertousercartype({
    this.id,
    this.carTypeId,
    this.carBrand,
    this.carModel,
    this.cartypetousercartypes,
  });

  factory Usertousercartype.fromJson(Map<String, dynamic> json) =>
      Usertousercartype(
        id: json["id"],
        carTypeId: json["carTypeID"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        cartypetousercartypes: json["cartypetousercartypes"] == null
            ? null
            : Cartypetousercartypes.fromJson(json["cartypetousercartypes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carTypeID": carTypeId,
        "carBrand": carBrand,
        "carModel": carModel,
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
