class UpdateProfilePictureResponseModel {
  int? success;
  List<dynamic>? data;
  String? message;

  UpdateProfilePictureResponseModel({this.success, this.data, this.message});

  UpdateProfilePictureResponseModel.fromJson(Map<String, dynamic> json) {
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
