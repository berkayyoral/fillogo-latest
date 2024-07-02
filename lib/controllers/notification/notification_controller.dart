import 'package:fillogo/export.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationController extends GetxController {
  RxBool value = false.obs;

  var navigationNotify = NavigationConstants.notifications.obs;

  var notificationCount = 0.obs;

  changeNavigationNotify(newNavigation) {
    navigationNotify.value = newNavigation;
    navigationNotify.refresh();
  }

  var params = [].obs;

  changeParams(newValue) {
    params.clear();
    params.value = newValue;
    params.refresh();
  }

  @override
  void onInit() {
    initializeNotifications();
    super.onInit();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('ic_stat_notifications');

  final DarwinInitializationSettings _darwinInitializationSettings =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) async {},
  );
  void initializeNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _darwinInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        Get.toNamed(navigationNotify.value, arguments: [
          params[0],
        ]);
      },
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
