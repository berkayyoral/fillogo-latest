// To parse this JSON data, do
//
//     final postLikeResponse = postLikeResponseFromJson(jsonString);

import 'dart:convert';

class PostLikeResponse {
    PostLikeResponse({
        this.success,
        this.data,
        this.message,
    });

    int? success;
    List<Datum>? data;
    String? message;

    factory PostLikeResponse.fromRawJson(String str) => PostLikeResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PostLikeResponse.fromJson(Map<String, dynamic> json) => PostLikeResponse(
        success: json["success"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    Datum({
        this.removed,
        this.likeCount,
    });

    bool? removed;
    int? likeCount;

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        removed: json["removed"],
        likeCount: json["likeCount"],
    );

    Map<String, dynamic> toJson() => {
        "removed": removed,
        "likeCount": likeCount,
    };
}
