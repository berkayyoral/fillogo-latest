import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/chat/chats/chat_response_model.dart';
import 'package:fillogo/models/chat/chats/create_chat/chat_request_model.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/models/user/block_user.dart';
import 'package:fillogo/models/user/follow_user.dart';
import 'package:fillogo/models/user/other_profile/other_profile.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:fillogo/widgets/followers_count_row_widget.dart';
import 'package:fillogo/widgets/popup_post_details.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';
import 'package:fillogo/widgets/profile_header_widget.dart';
import 'package:fillogo/widgets/user_vehicle_infos_widget.dart';

class OtherProfilsView extends StatelessWidget {
  OtherProfilsView({Key? key}) : super(key: key);
  final PostService postService = PostService();

  var isFollowed = false.obs;
  var isReported = false.obs;

  UserOtherProfileRequest otherProfileRequest = UserOtherProfileRequest();
  ChatController chatController = Get.put(ChatController());
  ConnectionsController connectionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    otherProfileRequest.userID = Get.arguments ?? 1;
    return GetBuilder<UserStateController>(
      id: 'like',
      builder: (controller) {
        return FutureBuilder<UserOtherProfileResponse>(
            future: GeneralServicesTemp().makePostRequest(
                "/users/user-profile?page=1", otherProfileRequest, {
              "Content-type": "application/json",
              'Authorization':
                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
            }).then((value) {
              return UserOtherProfileResponse.fromJson(json.decode(value!));
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                isReported.value = snapshot.data!.data!.doIblock!;
                isFollowed.value = snapshot.data!.data!.doIfollow!;
                print("isReported.val" + isReported.value.toString());
                return Scaffold(
                  appBar: AppBarGenel(
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                        ),
                        child: SvgPicture.asset(
                          height: 24.h,
                          width: 24.w,
                          'assets/icons/back-icon.svg',
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                    ),
                    title: Text(
                      "${snapshot.data!.data!.users!.name!} ${snapshot.data!.data!.users!.surname!}",
                      style: TextStyle(
                        fontFamily: "Sfbold",
                        fontSize: 20.sp,
                        color: AppConstants().ltBlack,
                      ),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Container(
                                      margin: EdgeInsets.all(12.w),
                                      width: Get.width,
                                      height: 120.h,
                                      child: Column(
                                        children: [
                                          Divider(
                                              indent: 150.w,
                                              endIndent: 150.w,
                                              height: 2.5.h,
                                              thickness: 2.5.h,
                                              color: AppConstants().ltBlack),
                                          const DummyBox15(),
                                          const DummyBox15(),
                                          Obx(
                                            () => GestureDetector(
                                              onTap: () {
                                                print(EndPoint.blockUser +
                                                    otherProfileRequest.userID
                                                        .toString());
                                                GeneralServicesTemp()
                                                    .makePostRequest2(
                                                  EndPoint.blockUser +
                                                      otherProfileRequest.userID
                                                          .toString(),
                                                  {
                                                    'Authorization':
                                                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                    'Content-Type':
                                                        'application/json',
                                                  },
                                                ).then((value) {
                                                  var response =
                                                      BlockUserResponse
                                                          .fromJson(json
                                                              .decode(value!));
                                                  if (response.success == 1) {
                                                    isReported.value =
                                                        !isReported.value;

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          ShowAllertDialogWidget(
                                                        button1Color:
                                                            AppConstants()
                                                                .ltMainRed,
                                                        button1Height: 50.h,
                                                        button1IconPath: '',
                                                        button1Text: 'Tamam',
                                                        button1TextColor:
                                                            AppConstants()
                                                                .ltWhite,
                                                        button1Width: Get.width,
                                                        buttonCount: 1,
                                                        discription1: isReported
                                                                    .value ==
                                                                true
                                                            ? "Bu kullanıcıyı engellediniz."
                                                            : "Bu kullanıcının engelini kaldırdınız.",
                                                        discription2: "",
                                                        onPressed1: () {
                                                          Get.back();
                                                        },
                                                        title: isReported
                                                                    .value ==
                                                                true
                                                            ? 'Engellendi'
                                                            : "Engeli Kaldırıldı",
                                                      ),
                                                    );
                                                  } else {
                                                    print(response.message);
                                                    print(response.success);
                                                    UiHelper.showWarningSnackBar(
                                                        context,
                                                        "Bir hata ile karşılaşıldı Lütfen Tekrar Deneyiniz");
                                                  }
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 12.w),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/icons/information.svg"),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10.w),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            isReported.value ==
                                                                    false
                                                                ? 'Engelle'
                                                                : "Engeli Kaldır",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Sfmedium",
                                                                color: AppConstants()
                                                                    .ltMainRed,
                                                                fontSize:
                                                                    14.sp),
                                                          ),
                                                          Text(
                                                            isReported.value ==
                                                                    false
                                                                ? "Bu kullanıcıyı engelliyorsunuz."
                                                                : "Bu kullanıcıyı engellediniz",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Sflight",
                                                                color: AppConstants()
                                                                    .ltMainRed,
                                                                fontSize:
                                                                    12.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 20.w,
                          ),
                          child: SvgPicture.asset(
                            height: 32.h,
                            width: 32.w,
                            'assets/icons/three-point-icon.svg',
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeaderWidget(
                          profilePictureUrl:
                              snapshot.data!.data!.users!.profilePicture!,
                          coverPictureUrl: snapshot.data!.data!.users!.banner!,
                          isMyProfile: false,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 12.w,
                          ),
                          child: Text(
                            "${snapshot.data!.data!.users!.name!} ${snapshot.data!.data!.users!.surname!}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Sfbold',
                              color: AppConstants().ltLogoGrey,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        12.h.spaceY,
                        UserVehicleInfosWidget(
                          vehicleType:
                              snapshot.data!.data!.carInformations == null
                                  ? "Araç bilgisi bulunamadı"
                                  : snapshot.data!.data!.carInformations != {}
                                      ? snapshot.data!.data!.carInformations!
                                          .cartypetousercartypes!.carType!
                                      : "Mevcut değil",
                          vehicleBrand:
                              snapshot.data!.data!.carInformations == null
                                  ? "Araç bilgisi bulunamadı"
                                  : snapshot.data!.data!.carInformations != {}
                                      ? snapshot.data!.data!.carInformations!
                                          .carBrand!
                                      : "Mevcut değil",
                          vehicleModel:
                              snapshot.data!.data!.carInformations == null
                                  ? "Araç bilgisi bulunamadı"
                                  : snapshot.data!.data!.carInformations != {}
                                      ? snapshot.data!.data!.carInformations!
                                          .carModel!
                                      : "Mevcut değil",
                        ),
                        16.h.spaceY,
                        FollowersCountRowWidget(
                          followersCount:
                              snapshot.data!.data!.followerCount.toString(),
                          followedCount:
                              snapshot.data!.data!.followingCount.toString(),
                          routesCount:
                              snapshot.data!.data!.routeCount.toString(),
                          onTapFollowers: () {},
                          onTapFollowed: () {},
                          onTapRoutes: () {},
                        ),
                        24.h.spaceY,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 14.w,
                              ),
                              child: Obx(() => CustomButtonDesign(
                                    text: isFollowed.value == false
                                        ? 'Takip Et'
                                        : 'Takip Ediliyor',
                                    textColor: AppConstants().ltWhite,
                                    color: isFollowed.value == false
                                        ? AppConstants().ltMainRed
                                        : AppConstants().ltDarkGrey,
                                    width: 168.w,
                                    height: 50.h,
                                    onpressed: () {
                                      GeneralServicesTemp().makePostRequest2(
                                          EndPoint.followUser +
                                              "${otherProfileRequest.userID}",
                                          {
                                            "Content-type": "application/json",
                                            'Authorization':
                                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                          }).then((value) {
                                        var response =
                                            FollowUserResponse.fromJson(
                                                jsonDecode(value!));
                                        if (response.message ==
                                            "User followed") {
                                          SocketService.instance().socket.emit(
                                              'notification',
                                              NotificationModel(
                                                sender: LocaleManager.instance
                                                    .getInt(PreferencesKeys
                                                        .currentUserId),
                                                receiver:
                                                    otherProfileRequest.userID,
                                                type: 1,
                                                params: [
                                                  otherProfileRequest.userID!
                                                ],
                                                message: NotificaitonMessage(
                                                    text: NotificationText(
                                                      content:
                                                          "adlı kullanıcı seni takip etmeye başladı",
                                                      name: LocaleManager
                                                          .instance
                                                          .getString(PreferencesKeys
                                                              .currentUserUserName),
                                                      surname: "" ?? "",
                                                      username: LocaleManager
                                                              .instance
                                                              .getString(
                                                                  PreferencesKeys
                                                                      .currentUserUserName) ??
                                                          "",
                                                    ),
                                                    link: "" //,
                                                    ),
                                              ));
                                          isFollowed.value = true;
                                        } else {
                                          isFollowed.value = false;
                                        }
                                      });
                                    },
                                    iconPath: '',
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 14.w,
                              ),
                              child: CustomButtonDesign(
                                text: 'Mesaj Gönder',
                                textColor: AppConstants().ltWhite,
                                color: AppConstants().ltMainRed,
                                width: 168.w,
                                height: 50.h,
                                onpressed: () async {
                                  await GeneralServicesTemp().makePostRequest(
                                    '/chats/new',
                                    ChatRequestModel(
                                        member: snapshot.data!.data!.users!.id),
                                    {
                                      'Authorization':
                                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                      'Content-Type': 'application/json',
                                    },
                                  ).then((value) async {
                                    await GeneralServicesTemp().makeGetRequest(
                                      "/chats/list",
                                      {
                                        'Authorization':
                                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                        'Content-Type': 'application/json',
                                      },
                                    ).then((value2) async {
                                      if (value2 != null) {
                                        final response =
                                            ChatResponseModel.fromJson(
                                                json.decode(value2));
                                        if (response.success == 1) {
                                          List<Chat> chatList =
                                              response.data![0].chats!;
                                          final int? currentUserId =
                                              LocaleManager.instance.getInt(
                                                  PreferencesKeys
                                                      .currentUserId);

                                          for (var chat in chatList) {
                                            for (var chatUserItem
                                                in chat.chatusers!) {
                                              if (chatUserItem.chatuser!.id !=
                                                  currentUserId) {
                                                log("Burada");

                                                if (chatUserItem.chatuser!.id ==
                                                    snapshot.data!.data!.users!
                                                        .id) {
                                                  chatController.receiverUser =
                                                      await SenderClass(
                                                    id: chatUserItem
                                                        .chatuser!.id,
                                                    name: chatUserItem
                                                        .chatuser!.name,
                                                    surname: chatUserItem
                                                        .chatuser!.surname,
                                                  );

                                                  SocketService.instance()
                                                      .socket
                                                      .emit("add-chat-user", {
                                                    "chatId": chat.id,
                                                    "userId": currentUserId,
                                                  });

                                                  chatController.chatId =
                                                      chat.id!;
                                                  Get.toNamed(
                                                      '/chatDetailsView');
                                                } else {}
                                              }
                                            }
                                          }
                                        }
                                      }
                                    });

                                    log(value!);
                                  });
                                  Get.toNamed('/chatDetailsView');
                                },
                                iconPath: '',
                              ),
                            ),
                          ],
                        ),
                        10.h.spaceY,
                        Padding(
                          padding: EdgeInsets.only(
                            left: 14.w,
                            right: 10.w,
                          ),
                          child: CustomButtonDesign(
                            text: 'Selektör Yap',
                            textColor: AppConstants().ltWhite,
                            color: AppConstants().ltDarkGrey,
                            width: 348.w,
                            height: 50.h,
                            onpressed: () {
                              SocketService.instance().socket.emit(
                                  'notification',
                                  NotificationModel(
                                    sender: LocaleManager.instance
                                        .getInt(PreferencesKeys.currentUserId),
                                    receiver: snapshot.data!.data!.users!.id,
                                    type: 99,
                                    params: [],
                                    message: NotificaitonMessage(
                                        text: NotificationText(
                                          content:
                                              " adlı kullanıcı selektör yaptı",
                                          name: LocaleManager.instance
                                              .getString(PreferencesKeys
                                                  .currentUserName),
                                          surname: "" ?? "",
                                          username: LocaleManager.instance
                                                  .getString(PreferencesKeys
                                                      .currentUserUserName) ??
                                              "",
                                        ),
                                        link: "" //,
                                        ),
                                  ));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    ShowAllertDialogWidget(
                                  button1Color: AppConstants().ltMainRed,
                                  button1Height: 50.h,
                                  button1IconPath: '',
                                  button1Text: 'Tamam',
                                  button1TextColor: AppConstants().ltWhite,
                                  button1Width: Get.width,
                                  buttonCount: 1,
                                  discription1:
                                      "${snapshot.data!.data!.users!.name!}'e selektör yapıldı ",
                                  onPressed1: () {
                                    Get.back();
                                  },
                                  title: 'Selektör Yapıldı',
                                ),
                              );
                            },
                            iconPath: '',
                          ),
                        ),
                        32.h.spaceY,
                        snapshot.data!.data!.posts!.result!.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero, //This deletes spaces.
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    snapshot.data!.data!.posts!.result!.length,
                                itemBuilder: (context, index) {
                                  return PostFlowWidget(
                                    deletePost: false,
                                    didILiked: snapshot.data!.data!.posts!
                                            .result![index].didILiked ??
                                        0,
                                    postId: snapshot.data!.data!.posts!
                                        .result![index].post!.id!,
                                    onlyPost: true,
                                    centerImageUrl: snapshot.data!.data!.posts!
                                        .result![index].post!.media!,
                                    subtitle: snapshot.data!.data!.posts!
                                        .result![index].post!.text!,
                                    name:
                                        "${snapshot.data!.data!.users!.name!} ${snapshot.data!.data!.users!.surname!}",
                                    userId: snapshot.data!.data!.users!.id!,
                                    userProfilePhoto: snapshot
                                        .data!.data!.users!.profilePicture!,
                                    locationName:
                                        "${snapshot.data!.data!.posts!.result![index].post!.postroute == null ? "" : snapshot.data!.data!.posts!.result![index].post!.postroute!.startingCity} ${snapshot.data!.data!.posts!.result![index].post!.postroute == null ? "" : snapshot.data!.data!.posts!.result![index].post!.postroute!.endingCity}",
                                    beforeHours: "",
                                    commentCount: snapshot.data!.data!.posts!
                                        .result![index].commentNum
                                        .toString(),
                                    firstCommentName: "Furkan Semiz",
                                    firstCommentTitle:
                                        "Akşam 8 de yola çıkacağım",
                                    firstLikeName: "Furkan Semiz",
                                    firstLikeUrl: "",
                                    othersLikeCount: (snapshot.data!.data!
                                            .posts!.result![index].likedNum!)
                                        .toString(),
                                    secondLikeUrl:
                                        "snapshot.data!.data[index].secondLikeUrl",
                                    thirdLikeUrl:
                                        "snapshot.data!.data[index].thirdLikeUrl",
                                    haveTag: true,
                                    usersTagged: snapshot.data!.data!.posts!
                                        .result![index].post!.postpostlabels,
                                    haveEmotion: true,
                                    emotion: snapshot
                                            .data!
                                            .data!
                                            .posts!
                                            .result![index]
                                            .post!
                                            .postemojis!
                                            .isNotEmpty
                                        ? snapshot
                                            .data!
                                            .data!
                                            .posts!
                                            .result![index]
                                            .post!
                                            .postemojis![0]
                                            .emojis!
                                            .emoji!
                                        : "",
                                    emotionContent: snapshot
                                            .data!
                                            .data!
                                            .posts!
                                            .result![index]
                                            .post!
                                            .postemojis!
                                            .isNotEmpty
                                        ? snapshot
                                            .data!
                                            .data!
                                            .posts!
                                            .result![index]
                                            .post!
                                            .postemojis![0]
                                            .emojis!
                                            .name!
                                        : "",
                                    likedStatus: 1,
                                    //TODO: ROUTE ID LAZIM
                                    selectedRouteId: snapshot.data!.data!.posts!
                                        .result![index].post!.id,
                                    selectedRouteUserId: snapshot.data!.data!
                                        .posts!.result![index].post!.id,
                                  );
                                },
                              )
                            : const Center(
                                child: Text("Gönderi bulunamadı"),
                              ),
                      ],
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: UiHelper.loadingAnimationWidget(context),
                  ),
                );
              }
            });
      },
    );
  }
}
