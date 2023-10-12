// To parse this JSON data, do
//
//     final commentCreateRequest = commentCreateRequestFromJson(jsonString);

import 'dart:convert';

class CommentCreateRequest {
  String? comment;
  List<int>? labels;

  CommentCreateRequest({
    this.comment,
    this.labels,
  });

  factory CommentCreateRequest.fromRawJson(String str) =>
      CommentCreateRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentCreateRequest.fromJson(Map<String, dynamic> json) =>
      CommentCreateRequest(
        comment: json["comment"],
        labels: json["labels"] == null
            ? []
            : List<int>.from(json["labels"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "labels":
            labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
      };
}
