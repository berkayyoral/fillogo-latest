// To parse this JSON data, do
//
//     final followUserResponse = followUserResponseFromJson(jsonString);

import 'dart:convert';

class FollowUserResponse {
    int? success;
    List<dynamic>? data;
    String? message;

    FollowUserResponse({
        this.success,
        this.data,
        this.message,
    });

    factory FollowUserResponse.fromRawJson(String str) => FollowUserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FollowUserResponse.fromJson(Map<String, dynamic> json) => FollowUserResponse(
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
