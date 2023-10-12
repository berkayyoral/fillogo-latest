// To parse this JSON data, do
//
//     final deleteAccountResponseModel = deleteAccountResponseModelFromJson(jsonString);

import 'dart:convert';

class DeleteAccountResponseModel {
    int? success;
    List<dynamic>? data;
    String? message;

    DeleteAccountResponseModel({
        this.success,
        this.data,
        this.message,
    });

    factory DeleteAccountResponseModel.fromRawJson(String str) => DeleteAccountResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteAccountResponseModel.fromJson(Map<String, dynamic> json) => DeleteAccountResponseModel(
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
