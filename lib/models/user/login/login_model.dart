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
  List<Data>? data;
  String? message;

  LoginResponseModel({this.success, this.data, this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  bool? isAcikmi;
  Tokens? tokens;
  User? user;

  Data({this.isAcikmi, this.tokens, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    isAcikmi = json['isAcikmi'];
    tokens =
        json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAcikmi'] = isAcikmi;
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? surname;
  String? username;
  String? mail;
  String? phoneNumber;
  String? profilePicture;
  String? banner;
  String? title;
  bool? isPrivate;
  bool? isOpen;
  bool? isVerified;
  String? createdAt;

  User(
      {this.id,
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
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    username = json['username'];
    mail = json['mail'];
    phoneNumber = json['phoneNumber'];
    profilePicture = json['profilePicture'];
    banner = json['banner'];
    title = json['title'];
    isPrivate = json['isPrivate'];
    isOpen = json['isOpen'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['username'] = username;
    data['mail'] = mail;
    data['phoneNumber'] = phoneNumber;
    data['profilePicture'] = profilePicture;
    data['banner'] = banner;
    data['title'] = title;
    data['isPrivate'] = isPrivate;
    data['isOpen'] = isOpen;
    data['isVerified'] = isVerified;
    data['createdAt'] = createdAt;
    return data;
  }
}
