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
  List<Chat>? chat;

  Data({this.chat});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chat != null) {
      data['chat'] = this.chat!.map((v) => v.toJson()).toList();
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
        users!.add(new ChatUsers.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
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
        ? new UserChats.fromJson(json['UserChats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['profilePicture'] = this.profilePicture;
    if (this.userChats != null) {
      data['UserChats'] = this.userChats!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['chatID'] = this.chatID;
    data['createdAt'] = this.createdAt;
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
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
