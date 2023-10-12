import '../../export.dart';

class ThemeController extends GetxController {
  var isDarkMode = (LocaleManager.instance.getBool(PreferencesKeys.isDarkMode) ?? Get.isPlatformDarkMode).obs;

  changeThemeMode() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
    LocaleManager.instance.setBool(PreferencesKeys.isDarkMode, !isDarkMode.value);
    isDarkMode.value = !isDarkMode.value;
  }
}
