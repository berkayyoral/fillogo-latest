// To parse this JSON data, do
//
//     final getHomePostResponse = getHomePostResponseFromJson(jsonString);

import 'dart:convert';

GetHomePostResponse getHomePostResponseFromJson(String str) =>
    GetHomePostResponse.fromJson(json.decode(str));

String getHomePostResponseToJson(GetHomePostResponse data) =>
    json.encode(data.toJson());

class GetHomePostResponse {
  int success;
  List<Datum> data;
  String message;

  GetHomePostResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetHomePostResponse.fromJson(Map<String, dynamic> json) =>
      GetHomePostResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  List<HomePostDetail> result;
  Pagination pagination;

  Datum({
    required this.result,
    required this.pagination,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        result: List<HomePostDetail>.from(
            json["result"].map((x) => HomePostDetail.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class Postpostlabel {
  Postpostlabel({
    this.id,
    this.userpostlabels,
  });

  int? id;
  User? userpostlabels;

  factory Postpostlabel.fromRawJson(String str) =>
      Postpostlabel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Postpostlabel.fromJson(Map<String, dynamic> json) => Postpostlabel(
        id: json["id"],
        userpostlabels: json["userpostlabels"] == null
            ? null
            : User.fromJson(json["userpostlabels"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userpostlabels": userpostlabels?.toJson(),
      };
}

class Pagination {
  int totalRecords;
  int totalPerpage;
  int totalPage;
  int currentPage;
  int nextPage;
  dynamic previousPage;

  Pagination({
    required this.totalRecords,
    required this.totalPerpage,
    required this.totalPage,
    required this.currentPage,
    required this.nextPage,
    required this.previousPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalRecords: json["total_records"],
        totalPerpage: json["total_perpage"],
        totalPage: json["total_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_records": totalRecords,
        "total_perpage": totalPerpage,
        "total_page": totalPage,
        "current_page": currentPage,
        "next_page": nextPage,
        "previous_page": previousPage,
      };
}

class HomePostDetail {
  bool onlyPost;
  bool haveLabel;
  bool haveEmojies;
  int didILiked;
  int likedNum;
  int commentNum;
  Firstcomment? firstcomment;
  Post post;
  List<dynamic> likedFriends;

  HomePostDetail({
    required this.onlyPost,
    required this.haveLabel,
    required this.haveEmojies,
    required this.didILiked,
    required this.likedNum,
    required this.commentNum,
    required this.firstcomment,
    required this.post,
    required this.likedFriends,
  });

  factory HomePostDetail.fromJson(Map<String, dynamic> json) => HomePostDetail(
        onlyPost: json["onlyPost"],
        haveLabel: json["haveLabel"],
        haveEmojies: json["haveEmojies"],
        didILiked: json["didILiked"],
        likedNum: json["likedNum"],
        commentNum: json["commentNum"],
        firstcomment: json["firstcomment"] == null
            ? null
            : Firstcomment.fromJson(json["firstcomment"]),
        post: Post.fromJson(json["post"]),
        likedFriends: List<dynamic>.from(json["likedFriends"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "onlyPost": onlyPost,
        "haveLabel": haveLabel,
        "haveEmojies": haveEmojies,
        "didILiked": didILiked,
        "likedNum": likedNum,
        "commentNum": commentNum,
        "firstcomment": firstcomment?.toJson(),
        "post": post.toJson(),
        "likedFriends": List<dynamic>.from(likedFriends.map((x) => x)),
      };
}

class Firstcomment {
  int id;
  String comment;
  User commentedposts;

  Firstcomment({
    required this.id,
    required this.comment,
    required this.commentedposts,
  });

  factory Firstcomment.fromJson(Map<String, dynamic> json) => Firstcomment(
        id: json["id"],
        comment: json["comment"],
        commentedposts: User.fromJson(json["commentedposts"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "commentedposts": commentedposts.toJson(),
      };
}

class User {
  int id;
  String name;
  String surname;
  String profilePicture;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "profilePicture": profilePicture,
      };
}

class Post {
  int id;
  String text;
  String? media;
  int? routeId;
  String? address;
  double? latitude;
  double? longitude;
  bool? isLocation;
  DateTime createdAt;
  User user;
  List<Postemoji>? postemojis;
  List<Postpostlabel>? postpostlabels;
  Postroute? postroute;

  Post({
    required this.id,
    required this.text,
    required this.media,
    required this.routeId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isLocation,
    required this.createdAt,
    required this.user,
    required this.postemojis,
    required this.postpostlabels,
    required this.postroute,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        text: json["text"],
        media: json["media"] ?? "",
        routeId: json["routeID"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        isLocation: json["isLocation"],
        createdAt: DateTime.parse(json["createdAt"]),
        user: User.fromJson(json["user"]),
        postemojis: json["postemojis"] == null
            ? []
            : List<Postemoji>.from(
                json["postemojis"]!.map((x) => Postemoji.fromJson(x))),
        postpostlabels: json["postpostlabels"] == null
            ? []
            : List<Postpostlabel>.from(
                json["postpostlabels"]!.map((x) => Postpostlabel.fromJson(x))),
        postroute: json["postroute"] == null
            ? null
            : Postroute.fromJson(json["postroute"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "media": media,
        "routeID": routeId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "isLocation": isLocation,
        "createdAt": createdAt.toIso8601String(),
        "user": user.toJson(),
        "postemojis": postemojis == null
            ? []
            : List<dynamic>.from(postemojis!.map((x) => x.toJson())),
        "postpostlabels": postpostlabels == null
            ? []
            : List<dynamic>.from(postpostlabels!.map((x) => x.toJson())),
        "postroute": postroute?.toJson(),
      };
}

class Postemoji {
  Postemoji({
    this.id,
    this.emojis,
  });

  int? id;
  Emojis? emojis;

  factory Postemoji.fromRawJson(String str) =>
      Postemoji.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Postemoji.fromJson(Map<String, dynamic> json) => Postemoji(
        id: json["id"],
        emojis: json["emojis"] == null ? null : Emojis.fromJson(json["emojis"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emojis": emojis?.toJson(),
      };
}

class Emojis {
  Emojis({
    this.id,
    this.name,
    this.emoji,
  });

  int? id;
  String? name;
  String? emoji;

  factory Emojis.fromRawJson(String str) => Emojis.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Emojis.fromJson(Map<String, dynamic> json) => Emojis(
        id: json["id"],
        name: json["name"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "emoji": emoji,
      };
}

class Postroute {
  int id;
  String startingCity;
  String endingCity;
  DateTime? arrivalDate;

  Postroute({
    required this.id,
    required this.startingCity,
    required this.endingCity,
    this.arrivalDate,
  });

  factory Postroute.fromJson(Map<String, dynamic> json) => Postroute(
        id: json["id"],
        startingCity: json["startingCity"],
        endingCity: json["endingCity"],
        arrivalDate: json["arrivalDate"] == null
            ? null
            : DateTime.parse(json["arrivalDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startingCity": startingCity,
        "endingCity": endingCity,
        "arrivalDate": arrivalDate?.toIso8601String(),
      };
}





// *****



// import 'dart:convert';

// class GetHomePostResponse {
//   GetHomePostResponse({
//     this.success,
//     this.data,
//     this.message,
//   });

//   int? success;
//   List<Datum>? data;
//   String? message;

//   factory GetHomePostResponse.fromRawJson(String str) =>
//       GetHomePostResponse.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory GetHomePostResponse.fromJson(Map<String, dynamic> json) =>
//       GetHomePostResponse(
//         success: json["success"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class Datum {
//   Datum({
//     this.result,
//     this.pagination,
//   });

//   List<HomePostDetail>? result;
//   Pagination? pagination;

//   factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         result: json["result"] == null
//             ? []
//             : List<HomePostDetail>.from(
//                 json["result"]!.map((x) => HomePostDetail.fromJson(x))),
//         pagination: json["pagination"] == null
//             ? null
//             : Pagination.fromJson(json["pagination"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "result": result == null
//             ? []
//             : List<dynamic>.from(result!.map((x) => x.toJson())),
//         "pagination": pagination?.toJson(),
//       };
// }

// class Pagination {
//   Pagination({
//     this.totalRecords,
//     this.totalPerpage,
//     this.totalPage,
//     this.currentPage,
//     this.nextPage,
//     this.previousPage,
//   });

//   int? totalRecords;
//   int? totalPerpage;
//   int? totalPage;
//   int? currentPage;
//   dynamic nextPage;
//   dynamic previousPage;

//   factory Pagination.fromRawJson(String str) =>
//       Pagination.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         totalRecords: json["total_records"],
//         totalPerpage: json["total_perpage"],
//         totalPage: json["total_page"],
//         currentPage: json["current_page"],
//         nextPage: json["next_page"],
//         previousPage: json["previous_page"],
//       );

//   Map<String, dynamic> toJson() => {
//         "total_records": totalRecords,
//         "total_perpage": totalPerpage,
//         "total_page": totalPage,
//         "current_page": currentPage,
//         "next_page": nextPage,
//         "previous_page": previousPage,
//       };
// }

// class HomePostDetail {
//   HomePostDetail({
//     this.onlyPost,
//     this.haveLabel,
//     this.haveEmojies,
//     this.didILiked,
//     this.post,
//     this.likedNum,
//     this.commentNum,
//     this.likedFriends,
//     this.firstcomment,
//   });

//   bool? onlyPost;
//   bool? haveLabel;
//   bool? haveEmojies;
//   int? didILiked;
//   Post? post;
//   int? likedNum;
//   int? commentNum;
//   List<dynamic>? likedFriends;
//   dynamic firstcomment;

//   factory HomePostDetail.fromRawJson(String str) =>
//       HomePostDetail.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory HomePostDetail.fromJson(Map<String, dynamic> json) => HomePostDetail(
//         onlyPost: json["onlyPost"],
//         haveLabel: json["haveLabel"],
//         haveEmojies: json["haveEmojies"],
//         didILiked: json["didILiked"],
//         post: json["post"] == null ? null : Post.fromJson(json["post"]),
//         likedNum: json["likedNum"],
//         commentNum: json["commentNum"],
//         likedFriends: json["likedFriends"] == null
//             ? []
//             : List<dynamic>.from(json["likedFriends"]!.map((x) => x)),
//         firstcomment: json["firstcomment"],
//       );

//   Map<String, dynamic> toJson() => {
//         "onlyPost": onlyPost,
//         "haveLabel": haveLabel,
//         "haveEmojies": haveEmojies,
//         "didILiked": didILiked,
//         "post": post?.toJson(),
//         "likedNum": likedNum,
//         "commentNum": commentNum,
//         "likedFriends": likedFriends == null
//             ? []
//             : List<dynamic>.from(likedFriends!.map((x) => x)),
//         "firstcomment": firstcomment,
//       };
// }

// class Post {
//   Post({
//     this.id,
//     this.text,
//     this.media,
//     this.routeId,
//     this.createdAt,
//     this.user,
//     this.postemojis,
//     this.postpostlabels,
//     this.postroute,
//   });

//   int? id;
//   String? text;
//   String? media;
//   int? routeId;
//   DateTime? createdAt;
//   User? user;
//   List<Postemoji>? postemojis;
//   List<Postpostlabel>? postpostlabels;
//   Postroute? postroute;

//   factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//         id: json["id"],
//         text: json["text"],
//         media: json["media"] ?? "",
//         routeId: json["routeID"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
        // postemojis: json["postemojis"] == null
        //     ? []
        //     : List<Postemoji>.from(
        //         json["postemojis"]!.map((x) => Postemoji.fromJson(x))),
        // postpostlabels: json["postpostlabels"] == null
        //     ? []
        //     : List<Postpostlabel>.from(
        //         json["postpostlabels"]!.map((x) => Postpostlabel.fromJson(x))),
//         postroute: json["postroute"] == null
//             ? null
//             : Postroute.fromJson(json["postroute"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "text": text,
//         "media": media,
//         "routeID": routeId,
//         "createdAt": createdAt?.toIso8601String(),
//         "user": user?.toJson(),
        // "postemojis": postemojis == null
        //     ? []
        //     : List<dynamic>.from(postemojis!.map((x) => x.toJson())),
        // "postpostlabels": postpostlabels == null
        //     ? []
        //     : List<dynamic>.from(postpostlabels!.map((x) => x.toJson())),
//         "postroute": postroute?.toJson(),
//       };
// }

// class Postemoji {
//   Postemoji({
//     this.id,
//     this.emojis,
//   });

//   int? id;
//   Emojis? emojis;

//   factory Postemoji.fromRawJson(String str) =>
//       Postemoji.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Postemoji.fromJson(Map<String, dynamic> json) => Postemoji(
//         id: json["id"],
//         emojis: json["emojis"] == null ? null : Emojis.fromJson(json["emojis"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "emojis": emojis?.toJson(),
//       };
// }

// class Emojis {
//   Emojis({
//     this.id,
//     this.name,
//     this.emoji,
//   });

//   int? id;
//   String? name;
//   String? emoji;

//   factory Emojis.fromRawJson(String str) => Emojis.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Emojis.fromJson(Map<String, dynamic> json) => Emojis(
//         id: json["id"],
//         name: json["name"],
//         emoji: json["emoji"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "emoji": emoji,
//       };
// }

// class Postpostlabel {
//   Postpostlabel({
//     this.id,
//     this.userpostlabels,
//   });

//   int? id;
//   User? userpostlabels;

//   factory Postpostlabel.fromRawJson(String str) =>
//       Postpostlabel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Postpostlabel.fromJson(Map<String, dynamic> json) => Postpostlabel(
//         id: json["id"],
//         userpostlabels: json["userpostlabels"] == null
//             ? null
//             : User.fromJson(json["userpostlabels"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userpostlabels": userpostlabels?.toJson(),
//       };
// }

// class User {
//   User({
//     this.id,
//     this.name,
//     this.surname,
//     this.profilePicture,
//   });

//   int? id;
//   String? name;
//   String? surname;
//   String? profilePicture;

//   factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         surname: json["surname"],
//         profilePicture: json["profilePicture"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "surname": surname,
//         "profilePicture": profilePicture,
//       };
// }

// class Postroute {
//   Postroute({
//     this.id,
//     this.userId,
//     this.departureDate,
//     this.arrivalDate,
//     this.routeDescription,
//     this.vehicleCapacity,
//     this.isActive,
//     this.startingCoordinates,
//     this.startingOpenAdress,
//     this.startingCity,
//     this.endingCoordinates,
//     this.endingOpenAdress,
//     this.endingCity,
//     this.distance,
//     this.travelTime,
//     this.polylineEncode,
//     this.polylineDecode,
//     this.createdAt,
//   });

//   int? id;
//   int? userId;
//   DateTime? departureDate;
//   DateTime? arrivalDate;
//   String? routeDescription;
//   int? vehicleCapacity;
//   bool? isActive;
//   List<double>? startingCoordinates;
//   String? startingOpenAdress;
//   String? startingCity;
//   List<double>? endingCoordinates;
//   String? endingOpenAdress;
//   String? endingCity;
//   int? distance;
//   int? travelTime;
//   String? polylineEncode;
//   List<List<double>>? polylineDecode;
//   DateTime? createdAt;

//   factory Postroute.fromRawJson(String str) =>
//       Postroute.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Postroute.fromJson(Map<String, dynamic> json) => Postroute(
//         id: json["id"],
//         userId: json["userID"],
//         departureDate: json["departureDate"] == null
//             ? null
//             : DateTime.parse(json["departureDate"]),
        // arrivalDate: json["arrivalDate"] == null
        //     ? null
        //     : DateTime.parse(json["arrivalDate"]),
//         routeDescription: json["routeDescription"],
//         vehicleCapacity: json["vehicleCapacity"],
//         isActive: json["isActive"],
//         startingCoordinates: json["startingCoordinates"] == null
//             ? []
//             : List<double>.from(
//                 json["startingCoordinates"]!.map((x) => x?.toDouble())),
//         startingOpenAdress: json["startingOpenAdress"],
//         startingCity: json["startingCity"],
//         endingCoordinates: json["endingCoordinates"] == null
//             ? []
//             : List<double>.from(
//                 json["endingCoordinates"]!.map((x) => x?.toDouble())),
//         endingOpenAdress: json["endingOpenAdress"],
//         endingCity: json["endingCity"],
//         distance: json["distance"],
//         travelTime: json["travelTime"],
//         polylineEncode: json["polylineEncode"],
//         polylineDecode: json["polylineDecode"] == null
//             ? []
//             : List<List<double>>.from(json["polylineDecode"]!
//                 .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "userID": userId,
//         "departureDate": departureDate?.toIso8601String(),
//         "arrivalDate": arrivalDate?.toIso8601String(),
//         "routeDescription": routeDescription,
//         "vehicleCapacity": vehicleCapacity,
//         "isActive": isActive,
//         "startingCoordinates": startingCoordinates == null
//             ? []
//             : List<dynamic>.from(startingCoordinates!.map((x) => x)),
//         "startingOpenAdress": startingOpenAdress,
//         "startingCity": startingCity,
//         "endingCoordinates": endingCoordinates == null
//             ? []
//             : List<dynamic>.from(endingCoordinates!.map((x) => x)),
//         "endingOpenAdress": endingOpenAdress,
//         "endingCity": endingCity,
//         "distance": distance,
//         "travelTime": travelTime,
//         "polylineEncode": polylineEncode,
//         "polylineDecode": polylineDecode == null
//             ? []
//             : List<dynamic>.from(polylineDecode!
//                 .map((x) => List<dynamic>.from(x.map((x) => x)))),
//         "createdAt": createdAt?.toIso8601String(),
//       };
// }
