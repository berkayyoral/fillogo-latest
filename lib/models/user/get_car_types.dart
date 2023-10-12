// To parse this JSON data, do
//
//     final getCarTypesResponse = getCarTypesResponseFromJson(jsonString);

import 'dart:convert';

class GetCarTypesResponse {
    int? succes;
    List<Datum>? data;
    String? message;

    GetCarTypesResponse({
        this.succes,
        this.data,
        this.message,
    });

    factory GetCarTypesResponse.fromRawJson(String str) => GetCarTypesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetCarTypesResponse.fromJson(Map<String, dynamic> json) => GetCarTypesResponse(
        succes: json["succes"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "succes": succes,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    List<CarTypesobject>? carTypesobject;

    Datum({
        this.carTypesobject,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        carTypesobject: json["carTypesobject"] == null ? [] : List<CarTypesobject>.from(json["carTypesobject"]!.map((x) => CarTypesobject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "carTypesobject": carTypesobject == null ? [] : List<dynamic>.from(carTypesobject!.map((x) => x.toJson())),
    };
}

class CarTypesobject {
    int? id;
    String? carType;

    CarTypesobject({
        this.id,
        this.carType,
    });

    factory CarTypesobject.fromRawJson(String str) => CarTypesobject.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CarTypesobject.fromJson(Map<String, dynamic> json) => CarTypesobject(
        id: json["id"],
        carType: json["carType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "carType": carType,
    };
}
