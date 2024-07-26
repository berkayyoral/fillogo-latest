//import 'dart:math';
import 'dart:convert';
import 'dart:developer';
import 'package:fillogo/controllers/likecontroller.dart';
import 'package:fillogo/controllers/search/search_user_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/models/post/get_home_post.dart';
import 'package:fillogo/models/post/post_like_response.dart';
import 'package:fillogo/models/search/user/search_user_response.dart';
import 'package:fillogo/models/stories/user_stories.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/widgets/post_video_player_widget.dart';

import '../../../controllers/bottom_navigation_bar_controller.dart';
import '../../../widgets/popup_post_details.dart';
import '../../../widgets/profilePhoto.dart';
import '../../map_page_view/components/map_page_controller.dart';
import '../../route_details_page_view/components/selected_route_controller.dart';
import '../../route_details_page_view/components/start_end_adress_controller.dart';

// ignore: must_be_immutable
class PostFlowWidget extends StatefulWidget {
  PostFlowWidget(
      {Key? key,
      required this.onlyPost,
      required this.centerImageUrl,
      required this.subtitle,
      required this.name,
      required this.userId,
      required this.userProfilePhoto,
      required this.locationName,
      required this.beforeHours,
      required this.commentCount,
      required this.firstCommentName,
      required this.firstCommentTitle,
      required this.firstLikeName,
      required this.firstLikeUrl,
      required this.othersLikeCount,
      required this.secondLikeUrl,
      required this.thirdLikeUrl,
      required this.haveTag,
      this.usersTagged,
      required this.haveEmotion,
      required this.emotion,
      required this.emotionContent,
      required this.likedStatus,
      required this.postId,
      required this.didILiked,
      required this.selectedRouteId,
      required this.selectedRouteUserId,
      required this.deletePost,
      this.deletePostOnTap})
      : super(key: key);

  final bool onlyPost;
  final String centerImageUrl;
  final String subtitle;
  final String name;
  final int userId;
  final int postId;
  final int didILiked;
  final String userProfilePhoto;
  final String locationName;
  final String beforeHours;
  final String commentCount;
  final String firstCommentName;
  final String firstCommentTitle;
  final String firstLikeName;
  final String firstLikeUrl;
  String othersLikeCount;
  final String secondLikeUrl;
  final String thirdLikeUrl;
  final bool haveTag;
  final List<Postpostlabel>? usersTagged;
  final bool haveEmotion;
  final String? emotion;
  final String? emotionContent;
  final int likedStatus;
  final int? selectedRouteId;
  final int? selectedRouteUserId;
  bool deletePost;
  Function()? deletePostOnTap;

  @override
  State<PostFlowWidget> createState() => _PostFlowWidgetState();
}

class _PostFlowWidgetState extends State<PostFlowWidget> {
  StartEndAdressController startEndAdressController =
      Get.find<StartEndAdressController>();

  UserStateController userStateController = Get.find();

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  LikeCountController likeCountController = Get.put(LikeCountController());

  SearchUserController searchUserController = Get.put(SearchUserController());

  TextEditingController searchTextController = TextEditingController();

  String? currentUserName =
      LocaleManager.instance.getString(PreferencesKeys.currentUserUserName);

