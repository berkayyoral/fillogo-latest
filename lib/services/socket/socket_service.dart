import 'dart:convert';
import 'dart:developer';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/services/notificaiton_service/one_signal_notification/onesignal_send_notifycation_service.dart';
import 'package:http/http.dart' as http;

import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../export.dart';

class SocketService {
  late IO.Socket socket;
  SocketService._() {
    socket = IO.io(
      'https://fillogo.com:7000',
      //'ws://172.20.224.1:5000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setTimeout(20000)
          .enableForceNewConnection()
          .build(),
    );
    socket.onConnect((data) => log('Connection established'));
    socket.onConnectError((data) => log('Connect Error: $data'));
    socket.onDisconnect((data) => log('Socket.IO server disconnected'));
  }
  static SocketService? _singeton = SocketService._();

  static SocketService instance() {
    _singeton ??= SocketService._();
    return _singeton!;
  }

  destroy() {
    socket.destroy();
    _singeton = null;
  }

  close() {
    socket.close();
  }

  connect() {
    socket.connect();
    if (socket.active) {
      connectSocket();
    }
  }

  connectSocket() async {
    socket.on("get-notification", (data) async {
      print("NOTİFYCMM -> ${data}");
      NotificationController notificationController =
          Get.put(NotificationController());

      if (data['type'] != 5) {
        notificationController.notificationCount.value =
            NotificationController().notificationCount.value + 1;

        LocaleManager.instance.setInt(PreferencesKeys.notificationCount,
            notificationController.notificationCount.value);
      }

      NotificationModel notificationModel = NotificationModel.fromJson(data);

      if (notificationModel.type == 5) {
        notificationController.isUnReadMessage.value = true;
      } else if (notificationModel.type == 1 || notificationModel.type == 99) {
        notificationController.isUnOpenedNotification.value = true;
      }
      print("NOTİFYCMM NOTİFİCAİTONMODEL -> ${notificationModel}");
      String currentRoute = Get.currentRoute;
      String previousRoute = Get.previousRoute;
      print("NOTİFYCMM curret route -> $currentRoute");
      if (currentRoute != NavigationConstants.message &&
          (currentRoute != NavigationConstants.chatDetailsView &&
              previousRoute != NavigationConstants.message)) {
        OneSignalSenNotification()
            .sendNotification(notificationModel: notificationModel);
      }
      // onTapNotification(data);

      // notificationController.showNotification(
      //   title: "FilloGO",
      //   body: data['type'] != 5
      //       ? "${data['message']['text']['name'].toString()} ${data['message']['text']['surname'].toString()} ${data['message']['text']['content'].toString()}"
      //       : "${data['message']['text']['name'].toString()}:${data['message']['text']['surname'].toString()} ${data['message']['text']['content'].toString()}",
      // );
    });
  }

  onTapNotification(data) {
    switch (data['type']) {
      default:
        print("NOTİFYCMM değişti");
        // Get.toNamed(NavigationConstants.notifications);
        NotificationController()
            .changeNavigationNotify(NavigationConstants.notifications);
    }
  }
}
