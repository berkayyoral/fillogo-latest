import 'dart:convert';

class LoginServicesRequestModel {
  LoginServicesRequestModel({
    this.phoneNumberOrMail,
    this.password,
  });

  final String? phoneNumberOrMail;
  final String? password;

  factory LoginServicesRequestModel.fromRawJson(String str) =>
      LoginServicesRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginServicesRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginServicesRequestModel(
        phoneNumberOrMail: json["phoneNumberOrMail"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumberOrMail": phoneNumberOrMail,
        "password": password,
      };
}

class LoginServicesResponseModel {
  LoginServicesResponseModel({
    this.success,
    this.data,
    this.message,
  });

  final int? success;
  final List<Datum>? data;
  final String? message;

  factory LoginServicesResponseModel.fromRawJson(String str) =>
      LoginServicesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginServicesResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.isAcikmi,
    this.tokens,
  });

  final bool? isAcikmi;
  final Tokens? tokens;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isAcikmi: json["isAcikmi"],
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "isAcikmi": isAcikmi,
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  factory Tokens.fromRawJson(String str) => Tokens.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class RegisterServicesRequestModel {
  RegisterServicesRequestModel({
    this.name,
    this.surname,
    this.password,
    this.phoneNumberOrMail,
  });

  final String? name;
  final String? surname;
  final String? password;
  final String? phoneNumberOrMail;

  factory RegisterServicesRequestModel.fromRawJson(String str) =>
      RegisterServicesRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterServicesRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterServicesRequestModel(
        name: json["name"],
        surname: json["surname"],
        password: json["password"],
        phoneNumberOrMail: json["phoneNumberOrMail"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "password": password,
        "phoneNumberOrMail": phoneNumberOrMail,
      };
}

class RegisterServicesResponseModel {
  RegisterServicesResponseModel({
    this.success,
    this.data,
    this.message,
  });

  final int? success;
  final List<dynamic>? data;
  final String? message;

  factory RegisterServicesResponseModel.fromRawJson(String str) =>
      RegisterServicesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterServicesResponseModel(
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

class LoginServicesRequest {
    LoginServicesRequest({
        this.email,
        this.password,
    });

    final String? email;
    final String? password;

    factory LoginServicesRequest.fromRawJson(String str) => LoginServicesRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginServicesRequest.fromJson(Map<String, dynamic> json) => LoginServicesRequest(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}

class LoginServicesResponse {
    LoginServicesResponse({
        this.success,
        this.type,
        this.token,
    });

    final bool? success;
    final String? type;
    final String? token;

    factory LoginServicesResponse.fromRawJson(String str) => LoginServicesResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginServicesResponse.fromJson(Map<String, dynamic> json) => LoginServicesResponse(
        success: json["success"],
        type: json["type"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "type": type,
        "token": token,
    };
}