  // MapPageController mapPageController = Get.find<MapPageController>();

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  @override
  Widget build(BuildContext context) {
    likeCountController.lastLikeCount =
        int.parse(widget.othersLikeCount.obs.toString()).obs;
    var likeControll = false.obs;

    if (widget.didILiked == 1) {
      likeControll = true.obs;
    }
    var likeCount = widget.othersLikeCount.obs;
    var lastLikeCount = int.parse(widget.othersLikeCount).obs;

    return Column(children: [
      FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 8.w,
                    bottom: 10.h,
                  ),
                  child: GestureDetector(
                    // onTap: () async {
                    //   UserStoriesResponse? response =
                    //       await GeneralServicesTemp().makeGetRequest(
                    //           "/stories/user-stories/$userId?page=${1}", {
                    //     "Content-type": "application/json",
                    //     'Authorization':
                    //         'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                    //   }).then((value) {
                    //     if (value != null) {
                    //       return UserStoriesResponse.fromJson(
                    //           json.decode(value));
                    //     }
                    //     return null;
                    //   });
                    //   if (response == null) {
                    //     return;
                    //   }
                    //   if (response.success == 1) {
                    //     return Get.toNamed('/storyPageView', arguments: userId);
                    //   }
                    //   // Get.toNamed('/storyPageView');
                    //   if (mapPageController.myUserId.value != userId) {
                    //     Get.toNamed(NavigationConstants.otherprofiles,
                    //         arguments: userId);
                    //   } else {
                    //     //   //Get.back();
                    //     bottomNavigationBarController.selectedIndex.value = 3;
                    //   }
                    // },
                    child: ProfilePhoto(
                      onTap: () {
                        if (LocaleManager.instance
                                .getInt(PreferencesKeys.currentUserId)
                                .toString() ==
                            widget.userId.toString()) {
                          Get.back();
                          bottomNavigationBarController.selectedIndex.value = 3;
                        } else {
                          Get.toNamed('/otherprofiles',
                              arguments: widget.userId);
                        }
                      },
                      height: 40.h,
                      width: 40.w,
                      url: widget.userProfilePhoto,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmotionAndTagStringCreate(
                      userId: widget.userId,
                      emotion: widget.emotion,
                      name: widget.name,
                      usersTagged: widget.usersTagged!,
                      emotionContent: widget.emotionContent,
                      haveTag: widget.haveTag,
                      haveEmotion: widget.haveEmotion,
                    ),
                    Visibility(
                      visible: !widget.onlyPost,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/route-icon.svg',
                            height: 20.w,
                            color: AppConstants().ltMainRed,
                          ),
                          5.w.spaceX,
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.locationName,
                                  style: TextStyle(
                                    fontFamily: "Sfmedium",
                                    fontSize: 16.sp,
                                    color: AppConstants().ltDarkGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    3.h.spaceY,
                  ],
                ),
              ],
            ),
            IconButton(
              padding: EdgeInsets.only(right: 0.w),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  context: context,
                  builder: (builder) {
                    return PopupPostDetails(
                      deletePostOnTap: widget.deletePostOnTap,
                      deletePost: widget.deletePost,
                    );
                  },
                );
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ],
        ),
      ),
      10.h.spaceY,
      SizedBox(
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.subtitle,
                  style: TextStyle(
                    fontFamily: "Sfregular",
                    fontSize: 14.sp,
                    color: AppConstants().ltLogoGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      10.h.spaceY,
      Visibility(
        visible: widget.centerImageUrl.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 300.h,
            ),
            child: widget.centerImageUrl.contains('.mp4')
                ? PostVideoPlayerWidget(path: widget.centerImageUrl)
                : Image.network(
                    widget.centerImageUrl,
                    width: Get.width,
                    fit: BoxFit.fitWidth,
                  ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.w, right: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Obx(
                    () => IconButton(
                      icon: likeControll.value == true
                          ? SvgPicture.asset(
                              'assets/icons/like-icon.svg',
                              height: 20.h,
                              color: AppConstants().ltMainRed,
                            )
                          : SvgPicture.asset(
                              "assets/icons/heart.svg",
                              color: AppConstants().ltDarkGrey,
                              height: 20.h,
                            ),
                      onPressed: () {
                        likeControll.value = !likeControll.value;
                        GeneralServicesTemp().makePostRequest2(
                          '/posts/like-post/${widget.postId}',
                          {
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                            'Content-Type': 'application/json',
                          },
                        ).then((value) async {
                          if (value != null) {
                            ++lastLikeCount.value;
                            final response =
                                PostLikeResponse.fromJson(jsonDecode(value));
                            if (response.data![0].removed == true) {
                              likeCountController.lastLikeCount =
                                  likeCountController.lastLikeCount + 1;

                              SocketService.instance().socket.emit(
                                  'notification',
                                  NotificationModel(
                                    sender: LocaleManager.instance
                                        .getInt(PreferencesKeys.currentUserId),
                                    receiver: widget.userId,
                                    type: 4,
                                    params: [widget.postId],
                                    message: NotificaitonMessage(
                                        text: NotificationText(
                                          content:
                                              "adlı kullanıcı gönderini beğendi",
                                          name: LocaleManager.instance
                                              .getString(PreferencesKeys
                                                  .currentUserUserName),
                                          surname: "",
                                          username: currentUserName ?? "",
                                        ),
                                        link: widget.centerImageUrl),
                                  ));
                            } else if (!likeControll.value) {
                              print("kankaaaaa else girdi");
                              --lastLikeCount.value;
                              --lastLikeCount.value;
                              likeCountController.lastLikeCount =
                                  likeCountController.lastLikeCount - 1;
                            }
                          }
                        });
                      },
                    ),
                  ),
                  8.w.spaceX,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NavigationConstants.comments,
                          arguments: [widget.postId]);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/comment-icon.svg',
                      height: 20.h,
                      color: AppConstants().ltLogoGrey,
                    ),
                  ),
                  15.w.spaceX,
                  Visibility(
                    visible: false,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheetForShareIcon(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/message-icon.svg',
                        height: 20.w,
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.selectedRouteId == 0
                ? SizedBox()
                : Visibility(
                    visible: !widget.onlyPost,
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          selectedRouteController.selectedRouteId.value =
                              widget.selectedRouteId!;
                          selectedRouteController.selectedRouteUserId.value =
                              widget.selectedRouteUserId!;
                          Get.toNamed(NavigationConstants.routeDetails);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/route-icon.svg',
                              height: 27.h,
                              color: AppConstants().ltMainRed,
                            ),
                            5.w.spaceX,
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Rotayı Göster',
                                    style: TextStyle(
                                      fontFamily: "Sfregular",
                                      fontSize: 13.sp,
                                      color: AppConstants().ltBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            GetBuilder<UserStateController>(
              id: 'like',
              builder: (controller) {
                likeControll.value;

                return Obx(
                  () => RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: ""),
                        TextSpan(
                          text: lastLikeCount.value.toString(),
                          style: TextStyle(
                              fontFamily: "Sfmedium",
                              fontSize: 14.sp,
                              color: AppConstants().ltLogoGrey),
                        ),
                        TextSpan(
                          text: ' kişi ',
                          style: TextStyle(
                              fontFamily: "Sfmedium",
                              fontSize: 14.sp,
                              color: AppConstants().ltLogoGrey),
                        ),
                        TextSpan(
                          text: 'beğendi!',
                          style: TextStyle(
                              fontFamily: "Sflight",
                              fontSize: 14.sp,
                              color: AppConstants().ltLogoGrey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      // SizedBox(
      //   width: Get.width,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(
      //       horizontal: 16.w,
      //       vertical: 4.h,
      //     ),
      //     child: RichText(
      //       textAlign: TextAlign.left,
      //       text: TextSpan(
      //         children: [
      //           TextSpan(
      //             text: firstCommentName,
      //             style: TextStyle(
      //                 fontFamily: "Sfmedium",
      //                 fontSize: 14.sp,
      //                 color: AppConstants().ltLogoGrey),
      //           ),
      //           TextSpan(
      //             text: firstCommentTitle,
      //             style: TextStyle(
      //                 fontFamily: "Sflight",
      //                 fontSize: 14.sp,
      //                 color: AppConstants().ltLogoGrey),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      GestureDetector(
        onTap: () {
          Get.toNamed(NavigationConstants.comments, arguments: [widget.postId]);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: Row(
            children: [
              Text(
                widget.commentCount,
                style: TextStyle(
                    fontFamily: "Sfmedium",
                    fontSize: 14.sp,
                    color: AppConstants().ltLogoGrey),
              ),
              Text(
                ' yorumun tümünü gör.',
                style: TextStyle(
                    fontFamily: "Sfmedium",
                    fontSize: 14.sp,
                    color: AppConstants().ltLogoGrey),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Text(
              widget.beforeHours,
              style: TextStyle(
                fontFamily: "Sflight",
                fontSize: 14.sp,
                color: AppConstants().ltDarkGrey,
              ),
            ),
          ],
        ),
      ),
      14.h.spaceY,
      Divider(
        height: 2.h,
        color: AppConstants().ltLogoGrey,
      ),
      14.h.spaceY,
    ]);
  }

  showModalBottomSheetForShareIcon(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      context: context,
      builder: (builder) {
        RxList<int> bottomSheetIndex = <int>[].obs;
        RxList<int> bottomSheetID = <int>[].obs;
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            margin: const EdgeInsets.all(12),
            width: Get.width,
            height: Get.height * 0.65,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Divider(
                          indent: 150,
                          endIndent: 150,
                          height: 2.5,
                          thickness: 2.5,
                          color: AppConstants().ltBlack),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                        child: Container(
                          width: 330.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: AppConstants().ltWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8.r,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppConstants().ltLogoGrey.withOpacity(
                                      0.2.r,
                                    ),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(0.w, 0.w),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 320.w,
                                height: 50.h,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: searchTextController,
                                  onChanged: (value) {
                                    searchUserController.searchRequestText =
                                        searchTextController.text;

                                    searchUserController
                                            .searchUserRequest.text =
                                        searchUserController.searchRequestText;
                                    searchUserController.update(['search']);

                                    GeneralServicesTemp().makePostRequest(
                                      '/users/search-user',
                                      searchUserController.searchUserRequest,
                                      {
                                        "Content-type": "application/json",
                                        'Authorization':
                                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                      },
                                    ).then(
                                      (value) => SearchUserResponse.fromJson(
                                        json.decode(value!),
                                      ),
                                    );
                                  },
                                  autofocus: false,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  cursorColor: AppConstants().ltMainRed,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Sfregular',
                                    color: AppConstants().ltLogoGrey,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.r),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'Kullanıcı ara',
                                    hintStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: 'Sflight',
                                      color: AppConstants().ltDarkGrey,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.search_rounded,
                                        color: AppConstants().ltMainRed,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      10.h.spaceY,
                      GetBuilder<SearchUserController>(
                        id: 'search',
                        builder: (GetxController controller) {
                          return FutureBuilder<SearchUserResponse?>(
                              future: GeneralServicesTemp().makePostRequest(
                                '/users/search-user',
                                searchUserController.searchUserRequest,
                                {
                                  'Authorization':
                                      'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                  'Content-Type': 'application/json',
                                },
                              ).then(
                                (value) => SearchUserResponse.fromJson(
                                  json.decode(value!),
                                ),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.data!.isEmpty) {
                                    return Center(
                                      child: UiHelper.notFoundAnimationWidget(
                                          context, 'Kullanıcı bulunamadı...'),
                                    );
                                  }
                                  return Column(
                                    children: List.generate(
                                      snapshot.data!.data![0].searchResult!
                                          .result!.length,
                                      (index) {
                                        return ListTile(
                                          leading: ProfilePhoto(
                                            height: 48.w,
                                            width: 48.w,
                                            url: snapshot
                                                .data!
                                                .data![0]
                                                .searchResult!
                                                .result![index]
                                                .profilePicture,
                                          ),
                                          title: Text(
                                            "${snapshot.data!.data![0].searchResult!.result![index].name!} ${snapshot.data!.data![0].searchResult!.result![index].surname!}",
                                            style: TextStyle(
                                              fontFamily: 'Sfsemibold',
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          subtitle: Text(
                                            snapshot
                                                .data!
                                                .data![0]
                                                .searchResult!
                                                .result![index]
                                                .username!,
                                            style: TextStyle(
                                              fontFamily: 'Sfsemibold',
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          trailing: InkWell(
                                            onTap: () {
                                              bottomSheetIndex.add(index);
                                              bottomSheetID.add(snapshot
                                                  .data!
                                                  .data![0]
                                                  .searchResult!
                                                  .result![index]
                                                  .id!);
                                              print(bottomSheetID.toString());
                                            },
                                            child: Obx(() => Container(
                                                  width: 80.w,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: bottomSheetIndex
                                                            .contains(index)
                                                        ? AppConstants()
                                                            .ltDarkGrey
                                                        : AppConstants()
                                                            .ltMainRed,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    bottomSheetIndex
                                                            .contains(index)
                                                        ? 'Gönderildi'
                                                        : 'Gönder',
                                                    style: TextStyle(
                                                      fontFamily: 'Sfbold',
                                                      fontSize: 10.sp,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                                )),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });
                        },
                      ),
                    ],
                  ),
                ),
                /*Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  right: 10.w,
                  child: Obx(
                    () {
                      return bottomSheetIndex.isNotEmpty
                          ? RedButton(
                              text: 'Bitti',
                              onpressed: () {
                                print(bottomSheetID.toString());
                                for (var i = 0;
                                    i < bottomSheetIndex.length;
                                    i++) {
                                  sendMessageOnPressed(bottomSheetID[i]);
                                }
                              },
                            )
                          : const SizedBox();
                    },
                  ),
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}

/*sendMessageOnPressed(dynamic userId) async {
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
        print(currentChat.id!);
        print("Anlamadım id 0 sa noluyo");
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
            log("Bir hata oluştu : + bcc ${response2.message} ");
          }
        });
      }
    },
  );
}

goToChat(Chat currentChat) {
  ChatController chatController = Get.put(ChatController());

  int currentUserId =
      LocaleManager.instance.getInt(PreferencesKeys.currentUserId)!;
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
        currentChat.messages![0].senderId == chatController.receiverUser.id)) {
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
}*/

class EmotionAndTagStringCreate extends StatelessWidget {
  EmotionAndTagStringCreate({
    super.key,
    required this.name,
    required this.usersTagged,
    required this.emotion,
    required this.emotionContent,
    required this.haveTag,
    required this.haveEmotion,
    required this.userId,
  });
  final String name;
  final int userId;
  final List<Postpostlabel>? usersTagged;
  final String? emotion;
  final String? emotionContent;
  final bool haveTag;
  final bool haveEmotion;

  // MapPageController mapPageController = Get.find<MapPageController>();
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268.w,
      child: Wrap(
        runSpacing: 2.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              log(userId.toString());

              if (LocaleManager.instance
                      .getInt(PreferencesKeys.currentUserId) !=
                  userId) {
                Get.toNamed(NavigationConstants.otherprofiles,
                    arguments: userId);
              } else {
                //Get.back();
                bottomNavigationBarController.selectedIndex.value = 3;
              }
            },
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$name   ",
                    style: TextStyle(
                        fontFamily: "Sfbold",
                        fontSize: 16.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: haveTag,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: haveTag
                        ? usersTagged!.isNotEmpty
                            ? usersTagged![0].userpostlabels!.name
                            : ""
                        : "",
                    style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 13.sp,
                      color: AppConstants().ltLogoGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged!.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ve",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged!.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " diğer",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged!.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ${(usersTagged!.length - 1).toString()}",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged!.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " kişi",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: haveTag,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ile",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: haveTag,
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " birlikte  ",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: haveEmotion,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10.r,
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(emotion ?? ""),
                  ),
                  color: AppConstants().ltMainRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Visibility(
            visible: haveEmotion,
            child: Text(
              "  $emotionContent",
              style: TextStyle(
                fontFamily: "Sflight",
                fontSize: 13.sp,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
          Visibility(
            visible: haveEmotion,
            child: Text(
              " hissediyor",
              style: TextStyle(
                fontFamily: "Sflight",
                fontSize: 13.sp,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
