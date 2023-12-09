import 'dart:convert';

class FriendsRoutesCircular {
  late final int success;
  late final String message;
  late final List<FriendsRoutes> data;

  FriendsRoutesCircular(
      {required this.success, required this.message, required this.data});

  factory FriendsRoutesCircular.fromRawJson(String str) =>
      FriendsRoutesCircular.fromJson(json.decode(str));

  FriendsRoutesCircular.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        List.from(json['data']).map((e) => FriendsRoutes.fromJson(e)).toList();
  }

}

class FriendsRoutes {
  int? userID;
  String? profilePic;
  double? latitude;
  double? longitude;
  String? message;

  FriendsRoutes(
      {this.userID,
      this.profilePic,
      this.latitude,
      this.longitude,
      this.message});

  factory FriendsRoutes.fromRawJson(String str) =>
      FriendsRoutes.fromJson(json.decode(str));


  factory FriendsRoutes.fromJson(Map<String, dynamic> json) => FriendsRoutes(
      userID: json["userID"],
      profilePic: json["profilePic"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      message: json["message"]);
}
