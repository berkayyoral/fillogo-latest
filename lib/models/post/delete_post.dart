import 'dart:convert';

class DeletePostResponse {
    int? success;
    List<dynamic>? data;
    String? message;

    DeletePostResponse({
        this.success,
        this.data,
        this.message,
    });

    factory DeletePostResponse.fromRawJson(String str) => DeletePostResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeletePostResponse.fromJson(Map<String, dynamic> json) => DeletePostResponse(
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
