import 'dart:convert';

class GetRouteSearchByCityRequestModel {
  GetRouteSearchByCityRequestModel({
    this.startLocation,
    this.endLocation,
    required this.departureDate,
    required this.carType,
  });

  String? startLocation;
  String? endLocation;
  String departureDate;
  List<String> carType;

  factory GetRouteSearchByCityRequestModel.fromRawJson(String str) =>
      GetRouteSearchByCityRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetRouteSearchByCityRequestModel.fromJson(
          Map<String, dynamic> json) =>
      GetRouteSearchByCityRequestModel(
        startLocation: json["startLocation"],
        endLocation: json["endLocation"],
        departureDate: json["departureDate"],
        carType: json["carType"],
      );

  Map<String, dynamic> toJson() => {
        "startLocation": startLocation,
        "endLocation": endLocation,
        "departureDate": departureDate,
        "carType": carType
      };
}

GetRouteSearchByCityResponseModel getRouteSearchByCityResponseModelFromJson(
        String str) =>
    GetRouteSearchByCityResponseModel.fromJson(json.decode(str));

String getRouteSearchByCityResponseModelToJson(
        GetRouteSearchByCityResponseModel data) =>
    json.encode(data.toJson());

class GetRouteSearchByCityResponseModel {
  int? success;
  List<List<SearchByCityDatum>>? data;
  String? message;

  GetRouteSearchByCityResponseModel({
    this.success,
    this.data,
    this.message,
  });

  GetRouteSearchByCityResponseModel copyWith({
    int? success,
    List<List<SearchByCityDatum>>? data,
    String? message,
  }) =>
      GetRouteSearchByCityResponseModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory GetRouteSearchByCityResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetRouteSearchByCityResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<List<SearchByCityDatum>>.from(json["data"]!.map((x) =>
                List<SearchByCityDatum>.from(
                    x.map((x) => SearchByCityDatum.fromJson(x))))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "message": message,
      };
}

class SearchByCityDatum {
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
  User? user;

  SearchByCityDatum({
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
    this.user,
  });

  SearchByCityDatum copyWith({
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
    User? user,
  }) =>
      SearchByCityDatum(
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
        user: user ?? this.user,
      );

  factory SearchByCityDatum.fromJson(Map<String, dynamic> json) =>
      SearchByCityDatum(
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "user": user?.toJson(),
      };
}

class User {
  String? username;
  List<Usertousercartype>? usertousercartypes;

  User({
    this.username,
    this.usertousercartypes,
  });

  User copyWith({
    String? username,
    List<Usertousercartype>? usertousercartypes,
  }) =>
      User(
        username: username ?? this.username,
        usertousercartypes: usertousercartypes ?? this.usertousercartypes,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        usertousercartypes: json["usertousercartypes"] == null
            ? []
            : List<Usertousercartype>.from(json["usertousercartypes"]!
                .map((x) => Usertousercartype.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "usertousercartypes": usertousercartypes == null
            ? []
            : List<dynamic>.from(usertousercartypes!.map((x) => x.toJson())),
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
