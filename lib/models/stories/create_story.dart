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
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Story? story;

  Data({this.story});

  Data.fromJson(Map<String, dynamic> json) {
    story = json['story'] != null ? new Story.fromJson(json['story']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.story != null) {
      data['story'] = this.story!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    return data;
  }
}