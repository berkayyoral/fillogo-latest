import '../../export.dart';

class UserInfoController extends GetxController {
  var user = UserInfoModel().obs;

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  Future getUserInfo() async {
    user.value = await UserInfoServices.instance!.getUsersInfo();
  }

  Future postUserInfo(UserInputModel userInputModel) async {
    user.value = await UserInfoServices.instance!.postUsersInfo(userInputModel);
  }
}
