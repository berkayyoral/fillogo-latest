import 'dart:convert';

import 'package:fillogo/models/post/get_home_post.dart';
import 'package:fillogo/models/user/profile/user_profile.dart';

class UserOtherProfileRequest {
  int? userID;

  UserOtherProfileRequest({this.userID});

  UserOtherProfileRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    return data;
  }
}

class UserOtherProfileResponse {
  int? success;
  UserProfilData? data;
  String? message;

  UserOtherProfileResponse({this.success, this.data, this.message});

  UserOtherProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? UserProfilData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class UserProfilData {
  Users? users;
  List<Stories>? stories;
  int? followerCount;
  int? followingCount;
  bool? doIfollow;
  bool? doIblock;
  Posts? posts;
  CarInformations? carInformations;
  int? routeCount;

  UserProfilData(
      {this.users,
      this.stories,
      this.followerCount,
      this.followingCount,
      this.doIfollow,
      this.doIblock,
      this.posts,
      this.carInformations,
      this.routeCount});

  UserProfilData.fromJson(Map<String, dynamic> json) {
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
    followerCount = json['followerCount'];
    followingCount = json['followingCount'];
    doIfollow = json['doIfollow'];
    doIblock = json['doIblock'];
    posts = json['posts'] != null ? Posts.fromJson(json['posts']) : null;
    carInformations = json['carInformations'] != null
        ? CarInformations.fromJson(json['carInformations'])
        : null;
    routeCount = json['routeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.toJson();
    }
    if (stories != null) {
      data['stories'] = stories!.map((v) => v.toJson()).toList();
    }
    data['followerCount'] = followerCount;
    data['followingCount'] = followingCount;
    data['doIfollow'] = doIfollow;
    data['doIblock'] = doIblock;
    if (posts != null) {
      data['posts'] = posts!.toJson();
    }
    if (carInformations != null) {
      data['carInformations'] = carInformations!.toJson();
    }
    data['routeCount'] = routeCount;
    return data;
  }
}

class Stories {
  int? id;
  int? userID;
  String? url;
  String? createdAt;

  Stories({this.id, this.userID, this.url, this.createdAt});

  Stories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    url = json['url'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['url'] = url;
    data['createdAt'] = createdAt;
    return data;
  }
}

class Posts {
  List<Result>? result;
  Pagination? pagination;

  Posts({this.result, this.pagination});

  Posts.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Result {
  Post? post;
  int? likedNum;
  int? didILiked;
  int? commentNum;

  Result({this.post, this.likedNum, this.didILiked, this.commentNum});

  Result.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    likedNum = json['likedNum'];
    didILiked = json['didILiked'];
    commentNum = json['commentNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (post != null) {
      data['post'] = post!.toJson();
    }
    data['likedNum'] = likedNum;
    data['didILiked'] = didILiked;
    data['commentNum'] = commentNum;
    return data;
  }
}

class Post {
  int? id;
  int? userID;
  String? text;
  String? media;
  List<Postemojis>? postemojis;
  List<Postpostlabel>? postpostlabels;
  Postroute? postroute;

  Post(
      {this.id,
      this.userID,
      this.text,
      this.media,
      this.postemojis,
      this.postpostlabels,
      this.postroute});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    text = json['text'];
    media = json['media'] == null ? "" : json["media"];
    if (json['postemojis'] != null) {
      postemojis = <Postemojis>[];
      json['postemojis'].forEach((v) {
        postemojis!.add(Postemojis.fromJson(v));
      });
    }
    if (json['postpostlabels'] != null) {
      postpostlabels = <Postpostlabel>[];
      json['postpostlabels'].forEach((v) {
        postpostlabels!.add(Postpostlabel.fromJson(v));
      });
    }
    postroute = json['postroute'] != null
        ? Postroute.fromJson(json['postroute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['text'] = text;
    data['media'] = media;
    if (postemojis != null) {
      data['postemojis'] = postemojis!.map((v) => v.toJson()).toList();
    }
    if (postpostlabels != null) {
      data['postpostlabels'] =
          postpostlabels!.map((v) => v.toJson()).toList();
    }
    if (postroute != null) {
      data['postroute'] = postroute!.toJson();
    }
    return data;
  }
}

class Postemojis {
  int? id;
  Emojis? emojis;

  Postemojis({this.id, this.emojis});

  Postemojis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emojis =
        json['emojis'] != null ? Emojis.fromJson(json['emojis']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (emojis != null) {
      data['emojis'] = emojis!.toJson();
    }
    return data;
  }
}

class Emojis {
  int? id;
  String? name;
  String? emoji;

  Emojis({this.id, this.name, this.emoji});

  Emojis.fromJson(Map<String, dynamic> json) {
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

class Userpostlabels {
  int? id;
  String? name;
  String? surname;

  Userpostlabels({this.id, this.name, this.surname});

  Userpostlabels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    return data;
  }
}

class Postroute {
    int? id;
    String? startingCity;
    String? endingCity;

    Postroute({
        this.id,
        this.startingCity,
        this.endingCity,
    });

    factory Postroute.fromRawJson(String str) => Postroute.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Postroute.fromJson(Map<String, dynamic> json) => Postroute(
        id: json["id"],
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startingCity": startingCity,
        "endingCity": endingCity,
    };
}


class Pagination {
  int? totalRecords;
  int? totalPerpage;
  int? totalPage;
  int? currentPage;
  int? nextPage;
  int? previousPage;

  Pagination(
      {this.totalRecords,
      this.totalPerpage,
      this.totalPage,
      this.currentPage,
      this.nextPage,
      this.previousPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalRecords = json['total_records'];
    totalPerpage = json['total_perpage'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_records'] = totalRecords;
    data['total_perpage'] = totalPerpage;
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['next_page'] = nextPage;
    data['previous_page'] = previousPage;
    return data;
  }
}

class CarInformations {
  int? carTypeID;
  String? carBrand;
  String? carModel;
  Cartypetousercartypes? cartypetousercartypes;

  CarInformations(
      {this.carTypeID,
      this.carBrand,
      this.carModel,
      this.cartypetousercartypes});

  CarInformations.fromJson(Map<String, dynamic> json) {
    carTypeID = json['carTypeID'];
    carBrand = json['carBrand'];
    carModel = json['carModel'];
    cartypetousercartypes = json['cartypetousercartypes'] != null
        ? Cartypetousercartypes.fromJson(json['cartypetousercartypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carTypeID'] = carTypeID;
    data['carBrand'] = carBrand;
    data['carModel'] = carModel;
    if (cartypetousercartypes != null) {
      data['cartypetousercartypes'] = cartypetousercartypes!.toJson();
    }
    return data;
  }
}

class Cartypetousercartypes {
  int? id;
  String? carType;
  String? driverType;

  Cartypetousercartypes({this.id, this.carType, this.driverType});

  Cartypetousercartypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carType = json['carType'];
    driverType = json['driverType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['carType'] = carType;
    data['driverType'] = driverType;
    return data;
  }
}
