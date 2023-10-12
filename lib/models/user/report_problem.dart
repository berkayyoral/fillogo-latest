import 'dart:convert';

class ReportProblemRequest {
    String? category;
    String? message;

    ReportProblemRequest({
        this.category,
        this.message,
    });

    factory ReportProblemRequest.fromRawJson(String str) => ReportProblemRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReportProblemRequest.fromJson(Map<String, dynamic> json) => ReportProblemRequest(
        category: json["category"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "message": message,
    };
}


class ReportProblemResponse {
    int? success;
    List<dynamic>? data;
    String? message;

    ReportProblemResponse({
        this.success,
        this.data,
        this.message,
    });

    factory ReportProblemResponse.fromRawJson(String str) => ReportProblemResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReportProblemResponse.fromJson(Map<String, dynamic> json) => ReportProblemResponse(
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

