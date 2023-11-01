import 'dart:convert';

class FriendsRoutesCircular {
  String? userID;
  String? profilePic;
  String? latitude;
  String? longitude;

  FriendsRoutesCircular(
      {this.userID, this.profilePic, this.latitude, this.longitude});

  factory FriendsRoutesCircular.fromRawJson(String str) =>
      FriendsRoutesCircular.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FriendsRoutesCircular.fromJson(Map<String, dynamic> json) =>
      FriendsRoutesCircular(
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
