import '../../export.dart';


class UserInputModel extends IBaseModel {
  UserInputModel({
    this.message,
    required this.name,
  });

  String? message;
  String name;

  factory UserInputModel.fromJson(Map<String, dynamic> json) => UserInputModel(
        message: json['message'],
        name: json['name'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'message': message,
        'name': name,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return UserInputModel.fromJson(json);
  }
}
