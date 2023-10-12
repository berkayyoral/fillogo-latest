

import '../../export.dart';

class LanguageController extends GetxController {
  updateLocale(String languageCode) async {
    await LocaleManager.instance
        .setString(PreferencesKeys.languageCode, languageCode);
    Get.updateLocale(Locale(languageCode));
  }
}
