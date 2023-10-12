class SetNewPasswordRequestModel {
  String? newPassword;

  SetNewPasswordRequestModel({this.newPassword});

  SetNewPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newPassword'] = newPassword;
    return data;
  }
}

class SetNewPasswordResponseModel {
  int? success;
  List<dynamic>? data;
  String? message;

  SetNewPasswordResponseModel({this.success, this.data, this.message});

  SetNewPasswordResponseModel.fromJson(Map<String, dynamic> json) {
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
