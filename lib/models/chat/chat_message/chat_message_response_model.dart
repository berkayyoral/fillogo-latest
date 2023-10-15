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
  List<Chat>? chat;

  Data({this.chat});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  int? id;
  List<ChatUsers>? users;
  List<Messages>? messages;

  Chat({this.id, this.users, this.messages});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['users'] != null) {
      users = <ChatUsers>[];
      json['users'].forEach((v) {
        users!.add(ChatUsers.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatUsers {
  int? id;
  String? name;
  String? surname;
  String? username;
  String? profilePicture;
  UserChats? userChats;

  ChatUsers(
      {this.id,
      this.name,
      this.surname,
      this.username,
      this.profilePicture,
      this.userChats});

  ChatUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    profilePicture = json['profilePicture'];
    userChats = json['UserChats'] != null
        ? UserChats.fromJson(json['UserChats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['username'] = username;
    data['profilePicture'] = profilePicture;
    if (userChats != null) {
      data['UserChats'] = userChats!.toJson();
    }
    return data;
  }
}

class UserChats {
  int? userID;
  int? chatID;
  String? createdAt;

  UserChats({this.userID, this.chatID, this.createdAt});

  UserChats.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    chatID = json['chatID'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['chatID'] = chatID;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Messages {
  String? text;
  String? createdAt;
  Sender? sender;

  Messages({this.text, this.createdAt, this.sender});

  Messages.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    createdAt = json['createdAt'];
    sender =
        json['sender'] != null ? Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['createdAt'] = createdAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    return data;
  }
}

class Sender {
  int? id;
  String? username;
  String? name;
  String? surname;
  String? profilePicture;

  Sender(
      {this.id, this.username, this.name, this.surname, this.profilePicture});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    surname = json['surname'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['surname'] = surname;
    data['profilePicture'] = profilePicture;
    return data;
  }
}
