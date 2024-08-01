import 'dart:convert';

import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/core/constants/enums/preference_keys_enum.dart';
import 'package:fillogo/core/init/locale/locale_manager.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../export.dart';

class OneSignalManager {
  static Future<void> setupOneSignal() async {
    OneSignal.initialize(AppConstants.oneSignalAppId);
    final int? id =
        LocaleManager.instance.getInt(PreferencesKeys.currentUserId);
    print("ONESİGNALm burdayım");
    print("ONESİGNALm İÇİN ID -> $id");
    final String deviceLang =
        LocaleManager.instance.getString(PreferencesKeys.languageCode) ??
            Get.deviceLocale?.languageCode ??
            AppConstants.defaultLanguage;

    if (id != null) {
      print("NOTİFYCMM ONESİGNALm İÇİN IDm c -> $id");
      await OneSignal.login(id.toString())
          .then((value) => print("ONESİGNALm LOGİN OLDUM"));
    }
    OneSignal.User.setLanguage(deviceLang);

    OneSignal.Notifications.requestPermission(false).then((permission) async {
      print("NOTİFYCMM ONESİGNALm permission $permission");
      await setupNotificationStatusInTheBackend(
          isNotificationActive: permission);
    });

    OneSignal.Notifications.addPermissionObserver((permission) async {
      print("NOTİFYCMM ONESİGNALm permissionmm");
      await setupNotificationStatusInTheBackend(
          isNotificationActive: permission);
    });

    OneSignal.Notifications.addClickListener((event) {
      try {
        int type = event.notification.additionalData!["type"];
        int sender = event.notification.additionalData!["sender"];
        List? params = event.notification.additionalData!["params"];
        debugPrint(
            'NOTİFYCMM ONESİGNALm EVENT: type -> $type param -> $params sender -> $sender');

        // Get.toNamed(NavigationConstants.otherprofiles,
        //     arguments: event.notification.additionalData!["params"]
        //         .first);
        navigateToPage(type: type, params: params ?? [], sender: sender);
      } catch (e) {
        print("NOTİFYCMM ONESİGNALm  click error -> $e");
      }
    });

    OneSignal.User.pushSubscription.addObserver((stateChanges) async {
      debugPrint(
          'NOTİFYCMM ONESİGNALm previous state ${stateChanges.previous.optedIn}');
      debugPrint(
          'NOTİFYCMM ONESİGNALm current state ${stateChanges.current.optedIn}');

      if (stateChanges.current.optedIn == true) {
        // OneSignal.logout();
        await setupOneSignal();
      }
    });
  }

  static Future<bool> switchNotificationStatus(
      {required bool isNotificationActive}) async {
    if (isNotificationActive) {
      if (!OneSignal.Notifications.permission) {
        bool permission =
            await OneSignal.Notifications.requestPermission(false);
        await setupNotificationStatusInTheBackend(
            isNotificationActive: permission);
        return permission;
      } else {
        // bu fonsksiyon kullanıcının bildirim almasına izin verir
        OneSignal.User.pushSubscription.optIn();
        return isNotificationActive;
      }
    } else {
      if (OneSignal.Notifications.permission) {
        // bu fonsksiyon kullanıcının bildirim almasını durdurur
        OneSignal.User.pushSubscription.optOut();
      }
      return isNotificationActive;
    }
  }
}

