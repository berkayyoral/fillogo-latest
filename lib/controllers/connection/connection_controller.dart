import '../../export.dart';

class ConnectionController extends GetxController {
  Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    connectionListen();
    super.onInit();
  }

  connectionListen() {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none
          // &&
          //     Get.currentRoute != NavigationConstants.connectionError
          ) {
        Get.offAndToNamed(NavigationConstants.connectionError);
      }
    });
  }

  checkConnection() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    bool? firstLogin =
        LocaleManager.instance.getBool(PreferencesKeys.firstLogin);
    String? pass =
        LocaleManager.instance.getString(PreferencesKeys.currentuserpassword);
    if (result != ConnectivityResult.none) {
      print(
          "DEBUGMODEM HATA CHECKC BAĞLANTI -> ${LocaleManager.instance.getBool(PreferencesKeys.firstLogin)}");
      Get.offAndToNamed(
        pass != null
            ? NavigationConstants.bottomNavigationBar
            : firstLogin != null
                ? firstLogin == true
                    ? NavigationConstants.onboardone
                    : NavigationConstants.bottomNavigationBar
                : NavigationConstants.onboardone,
      );
    } else {
      Get.snackbar('ConnectionError'.tr, 'YouAreNotConnectedToTheInternet'.tr,
          backgroundColor: Colors.black.withOpacity(0.5));
    }
  }
}
