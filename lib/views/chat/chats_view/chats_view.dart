import 'dart:convert';

import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/chat/chats/chat_response_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';
import 'package:fillogo/widgets/custom_user_information_card.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class ChatsView extends StatefulWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  ChatController chatController = Get.find();
  UserStateController userStateController = Get.find();
  int? currentUserId;

  @override
  Widget build(BuildContext context) {
    print(
        "Current User Id = ${LocaleManager.instance.getInt(PreferencesKeys.currentUserId)}");
    currentUserId =
        LocaleManager.instance.getInt(PreferencesKeys.currentUserId);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: AppConstants().ltWhite),
        onPressed: () {
          Get.toNamed(NavigationConstants.chatCreate);
        },
      ),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
          ),
          child: GetBuilder<ChatController>(
            id: 'chat',
            builder: (controller) {
              return FutureBuilder<ChatResponseModel?>(
                future: GeneralServicesTemp().makeGetRequest(
                  "/chats/list",
                  {
                    "Content-type": 'application/json',
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                  },
                ).then((value) {
                  if (value != null) {
                    return ChatResponseModel.fromJson(json.decode(value));
                  }
                  return null;
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    chatController.chatList = snapshot.data!.data!.isEmpty
                        ? []
                        : snapshot.data!.data![0].chats!;
                    List<Chat>? chatList = [];
                    for (var element in chatController.chatList) {
                      if (element.messages!.isNotEmpty) {
                        chatList.add(element);
                      }
                    }
                    chatList.sort((a, b) {
                      var adate = a.messages![0].createdAt;
                      var bdate = b.messages![0].createdAt;
                      return -adate!.compareTo(bdate!);
                    });
                    return chatList.isEmpty
                        ? Center(
                            child: UiHelper.notFoundAnimationWidget(
                                context, 'Hiç mesaj bulunamadı...'),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero, //This deletes spaces.
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              var receiverIndex = getChatUsersId(
                                  chatusers: chatList[index].chatusers!);
                              return chatList[index].messages!.isEmpty
                                  ? const SizedBox()
                                  : UserInformationCard(
                                      userId: chatList[index]
                                          .chatusers![receiverIndex]
                                          .chatuser!
                                          .id!,
                                      imagePath: chatList[index]
                                              .chatusers![receiverIndex]
                                              .chatuser!
                                              .profilePicture ??
                                          'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png',
                                      name: chatList[index]
                                          .chatusers![receiverIndex]
                                          .chatuser!
                                          .name!,
                                      lastMessage:
                                          chatList[index].messages![0].text!,
                                      lastMessageTime: timeago.format(
                                        chatList[index].messages![0].createdAt!,
                                        locale: "tr",
                                      ),
                                      unreadMessageCounter: (chatList[index]
                                                  .messages![0]
                                                  .sender!
                                                  .id !=
                                              currentUserId)
                                          ? int.parse(
                                              chatList[index].sentCount!)
                                          : 0,
                                      onTap: () {
                                        chatController.changeLiveChattingUserId(
                                            chatList[index]
                                                .chatusers![receiverIndex]
                                                .chatuser!
                                                .id!);
                                        chatController.chatId =
                                            chatList[index].id;

                                        chatController.receiverUser =
                                            SenderClass(
                                          id: chatList[index]
                                              .chatusers![receiverIndex]
                                              .chatuser!
                                              .id!,
                                          name: chatList[index]
                                              .chatusers![receiverIndex]
                                              .chatuser!
                                              .name!,
                                          surname: chatList[index]
                                              .chatusers![receiverIndex]
                                              .chatuser!
                                              .surname!,
                                          profilePicture: chatList[index]
                                              .chatusers![receiverIndex]
                                              .chatuser!
                                              .profilePicture!,
                                        );
                                        Get.toNamed('/chatDetailsView');

                                        if ((currentUserId !=
                                                chatList[index]
                                                    .messages![0]
                                                    .senderId &&
                                            chatList[index]
                                                    .messages![0]
                                                    .senderId ==
                                                chatController
                                                    .receiverUser.id)) {
                                          SocketService.instance().socket.emit(
                                            "message-seen-status",
                                            {
                                              "chatId": chatList[index].id!,
                                              "mesaj": "sdfsf",
                                            },
                                          );
                                          chatController.update(["chat"]);
                                        }
                                      },
                                    );
                            },
                          );
                  } else {
                    return Center(
                      child: UiHelper.loadingAnimationWidget(context),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  getChatUsersId({required List chatusers}) {
    for (int i = 0; i < chatusers.length; i++) {
      if (chatusers[i].chatuser.id != currentUserId) {
        chatController.receiverId.value = chatusers[i].chatuser.id;
        return i;
      }
    }
  }

  AppBarGenel buildAppBar() {
    NotificationController notificationController = Get.find();
    return AppBarGenel(
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
      title: Text(
        "Mesajlar",
        style: TextStyle(
          fontFamily: "Sfbold",
          fontSize: 20.sp,
          color: AppConstants().ltBlack,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            Get.toNamed(NavigationConstants.searchUser);
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.w,
              right: 10.w,
            ),
            child: SvgPicture.asset(
              'assets/icons/search-icon.svg',
              height: 25.h,
              width: 25.w,
              color: const Color(0xff3E3E3E),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(NavigationConstants.notifications);
            notificationController.isUnOpenedNotification.value = false;
          },
          child: Padding(
            padding: EdgeInsets.only(
              right: 5.w,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                SvgPicture.asset(
                  height: 25.h,
                  width: 25.w,
                  'assets/icons/notification-icon.svg',
                  color: AppConstants().ltLogoGrey,
                ),
                Obx(() => notificationController.isUnOpenedNotification.value
                    ? CircleAvatar(
                        radius: 6.h,
                        backgroundColor: AppConstants().ltMainRed,
                      )
                    : SizedBox())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
