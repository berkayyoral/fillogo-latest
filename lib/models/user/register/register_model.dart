class RegisterRequestModel {
  String? name;
  String? surname;
  String? password;
  String? phoneNumberOrMail;

  RegisterRequestModel(
      {this.name, this.surname, this.password, this.phoneNumberOrMail});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    password = json['password'];
    phoneNumberOrMail = json['phoneNumberOrMail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['password'] = password;
    data['phoneNumberOrMail'] = phoneNumberOrMail;
    return data;
  }
}

class RegisterResponseModel {
  int? success;
  List<dynamic>? data;
  String? message;

  RegisterResponseModel({this.success, this.data, this.message});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.castFrom<dynamic, dynamic>(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}
