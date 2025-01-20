import 'dart:developer';

import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/controllers/map/start_or_delete_route_dialog.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/services/notificaiton_service/one_signal_notification/one_signal_notification_service.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LifeCycleController extends GetxController with WidgetsBindingObserver {
  @override
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  UserStateController userStateController = Get.find();

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    userStateController.state.value = state;

    print(
        "LİFECYSKLEMMMM -> USER ->  ${userStateController.state.value} state -> ${state}");
    if (state == AppLifecycleState.resumed) {
      if (LocaleManager.instance.getInt(PreferencesKeys.currentUserId) !=
          null) {
        int currentUserId =
            LocaleManager.instance.getInt(PreferencesKeys.currentUserId)!;
        SocketService.instance().socket.emit("new-user-add", currentUserId);
      }
      userStateController.update(['onlineUsers']);
      log(state.toString());
      print("RESUMMEEE");

      print(
          "LİFECYCLE NOTİFY -> ${LocaleManager.instance.getString(PreferencesKeys.dialogStartRoute)}");
      // if (LocaleManager.instance.getString(PreferencesKeys.dialogStartRoute) !=
      //     null) {
      //   StartOrRouteRouteDialog.show(
      //     isStartDatePast: true,
      //     startCity: LocaleManager.instance
      //         .getString(PreferencesKeys.dialogStartRoute)!,
      //     finishCity: LocaleManager.instance
      //         .getString(PreferencesKeys.dialogFinishRoute)!,
      //     departureTime: DateTime.now(),
      //     routeId:
      //         LocaleManager.instance.getInt(PreferencesKeys.dialogRouteID)!,
      //   );
      // }

      if (LocaleManager.instance
          .getBool(PreferencesKeys.showStartRouteAlert)!) {
        print("TRUEEE");
      } else {
        print("FALSEE");
      }
    }

    if ((state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive)) {
      GlobalChatController globalChatController = Get.find();

      if (globalChatController.isMessageView == true) {
        Get.back();
      }
      log("paused and inactive life cycle");
      SocketService.instance().socket.emit("offline");
      SocketService.instance().socket.emit("remove-chat-user", {
        "userId":
            LocaleManager.instance.getInt(PreferencesKeys.currentUserId) ?? 0,
      });
      print(
          "LİFECYCLE SHOW -> ${LocaleManager.instance.getBool(PreferencesKeys.showStartRouteAlert)}");
      if (LocaleManager.instance
          .getBool(PreferencesKeys.showStartRouteAlert)!) {
        LocaleManager.instance
            .setBool(PreferencesKeys.showStartRouteAlert, false);
      }

      userStateController.update(['onlineUsers']);

      log(state.toString());
    }
  }
}
