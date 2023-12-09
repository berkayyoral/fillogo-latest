class CreateStoryResponse {
  int? success;
  List<Data>? data;
  String? message;

  CreateStoryResponse({this.success, this.data, this.message});

  CreateStoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  Story? story;

  Data({this.story});

  Data.fromJson(Map<String, dynamic> json) {
    story = json['story'] != null ? Story.fromJson(json['story']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (story != null) {
      data['story'] = story!.toJson();
    }
    return data;
  }
}

class Story {
  int? id;
  int? userID;
  String? url;
  String? createdAt;

  Story({this.id, this.userID, this.url, this.createdAt});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    url = json['url'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['url'] = url;
    data['createdAt'] = createdAt;
    return data;
  }
}