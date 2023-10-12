class ChatMessageResponseModel {
  int? success;
  List<Data>? data;
  String? message;

  ChatMessageResponseModel({this.success, this.data, this.message});

  ChatMessageResponseModel.fromJson(Map<String, dynamic> json) {
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
  CreatedMessage? createdMessage;

  Data({this.createdMessage});

  Data.fromJson(Map<String, dynamic> json) {
    createdMessage = json['createdMessage'] != null
        ? CreatedMessage.fromJson(json['createdMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (createdMessage != null) {
      data['createdMessage'] = createdMessage!.toJson();
    }
    return data;
  }
}

class CreatedMessage {
  String? status;
  int? id;
  int? chatID;
  int? senderID;
  String? text;
  String? updatedAt;
  String? createdAt;

  CreatedMessage(
      {this.status,
      this.id,
      this.chatID,
      this.senderID,
      this.text,
      this.updatedAt,
      this.createdAt});

  CreatedMessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    chatID = json['chatID'];
    senderID = json['senderID'];
    text = json['text'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['id'] = id;
    data['chatID'] = chatID;
    data['senderID'] = senderID;
    data['text'] = text;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
