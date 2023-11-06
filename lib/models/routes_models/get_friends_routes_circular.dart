import 'dart:convert';

class FriendsRoutesCircular {
  late final int success;
  late final String message;
  late final List<FriendsRoutes> data;

  FriendsRoutesCircular(
      {required this.success, required this.message, required this.data});

  factory FriendsRoutesCircular.fromRawJson(String str) =>
      FriendsRoutesCircular.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  FriendsRoutesCircular.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        List.from(json['data']).map((e) => FriendsRoutes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FriendsRoutes {
  int? userID;
  String? profilePic;
  double? latitude;
  double? longitude;

  FriendsRoutes({this.userID, this.profilePic, this.latitude, this.longitude});

  factory FriendsRoutes.fromRawJson(String str) =>
      FriendsRoutes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FriendsRoutes.fromJson(Map<String, dynamic> json) => FriendsRoutes(
      userID: json["userID"],
      profilePic: json["profilePic"],
      latitude: json["latitude"],
      longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "profilePic": profilePic,
        "latitude": latitude,
        "longitude": longitude
      };
}
