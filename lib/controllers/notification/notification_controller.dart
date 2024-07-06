import 'dart:async';
import 'package:fillogo/export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void backgroundNotificationHandler(NotificationResponse notificationResponse) {
  // Arka plan bildirim işleme kodları buraya
  print("NOTİFYCMM RESPONSE2: ${notificationResponse.payload}");
  // Do something with the notification, for example:
  Get.toNamed(NavigationConstants.notifications,
      arguments: notificationResponse.payload);
}

class NotificationController extends GetxController {
  RxBool value = false.obs;
  var navigationNotify = NavigationConstants.notifications.obs;
  var notificationCount = 0.obs;
  RxBool isUnReadMessage = false.obs;
  RxBool isUnOpenedNotification = false.obs;

  changeNavigationNotify(newNavigation) {
    navigationNotify.value = newNavigation;
    navigationNotify.refresh();
    print("NOTİFYCMM change -> ${newNavigation}");
  }

  var params = [].obs;

  changeParams(newValue) {
    params.clear();
    params.value = newValue;
    params.refresh();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('ic_stat_notifications');

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      print("NOTİFYCMM darwincim}");
      ReceivedNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      );
    },
  );

  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // iOS için eski bildirimler
    Get.dialog(AlertDialog(
      title: Text(title ?? ""),
      content: Text(body ?? ""),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            print("NOTİFYCMM ioosossoso");
            Get.back();
          },
        )
      ],
    ));
  }

  @override
  void onInit() {
    initializeNotifications();
    print("NOTİFYCMM noldu kk->");
    super.onInit();
  }

  void initializeNotifications() async {
    print("NOTİFYCMM noldu 1->");
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print("NOTİFYCMM RESPONSE: ${notificationResponse.payload}");
        Get.toNamed(navigationNotify.value,
            arguments: params.isNotEmpty ? params[0] : null);
      },
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    );
  }

  Future showNotification({
    int id = 0,
    required String title,
    required String body,
  }) async {
    return _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        color: Colors.transparent,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> requestNotificationPermission() async {
    final PermissionStatus permissionStatus =
        await Permission.notification.request();
    if (permissionStatus == PermissionStatus.denied) {
      await openAppSettings();
    }
  }

  Future<bool> checkNotificationPermission() async {
    PermissionStatus permission = await Permission.notification.status;
    return permission == PermissionStatus.granted;
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
