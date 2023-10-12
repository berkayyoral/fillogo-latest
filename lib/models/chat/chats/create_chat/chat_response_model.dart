class ChatResponseModel {
  int? success;
  List<Data>? data;
  String? message;

  ChatResponseModel({this.success, this.data, this.message});

  ChatResponseModel.fromJson(Map<String, dynamic> json) {
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
  CreatedChat? createdChat;

  Data({this.createdChat});

  Data.fromJson(Map<String, dynamic> json) {
    createdChat = json['createdChat'] != null
        ? CreatedChat.fromJson(json['createdChat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createdChat != null) {
      data['createdChat'] = createdChat!.toJson();
    }
    return data;
  }
}

class CreatedChat {
  int? id;
  int? member1ID;
  int? member2ID;
  String? createdAt;

  CreatedChat({this.id, this.member1ID, this.member2ID, this.createdAt});

  CreatedChat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    member1ID = json['member1ID'];
    member2ID = json['member2ID'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['member1ID'] = member1ID;
    data['member2ID'] = member2ID;
    data['createdAt'] = createdAt;
    return data;
  }
}
