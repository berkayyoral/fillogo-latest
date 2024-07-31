import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/comment/comment_create/comment_create_request.dart';
import 'package:fillogo/models/comment/comment_create/comment_create_response.dart';
import 'package:fillogo/models/comment/get_comment_response.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/models/post/post_detail_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class CommentsView extends StatefulWidget {
  const CommentsView({Key? key}) : super(key: key);

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  GeneralDrawerController drawerControl = Get.find();
  UserStateController userStateController = Get.find();
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  final PostService postService = PostService();

  TextEditingController commentTextController = TextEditingController();

  var postId = Get.arguments[0];

  var nowComment = "".obs;

  var userId = 0.obs;
  String? currentUserName =
      LocaleManager.instance.getString(PreferencesKeys.currentUserUserName);

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
        title: Text(
          "Yorumlar",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      drawer: NavigationDrawerWidget(),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GetBuilder<UserStateController>(
                  id: 'comment',
                  builder: (controller) {
                    return FutureBuilder<PostDetailResponse?>(
                      future: GeneralServicesTemp()
                          .makeGetRequest("/posts/get-post/$postId", {
                        "Content-type": "application/json",
                        'Authorization':
                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                      }).then((value) {
                        if (value != null) {
                          return PostDetailResponse.fromJson(
                              json.decode(value));
                        }
                        return null;
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.data!.isEmpty) {
                            return const Text("Bir hata oluştu");
                          } else {
                            userId.value =
                                snapshot.data!.data![0].post!.user!.id!;
                            print(
                                "asdasdasdas ${snapshot.data!.data![0].post!.postroute?.id}");
                            return Column(
                              children: [
                                PostFlowWidget(
                                  deletePost: false,
                                  didILiked:
                                      snapshot.data!.data![0].didILiked ?? 0,
                                  postId: snapshot.data!.data![0].post!.id!,
                                  onlyPost: false,
                                  centerImageUrl:
                                      snapshot.data!.data![0].post!.media!,
                                  subtitle: snapshot.data!.data![0].post!.text!,
                                  name:
                                      "${snapshot.data!.data![0].post!.user!.name!} ${snapshot.data!.data![0].post!.user!.surname!}",
                                  userId:
                                      snapshot.data!.data![0].post!.user!.id!,
                                  userProfilePhoto: snapshot.data!.data![0]
                                      .post!.user!.profilePicture!,
                                  locationName: snapshot
                                              .data!.data![0].post!.postroute !=
                                          null
                                      ? "${snapshot.data!.data![0].post!.postroute!.startingCity} - ${snapshot.data!.data![0].post!.postroute!.endingCity}"
                                      : "",
                                  beforeHours: timeago.format(
                                      DateTime.parse(snapshot
                                          .data!.data![0].post!.createdAt
                                          .toString()),
                                      locale: "tr"),
                                  commentCount: snapshot
                                      .data!.data![0].commentedNum
                                      .toString(),
                                  firstCommentName: "",
                                  firstCommentTitle: "",
                                  firstLikeName: "",
                                  firstLikeUrl: "",
                                  othersLikeCount:
                                      snapshot.data!.data![0].likedNum == null
                                          ? "null"
                                          : snapshot.data!.data![0].likedNum
                                              .toString(),
                                  secondLikeUrl: "",
                                  thirdLikeUrl: "",
                                  haveTag: snapshot.data!.data![0].post!
                                      .postpostlabels!.isNotEmpty,
                                  usersTagged: snapshot
                                      .data!.data![0].post!.postpostlabels!,
                                  haveEmotion: snapshot.data!.data![0].post!
                                      .postemojis!.isNotEmpty,
                                  emotion: snapshot.data!.data![0].post!
                                          .postemojis!.isNotEmpty
                                      ? snapshot.data!.data![0].post!
                                          .postemojis![0].emojis!.emoji
                                      : "",
                                  emotionContent: snapshot.data!.data![0].post!
                                          .postemojis!.isNotEmpty
                                      ? snapshot.data!.data![0].post!
                                          .postemojis![0].emojis!.name
                                      : "",
                                  likedStatus: 1,
                                  selectedRouteId: snapshot
                                          .data!.data![0].post!.postroute?.id ??
                                      0,
                                  selectedRouteUserId:
                                      snapshot.data!.data![0].post!.user!.id,
                                ),
                                GetBuilder<GeneralDrawerController>(
                                  id: 'deneme',
                                  builder: (controller) {
                                    return FutureBuilder<GetCommentsResponse?>(
                                      future: GeneralServicesTemp()
                                          .makeGetRequest(
                                              "/posts/get-comments/$postId", {
                                        "Content-type": "application/json",
                                        'Authorization':
                                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                      }).then((value) {
                                        if (value != null) {
                                          return GetCommentsResponse.fromJson(
                                              json.decode(value));
                                        }
                                        return null;
                                      }),
                                      builder: (context, snapshot2) {
                                        if (snapshot2.hasData) {
                                          return snapshot2.data!.data!.isEmpty
                                              ? const Text("Bir hata oluştu")
                                              : ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot2
                                                      .data!
                                                      .data![0]
                                                      .comments!
                                                      .result!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var comment = snapshot2
                                                        .data!
                                                        .data![0]
                                                        .comments!
                                                        .result![index];
                                                    return OtherComments(
                                                      onTap: () {
                                                        if (comment
                                                                .commentedposts!
                                                                .id ==
                                                            LocaleManager
                                                                .instance
                                                                .getInt(PreferencesKeys
                                                                    .currentUserId)) {
                                                          Get.back();
                                                          bottomNavigationBarController
                                                              .selectedIndex
                                                              .value = 3;
                                                        } else {
                                                          Get.toNamed(
                                                              NavigationConstants
                                                                  .otherprofiles,
                                                              arguments: comment
                                                                  .commentedposts!
                                                                  .id);
                                                        }
                                                      },
                                                      url: comment
                                                          .commentedposts!
                                                          .profilePicture!,
                                                      name:
                                                          "${comment.commentedposts!.name} ${comment.commentedposts!.surname}",
                                                      content: comment.comment!,
                                                      beforeHours:
                                                          timeago.format(
                                                        comment.createdAt!,
                                                        locale: "tr",
                                                      ),
                                                      likeCount:
                                                          comment.likedCount!,
                                                      didILiked:
                                                          comment.isLikedByMe!,
                                                    );
                                                  },
                                                );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                                const DummyBox15(),
                              ],
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
              child: SizedBox(
                height: 50.h,
                width: 342.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.r,
                        ),
                      ),
                      height: 50.h,
                      width: 341.w,
                      child: Material(
                        borderRadius: BorderRadius.circular(8.r),
                        elevation: 5,
                        child: Center(
                          child: TextField(
                            controller: commentTextController,
                            textAlignVertical: TextAlignVertical.center,
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
                              contentPadding: EdgeInsets.only(
                                left: 0.w,
                                right: 0.w,
                              ),
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Yorum yap',
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Sflight',
                                color: AppConstants().ltDarkGrey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                child: ProfilePhoto(
                                  height: 12.h,
                                  width: 12.w,
                                  url: LocaleManager.instance.getString(
                                          PreferencesKeys
                                              .currentUserProfilPhoto) ??
                                      'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png',
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: GestureDetector(
                                  onTap: () {
                                    nowComment.value =
                                        commentTextController.text;
                                    GeneralServicesTemp().makePostRequest(
                                      '/posts/comment-post/$postId',
                                      CommentCreateRequest(
                                        comment: commentTextController.text,
                                        labels: [],
                                      ),
                                      {
                                        'Authorization':
                                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                        'Content-Type': 'application/json',
                                      },
                                    ).then((value2) {
                                      final response2 =
                                          CommentCreateResponse.fromJson(
                                              json.decode(value2!));

                                      if (response2.success == 1) {
                                        log("Yorumunuz başarıyla paylaşıldı");
                                        SocketService.instance().socket.emit(
                                            'notification',
                                            NotificationModel(
                                              sender: LocaleManager.instance
                                                  .getInt(PreferencesKeys
                                                      .currentUserId),
                                              receiver: userId.value,
                                              type: 3,
                                              params: [postId],
                                              message: NotificaitonMessage(
                                                  text: NotificationText(
                                                    content:
                                                        "adlı kullanıcı gönderine yorum yaptı.",
                                                    name: LocaleManager.instance
                                                        .getString(PreferencesKeys
                                                            .currentUserUserName),
                                                    surname: "" ?? "",
                                                    username:
                                                        currentUserName ?? "",
                                                  ),
                                                  link: "" //,
                                                  ),
                                            ));
                                        userStateController.update(['comment']);

                                        setState(() {});
                                      } else {
                                        log("Bir hata oluştu : + abcc ${response2.message} ");
                                      }
                                    });
                                    log("het");
                                    commentTextController.text = '';
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/message-icon.svg',
                                    height: 16.h,
                                    width: 16.w,
                                    color: AppConstants().ltMainRed,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
