

import '../../export.dart';

class UserInfoServices {
  static UserInfoServices? _instace;
  static UserInfoServices? get instance {
    _instace ??= UserInfoServices._init();
    return _instace;
  }

  UserInfoServices._init();

  Future<UserInfoModel> getUsersInfo() async {
    return await NetworkService.instance.http<UserInfoModel>(
      '/userinfo.json',
      UserInfoModel(),
      Methods.get,
    );
  }

  Future<UserInfoModel> postUsersInfo(UserInputModel userInputModel) async {
    return await NetworkService.instance.http<UserInfoModel>(
      '/userinfo.json',
      UserInfoModel(),
      Methods.post,
      body: userInputModel.toJson(),
    );
  }
}
