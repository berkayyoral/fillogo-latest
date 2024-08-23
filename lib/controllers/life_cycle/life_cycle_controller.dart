import 'dart:developer';

import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/controllers/map/start_or_delete_route_dialog.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/services/socket/socket_service.dart';

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
    if (state == AppLifecycleState.resumed) {
      if (LocaleManager.instance.getInt(PreferencesKeys.currentUserId) !=
          null) {
        int currentUserId =
            LocaleManager.instance.getInt(PreferencesKeys.currentUserId)!;
        SocketService.instance().socket.emit("new-user-add", currentUserId);
      }
      userStateController.update(['onlineUsers']);
      log(state.toString());

      if (LocaleManager.instance
          .getBool(PreferencesKeys.showStartRouteAlert)!) {
        StartOrRouteRouteDialog.show(
          isStartDatePast: true,
          startCity: LocaleManager.instance
              .getString(PreferencesKeys.dialogStartRoute)!,
          finishCity: LocaleManager.instance
              .getString(PreferencesKeys.dialogFinishRoute)!,
          departureTime: DateTime.parse(LocaleManager.instance
              .getCryptedData(PreferencesKeys.dialogDepartureDate)!),
          routeId:
              LocaleManager.instance.getInt(PreferencesKeys.dialogRouteID)!,
        );
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
        "userId": LocaleManager.instance.getInt(PreferencesKeys.currentUserId)!,
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
