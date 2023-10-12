class EmojiResponseModel {
  int? success;
  List<EmotionData>? data;
  String? message;

  EmojiResponseModel({this.success, this.data, this.message});

  EmojiResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <EmotionData>[];
      json['data'].forEach((v) {
        data!.add(EmotionData.fromJson(v));
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

class EmotionData {
  int? id;
  String? name;
  String? emoji;

  EmotionData({this.id, this.name, this.emoji});

  EmotionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emoji = json['emoji'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emoji'] = emoji;
    return data;
  }
}
