class RouteLoginOrRegisterRequestModel {
  String? mail;

  RouteLoginOrRegisterRequestModel({this.mail});

  RouteLoginOrRegisterRequestModel.fromJson(Map<String, dynamic> json) {
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail'] = this.mail;
    return data;
  }
}

class RouteLoginOrRegisterResponseModel {
  int? success;
  List<Data>? data;
  String? message;

  RouteLoginOrRegisterResponseModel({this.success, this.data, this.message});

  RouteLoginOrRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? mail;
  String? profilePicture;
  String? name;
  String? surname;

  Data({this.mail, this.profilePicture, this.name, this.surname});

  Data.fromJson(Map<String, dynamic> json) {
    mail = json['mail'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail'] = this.mail;
    data['profilePicture'] = this.profilePicture;
    data['name'] = this.name;
    data['surname'] = this.surname;
    return data;
  }
}
