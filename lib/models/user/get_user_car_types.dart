import 'dart:convert';

class GetUserCarTypesResponse {
  int? succes;
  List<Datum>? data;
  String? message;

  GetUserCarTypesResponse({
    this.succes,
    this.data,
    this.message,
  });

  factory GetUserCarTypesResponse.fromRawJson(String str) =>
      GetUserCarTypesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserCarTypesResponse.fromJson(Map<String, dynamic> json) =>
      GetUserCarTypesResponse(
        succes: json["succes"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  List<UserCarType>? userCarTypes;

  Datum({
    this.userCarTypes,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userCarTypes: json["userCarTypes"] == null
            ? []
            : List<UserCarType>.from(
                json["userCarTypes"]!.map((x) => UserCarType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userCarTypes": userCarTypes == null
            ? []
            : List<dynamic>.from(userCarTypes!.map((x) => x.toJson())),
      };
}

class UserCarType {
  int? id;
  int? carTypeId;
  int? carCapacity;
  String? carBrand;
  String? carModel;

  Cartypetousercartypes? cartypetousercartypes;

  UserCarType({
    this.id,
    this.carTypeId,
    this.carCapacity,
    this.carBrand,
    this.carModel,
    this.cartypetousercartypes,
  });

  factory UserCarType.fromRawJson(String str) =>
      UserCarType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCarType.fromJson(Map<String, dynamic> json) => UserCarType(
        id: json["id"],
        carTypeId: json["carTypeID"],
        carCapacity: json["carCapacity"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        cartypetousercartypes: json["cartypetousercartypes"] == null
            ? null
            : Cartypetousercartypes.fromJson(json["cartypetousercartypes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carTypeID": carTypeId,
        "carCapacity": carCapacity,
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

  factory Cartypetousercartypes.fromRawJson(String str) =>
      Cartypetousercartypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
