// To parse this JSON data, do
//
//     final searchFollowersRequest = searchFollowersRequestFromJson(jsonString);

import 'dart:convert';

class SearchFollowersRequest {
  SearchFollowersRequest({
    this.text,
  });

  String? text;

  factory SearchFollowersRequest.fromRawJson(String str) =>
      SearchFollowersRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFollowersRequest.fromJson(Map<String, dynamic> json) =>
      SearchFollowersRequest(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
