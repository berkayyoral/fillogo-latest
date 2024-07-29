class LoginRequestModel {
  String? phoneNumberOrMail;
  String? password;

  LoginRequestModel({this.phoneNumberOrMail, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumberOrMail = json['phoneNumberOrMail'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumberOrMail'] = phoneNumberOrMail;
    data['password'] = password;
    return data;
  }
}

class LoginResponseModel {
  int? success;
  List<Datum>? data;
  String? message;

  LoginResponseModel({
    this.success,
    this.data,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  bool? isAcikmi;
  Tokens? tokens;
  User? user;

  Datum({
    this.isAcikmi,
    this.tokens,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isAcikmi: json["isAcikmi"],
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "isAcikmi": isAcikmi,
        "tokens": tokens?.toJson(),
        "user": user?.toJson(),
      };
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class User {
  int? id;
  String? name;
  String? surname;
  String? username;
  String? mail;
  dynamic phoneNumber;
  String? profilePicture;
  String? banner;
  String? title;
  bool? isPrivate;
  bool? isOpen;
  bool? isVerified;
  bool? isInvisible;
  bool? isAvailable;
  String? location;
  DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.surname,
    this.username,
    this.mail,
    this.phoneNumber,
    this.profilePicture,
    this.banner,
    this.title,
    this.isPrivate,
    this.isOpen,
    this.isVerified,
    this.isInvisible,
    this.isAvailable,
    this.location,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        username: json["username"],
        mail: json["mail"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
        banner: json["banner"],
        title: json["title"],
        isPrivate: json["isPrivate"],
        isOpen: json["isOpen"],
        isVerified: json["isVerified"],
        isInvisible: json["isInvisible"],
        isAvailable: json["isAvailable"],
        location: json["location"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "username": username,
        "mail": mail,
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
        "banner": banner,
        "title": title,
        "isPrivate": isPrivate,
        "isOpen": isOpen,
        "isVerified": isVerified,
        "isInvisible": isInvisible,
        "isAvailable": isAvailable,
        "location": location,
        "createdAt": createdAt?.toIso8601String(),
      };
}
