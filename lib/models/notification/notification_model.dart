class NotificationModel {
  NotificaitonMessage? message;
  int? sender;
  int? receiver;
  int? type;
  List<int>? params;

  NotificationModel(
      {this.message, this.sender, this.receiver, this.type, this.params});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null
        ? NotificaitonMessage.fromJson(json['message'])
        : null;
    sender = json['sender'];
    receiver = json['receiver'];
    type = json['type'];
    params = json['params'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['type'] = type;
    data['params'] = params;
    return data;
  }
}



class NotificaitonMessage {
  NotificationText? text;
  String? link;

  NotificaitonMessage({this.text, this.link});

  NotificaitonMessage.fromJson(Map<String, dynamic> json) {
    text =
        json['text'] != null ? NotificationText.fromJson(json['text']) : null;
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (text != null) {
      data['text'] = text!.toJson();
    }
    data['link'] = link;
    return data;
  }
}

class NotificationText {
  String? username;
  String? name;
  String? surname;
  String? content;

  NotificationText({this.username, this.content, this.name, this.surname});

  NotificationText.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    surname = json['surname'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name;
    data['surname'] = surname;
    data['content'] = content;
    return data;
  }
}


class NotificationAllModel {
  String? message;
  List<int>? receiverIds;

  NotificationAllModel(
      {this.message, this.receiverIds});

  NotificationAllModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    receiverIds = json['receiverIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['params'] = receiverIds;
    return data;
  }
}