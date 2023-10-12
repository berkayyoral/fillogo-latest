// To parse this JSON data, do
//
//     final activateRouteRequestModel = activateRouteRequestModelFromJson(jsonString);

import 'dart:convert';

class ActivateRouteRequestModel {
    int? routeId;

    ActivateRouteRequestModel({
        this.routeId,
    });

    factory ActivateRouteRequestModel.fromRawJson(String str) => ActivateRouteRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ActivateRouteRequestModel.fromJson(Map<String, dynamic> json) => ActivateRouteRequestModel(
        routeId: json["RouteID"],
    );

    Map<String, dynamic> toJson() => {
        "RouteID": routeId,
    };
}

// To parse this JSON data, do
//
//     final activateRouteResponseModel = activateRouteResponseModelFromJson(jsonString);



class ActivateRouteResponseModel {
    int? success;
    List<dynamic>? data;
    String? message;

    ActivateRouteResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory ActivateRouteResponseModel.fromRawJson(String str) => ActivateRouteResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ActivateRouteResponseModel.fromJson(Map<String, dynamic> json) => ActivateRouteResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
    };
}

