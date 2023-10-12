class ChatMessageRequestModel {
  int? chatID;
  String? text;

  ChatMessageRequestModel({this.chatID, this.text});

  ChatMessageRequestModel.fromJson(Map<String, dynamic> json) {
    chatID = json['chatID'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatID'] = chatID;
    data['text'] = text;
    return data;
  }
}
