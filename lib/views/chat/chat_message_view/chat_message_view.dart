import 'dart:convert';
import 'dart:ffi';

import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/chat/chat_message/chat_message_response_model.dart';
import 'package:fillogo/models/chat/chat_message/create_chat_message/chat_message_request_model.dart';
import 'package:fillogo/models/chat/chats/chat_response_model.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/notificaiton_service/local_notification/local_notification_service.dart';
import 'package:fillogo/services/notificaiton_service/one_signal_notification/onesignal_send_notifycation_service.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/views/chat/chat_message_view/chat_message_controller.dart';
import 'package:fillogo/views/chat/chat_message_view/components/chat_message_text_field.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:intl/intl.dart';

// import 'components/chat_message_appbar.dart';

// ignore: must_be_immutable
class ChatMessageView extends StatelessWidget {
  ChatMessageView({Key? key}) : super(key: key);

  TextEditingController chatTextController = TextEditingController();
  ChatMessageController chatMessagesController = Get.find();
  ChatController chatController = Get.find();
  UserStateController userStateController = Get.find();
  GlobalChatController globalChatController = Get.find();

  String? currentUserName =
      LocaleManager.instance.getString(PreferencesKeys.currentUserUserName);

  int? currentUserId =
      LocaleManager.instance.getInt(PreferencesKeys.currentUserId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 2.w,
            ),
            child: SvgPicture.asset(
              height: 20.h,
              width: 20.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: InkWell(
          onTap: () {
            print("asd2d23d ${chatController.receiverId}");
            Get.toNamed('/otherprofiles',
                arguments: chatController.receiverId.value);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfilePhoto(
                height: 28.h,
                width: 28.w,
                url: chatController.receiverUser.profilePicture ??
                    'https://picsum.photos/150',
              ),
              10.w.spaceX,
              Text(
                chatController.receiverUser.name!,
                style: TextStyle(
                  fontFamily: "Sfbold",
                  fontSize: 20.sp,
                  color: AppConstants().ltBlack,
                ),
              ),
              50.w.spaceX,
            ],
          ),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            10.h.spaceY,
            Obx(
              () => FutureBuilder<ChatMessageResponseModel?>(
                future: GeneralServicesTemp().makeGetRequest(
                  "${"/chats/messages/${chatController.chatId}"}?page=${chatMessagesController.paginationId}",
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                    'Content-Type': 'application/json',
                  },
                ).then((value) {
                  if (value != null) {
                    return ChatMessageResponseModel.fromJson(
                        json.decode(value));
                  }
                  return null;
                }),
                builder: (context, snapshot) {
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => chatMessagesController.myScrollToBottom());
                  if (snapshot.hasData) {
                    var messageList = [];
                    if (chatMessagesController.paginationId == 1) {
                      messageList = snapshot.data!.data![0].chat!.isNotEmpty
                          ? snapshot.data!.data![0].chat![0].messages!.reversed
                              .toList()
                          : [];
                    } else {
                      messageList = snapshot.data!.data![0].chat![0].messages!;
                    }

                    for (var element in messageList) {
                      if (chatMessagesController.paginationId == 1) {
                        chatMessagesController.addMessageToEnd(element);
                      } else if (!chatMessagesController.chatMessages
                          .contains(element)) {
                        chatMessagesController.addMessageToTop(element);
                      }
                    }

                    return Expanded(
                        child: Obx(() => chatMessagesController
                                .chatMessages.isEmpty
                            ? const SizedBox()
                            : RefreshIndicator(
                                onRefresh: () async {
                                  messageList.isNotEmpty
                                      ? chatMessagesController.paginationId =
                                          chatMessagesController.paginationId +
                                              1
                                      : null;
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: ListView.builder(
                                    controller:
                                        chatMessagesController.scrollController,
                                    shrinkWrap: true,
                                    itemCount: chatMessagesController
                                        .chatMessages.length,
                                    itemBuilder: (context, index) {
                                      var senderId = chatMessagesController
                                          .chatMessages[index].sender!.id;

                                      return Column(
                                        children: [
                                          Align(
                                            alignment:
                                                (senderId != currentUserId
                                                    ? Alignment.topLeft
                                                    : Alignment.topRight),
                                            child: Card(
                                              color: (senderId == currentUserId
                                                  ? AppConstants().ltMainRed
                                                  : AppConstants().ltWhiteGrey),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 2.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.w),
                                                child: Wrap(
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.end,
                                                  direction: Axis.horizontal,
                                                  spacing: 10,
                                                  children: [
                                                    Text(
                                                      chatMessagesController
                                                          .chatMessages[index]
                                                          .text!,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: senderId ==
                                                                currentUserId
                                                            ? AppConstants()
                                                                .ltWhite
                                                            : AppConstants()
                                                                .ltBlack,
                                                      ),
                                                    ),
                                                    Text(
                                                        chatMessagesController
                                                                    .chatMessages[
                                                                        index]
                                                                    .createdAt ==
                                                                null
                                                            ? "${DateFormat.Hm().format(DateTime.now())} "
                                                            : "${DateFormat.Hm().format(DateTime.parse(
                                                                chatMessagesController
                                                                    .chatMessages[
                                                                        index]
                                                                    .createdAt!,
                                                              ))} ",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: chatMessagesController
                                                                      .chatMessages[
                                                                          index]
                                                                      .sender!
                                                                      .id ==
                                                                  currentUserId
                                                              ? AppConstants()
                                                                  .ltWhite
                                                              : AppConstants()
                                                                  .ltLogoGrey,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: (chatMessagesController
                                                        .chatMessages[index]
                                                        .sender!
                                                        .id !=
                                                    currentUserId
                                                ? Alignment.topLeft
                                                : Alignment.topRight),
                                            child: buildDate(DateTime.parse(
                                                      chatMessagesController
                                                          .chatMessages[index]
                                                          .createdAt!,
                                                    )) ==
                                                    null
                                                ? SizedBox(
                                                    height: Get.height * 0.005)
                                                : Text(
                                                    chatMessagesController
                                                                .chatMessages[
                                                                    index]
                                                                .createdAt ==
                                                            null
                                                        ? "${DateFormat.Hm().format(DateTime.now())} "
                                                        : buildDate(
                                                                DateTime.parse(
                                                              chatMessagesController
                                                                  .chatMessages[
                                                                      index]
                                                                  .createdAt!,
                                                            )) ??
                                                            "",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: AppConstants()
                                                          .ltLogoGrey,
                                                    ),
                                                  ),
                                          ),
                                          index ==
                                                  chatMessagesController
                                                          .chatMessages.length -
                                                      1
                                              ? Obx(
                                                  () => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                        (currentUserId ==
                                                                chatMessagesController
                                                                    .chatMessages
                                                                    .last
                                                                    .sender!
                                                                    .id)
                                                            ? (globalChatController
                                                                            .messageSeen ==
                                                                        "seen" &&
                                                                    globalChatController
                                                                            .messageSeenChatId ==
                                                                        chatController
                                                                            .chatId)
                                                                ? "Görüldü"
                                                                : ""
                                                            : "",
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            chatController.receiverUser.id !=
                    chatMessagesController.typingUserId
                ? Obx(
                    () => Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 16.w, bottom: 5.h),
                          child: chatMessagesController.typing
                              ? const Text("Yazıyor...")
                              : const SizedBox()),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.only(
                bottom: 24.h,
                left: 16.w,
                right: 16.w,
              ),
              child: SizedBox(
                height: 50.h,
                width: 340.w,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ChatMessageTextField(
                        controller: chatTextController,
                        onChanged: (value) {
                          SocketService.instance().socket.emit(
                            "typing",
                            {
                              "receiverId": chatController.receiverUser.id,
                              "senderId": currentUserId,
                            },
                          );
                          WidgetsBinding.instance.addPostFrameCallback(
                              (_) => chatMessagesController.myScrollToBottom());
                        },
                      ),
                      10.w.spaceX,
                      sendButton()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector sendButton() {
    SenderClass receiverUser = chatController.receiverUser;
    return GestureDetector(
      onTap: () async {
        if (chatTextController.text.isNotEmpty) {
          chatMessagesController.typing = false;

          await GeneralServicesTemp().makePostRequest(
            '/chats/message',
            ChatMessageRequestModel(
                chatID: chatController.chatId, text: chatTextController.text),
            {
              'Authorization':
                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
              'Content-Type': 'application/json',
            },
          );

          Messages messageJson = Messages(
            text: chatTextController.text,
            createdAt: DateTime.now().toString(),
            sender: Sender(id: currentUserId, username: currentUserName),
          );

          /// SEND MESSAGE WİTH SOCKET
          SocketService.instance().socket.emit(
            'send-message',
            {
              "message": messageJson,
              "receiverId": receiverUser.id,
              "chatId": chatController.chatId,
              "senderId": currentUserId,
            },
          );

          globalChatController.messageSeen = "sent";

          if (chatMessagesController.usersInChat.length == 2) {
            SocketService.instance().socket.emit(
              "message-seen-status",
              {"chatId": chatController.chatId},
            );
          } else {
            // OneSignalSenNotification().sendNotification(
            //   notificationModel: NotificationModel(
            //     message: NotificaitonMessage(
            //       text: NotificationText(
            //         username: currentUserName!,
            //         surname: "",
            //         content: ": ${chatTextController.text}",
            //       ),
            //     ),
            //     sender: currentUserId,
            //     receiver: receiverUser.id!,
            //     type: 5,
            //   ),
            // );
          }

          chatMessagesController.addMessageToEnd(messageJson);
          messageJson = Messages();
          chatMessagesController.chatMessages.refresh();

          ///SEND MESSAGE WİTH ONESİGNAL

          LocalNotificationService().pushNotification(
            receiver: receiverUser.id!,
            type: 5,
            username: currentUserName!,
            name: currentUserName!,
            content: ": ${chatTextController.text}",
            params: [chatController.chatId],
          );
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => chatMessagesController.myScrollToBottom());
          chatTextController.text = '';
          chatController.update(["chat"]);
        }
      },
      child: SvgPicture.asset(
        'assets/icons/message-icon.svg',
        height: 30.h,
        width: 30.w,
        color: AppConstants().ltMainRed,
      ),
    );
  }

  buildDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return null;
    } else if (aDate == yesterday) {
      return "Dün";
    } else {
      // ignore: unnecessary_string_interpolations
      return "${DateFormat('dd.MM.yy').format(date)}";
    }
  }
}
