class ChatRequestModel {
  int? member;

  ChatRequestModel({this.member});

  ChatRequestModel.fromJson(Map<String, dynamic> json) {
    member = json['member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member'] = this.member;
    return data;
  }
}
