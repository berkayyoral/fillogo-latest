

import '../../export.dart';

class UserInfoModel extends IBaseModel {
  UserInfoModel({
    this.success,
    this.result,
    this.error,
  });

  String? message;
  bool? success;
  List? result;
  String? error;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        success: json['success'],
        result: json['result'],
        error: json['error'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'success': success,
        'result': result,
        'error': error,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return UserInfoModel.fromJson(json);
  }
}
