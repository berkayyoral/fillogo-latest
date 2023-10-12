import 'dart:convert';

class BlockUserResponse {
    int? success;
    List<dynamic>? data;
    String? message;

    BlockUserResponse({
        this.success,
        this.data,
        this.message,
    });

    factory BlockUserResponse.fromRawJson(String str) => BlockUserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BlockUserResponse.fromJson(Map<String, dynamic> json) => BlockUserResponse(
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
