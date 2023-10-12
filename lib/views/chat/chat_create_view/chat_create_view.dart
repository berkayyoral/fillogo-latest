import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/chat/chats/chat_response_model.dart';
import 'package:fillogo/models/chat/chats/create_chat/chat_request_model.dart';
import 'package:fillogo/models/search/following/search_following_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/views/chat/chat_create_view/components/chat_create_appbar.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';
import 'package:fillogo/views/search_user_view/components/search_profile_card.dart';
import 'package:fillogo/widgets/custom_search_box.dart';

class ChatCreateView extends StatefulWidget {
  const ChatCreateView({super.key});

  @override
  State<ChatCreateView> createState() => _ChatCreateViewState();
}

class _ChatCreateViewState extends State<ChatCreateView> {
  ChatController chatController = Get.find();
  UserStateController userStateController = Get.find();

  int currentUserId =
      LocaleManager.instance.getInt(PreferencesKeys.currentUserId)!;
  @override
  Widget build(BuildContext context) {
    // List<Chats> chatList = chatController.chatList;
    TextEditingController searchTextController = TextEditingController();
    ChatController chatController = Get.find();
    UserStateController userStateController = Get.find();
    chatController.searchFollowingRequest.text = "";
    return Scaffold(
      appBar: const ChatCreateAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSearchBox(
              controller: searchTextController,
              onChanged: (value) {
                chatController.searchRequestText = searchTextController.text;

                chatController.searchFollowingRequest.text =
                    chatController.searchRequestText;
                chatController.update(['search']);

                GeneralServicesTemp()
                    .makePostRequest(
                      '/users/search-followings',
                      chatController.searchFollowingRequest,
                      ServicesConstants.appJsonWithToken,
                    )
                    .then(
                      (value) => SearchFollowingResponse.fromJson(
                        json.decode(value!),
                      ),
                    );
              },
            ),
            16.h.spaceY,
            GetBuilder<ChatController>(
              id: 'search',
              builder: (controller) {
                return FutureBuilder<SearchFollowingResponse?>(
                    future: GeneralServicesTemp().makePostRequest(
                      '/users/search-followings',
                      chatController.searchFollowingRequest,
                      {
                        'Authorization':
                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                        'Content-Type': 'application/json',
                      },
                    ).then((value) =>
                        SearchFollowingResponse.fromJson(json.decode(value!))),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return (snapshot.data!.success == 1 &&
                                snapshot.data!.data!.isNotEmpty)
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.data![0].searchResult!
                                    .result!.length,
                                itemBuilder: (context, index) {
                                  var user = snapshot.data!.data![0]
                                      .searchResult!.result![index];
                                  return snapshot.data!.data!.isEmpty
                                      ? const Text("Bir sorun oluştu")
                                      : SearchProfileCard(
                                          onPress: () {
                                            sendMessageOnPressed(user.id);
                                          },
                                          nickName: user.username!,
                                          name: user.name!,
                                          allRoute: user.routeCount!,
                                          profilPhoto: user.profilePicture,
                                        );
                                },
                              )
                            : const Center(
                                child: Text("Kullanıcı Bulunamadı"),
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  sendMessageOnPressed(dynamic userId) async {
    GeneralServicesTemp().makeGetRequest(
      "/chats/list",
      {
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
        'Content-Type': 'application/json',
      },
    ).then(
      (value) {
        final response = ChatResponseModel.fromJson(json.decode(value!));

        List<Chat> chatList = response.data![0].chats!;

        Chat currentChat = Chat(id: 0);

        for (var chat in chatList) {
          if (chat.member1Id == userId) {
            currentChat = chat;
          }
          if (chat.member2Id == userId) {
            currentChat = chat;
          }
        }
        log(currentChat.id.toString());
        if (currentChat.id! != 0) {
          goToChat(currentChat);
        } else {
          GeneralServicesTemp().makePostRequest(
            '/chats/new',
            ChatRequestModel(member: userId),
            {
              'Authorization':
                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
              'Content-Type': 'application/json',
            },
          ).then((value2) {
            final response2 = ChatResponseModel.fromJson(json.decode(value2!));

            if (response2.success == 1) {
              sendMessageOnPressed(userId);
            } else {
              log("Bir hata oluştu : + rff ${response2.message} ");
            }
          });
        }
      },
    );
  }

  goToChat(Chat currentChat) {
    // NotificationController notificationController = Get.find();

    SenderClass receiverUser = SenderClass();
    for (var element in currentChat.chatusers!) {
      if (element.chatuser!.id != currentUserId) {
        receiverUser = element.chatuser!;
      }
    }

    // notificationController.removeMessageChatIdList(currentChat.id!);
    // LocaleManager.instance.setInt(PreferencesKeys.chatCount,
    //     notificationController.messageChatIdList.length);

    // notificationController.chatCount.value =
    //     LocaleManager.instance.getInt(PreferencesKeys.chatCount);

    chatController.changeLiveChattingUserId(receiverUser.id);
    chatController.chatId = currentChat.id!;

    chatController.receiverUser = (SenderClass(
        id: receiverUser.id,
        name: receiverUser.name,
        surname: receiverUser.surname,
        profilePicture: receiverUser.profilePicture));
    // messageController.chatMessages.clear();
    Get.toNamed('/chatDetailsView');

    SocketService.instance().socket.emit("add-chat-user", {
      "chatId": currentChat.id,
      "userId": currentUserId,
    });

    if (currentChat.messages!.isNotEmpty) {
      if ((LocaleManager.instance.getInt(PreferencesKeys.currentUserId) !=
              currentChat.messages![0].senderId &&
          currentChat.messages![0].senderId ==
              chatController.receiverUser.id)) {
        SocketService.instance().socket.emit(
          "message-seen-status",
          {
            "chatId": currentChat.id!,
            "mesaj": "sdfsf",
          },
        );
        chatController.update(["chat"]);
      }
    }
  }
}
