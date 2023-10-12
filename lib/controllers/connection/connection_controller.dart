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
    if (result != ConnectivityResult.none) {
      Get.offAndToNamed(
        LocaleManager.instance.getBool(PreferencesKeys.firstLogin) == false
            ? NavigationConstants.onboardone
            : NavigationConstants.bottomNavigationBar,
      );
    } else {
      Get.snackbar('ConnectionError'.tr, 'YouAreNotConnectedToTheInternet'.tr,
          backgroundColor: Colors.black.withOpacity(0.5));
    }
  }
}
