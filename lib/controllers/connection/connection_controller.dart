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
      print("CHECHCON list -> ${result}");
      if (result == ConnectivityResult.none
          // &&
          //     Get.currentRoute != NavigationConstants.connectionError
          ) {
        Get.offAndToNamed(NavigationConstants.connectionError);
      } else {
        checkConnection();
      }
    });
  }

  checkConnection() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    bool? firstLogin =
        LocaleManager.instance.getBool(PreferencesKeys.firstLogin);
    String? pass =
        LocaleManager.instance.getString(PreferencesKeys.currentuserpassword);
    print("CHECHCON _-> ${result}");
    if (result != ConnectivityResult.none) {
      Get.back();
      // Get.toNamed(
      //   pass != null
      //       ? NavigationConstants.bottomNavigationBar
      //       : firstLogin != null
      //           ? firstLogin == true
      //               ? NavigationConstants.onboards
      //               : NavigationConstants.bottomNavigationBar
      //           : NavigationConstants.onboards,
      // );
    } else {
      Get.snackbar('ConnectionError'.tr, 'YouAreNotConnectedToTheInternet'.tr,
          backgroundColor: Colors.black.withOpacity(0.5));
    }
  }
}
