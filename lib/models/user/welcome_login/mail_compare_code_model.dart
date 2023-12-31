class MailCompareCodeRequestModel {
  String? code;

  MailCompareCodeRequestModel({this.code});

  MailCompareCodeRequestModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    return data;
  }
}

class MailCompareCodeResponseModel {
  int? succes;
  List<bool>? data;
  String? message;

  MailCompareCodeResponseModel({this.succes, this.data, this.message});

  MailCompareCodeResponseModel.fromJson(Map<String, dynamic> json) {
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
