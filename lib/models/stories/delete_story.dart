import 'dart:convert';

class DeleteStoryResponse {
    int? success;
    List<dynamic>? data;
    String? message;

    DeleteStoryResponse({
        this.success,
        this.data,
        this.message,
    });

    factory DeleteStoryResponse.fromRawJson(String str) => DeleteStoryResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteStoryResponse.fromJson(Map<String, dynamic> json) => DeleteStoryResponse(
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
