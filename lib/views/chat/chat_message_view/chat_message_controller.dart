import 'dart:async';

import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/chat/chat_message/chat_message_response_model.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';

class ChatMessageController extends GetxController {
  ChatController chatController = Get.put(ChatController());
  GlobalChatController globalChatController = Get.find();

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    globalChatController.isMessageView = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => myScrollToBottom());
    SocketService.instance().socket.emit("add-chat-user", {
      "chatId": chatController.chatId,
      "userId": LocaleManager.instance.getInt(PreferencesKeys.currentUserId),
    });

    getUsersInChatWithSocket();
    receiverMessageListenInSocket();
    receiverTypingListenInSocket();
    super.onInit();
  }

  @override
  void onClose() {
    globalChatController.isMessageView = false;
    paginationId = 1;
    removeChatUserInSocket();
    super.onClose();
  }

  final usersInChat = [].obs;
  void changeUserInChat(newUsers) {
    usersInChat.value = newUsers;
    usersInChat.refresh();
  }

  getUsersInChatWithSocket() {
    SocketService.instance().socket.on("get-users-in-chat", (data) {
      changeUserInChat(data);
    });
  }

  final _paginationId = 1.obs;
  get paginationId => _paginationId.value;
  set paginationId(newValue) => _paginationId.value = newValue;

  var newMessageControl = 0.obs;

  final _typingUserId = 0.obs;
  get typingUserId => _typingUserId.value;
  set typingUserId(newValue) => _typingUserId.value = newValue;

  final _typing = false.obs;
  get typing => _typing.value;
  set typing(newValue) => _typing.value = newValue;

  var chatMessages = <Messages>[].obs;

  void addMessageToEnd(Messages newMessage) {
    chatMessages.add(newMessage);
    chatMessages.refresh();
  }

  void addMessageToTop(Messages newMessage) {
    chatMessages.reversed;
    chatMessages.insert(0, newMessage);
    chatMessages.refresh();
  }

  void removeChatUserInSocket() {
    SocketService.instance().socket.emit("remove-chat-user", {
      "userId": LocaleManager.instance.getInt(PreferencesKeys.currentUserId)!,
    });
  }

  void receiverMessageListenInSocket() async {
    SocketService.instance().socket.on("recieve-message", (data) async {
      if (chatController.liveChattingUserId.value == data['senderId']) {
        addMessageToEnd(Messages.fromJson(data['message']));
      } else {}
      globalChatController.messageSeen = data['status'];
      data = Messages();
      WidgetsBinding.instance.addPostFrameCallback((_) => myScrollToBottom());
      chatController.update(["chat"]);
      //log("recieve-message");
    });
  }

  void receiverTypingListenInSocket() {
    SocketService.instance().socket.on('receiver-typing', (data) async {
      var usersInChatIds = [];

      for (var element in usersInChat) {
        usersInChatIds.add(element['userId']);
      }

      if (usersInChatIds.contains(data['receiverId']) &&
          usersInChatIds.contains(data['senderId'])) {
        typing = true;
      }

      Future.delayed(const Duration(seconds: 3), () {
        typing = false;
      });
    });
  }

  void myScrollToBottom() {
    if (scrollController.hasClients && paginationId == 1) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastLinearToSlowEaseIn);
    } else {
      Timer(const Duration(milliseconds: 1), () => myScrollToBottom());
    }
  }
}
