class ForgotPasswordCompareCodeRequestModel {
  String? code;

  ForgotPasswordCompareCodeRequestModel({this.code});

  ForgotPasswordCompareCodeRequestModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}

class ForgotPasswordCompareCodeResponseModel {
  int? succes;
  List<bool>? data;
  String? message;

  ForgotPasswordCompareCodeResponseModel(
      {this.succes, this.data, this.message});

  ForgotPasswordCompareCodeResponseModel.fromJson(Map<String, dynamic> json) {
    succes = json['succes'];
    data = json['data'].cast<bool>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succes'] = succes;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
