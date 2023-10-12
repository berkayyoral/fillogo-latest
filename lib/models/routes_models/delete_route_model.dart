
import 'dart:convert';

class DeleteRouteRequestModel {
    int? routeId;

    DeleteRouteRequestModel({
        this.routeId,
    });

    factory DeleteRouteRequestModel.fromRawJson(String str) => DeleteRouteRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteRouteRequestModel.fromJson(Map<String, dynamic> json) => DeleteRouteRequestModel(
        routeId: json["RouteID"],
    );

    Map<String, dynamic> toJson() => {
        "RouteID": routeId,
    };
}


// To parse this JSON data, do
//
//     final deleteRouteResponseModel = deleteRouteResponseModelFromJson(jsonString);


class DeleteRouteResponseModel {
    int? success;
    List<dynamic>? data;
    String? message;

    DeleteRouteResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory DeleteRouteResponseModel.fromRawJson(String str) => DeleteRouteResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteRouteResponseModel.fromJson(Map<String, dynamic> json) => DeleteRouteResponseModel(
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