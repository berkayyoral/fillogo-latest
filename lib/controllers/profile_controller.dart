import 'package:fillogo/export.dart';

class ProfileInfoController extends GetxController {
  RxString name = "".obs;
  RxString surName = "".obs;
  RxString userName = "".obs;

  RxBool isUpdateProfile = false.obs;

  @override
  void onInit() {
    name.value =
        LocaleManager.instance.getString(PreferencesKeys.currentUserName)!;
    surName.value =
        LocaleManager.instance.getString(PreferencesKeys.currentUserSurname)!;
    userName.value =
        LocaleManager.instance.getString(PreferencesKeys.currentUserUserName)!;
    super.onInit();
  }

  changeProfileInfo(
      {String? newName, String? newUserName, String? newSurname}) {
    name.value =
        LocaleManager.instance.getString(PreferencesKeys.currentUserName)!;
    surName.value =
        LocaleManager.instance.getString(PreferencesKeys.currentUserSurname)!;
    userName.value =
        LocaleManager.instance.getString(PreferencesKeys.currentUserUserName)!;
  }
}
