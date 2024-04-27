import 'dart:convert';

class UpdateUserProfileRequest {
  String? name;
  String? surname;
  String? username;
  String? mail;
  // String? phoneNumber;

  UpdateUserProfileRequest({
    this.name,
    this.surname,
    this.username,
    this.mail,
    // this.phoneNumber
  });

  UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    mail = json['mail'];
    // phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['username'] = username;
    data['mail'] = mail;
    // data['phoneNumber'] = phoneNumber;
    return data;
  }
}

class UpdateProfileResponse {
  int? success;
  List<dynamic>? data;
  String? message;

  UpdateProfileResponse({
    this.success,
    this.data,
    this.message,
  });

  factory UpdateProfileResponse.fromRawJson(String str) =>
      UpdateProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
      };
}
