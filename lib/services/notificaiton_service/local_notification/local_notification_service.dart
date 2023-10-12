import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService() {
    initializeNotifications();
  }
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('ic_stat_notifications');

  void initializeNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        NotificationController notificationController = Get.find();
        Get.toNamed(notificationController.navigationNotify.value, arguments: [
          notificationController.params[0],
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

  void pushNotification({
    required int receiver,
    required int type,
    required String name,
    required String content,
    required List<int> params,
    String? surname,
    String? username,
  }) {
    NotificationModel notificationModel = NotificationModel(
      sender: LocaleManager.instance.getInt(PreferencesKeys.currentUserId),
      receiver: receiver,
      type: type,
      params: params,
      message: NotificaitonMessage(
        text: NotificationText(
          content: content,
          name: name,
          surname: surname ?? "",
          username: username ?? "",
        ),
        link: "",
      ),
    );
    SocketService.instance().socket.emit(
          'notification',
          notificationModel,
        );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }
}
