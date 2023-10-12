import 'dart:convert';

class SetNewTokenRequestModel {
  SetNewTokenRequestModel({
    this.refreshToken,
  });

  String? refreshToken;

  factory SetNewTokenRequestModel.fromRawJson(String str) =>
      SetNewTokenRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SetNewTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      SetNewTokenRequestModel(
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
      };
}

class SetNewTokenResponseModel {
  SetNewTokenResponseModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<RefreshTData>? data;
  String? message;

  factory SetNewTokenResponseModel.fromRawJson(String str) =>
      SetNewTokenResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SetNewTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      SetNewTokenResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<RefreshTData>.from(
                json["data"]!.map((x) => RefreshTData.fromJson(x))),
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

class RefreshTData {
  RefreshTData({
    this.tokens,
  });

  Tokens? tokens;

  factory RefreshTData.fromRawJson(String str) =>
      RefreshTData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RefreshTData.fromJson(Map<String, dynamic> json) => RefreshTData(
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  String? accessToken;
  String? refreshToken;

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
