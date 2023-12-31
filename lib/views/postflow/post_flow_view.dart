import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/home_controller/home_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/postflow/components/new_post_create_button.dart';
import 'package:fillogo/views/postflow/components/only_route_widget.dart';
import 'package:fillogo/views/postflow/components/story_flow_widget.dart';
import 'package:fillogo/views/route_details_page_view/components/selected_route_controller.dart';
import 'package:fillogo/views/testFolder/test19/route_api_services.dart';
import 'package:fillogo/widgets/admob.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:fillogo/widgets/share_post_progressbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../route_calculate_view/components/create_route_controller.dart';

class PostFlowView extends StatelessWidget {
  PostFlowView({Key? key}) : super(key: key);

  final PostService postService = PostService();
  GeneralDrawerController postFlowDrawerController =
      Get.find<GeneralDrawerController>();

  GetPollylineRequest getPollylineRequest = GetPollylineRequest();

  CreateRouteController createRouteController = Get.find();

  DateFormat inputFormat = DateFormat('dd.MM.yyyy');

  final HomeController homeContoller = Get.put(HomeController());

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: postFlowDrawerController.postFlowPageScaffoldKey,
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            postFlowDrawerController.openPostFlowScaffoldDrawer();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 5.h,
            ),
            child: SvgPicture.asset(
              height: 25.h,
              width: 25.w,
              'assets/icons/open-drawer-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Image.asset(
          'assets/logo/logo-1.png',
          height: 45,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(NavigationConstants.notifications);
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 5.w,
              ),
              child: SvgPicture.asset(
                height: 25.h,
                width: 25.w,
                'assets/icons/notification-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.toNamed(NavigationConstants.message);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 20.w,
              ),
              child: SvgPicture.asset(
                'assets/icons/message-icon.svg',
                height: 25.h,
                width: 25.w,
                color: const Color(0xff3E3E3E),
              ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: GetBuilder<HomeController>(
          id: "homePage",
          builder: (controllerHome) {
            return RefreshIndicator(
                onRefresh: () async {
                  homeContoller.currentPage.value = 1;
                  homeContoller.scrollOffset.value = 600;
                  homeContoller.snapshotList.clear();
                  homeContoller.fillList(1);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      NewPostCreateButtonView(),
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
                      GetBuilder<UserStateController>(
                        id: 'comment',
                        builder: (controller) {
                          return GetBuilder<UserStateController>(
                            id: 'like',
                            builder: (controller) {
                              if (homeContoller.snapshotList.isNotEmpty) {
                                return Obx(() => ListView.separated(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        homeContoller.snapshotList.length,
                                    itemBuilder: (context, index) {
                                      return (homeContoller.snapshotList[index]!.post!.media!.isNotEmpty ||
                                              homeContoller.snapshotList[index]!.post!.text !=
                                                  "default text")
                                          ? PostFlowWidget(
                                              deletePost: false,
                                              didILiked: homeContoller
                                                  .snapshotList[index]!
                                                  .didILiked!,
                                              postId: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .id!,
                                              onlyPost: homeContoller
                                                  .snapshotList[index]!
                                                  .onlyPost!,
                                              centerImageUrl: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .media!,
                                              subtitle: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .text!,
                                              name:
                                                  "${homeContoller.snapshotList[index]!.post!.user!.name!} ${homeContoller.snapshotList[index]!.post!.user!.surname!}",
                                              userId: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .user!
                                                  .id!,
                                              userProfilePhoto: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .user!
                                                  .profilePicture!,
                                              locationName: homeContoller.snapshotList[index]!.post!.postroute != null
                                                  ? "${homeContoller.snapshotList[index]!.post!.postroute!.startingCity} - ${homeContoller.snapshotList[index]!.post!.postroute!.endingCity!}"
                                                  : "",
                                              beforeHours:
                                                  timeago.format(DateTime.parse(homeContoller.snapshotList[index]!.post!.createdAt!.toString()),
                                                      locale: "tr"),
                                              commentCount: homeContoller
                                                  .snapshotList[index]!
                                                  .commentNum!
                                                  .toString(),
                                              firstCommentName: "",
                                              firstCommentTitle: "",
                                              firstLikeName: "",
                                              firstLikeUrl: "",
                                              othersLikeCount: homeContoller
                                                  .snapshotList[index]!
                                                  .likedNum!
                                                  .toString(),
                                              secondLikeUrl: "",
                                              thirdLikeUrl: "",
                                              haveTag: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .postpostlabels!
                                                  .isNotEmpty,
                                              usersTagged: homeContoller.snapshotList[index]!.post!.postpostlabels!,
                                              haveEmotion: homeContoller.snapshotList[index]!.post!.postemojis!.isNotEmpty,
                                              emotion: homeContoller.snapshotList[index]!.post!.postemojis!.isNotEmpty ? homeContoller.snapshotList[index]!.post!.postemojis![0].emojis!.emoji! : "",
                                              emotionContent: homeContoller.snapshotList[index]!.post!.postemojis!.isNotEmpty ? homeContoller.snapshotList[index]!.post!.postemojis![0].emojis!.name! : "",
                                              likedStatus: homeContoller.snapshotList[index]!.didILiked!,
                                              selectedRouteId: homeContoller.snapshotList[index]!.post!.routeId,
                                              selectedRouteUserId: homeContoller.snapshotList[index]!.post!.user!.id)
                                          : OnlyRouteWidget(
                                              deletePost: false,
                                              onTap: () {
                                                selectedRouteController
                                                        .selectedRouteId.value =
                                                    homeContoller
                                                        .snapshotList[index]!
                                                        .post!
                                                        .routeId!;
                                                selectedRouteController
                                                        .selectedRouteUserId
                                                        .value =
                                                    homeContoller
                                                        .snapshotList[index]!
                                                        .post!
                                                        .user!
                                                        .id!;
                                                Get.toNamed(NavigationConstants
                                                    .routeDetails);
                                              },
                                              didILiked: homeContoller
                                                  .snapshotList[index]!
                                                  .didILiked!,
                                              routeContent:
                                                  "${homeContoller.snapshotList[index]!.post!.postroute!.startingCity!} -> ${homeContoller.snapshotList[index]!.post!.postroute!.endingCity!}",
                                              routeStartDate: inputFormat
                                                  .format(DateTime.parse(
                                                      homeContoller
                                                          .snapshotList[index]!
                                                          .post!
                                                          .postroute!
                                                          .departureDate!
                                                          .toString()))
                                                  .toString(),
                                              routeEndDate: inputFormat
                                                  .format(DateTime.parse(
                                                      homeContoller
                                                          .snapshotList[index]!
                                                          .post!
                                                          .postroute!
                                                          .arrivalDate!
                                                          .toString()))
                                                  .toString(),
                                              postId: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .id!,
                                              onlyPost: homeContoller
                                                  .snapshotList[index]!
                                                  .onlyPost!,
                                              centerImageUrl: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .media!,
                                              subtitle: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .text!,
                                              name:
                                                  "${homeContoller.snapshotList[index]!.post!.user!.name!} ${homeContoller.snapshotList[index]!.post!.user!.surname!}",
                                              userId: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .user!
                                                  .id!,
                                              userProfilePhoto: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .user!
                                                  .profilePicture!,
                                              locationName: homeContoller
                                                          .snapshotList[index]!
                                                          .post!
                                                          .postroute !=
                                                      null
                                                  ? "${homeContoller.snapshotList[index]!.post!.postroute!.startingCity} - ${homeContoller.snapshotList[index]!.post!.postroute!.endingCity!}"
                                                  : "",
                                              beforeHours: timeago.format(
                                                  DateTime.parse(homeContoller
                                                      .snapshotList[index]!
                                                      .post!
                                                      .createdAt!
                                                      .toString()),
                                                  locale: "tr"),
                                              commentCount: homeContoller
                                                  .snapshotList[index]!
                                                  .commentNum!
                                                  .toString(),
                                              firstCommentName: "",
                                              firstCommentTitle: "",
                                              firstLikeName: "",
                                              firstLikeUrl: "",
                                              othersLikeCount: homeContoller
                                                  .snapshotList[index]!
                                                  .likedNum!
                                                  .toString(),
                                              secondLikeUrl: "",
                                              thirdLikeUrl: "",
                                              haveTag: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .postpostlabels!
                                                  .isNotEmpty,
                                              usersTagged: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .postpostlabels!,
                                              haveEmotion: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .postemojis!
                                                  .isNotEmpty,
                                              emotion: homeContoller
                                                      .snapshotList[index]!
                                                      .post!
                                                      .postemojis!
                                                      .isNotEmpty
                                                  ? homeContoller
                                                      .snapshotList[index]!
                                                      .post!
                                                      .postemojis![0]
                                                      .emojis!
                                                      .emoji!
                                                  : "",
                                              emotionContent: homeContoller
                                                      .snapshotList[index]!
                                                      .post!
                                                      .postemojis!
                                                      .isNotEmpty
                                                  ? homeContoller
                                                      .snapshotList[index]!
                                                      .post!
                                                      .postemojis![0]
                                                      .emojis!
                                                      .name!
                                                  : "",
                                              likedStatus: homeContoller
                                                  .snapshotList[index]!
                                                  .didILiked!,
                                              selectedRouteId: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .postroute!
                                                  .id!,
                                              selectedRouteUserId: homeContoller
                                                  .snapshotList[index]!
                                                  .post!
                                                  .user!
                                                  .id!,
                                            );
                                    },
                                    separatorBuilder: (context, index) {
                                      if (((index) % 5 == 0)) {
                                        return const AdMobWidget();
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
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
