class PostModel {
  PostModel({
    required this.success,
    required this.message,
    required this.data,
  });
  late final int success;
  late final String message;
  late final List<Data> data;

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.onlyPost,
    required this.centerImageUrl,
    required this.subtitle,
    required this.name,
    required this.userId,
    required this.userProfilePhoto,
    required this.locationName,
    required this.beforeHours,
    required this.commentCount,
    required this.firstCommentName,
    required this.firstCommentTitle,
    required this.firstLikeName,
    required this.firstLikeUrl,
    required this.othersLikeCount,
    required this.secondLikeUrl,
    required this.thirdLikeUrl,
    required this.haveTag,
    required this.usersTagged,
    required this.haveEmotion,
    required this.emotion,
    required this.emotionContent,
    required this.likedStatus,
  });

  late final bool onlyPost;
  late final String centerImageUrl;
  late final String subtitle;
  late final String name;
  late final int userId;
  late final String userProfilePhoto;
  late final String locationName;
  late final String beforeHours;
  late final String commentCount;
  late final String firstCommentName;
  late final String firstCommentTitle;
  late final String firstLikeName;
  late final String firstLikeUrl;
  late final String othersLikeCount;
  late final String secondLikeUrl;
  late final String thirdLikeUrl;
  late final bool haveTag;
  late final List<UsersTagged> usersTagged;
  late final bool haveEmotion;
  late final String emotion;
  late final String emotionContent;
  late final int likedStatus;

  Data.fromJson(Map<String, dynamic> json) {
    onlyPost = json['onlyPost'];
    centerImageUrl = json['centerImageUrl'];
    subtitle = json['subtitle'];
    name = json['name'];
    userId = json['userId'];
    userProfilePhoto = json['userProfilePhoto'];
    locationName = json['locationName'];
    beforeHours = json['beforeHours'];
    commentCount = json['commentCount'];
    firstCommentName = json['firstCommentName'];
    firstCommentTitle = json['firstCommentTitle'];
    firstLikeName = json['firstLikeName'];
    firstLikeUrl = json['firstLikeUrl'];
    othersLikeCount = json['othersLikeCount'];
    secondLikeUrl = json['secondLikeUrl'];
    thirdLikeUrl = json['thirdLikeUrl'];
    haveTag = json['haveTag'];
    usersTagged = <UsersTagged>[];
    json['usersTagged'].forEach(
      (v) {
        usersTagged.add(
          new UsersTagged.fromJson(v),
        );
      },
    );
    haveEmotion = json['haveEmotion'];
    emotion = json['emotion'];
    emotionContent = json['emotionContent'];
    likedStatus = json['likedStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['onlyPost'] = onlyPost;
    _data['centerImageUrl'] = centerImageUrl;
    _data['subtitle'] = subtitle;
    _data['name'] = name;
    _data['userId'] = userId;
    _data['userProfilePhoto'] = userProfilePhoto;
    _data['locationName'] = locationName;
    _data['beforeHours'] = beforeHours;
    _data['commentCount'] = commentCount;
    _data['firstCommentName'] = firstCommentName;
    _data['firstCommentTitle'] = firstCommentTitle;
    _data['firstLikeName'] = firstLikeName;
    _data['firstLikeUrl'] = firstLikeUrl;
    _data['othersLikeCount'] = othersLikeCount;
    _data['secondLikeUrl'] = secondLikeUrl;
    _data['thirdLikeUrl'] = thirdLikeUrl;
    _data['haveTag'] = haveTag;
    _data['usersTagged'] = usersTagged.map((v) => v.toJson()).toList();
    _data['haveEmotion'] = haveEmotion;
    _data['emotion'] = emotion;
    _data['emotionContent'] = emotionContent;
    _data['likedStatus'] = likedStatus;
    return _data;
  }
}

class UsersTagged {
  late final String name;
  late final int userId;

  UsersTagged({
    required this.name,
    required this.userId,
  });

  UsersTagged.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['name'] = this.name;
    _data['userId'] = this.userId;
    return _data;
  }
}
