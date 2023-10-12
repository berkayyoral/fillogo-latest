import 'dart:convert';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/future_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/post/delete_post.dart';
import 'package:fillogo/models/user/profile/user_profile.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/views/postflow/components/only_route_widget.dart';
import 'package:fillogo/views/route_details_page_view/components/selected_route_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:fillogo/widgets/listtile_widget.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:fillogo/widgets/user_vehicle_infos_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:fillogo/widgets/followers_count_row_widget.dart';
import 'package:fillogo/widgets/profile_header_widget.dart';

import '../../controllers/map/get_current_location_and_listen.dart';
import '../map_page_view/components/map_page_controller.dart';
import 'components/edit_banner_photo.dart';
import 'components/edit_profile_photo_widget.dart';

class MyProfilView extends StatefulWidget {
  MyProfilView({Key? key}) : super(key: key);

  @override
  State<MyProfilView> createState() => _MyProfilViewState();
}

class _MyProfilViewState extends State<MyProfilView> {
  //final PostService postService = PostService();
  final GeneralDrawerController myProfilePageDrawerController =
      Get.find<GeneralDrawerController>();

  final BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  MapPageController mapPageController = Get.find<MapPageController>();

  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  ConnectionsController connectionsController = Get.find();

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FutureController>(
        id: PageIDs.myProfile,
        builder: (context) {
          return GetBuilder<UserStateController>(
            id: 'like',
            builder: (controller) {
              return FutureBuilder<UserGetMyProfileResponse?>(
                  future: GeneralServicesTemp()
                      .makeGetRequest("/users/my-profile?page=1", {
                    "Content-type": "application/json",
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  }).then((value) {
                    if (value != null) {
                      return UserGetMyProfileResponse.fromJson(
                          json.decode(value));
                    }
                    return null;
                  }),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      mapPageController.myNameAndSurname.value =
                          "${snapshot.data!.data!.users!.name!} ${snapshot.data!.data!.users!.surname!}";
                      mapPageController.myUserId.value =
                          snapshot.data!.data!.users!.id!;
                      return Scaffold(
                        key: myProfilePageDrawerController
                            .myProfilePageScaffoldKey,
                        appBar: AppBarGenel(
                          leading: GestureDetector(
                            onTap: () {
                              myProfilePageDrawerController
                                  .openMyProfilePageScaffoldDrawer();
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
                                Get.toNamed('/settings');
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 20.w,
                                ),
                                child: SvgPicture.asset(
                                  height: 32.h,
                                  width: 32.w,
                                  'assets/icons/settings.svg',
                                  color: AppConstants().ltLogoGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        drawer: NavigationDrawerWidget(),
                        body: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileHeaderWidget(
                                profilePictureUrl:
                                    snapshot.data!.data!.users!.profilePicture!,
                                coverPictureUrl:
                                    snapshot.data!.data!.users!.banner!,
                                isMyProfile: true,
                                onTapEditProfilePicture: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        EditProfilePhoto(),
                                  );
                                },
                                onTapEditCoverPicture: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        EditBannerPhoto(),
                                  );
                                },
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
                              snapshot.hasData
                                  ? snapshot
                                          .data!.data!.carInformations.isBlank!
                                      ? const UserVehicleInfosWidget(
                                          vehicleType: "",
                                          vehicleBrand: "",
                                          vehicleModel: "",
                                        )
                                      : UserVehicleInfosWidget(
                                          vehicleType: snapshot
                                              .data!
                                              .data!
                                              .carInformations!
                                              .cartypetousercartypes!
                                              .carType!,
                                          vehicleBrand: snapshot.data!.data!
                                              .carInformations!.carBrand!,
                                          vehicleModel: snapshot.data!.data!
                                              .carInformations!.carModel!,
                                        )
                                  : const SizedBox(),
                              SizedBox(
                                height: 16.h,
                              ),
                              FollowersCountRowWidget(
                                followersCount: snapshot
                                    .data!.data!.followerCount
                                    .toString(),
                                followedCount: snapshot
                                    .data!.data!.followingCount
                                    .toString(),
                                routesCount:
                                    snapshot.data!.data!.routeCount.toString(),
                                onTapFollowers: () {
                                  connectionsController.user =
                                      snapshot.data!.data!.users!;
                                  connectionsController.followerCount =
                                      snapshot.data!.data!.followerCount!;
                                  connectionsController.followingCount =
                                      snapshot.data!.data!.followingCount!;
                                  connectionsController.routeCount =
                                      snapshot.data!.data!.routeCount!;
                                  Get.toNamed(
                                      NavigationConstants.connectionView);
                                },
                                onTapFollowed: () {
                                  connectionsController.user =
                                      snapshot.data!.data!.users!;
                                  connectionsController.followerCount =
                                      snapshot.data!.data!.followerCount!;
                                  connectionsController.followingCount =
                                      snapshot.data!.data!.followingCount!;
                                  connectionsController.routeCount =
                                      snapshot.data!.data!.routeCount!;
                                  Get.toNamed(
                                      NavigationConstants.connectionView);
                                },
                                onTapRoutes: () {
                                  connectionsController.user =
                                      snapshot.data!.data!.users!;
                                  connectionsController.followerCount =
                                      snapshot.data!.data!.followerCount!;
                                  connectionsController.followingCount =
                                      snapshot.data!.data!.followingCount!;
                                  connectionsController.routeCount =
                                      snapshot.data!.data!.routeCount!;
                                  Get.toNamed(
                                      NavigationConstants.connectionView);
                                },
                              ),
                              24.h.spaceY,
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 14.w,
                                      right: 10.w,
                                    ),
                                    child: CustomButtonDesign(
                                      text: 'Profili Düzenle',
                                      textColor: AppConstants().ltWhite,
                                      color: AppConstants().ltDarkGrey,
                                      width: 287.w,
                                      height: 50.h,
                                      onpressed: () {
                                        //Get.toNamed(NavigationConstants.profileSettings);
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
                                            return SizedBox(
                                              height: Get.height / 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                    height: 32,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            NavigationConstants
                                                                .profileSettings);
                                                      },
                                                      child:
                                                          const ListTileWidget(
                                                        iconPath:
                                                            'assets/icons/profil-icon.svg',
                                                        title:
                                                            "Profil Ayarları",
                                                        subTitle:
                                                            "Kişisel bilgilerinizi güncelleyin",
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          NavigationConstants
                                                              .vehicleSettings);
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 8),
                                                      child: ListTileWidget(
                                                        iconPath:
                                                            'assets/icons/truck.svg',
                                                        title:
                                                            "Araç Bilgilerini Düzenle",
                                                        subTitle:
                                                            "Kayıtlı aracınızın bilgilerini düzenleyin",
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed('/settings');
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16,
                                                              vertical: 8),
                                                      child: ListTileWidget(
                                                        iconPath:
                                                            'assets/icons/settings.svg',
                                                        title: "Genel Ayarlar",
                                                        subTitle:
                                                            "Genel ayarlarınızı düzenleyin",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      iconPath: '',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 14.w,
                                    ),
                                    child: CustomButtonDesign(
                                      text: '...',
                                      textColor: AppConstants().ltWhite,
                                      color: AppConstants().ltDarkGrey,
                                      width: 50.w,
                                      height: 50.h,
                                      onpressed: () {},
                                      iconPath: '',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                ),
                                child: CustomButtonDesign(
                                  text: 'Yeni Rota Oluştur',
                                  textColor: AppConstants().ltWhite,
                                  color: AppConstants().ltMainRed,
                                  width: 348.w,
                                  height: 50.h,
                                  onpressed: () {
                                    bottomNavigationBarController
                                        .selectedIndex.value = 1;
                                    mapPageController.selectedDispley.value = 0;
                                    mapPageController
                                        .iWantTrackerMyLocation.value = 2;
                                    mapPageController.changeCalculateLevel(2);
                                    mapPageController
                                        .addMarkerFunctionForMapPageWithoutOnTap2(
                                      MarkerId("myLocationMarker"),
                                      LatLng(
                                        getMyCurrentLocationController
                                            .myLocationLatitudeDo.value,
                                        getMyCurrentLocationController
                                            .myLocationLongitudeDo.value,
                                      ),
                                      "${mapPageController.mapPageRouteStartAddress2.value}",
                                      BitmapDescriptor.fromBytes(
                                          mapPageController
                                              .customMarkerIconController
                                              .mayLocationIcon!),
                                    );
                                  },
                                  iconPath: 'assets/icons/plus-add-icon.svg',
                                ),
                              ),
                              10.h.spaceY,
                              SizedBox(
                                height: 32.h,
                              ),
                              snapshot.data!.data!.posts!.result!.isNotEmpty
                                  ? ListView.builder(
                                      padding: EdgeInsets
                                          .zero, //This deletes spaces.
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot
                                          .data!.data!.posts!.result!.length,
                                      itemBuilder: (context, index) {
                                        return (snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .media!
                                                    .isNotEmpty ||
                                                snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .text! !=
                                                    "default text")
                                            ? PostFlowWidget(
                                                deletePostOnTap: () {
                                                  GeneralServicesTemp()
                                                      .makeDeleteWithoutBody(
                                                    EndPoint.deletePost +
                                                        snapshot
                                                            .data!
                                                            .data!
                                                            .posts!
                                                            .result![index]
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
                                                    if (response.success == 1) {

                                                      Get.back();
                                                      UiHelper.showSuccessSnackBar(
                                                          context,
                                                          "Başarıyla Gönderiniz Silindi");
                                                      mapPageController
                                                          .selectedDispley
                                                          .value = 0;
                                                      mapPageController
                                                          .selectedDispley(0);

                                                      mapPageController.markers2
                                                          .clear();
                                                      mapPageController
                                                          .polylineCoordinates
                                                          .clear();
                                                      mapPageController
                                                          .polylineCoordinates2
                                                          .clear();
                                                      mapPageController
                                                          .polylineCoordinatesListForB
                                                          .clear();
                                                      mapPageController
                                                          .polylines
                                                          .clear();
                                                      mapPageController
                                                          .polylines2
                                                          .clear();
                                                      setState(() {
                                                        
                                                      });
                                                    } else {
                                                      Get.back();
                                                      UiHelper.showWarningSnackBar(
                                                          context,
                                                          "Bir hata ile karşılaşıldı Lütfen Tekrar Deneyiniz.");
                                                      print(response.success);
                                                      print(response.message);
                                                    }
                                                  });
                                                },
                                                deletePost: true,
                                                didILiked: snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .didILiked ??
                                                    0,
                                                postId: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .id!,
                                                onlyPost: snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .postroute ==
                                                    null,
                                                centerImageUrl: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .media!,
                                                subtitle: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .text!,
                                                name:
                                                    "${snapshot.data!.data!.users!.name!} ${snapshot.data!.data!.users!.surname!}",
                                                userId: snapshot
                                                    .data!.data!.users!.id!,
                                                userProfilePhoto: snapshot
                                                    .data!
                                                    .data!
                                                    .users!
                                                    .profilePicture!,
                                                locationName: snapshot
                                                            .data!
                                                            .data!
                                                            .posts!
                                                            .result![index]
                                                            .post!
                                                            .postroute !=
                                                        null
                                                    ? "${snapshot.data!.data!.posts!.result![index].post!.postroute!.startingCity} - ${snapshot.data!.data!.posts!.result![index].post!.postroute!.endingCity}"
                                                    : "",
                                                beforeHours: timeago.format(
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .createdAt!,
                                                    locale: "tr"),
                                                commentCount: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .commentNum
                                                    .toString(),
                                                firstCommentName:
                                                    "Furkan Semiz",
                                                firstCommentTitle:
                                                    "Akşam 8 de yola çıkacağım",
                                                firstLikeName: "Furkan Semiz",
                                                firstLikeUrl: "",
                                                othersLikeCount: (snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .likedNum!)
                                                    .toString(),
                                                secondLikeUrl:
                                                    "snapshot.data!.data[index].secondLikeUrl",
                                                thirdLikeUrl:
                                                    "snapshot.data!.data[index].thirdLikeUrl",
                                                haveTag: true,
                                                usersTagged: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .postpostlabels,
                                                haveEmotion: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .postemojis!
                                                    .isNotEmpty,
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
                                                        .emoji
                                                    : null,
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
                                                        .name
                                                    : null,
                                                likedStatus: 1,
                                                selectedRouteId: !snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .postroute
                                                        .isNull
                                                    ? snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .postroute!
                                                        .id
                                                    : 0,
                                                selectedRouteUserId: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .userId,
                                              )
                                            : OnlyRouteWidget(
                                                deletePostOnTap: () {},
                                                deletePost: true,
                                                onTap: () {
                                                  selectedRouteController
                                                      .selectedRouteId
                                                      .value = 1;
                                                  selectedRouteController
                                                      .selectedRouteUserId
                                                      .value = 1;
                                                  Get.toNamed(
                                                      NavigationConstants
                                                          .routeDetails);
                                                },
                                                didILiked: snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .didILiked ??
                                                    0,
                                                routeContent: snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .postroute!
                                                        .startingCity! +
                                                    " -> " +
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .postroute!
                                                        .endingCity!,
                                                routeEndDate: "",
                                                routeStartDate: "",
                                                postId: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .id!,
                                                onlyPost: snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .postroute ==
                                                    null,
                                                centerImageUrl: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .media!,
                                                subtitle: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .text!,
                                                name:
                                                    "${snapshot.data!.data!.users!.name!} ${snapshot.data!.data!.users!.surname!}",
                                                userId: snapshot
                                                    .data!.data!.users!.id!,
                                                userProfilePhoto: snapshot
                                                    .data!
                                                    .data!
                                                    .users!
                                                    .profilePicture!,
                                                locationName: snapshot
                                                            .data!
                                                            .data!
                                                            .posts!
                                                            .result![index]
                                                            .post!
                                                            .postroute !=
                                                        null
                                                    ? "${snapshot.data!.data!.posts!.result![index].post!.postroute!.startingCity} - ${snapshot.data!.data!.posts!.result![index].post!.postroute!.endingCity}"
                                                    : "",
                                                beforeHours: timeago.format(
                                                    snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .post!
                                                        .createdAt!,
                                                    locale: "tr"),
                                                commentCount: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .commentNum
                                                    .toString(),
                                                firstCommentName:
                                                    "Furkan Semiz",
                                                firstCommentTitle:
                                                    "Akşam 8 de yola çıkacağım",
                                                firstLikeName: "Furkan Semiz",
                                                firstLikeUrl: "",
                                                othersLikeCount: (snapshot
                                                        .data!
                                                        .data!
                                                        .posts!
                                                        .result![index]
                                                        .likedNum!)
                                                    .toString(),
                                                secondLikeUrl:
                                                    "snapshot.data!.data[index].secondLikeUrl",
                                                thirdLikeUrl:
                                                    "snapshot.data!.data[index].thirdLikeUrl",
                                                haveTag: true,
                                                usersTagged: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .postpostlabels,
                                                haveEmotion: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .postemojis!
                                                    .isNotEmpty,
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
                                                        .emoji
                                                    : null,
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
                                                        .name
                                                    : null,
                                                likedStatus: 1,
                                                selectedRouteId: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .id!,
                                                selectedRouteUserId: snapshot
                                                    .data!
                                                    .data!
                                                    .posts!
                                                    .result![index]
                                                    .post!
                                                    .id!,
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
                    }
                  });
            },
          );
        });
  }
}
