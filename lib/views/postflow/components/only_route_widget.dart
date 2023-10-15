import 'dart:convert';

import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/models/post/get_home_post.dart';
import 'package:fillogo/models/post/post_like_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/route_view_widget_new_post.dart';
import 'package:fillogo/views/like_list_view/components/like_controller.dart';
import '../../../controllers/bottom_navigation_bar_controller.dart';
import '../../../export.dart';
import '../../../widgets/popup_post_details.dart';
import '../../../widgets/profilePhoto.dart';
import '../../map_page_view/components/map_page_controller.dart';
import '../../route_details_page_view/components/selected_route_controller.dart';
import '../../route_details_page_view/components/start_end_adress_controller.dart';

// ignore: must_be_immutable
class OnlyRouteWidget extends StatelessWidget {
  OnlyRouteWidget(
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
      this.routeContent,
      this.routeStartDate,
      this.routeEndDate,
      required this.likedStatus,
      required this.postId,
      required this.didILiked,
      required this.onTap,
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
  final String? routeContent;
  final String? routeStartDate;
  final String? routeEndDate;
  final int likedStatus;
  final Function() onTap;
  final int selectedRouteId;
  final int selectedRouteUserId;
  bool deletePost;
  Function()? deletePostOnTap;

  StartEndAdressController startEndAdressController =
      Get.find<StartEndAdressController>();
  UserStateController userStateController = Get.find();

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  MapPageController mapPageController = Get.find<MapPageController>();

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();
  LikeController likeController = Get.find();
  @override
  Widget build(BuildContext context) {
    var likeControll = didILiked == 1 ? 1.obs : 0.obs;

    var likeCount = othersLikeCount.obs;

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
                    onTap: () {
                      if (mapPageController.myUserId.value != userId) {
                        Get.toNamed(NavigationConstants.otherprofiles,
                            arguments: userId);
                      } else {
                        //Get.back();
                        bottomNavigationBarController.selectedIndex.value = 3;
                      }
                    },
                    child: ProfilePhoto(
                      height: 40.h,
                      width: 40.w,
                      url: userProfilePhoto,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmotionAndTagStringCreate(
                      emotion: emotion,
                      name: name,
                      usersTagged: usersTagged!,
                      emotionContent: emotionContent,
                      haveTag: haveTag,
                      haveEmotion: haveEmotion,
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
                      deletePostOnTap: deletePostOnTap,
                      deletePost: deletePost,
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
      GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: RouteViewWidgetNewPostPage(
              closeButtonVisible: false,
              userName: name,
              routeContent: routeContent!,
              routeStartDate: routeStartDate!,
              routeEndDate: routeEndDate!,
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
                      icon: likeControll == 1
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
                      onPressed: () async {
                        await GeneralServicesTemp().makePostRequest2(
                          '/posts/like-post/$postId',
                          {
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                            'Content-Type': 'application/json',
                          },
                        ).then((value) {
                          if (value != null) {
                            final response =
                                PostLikeResponse.fromJson(jsonDecode(value));
                            likeControll.value =
                                response.data![0].removed == true ? 1 : 0;
                            likeCount.value =
                                response.data![0].likeCount.toString();
                            userStateController.update(['like']);
                          }
                        });
                      },
                    ),
                  ),
                  8.w.spaceX,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NavigationConstants.comments,
                          arguments: postId);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/comment-icon.svg',
                      height: 20.h,
                      color: AppConstants().ltLogoGrey,
                    ),
                  ),
                  15.w.spaceX,
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheetForShareIcon(context);
                    },
                    child: SvgPicture.asset(
                      'assets/icons/message-icon.svg',
                      height: 20.w,
                      color: AppConstants().ltLogoGrey,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: false,
              child: SizedBox(
                child: GestureDetector(
                  onTap: () {
                    selectedRouteController.selectedRouteId.value = 1;
                    selectedRouteController.selectedRouteUserId.value = 1;
                    Get.toNamed(NavigationConstants.routeDetails);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/route-icon.svg',
                        height: 15.h,
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
                                fontSize: 12.sp,
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
                return InkWell(
                  onTap: () {
                    likeController.likeListPostId.value = postId;
                    Get.toNamed(NavigationConstants.likeListView);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: ""),
                        TextSpan(
                          text: likeCount.value,
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
      GetBuilder<UserStateController>(
          id: 'comment',
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(NavigationConstants.comments, arguments: postId);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  children: [
                    Text(
                      commentCount,
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
            );
          }),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Text(
              beforeHours,
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
                                  //controller: searchTextController,
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
                      Column(
                        children: List.generate(
                          10,
                          (index) {
                            return ListTile(
                              leading: ProfilePhoto(
                                height: 48.w,
                                width: 48.w,
                                url: 'https://picsum.photos/150',
                              ),
                              title: Text(
                                'Sadık Pehlivan',
                                style: TextStyle(
                                  fontFamily: 'Sfsemibold',
                                  fontSize: 12.sp,
                                ),
                              ),
                              subtitle: Text(
                                'sadkpehlvn',
                                style: TextStyle(
                                  fontFamily: 'Sfsemibold',
                                  fontSize: 12.sp,
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  bottomSheetIndex.add(index);
                                },
                                child: Obx(() => Container(
                                      width: 80.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: bottomSheetIndex.contains(index)
                                            ? AppConstants().ltDarkGrey
                                            : AppConstants().ltMainRed,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Center(
                                          child: Text(
                                        bottomSheetIndex.contains(index)
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
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  right: 10.w,
                  child: Obx(
                    () {
                      return bottomSheetIndex.isNotEmpty
                          ? RedButton(
                              text: 'Bitti',
                              onpressed: () {
                                Get.back();
                              },
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EmotionAndTagStringCreate extends StatelessWidget {
  const EmotionAndTagStringCreate({
    super.key,
    required this.name,
    required this.usersTagged,
    required this.emotion,
    required this.emotionContent,
    required this.haveTag,
    required this.haveEmotion,
  });
  final String name;
  final List<Postpostlabel>? usersTagged;
  final String? emotion;
  final String? emotionContent;
  final bool haveTag;
  final bool haveEmotion;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268.w,
      child: Wrap(
        runSpacing: 2.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          RichText(
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
