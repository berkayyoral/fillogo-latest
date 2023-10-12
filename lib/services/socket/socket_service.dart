import 'dart:developer';

import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  connectSocket() {
    socket.on("get-notification", (data) async {
      NotificationController notificationController =
          Get.put(NotificationController());

      if (data['type'] != 5) {
        NotificationController().notificationCount.value =
            NotificationController().notificationCount.value + 1;

        LocaleManager.instance.setInt(PreferencesKeys.notificationCount,
            notificationController.notificationCount.value);
      }

      onTapNotification(data);
      NotificationController().showNotification(
        title: "FilloGO",
        body: data['type'] != 5
            ? "${data['message']['text']['name'].toString()} ${data['message']['text']['surname'].toString()} ${data['message']['text']['content'].toString()}"
            : "${data['message']['text']['name'].toString()}:${data['message']['text']['surname'].toString()} ${data['message']['text']['content'].toString()}",
      );
    });
  }

  onTapNotification(data) {
    switch (data['type']) {
      default:
        NotificationController()
            .changeNavigationNotify(NavigationConstants.notifications);
    }
  }
}
