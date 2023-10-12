import 'dart:convert';

class UpdateUserCarInfosRequest {
    int? carId;
    String? carBrand;
    String? carModel;
    int? carCapacity;
    String? plateNumber;
    int? carTypeId;

    UpdateUserCarInfosRequest({
        this.carId,
        this.carBrand,
        this.carModel,
        this.carCapacity,
        this.plateNumber,
        this.carTypeId,
    });

    factory UpdateUserCarInfosRequest.fromRawJson(String str) => UpdateUserCarInfosRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateUserCarInfosRequest.fromJson(Map<String, dynamic> json) => UpdateUserCarInfosRequest(
        carId: json["carID"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
        carCapacity: json["carCapacity"],
        plateNumber: json["plateNumber"],
        carTypeId: json["carTypeID"],
    );

    Map<String, dynamic> toJson() => {
        "carID": carId,
        "carBrand": carBrand,
        "carModel": carModel,
        "carCapacity": carCapacity,
        "plateNumber": plateNumber,
        "carTypeID": carTypeId,
    };
}




class UpdateUserCarInfosResponse {
    int? success;
    List<dynamic>? data;
    String? message;

    UpdateUserCarInfosResponse({
        this.success,
        this.data,
        this.message,
    });

    factory UpdateUserCarInfosResponse.fromRawJson(String str) => UpdateUserCarInfosResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateUserCarInfosResponse.fromJson(Map<String, dynamic> json) => UpdateUserCarInfosResponse(
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