void navigateToPage(
    {required int type, required List? params, required int sender}) {
  NotificationController notificationController = Get.find();
  print("NOTİFYCMM NOTİFY TYPOE -> $type");
  switch (type) {
    case 1:
      print("NOTİFYCMM type 1");
      Get.toNamed(NavigationConstants.otherprofiles, arguments: sender);
      break;
    case 3:
      params!.isNotEmpty
          ? Get.toNamed(NavigationConstants.comments, arguments: params)
          : Get.toNamed(NavigationConstants.notifications, arguments: params);
      break;
    case 4:
      params!.isNotEmpty
          ? Get.toNamed(NavigationConstants.comments, arguments: params)
          : Get.toNamed(NavigationConstants.notifications, arguments: params);
      break;
    case 5:
      Get.toNamed(NavigationConstants.message, arguments: params);
      notificationController.isUnReadMessage.value = false;
      break;
    case 99: //selektör
      Get.toNamed(NavigationConstants.notifications, arguments: params);
      notificationController.isUnOpenedNotification.value = false;
      break;
    // case 3:
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await Get.offAllNamed(NavigationConstants.navigationPageview,
    //         arguments: 0);
    //   });
    //   break;
    // case 4:
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await Get.offAllNamed(NavigationConstants.navigationPageview,
    //         arguments: 1);
    //   });
    //   break;
    // case 5:
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await Get.offAllNamed(NavigationConstants.navigationPageview,
    //         arguments: 1);
    //   });
    //   break;
    // default:
  }
}

Future<void> setupNotificationStatusInTheBackend(
    {required bool isNotificationActive}) async {
  return print("NOTİFYCMM ALDIMMMM");
  // GetNotificationStatusResponseModel? response =
  //     await NotificationsServices.getNotificationStatus();
  // if (response == null || response.success != 1) {
  //   return;
  // }

  // if (isNotificationActive) {
  //   if (!response.data!.first.isNotificationOpen!) {
  //     SwitchNotificationStatusResponseModel? switchResponse =
  //         await NotificationsServices.switchNotificationStatus();
  //     if (switchResponse == null || switchResponse.success != 1) {
  //       return;
  //     }
  //   }
  // } else {
  //   if (response.data!.first.isNotificationOpen!) {
  //     SwitchNotificationStatusResponseModel? switchResponse =
  //         await NotificationsServices.switchNotificationStatus();
  //     if (switchResponse == null || switchResponse.success != 1) {
  //       return;
  //     }
  //   }
  // }
}

// class OneSignalManager {
//   static Future<void> setupOneSignal({
//     required String id,
//   }) async {
//     final String deviceLang =
//         LocaleManager.instance.getString(PreferencesKeys.languageCode) ?? Get.deviceLocale?.languageCode ?? AppConstants.defaultLanguage;

//     final OneSignal oneSignal = OneSignal.shared;

//     oneSignal.setAppId(AppConstants.oneSignalAppId);
//     oneSignal.setExternalUserId(id);
//     oneSignal.setLanguage(deviceLang);

//     oneSignal.promptUserForPushNotificationPermission();

//     oneSignal.setNotificationOpenedHandler((openedResult) async {
//       /* Accessible Fields On Notification */
//       final OSNotification notification = openedResult.notification;

//       /* Custom Informations */
//       final Map<String, dynamic>? additionalData = notification.additionalData;

//       if (additionalData != null) {
//         final int type = additionalData["type"];
//         final Map<String, dynamic> info = _redirects["$type"];

//         final String path = info["path"];
//         final Map<String, dynamic>? arguments = info["arguments"];

//         WidgetsBinding.instance.addPostFrameCallback((_) async {
//           if (path == NavigationConstants.navigationPageview) {
//             await Get.offAllNamed(path, arguments: arguments);
//           } else {
//             await Get.toNamed(path, arguments: arguments);
//           }
//         });
//       }
//     });
//   }
// }

// Map<String, dynamic> _redirects = {
//   "1": {
//     "arguments": null,
//     "path": NavigationConstants.settingsView,
//   },
//   "2": {
//     "arguments": null,
//     "path": NavigationConstants.paymentsView,
//   },
//   "3": {
//     "arguments": null,
//     "path": NavigationConstants.myEventsView,
//   },
//   "4": {
//     "arguments": {"tabIndex": 1},
//     "path": NavigationConstants.navigationPageview,
//   },
//   "5": {
//     "arguments": null,
//     "path": NavigationConstants.upcomingCustomersView,
//   },
//   "6": {
//     "arguments": {"tabIndex": 1},
//     "path": NavigationConstants.navigationPageview,
//   },
//   "7": {
//     "arguments": null,
//     "path": NavigationConstants.myEventsView,
//   },
//   "8": {
//     "arguments": {"tabIndex": 3},
//     "path": NavigationConstants.navigationPageview,
//   },
//   "9": {
//     "arguments": null,
//     "path": NavigationConstants.myEventsView,
//   },
// };

// import 'dart:developer';

// import 'package:fillogo/export.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

// class OneSignalNotificationService {
//   static OneSignal? _instance;
//   OneSignalNotificationService() {
//     getInstance();
//     _instance!.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//     _instance!.setAppId(AppConstants.oneSignalAppId);
//     _instance!.promptUserForPushNotificationPermission().then((accepted) {
//       log("1111111111111111111!!!");
//     });
//     _instance!.setNotificationWillShowInForegroundHandler(
//         (OSNotificationReceivedEvent event) {
//       event.complete(event.notification);
//     });

// /* _instance!.setExternalUserId(LocaleManager.instance
//     .getInt(PreferencesKeys.currentUserId)
//         .toString());*/

//     _instance!.setPermissionObserver((OSPermissionStateChanges changes) {});
//     _handleGetDeviceState();
//   }
//   void _handleGetDeviceState() async {
//     print("2222222222222222222222");
//     OneSignal.shared.getDeviceState().then((deviceState) {
//       LocaleManager.instance
//           .setBool(PreferencesKeys.subscribedValue, deviceState!.subscribed);
//     });
//   }

//   OneSignal? getInstance() {
//     _instance ??= OneSignal.shared;
//     return _instance;
//   }

//   handleClickNotification() {
//     OneSignal.shared.setNotificationOpenedHandler(
//         (OSNotificationOpenedResult result) async {
//       //  Logger().e("OneSignal bildirimine tıklandı");
//       log("ONESIGNAL BILDIRIMINE TIKLANDIIIIIIII");
//       switch (result.notification.additionalData!["type"]) {
//         case 1:
//           break;
//         case 2:
//           break;
//         case 3:
//           break;
//         case 4:
//           break;
//         case 5:
//           break;
//         case 10:
//           Get.toNamed(NavigationConstants.myRoutesPageView);
//           break;
//         default:
//           Get.toNamed(NavigationConstants.notifications);
//       }
//     });
//   }
// }
