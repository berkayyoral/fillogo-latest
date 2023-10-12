// To parse this JSON data, do
//
//     final chatResponseModel = chatResponseModelFromJson(jsonString);

import 'dart:convert';

class ChatResponseModel {
  ChatResponseModel({
    this.success,
    this.data,
    this.message,
  });

  int? success;
  List<Datum>? data;
  String? message;

  factory ChatResponseModel.fromRawJson(String str) =>
      ChatResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      ChatResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    this.chats,
  });

  List<Chat>? chats;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chats: json["chats"] == null
            ? []
            : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chats": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.id,
    this.member1Id,
    this.member2Id,
    this.createdAt,
    this.chatusers,
    this.messages,
    this.sentCount,
  });

  int? id;
  int? member1Id;
  int? member2Id;
  DateTime? createdAt;
  List<ChatuserElement>? chatusers;
  List<LastMessage>? messages;
  String? sentCount;

  factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        member1Id: json["member1ID"],
        member2Id: json["member2ID"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        chatusers: json["chatusers"] == null
            ? []
            : List<ChatuserElement>.from(
                json["chatusers"]!.map((x) => ChatuserElement.fromJson(x))),
        messages: json["messages"] == null
            ? []
            : List<LastMessage>.from(
                json["messages"]!.map((x) => LastMessage.fromJson(x))),
        sentCount: json["sentCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "member1ID": member1Id,
        "member2ID": member2Id,
        "createdAt": createdAt?.toIso8601String(),
        "chatusers": chatusers == null
            ? []
            : List<dynamic>.from(chatusers!.map((x) => x.toJson())),
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
        "sentCount": sentCount,
      };
}

class ChatuserElement {
  ChatuserElement({
    this.id,
    this.chatuser,
  });

  int? id;
  SenderClass? chatuser;

  factory ChatuserElement.fromRawJson(String str) =>
      ChatuserElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatuserElement.fromJson(Map<String, dynamic> json) =>
      ChatuserElement(
        id: json["id"],
        chatuser: json["chatuser"] == null
            ? null
            : SenderClass.fromJson(json["chatuser"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatuser": chatuser?.toJson(),
      };
}

class SenderClass {
  SenderClass({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.profilePicture,
  });

  int? id;
  String? name;
  String? surname;
  String? username;
  String? profilePicture;

  factory SenderClass.fromRawJson(String str) =>
      SenderClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SenderClass.fromJson(Map<String, dynamic> json) => SenderClass(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "username": username,
        "profilePicture": profilePicture,
      };
}

class LastMessage {
  LastMessage({
    this.id,
    this.chatId,
    this.senderId,
    this.text,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.sender,
  });

  int? id;
  int? chatId;
  int? senderId;
  String? text;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  SenderClass? sender;

  factory LastMessage.fromRawJson(String str) =>
      LastMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["id"],
        chatId: json["chatID"],
        senderId: json["senderID"],
        text: json["text"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        sender: json["sender"] == null
            ? null
            : SenderClass.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chatID": chatId,
        "senderID": senderId,
        "text": text,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sender": sender?.toJson(),
      };
}
