import 'dart:convert';

import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/home_controller/home_controller.dart';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/post/delete_post.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/postflow/components/new_post_create_button.dart';
import 'package:fillogo/views/postflow/components/only_route_widget.dart';
import 'package:fillogo/views/postflow/components/story_flow_widget.dart';
import 'package:fillogo/views/route_details_page_view/components/selected_route_controller.dart';
import 'package:fillogo/views/testFolder/test19/route_api_services.dart';
import 'package:fillogo/widgets/share_post_progressbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../route_calculate_view/components/create_route_controller.dart';

class PostFlowView extends StatelessWidget {
  PostFlowView({super.key});

  final PostService postService = PostService();

  final GeneralDrawerController postFlowDrawerController =
      Get.find<GeneralDrawerController>();

  GetPollylineRequest getPollylineRequest = GetPollylineRequest();

  CreateeRouteController createRouteController = Get.find();
  CreatePostPageController createPostPageController = Get.find();

  DateFormat inputFormat = DateFormat('dd.MM.yyyy');

  VehicleInfoController vehicleInfoController =
      Get.put(VehicleInfoController());

  final HomeController homeContoller = Get.put(HomeController());

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  NotificationController notificationController =
      Get.put(NotificationController());
  StoriesController storiesController = Get.put(StoriesController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        homeContoller.currentPage.value = 1;
        homeContoller.scrollOffset.value = 600;
        homeContoller.snapshotList.clear();
        homeContoller.fillList(1);
        storiesController.isLoading.value = true;
        storiesController.getMyStory();
        print(
            "SROTOEOY STORİCONTROLLER 1-> ${storiesController.isLoading.value}");
      },
      child: SingleChildScrollView(
        controller: homeContoller.scrollController,
        child: Column(
          children: [
            NewPostCreateButtonView(),
            // Obx(() => storiesController.isLoading.value
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : StoryFlowWiew()),
            StoryFlowWiew(),
            Divider(
              color: AppConstants().ltLogoGrey,
              height: 2.h,
            ),
            10.h.spaceY,
            Obx(() {
              return postFlowDrawerController.isLoading
                  ? const SharePostProgressBarWidget(
                      widget: Text(""),
                    )
                  : const SizedBox();
            }),
            Obx(
              () {
                return homeContoller.isLoading.value
                    ? const CircularProgressIndicator()
                    : GetBuilder<HomeController>(
                        id: 'comment',
                        builder: (controller) {
                          return GetBuilder<UserStateController>(
                            id: 'like',
                            builder: (controller) {
                              if (homeContoller.snapshotList.value.isNotEmpty) {
                                return Obx(() => ListView.separated(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        homeContoller.snapshotList.value.length,
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        if ((homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .media!
                                                .isNotEmpty ||
                                            homeContoller.snapshotList
                                                    .value[index]!.post!.text !=
                                                "default text")) {
                                          return Obx(() {
                                            print(
                                                "PWV POSTFLOW 2 video -> ${jsonEncode(homeContoller.snapshotList.value[0]!.post)}");
                                            return homeContoller.isDeletePostLoading.value &&
                                                    homeContoller
                                                            .snapshotList
                                                            .value[index]!
                                                            .post!
                                                            .user!
                                                            .id! ==
                                                        LocaleManager.instance
                                                            .getInt(PreferencesKeys
                                                                .currentUserId)
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : PostFlowWidget(
                                                    deletePost: LocaleManager.instance.getInt(PreferencesKeys.currentUserId) == homeContoller.snapshotList.value[index]!.post!.user!.id!
                                                        ? true
                                                        : false,
                                                    didILiked: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .didILiked!,
                                                    postId: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .post!
                                                        .id!,
                                                    onlyPost: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .onlyPost!,
                                                    centerImageUrl: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .post!
                                                        .media!,
                                                    deletePostOnTap: () async {
                                                      homeContoller
                                                          .isDeletePostLoading
                                                          .value = true;
                                                      await GeneralServicesTemp()
                                                          .makeDeleteWithoutBody(
                                                        EndPoint.deletePost +
                                                            homeContoller
                                                                .snapshotList
                                                                .value[index]!
                                                                .post!
                                                                .id!
                                                                .toString(),
                                                        {
                                                          'Authorization':
                                                              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                          'Content-Type':
                                                              'application/json',
                                                        },
                                                      ).then((value) {
                                                        var response =
                                                            DeletePostResponse
                                                                .fromJson(
                                                                    json.decode(
                                                                        value!));
                                                        if (response.success ==
                                                            1) {
                                                          // homeContoller
                                                          //     .snapshotList
                                                          //     .value
                                                          //     .removeAt(
                                                          //         index);

                                                          homeContoller
                                                                  .snapshotList
                                                                  .value =
                                                              List.from(
                                                                  homeContoller
                                                                      .snapshotList
                                                                      .value)
                                                                ..removeAt(
                                                                    index);

                                                          // homeContoller
                                                          //     .fillList(
                                                          //         1);
                                                          homeContoller
                                                              .update();

                                                          Get.back();
                                                          UiHelper.showSuccessSnackBar(
                                                              context,
                                                              "Başarıyla Gönderiniz Silindi");
                                                          print(
                                                              "GÖNDERİMİ SİLDİM HOMEPOST ${homeContoller.snapshotList.value.length}");
                                                        } else {
                                                          Get.back();
                                                          UiHelper.showWarningSnackBar(
                                                              context,
                                                              "Bir hata ile karşılaşıldı Lütfen Tekrar Deneyiniz.");
                                                        }
                                                      });
                                                      homeContoller
                                                          .isDeletePostLoading
                                                          .value = false;
                                                    },
                                                    subtitle: homeContoller.snapshotList.value[index]!.post!.text == "default text" ? "" : homeContoller.snapshotList.value[index]!.post!.text!,
                                                    name: "${homeContoller.snapshotList.value[index]!.post!.user!.name!} ${homeContoller.snapshotList.value[index]!.post!.user!.surname!}",
                                                    userId: homeContoller.snapshotList.value[index]!.post!.user!.id!,
                                                    userProfilePhoto: homeContoller.snapshotList.value[index]!.post!.user!.profilePicture!,
                                                    locationName: homeContoller.snapshotList.value[index]!.post!.postroute != null ? "${homeContoller.snapshotList.value[index]!.post!.postroute!.startingCity} - ${homeContoller.snapshotList[index]!.post!.postroute!.endingCity!}" : "",
                                                    beforeHours: timeago.format(DateTime.parse(homeContoller.snapshotList.value[index]!.post!.createdAt!.toString()), locale: "tr").tr,
                                                    commentCount: homeContoller.snapshotList.value[index]!.commentNum!.toString(),
                                                    firstCommentName: "",
                                                    firstCommentTitle: "",
                                                    firstLikeName: "",
                                                    firstLikeUrl: "",
                                                    othersLikeCount: homeContoller.snapshotList.value[index]!.likedNum!.toString(),
                                                    secondLikeUrl: "",
                                                    thirdLikeUrl: "",
                                                    haveTag: homeContoller.snapshotList.value[index]!.post!.postpostlabels!.isNotEmpty,
                                                    usersTagged: homeContoller.snapshotList.value[index]!.post!.postpostlabels!,
                                                    haveEmotion: homeContoller.snapshotList.value[index]!.post!.postemojis!.isNotEmpty,
                                                    emotion: homeContoller.snapshotList.value[index]!.post!.postemojis!.isNotEmpty ? homeContoller.snapshotList[index]!.post!.postemojis![0].emojis!.emoji! : "",
                                                    emotionContent: homeContoller.snapshotList.value[index]!.post!.postemojis!.isNotEmpty ? homeContoller.snapshotList[index]!.post!.postemojis![0].emojis!.name! : "",
                                                    likedStatus: homeContoller.snapshotList.value[index]!.didILiked!,
                                                    selectedRouteId: homeContoller.snapshotList.value[index]!.post!.routeId,
                                                    selectedRouteUserId: homeContoller.snapshotList.value[index]!.post!.user!.id);
                                          });
                                        } else {
                                          return OnlyRouteWidget(
                                            deletePost: false,
                                            onTap: () {
                                              selectedRouteController
                                                      .selectedRouteId.value =
                                                  homeContoller
                                                      .snapshotList
                                                      .value[index]!
                                                      .post!
                                                      .routeId!;
                                              selectedRouteController
                                                      .selectedRouteUserId
                                                      .value =
                                                  homeContoller
                                                      .snapshotList
                                                      .value[index]!
                                                      .post!
                                                      .user!
                                                      .id!;
                                              Get.toNamed(NavigationConstants
                                                  .routeDetails);
                                            },
                                            didILiked: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .didILiked!,
                                            routeContent: "",
                                            // "${homeContoller.snapshotList[index]!.post!.postroute!.startingCity!} -> ${homeContoller.snapshotList[index]!.post!.postroute!.endingCity!}",
                                            routeStartDate: "",
                                            //  inputFormat
                                            //     .format(DateTime.parse(
                                            //         homeContoller
                                            //             .snapshotList[index]!
                                            //             .post!
                                            //             .postroute!
                                            //             .departureDate!
                                            //             .toString()))
                                            //     .toString(),
                                            routeEndDate: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .post!
                                                        .postroute !=
                                                    null
                                                ? inputFormat
                                                    .format(DateTime.parse(
                                                        homeContoller
                                                            .snapshotList
                                                            .value[index]!
                                                            .post!
                                                            .postroute!
                                                            .arrivalDate!
                                                            .toString()))
                                                    .toString()
                                                : null,
                                            postId: homeContoller.snapshotList
                                                .value[index]!.post!.id!,
                                            onlyPost: homeContoller.snapshotList
                                                .value[index]!.onlyPost!,
                                            centerImageUrl: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .media!,
                                            subtitle: homeContoller.snapshotList
                                                .value[index]!.post!.text!,
                                            name:
                                                "${homeContoller.snapshotList.value[index]!.post!.user!.name!} ${homeContoller.snapshotList.value[index]!.post!.user!.surname!}",
                                            userId: homeContoller.snapshotList
                                                .value[index]!.post!.user!.id!,
                                            userProfilePhoto: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .user!
                                                .profilePicture!,
                                            locationName: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .post!
                                                        .postroute !=
                                                    null
                                                ? "${homeContoller.snapshotList.value[index]!.post!.postroute!.startingCity} - ${homeContoller.snapshotList[index]!.post!.postroute!.endingCity!}"
                                                : "",
                                            beforeHours: timeago.format(
                                                DateTime.parse(homeContoller
                                                    .snapshotList
                                                    .value[index]!
                                                    .post!
                                                    .createdAt!
                                                    .toString()),
                                                locale: "tr"),
                                            commentCount: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .commentNum!
                                                .toString(),
                                            firstCommentName: "",
                                            firstCommentTitle: "",
                                            firstLikeName: "",
                                            firstLikeUrl: "",
                                            othersLikeCount: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .likedNum!
                                                .toString(),
                                            secondLikeUrl: "",
                                            thirdLikeUrl: "",
                                            haveTag: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .postpostlabels!
                                                .isNotEmpty,
                                            usersTagged: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .postpostlabels!,
                                            haveEmotion: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .postemojis!
                                                .isNotEmpty,
                                            emotion: homeContoller
                                                    .snapshotList
                                                    .value[index]!
                                                    .post!
                                                    .postemojis!
                                                    .isNotEmpty
                                                ? homeContoller
                                                    .snapshotList
                                                    .value[index]!
                                                    .post!
                                                    .postemojis![0]
                                                    .emojis!
                                                    .emoji!
                                                : "",
                                            emotionContent: homeContoller
                                                    .snapshotList
                                                    .value[index]!
                                                    .post!
                                                    .postemojis!
                                                    .isNotEmpty
                                                ? homeContoller
                                                    .snapshotList
                                                    .value[index]!
                                                    .post!
                                                    .postemojis![0]
                                                    .emojis!
                                                    .name!
                                                : "",
                                            likedStatus: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .didILiked!,
                                            selectedRouteId: homeContoller
                                                        .snapshotList
                                                        .value[index]!
                                                        .post!
                                                        .postroute !=
                                                    null
                                                ? homeContoller
                                                    .snapshotList
                                                    .value[index]!
                                                    .post!
                                                    .postroute!
                                                    .id!
                                                : 1,
                                            selectedRouteUserId: homeContoller
                                                .snapshotList
                                                .value[index]!
                                                .post!
                                                .user!
                                                .id!,
                                          );
                                        }
                                      });
                                    },
                                    separatorBuilder: (context, index) {
                                      if (((index) % 5 == 0)) {
                                        return const SizedBox(); //const AdMobWidget();
                                      } else {
                                        return const SizedBox();
                                      }
                                    }));
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
