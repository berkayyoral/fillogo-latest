import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService() {
    initializeNotifications();
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void initializeNotifications() async {
    print("NOTİFYCMM BURDAYIM");
    AndroidInitializationSettings androidInitializationSettings =
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
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print("NOTİFYCMM BURDAYIMKIİ");
        NotificationController notificationController = Get.find();
        Get.toNamed(notificationController.navigationNotify.value, arguments: [
          notificationController.params[0],
        ]);
      },
    );
  }

  void pushNotification({
    required int receiver,
    required int type,
    required String name,
    required String content,
    required List<int>? params,
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

  Future showNotification({
    int id = 0,
    required String title,
    required String body,
  }) async {
    return flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
    );
  }

  notificationDetails() {
    print("NOTİFYCMM DETAİLSS");
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }
}
