import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalNotificationService {
  static OneSignal? _instance;
  OneSignalNotificationService() {
    getInstance();
    _instance!.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    _instance!.setAppId(AppConstants.oneSignalAppId);
    _instance!.promptUserForPushNotificationPermission().then((accepted) {
      log("1111111111111111111!!!");
    });
    _instance!.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    /* _instance!.setExternalUserId(LocaleManager.instance
        .getInt(PreferencesKeys.currentUserId)
        .toString());*/

    _instance!.setPermissionObserver((OSPermissionStateChanges changes) {});
    _handleGetDeviceState();
  }
  void _handleGetDeviceState() async {
    print("2222222222222222222222");
    OneSignal.shared.getDeviceState().then((deviceState) {
      LocaleManager.instance
          .setBool(PreferencesKeys.subscribedValue, deviceState!.subscribed);
    });
  }

  OneSignal? getInstance() {
    _instance ??= OneSignal.shared;
    return _instance;
  }

  handleClickNotification() {
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      //  Logger().e("OneSignal bildirimine tıklandı");
      log("ONESIGNAL BILDIRIMINE TIKLANDIIIIIIII");
      switch (result.notification.additionalData!["type"]) {
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
        case 4:
          break;
        case 5:
          break;
        case 10:
          Get.toNamed(NavigationConstants.myRoutesPageView);
          break;
        default:
          Get.toNamed(NavigationConstants.notifications);
      }
    });
  }
}
