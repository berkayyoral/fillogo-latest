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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
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
        json['data'] != null ? new UserProfilData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
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
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(new Stories.fromJson(v));
      });
    }
    followerCount = json['followerCount'];
    followingCount = json['followingCount'];
    doIfollow = json['doIfollow'];
    doIblock = json['doIblock'];
    posts = json['posts'] != null ? new Posts.fromJson(json['posts']) : null;
    carInformations = json['carInformations'] != null
        ? new CarInformations.fromJson(json['carInformations'])
        : null;
    routeCount = json['routeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    if (this.stories != null) {
      data['stories'] = this.stories!.map((v) => v.toJson()).toList();
    }
    data['followerCount'] = this.followerCount;
    data['followingCount'] = this.followingCount;
    data['doIfollow'] = this.doIfollow;
    data['doIblock'] = this.doIblock;
    if (this.posts != null) {
      data['posts'] = this.posts!.toJson();
    }
    if (this.carInformations != null) {
      data['carInformations'] = this.carInformations!.toJson();
    }
    data['routeCount'] = this.routeCount;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
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
        result!.add(new Result.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    likedNum = json['likedNum'];
    didILiked = json['didILiked'];
    commentNum = json['commentNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    data['likedNum'] = this.likedNum;
    data['didILiked'] = this.didILiked;
    data['commentNum'] = this.commentNum;
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
        postemojis!.add(new Postemojis.fromJson(v));
      });
    }
    if (json['postpostlabels'] != null) {
      postpostlabels = <Postpostlabel>[];
      json['postpostlabels'].forEach((v) {
        postpostlabels!.add(new Postpostlabel.fromJson(v));
      });
    }
    postroute = json['postroute'] != null
        ? new Postroute.fromJson(json['postroute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['text'] = this.text;
    data['media'] = this.media;
    if (this.postemojis != null) {
      data['postemojis'] = this.postemojis!.map((v) => v.toJson()).toList();
    }
    if (this.postpostlabels != null) {
      data['postpostlabels'] =
          this.postpostlabels!.map((v) => v.toJson()).toList();
    }
    if (this.postroute != null) {
      data['postroute'] = this.postroute!.toJson();
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
        json['emojis'] != null ? new Emojis.fromJson(json['emojis']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.emojis != null) {
      data['emojis'] = this.emojis!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['emoji'] = this.emoji;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['surname'] = this.surname;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_records'] = this.totalRecords;
    data['total_perpage'] = this.totalPerpage;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['next_page'] = this.nextPage;
    data['previous_page'] = this.previousPage;
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
        ? new Cartypetousercartypes.fromJson(json['cartypetousercartypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carTypeID'] = this.carTypeID;
    data['carBrand'] = this.carBrand;
    data['carModel'] = this.carModel;
    if (this.cartypetousercartypes != null) {
      data['cartypetousercartypes'] = this.cartypetousercartypes!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carType'] = this.carType;
    data['driverType'] = this.driverType;
    return data;
  }
}
