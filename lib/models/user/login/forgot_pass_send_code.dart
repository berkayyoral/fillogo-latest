class ForgotPasswordSendCodeRequestModel {
  String? mail;

  ForgotPasswordSendCodeRequestModel({this.mail});

  ForgotPasswordSendCodeRequestModel.fromJson(Map<String, dynamic> json) {
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail'] = this.mail;
    return data;
  }
}

class ForgotPasswordSendCodeResponseModel {
  int? succes;
  List<Data>? data;
  String? message;

  ForgotPasswordSendCodeResponseModel({this.succes, this.data, this.message});

  ForgotPasswordSendCodeResponseModel.fromJson(Map<String, dynamic> json) {
    succes = json['succes'];
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
    data['succes'] = this.succes;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
