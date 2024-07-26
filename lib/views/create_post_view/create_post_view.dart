// ignore: must_be_immutable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/home_controller/home_controller.dart';
import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/core/constants/enums/preference_keys_enum.dart';
import 'package:fillogo/core/constants/navigation_constants.dart';
import 'package:fillogo/core/init/locale/locale_manager.dart';
import 'package:fillogo/views/create_post_view/components/mfuController.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/widgets/appbar_genel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:fillogo/export.dart';
import 'package:fillogo/models/post/create/post_create_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/add_property_create_post.dart';
import 'package:fillogo/views/create_post_view/components/add_property_not_content_create_post.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/create_post_view/components/discription_textfield_widget.dart';
import 'package:fillogo/views/create_post_view/components/emotion_and_tag_string_create_post_witget.dart';
import 'package:fillogo/views/create_post_view/components/route_view_widget_new_post.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:fillogo/widgets/video_player_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/init/ui_helper/ui_helper.dart';

class CreatePostPageView extends StatelessWidget {
  CreatePostPageView({super.key});

  CreatePostPageController createPostPageController =
      Get.find<CreatePostPageController>();
  MediaPickerController mediaPickerController =
      Get.find<MediaPickerController>();

  TextEditingController discriptionTextController = TextEditingController();

  MfuController mfuController = Get.find<MfuController>();

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();
  UserStateController userStateController = Get.find();
  GeneralDrawerController postFlowDrawerController =
      Get.find<GeneralDrawerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: ProfilePhoto(
                          height: 48.h,
                          width: 48.w,
                          url: createPostPageController.userPhoto.value,
                        ),
                      ),
                      12.w.spaceX,
                      SizedBox(
                        width: 283.w,
                        child: Obx(
                          () => EmotionAndTagStringCreatePost(
                            name: createPostPageController.userName.value,
                            usersTagged: createPostPageController.tagList == []
                                ? ['']
                                : createPostPageController.tagList.value,
                            emotion:
                                createPostPageController.isSelectedEmotion.value
                                    ? createPostPageController
                                        .selectedEmotion.value.emoji!
                                    : "",
                            emotionContent:
                                createPostPageController.isSelectedEmotion.value
                                    ? createPostPageController
                                        .selectedEmotion.value.name!
                                    : "",
                            haveTag: createPostPageController.haveTag.value,
                            haveEmotion: createPostPageController
                                .isSelectedEmotion.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                    child: DiscriptionTextFieldWidget(
                      discriptionContent:
                          createPostPageController.discriptionContent.value,
                      discriptionTextController: discriptionTextController,
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: (createPostPageController.haveRoute.value == 1),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                      child: (createPostPageController.haveRoute.value == 1)
                          ? RouteViewWidgetNewPostPage(
                              // burada ekliyo
                              closeButtonVisible: true,
                              userName: createPostPageController.userName.value,
                              routeContent: mfuController.sehirler.value,
                              routeStartDate:
                                  mfuController.baslangictarihi.value,
                              routeEndDate: mfuController.bitistarihi.value,
                            )
                          : SizedBox(
                              height: 0.h,
                            ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible:
                        (createPostPageController.havePostPhoto.value == 1),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                      child: GetBuilder<MediaPickerController>(
                          id: 'isLoading',
                          builder: (context) {
                            return Obx(() {
                              return Container(
                                height: 320.h,
                                width: double.infinity,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.red.withOpacity(0.08),
                                ),
                                child: mediaPickerController.isMediaPicked ==
                                        false
                                    ? const SizedBox()
                                    : Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              height: 320.h,
                                              child: Obx(() {
                                                return mediaPickerController
                                                        .isVideo
                                                    ? VideoPlayerWidget(
                                                        file: File(
                                                            mediaPickerController
                                                                .media!.path!),
                                                      )
                                                    : mediaPickerController
                                                                .media !=
                                                            null
                                                        ? Image.file(
                                                            File(
                                                                mediaPickerController
                                                                    .media!
                                                                    .path!),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : const CircularProgressIndicator
                                                            .adaptive(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors.red),
                                                          );
                                              }),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 40,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                                color: Colors.transparent,
                                              ),
                                              child: CloseButton(
                                                color: mediaPickerController
                                                        .isVideo
                                                    ? Colors.black
                                                    : Colors.white,
                                                onPressed: () {
                                                  createPostPageController
                                                      .havePostPhoto.value = 0;
                                                  mediaPickerController
                                                      .isMediaPicked = false;

                                                  createPostPageController
                                                      .imageFile = File("");
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              );
                            });
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 20.h,
                  ),
                  child: Obx(
                    () => CustomButtonDesign(
                      text: 'Gönderi Oluştur',
                      textColor: AppConstants().ltWhite,
                      onpressed: () async {
                        if (createPostPageController.haveDiscription.value ==
                                0 &&
                            createPostPageController.havePostPhoto.value == 0 &&
                            createPostPageController.haveRoute.value == 0) {
                        } else {
                          Map<String, dynamic> map = <String, dynamic>{};
                          createPostPageController.isSelectedEmotion.value
                              ? map['emotionID[0]'] = createPostPageController
                                  .selectedEmotion.value.id
                              : null;
                          if (createPostPageController.tagIdList.isNotEmpty) {
                            for (int i = 0;
                                i < createPostPageController.tagIdList.length;
                                i++) {
                              map['taggedUserList[$i]'] =
                                  createPostPageController.tagIdList[i];
                            }
                          }

                          map['postDescription'] =
                              discriptionTextController.text.isEmpty
                                  ? "Yeni bir rotaya çıktım"
                                  : discriptionTextController.text;
                          createPostPageController.routeId.value == 0
                              ? null
                              : map['postRouteID'] =
                                  createPostPageController.routeId.value;

                          mediaPickerController.media != null
                              ? map['file'] = mediaPickerController.media
                              : null;

                          // mediaPickerController.media != null
                          //     ? map['postMedia'] = await MultipartFile.fromFile(
                          //         mediaPickerController.media!.path!,
                          //         filename: mediaPickerController.media!.name,
                          //         contentType: parser.MediaType(
                          //           mediaPickerController.media!.name
                          //                       .split('.')
                          //                       .last ==
                          //                   'mp4'
                          //               ? 'video'
                          //               : 'image',
                          //           mediaPickerController.media!.name
                          //               .split('.')
                          //               .last,
                          //         ),
                          //       )
                          //     : null;
                          log("map = $map");
                          log("platform = ${mediaPickerController.media}");
                          // Map<String, dynamic> formData1 = {
                          //   'postDescription': "a",
                          //   'postMedia': mediaPickerController.media
                          // };
                          await GeneralServicesTemp()
                              .makePostRequestWithFormData(
                                  '/posts/create-post', map, {
                            "Content-Type": "multipart/form-data",
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                          }).then((value) {
                            if (value != null) {
                              final response = PostCreateResponse.fromJson(
                                  jsonDecode(value));
                              if (response.success == 1) {
                                if (bottomNavigationBarController
                                        .selectedIndex.value ==
                                    1) {
                                  bottomNavigationBarController
                                      .selectedIndex.value = 1;
                                } else {
                                  final HomeController homeContoller =
                                      Get.put(HomeController());
                                  bottomNavigationBarController
                                      .selectedIndex.value = 0;
                                  homeContoller.currentPage.value = 1;
                                  homeContoller.scrollOffset.value = 600;
                                  homeContoller.snapshotList.clear();
                                  homeContoller.fillList(1);
                                }

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      showAllertDialogPostSharing(context),
                                );
                              } else {
                                UiHelper.showWarningSnackBar(context,
                                    'Bir hata oluştu. Tekrar deneyiniz.');
                              }
                            }
                          });
                        }
                      },
                      iconPath: '',
                      color: (createPostPageController.haveDiscription.value ==
                                  0 &&
                              createPostPageController.havePostPhoto.value ==
                                  0 &&
                              createPostPageController.haveRoute.value == 0)
                          ? AppConstants().ltDarkGrey
                          : AppConstants().ltMainRed,
                      height: 50.h,
                      width: 340.w,
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => Positioned(
                child: (createPostPageController.havePostPhoto.value == 0 &&
                        createPostPageController.haveRoute.value == 0)
                    ? const AddNewPropertyCreatePost()
                    : AddNewPropertyNotContentCreatePost(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBarGenel appBar(BuildContext context) {
    return AppBarGenel(
      leading: GestureDetector(
        onTap: () {
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) => ShowAllertDialogWidget(
          //     button1Color: AppConstants().ltMainRed,
          //     button1Height: 50.h,
          //     button1IconPath: '',
          //     button1Text: 'Kaydet',
          //     button1TextColor: AppConstants().ltWhite,
          //     button1Width: Get.width,
          //     button2Color: AppConstants().ltDarkGrey,
          //     button2Height: 50.h,
          //     button2IconPath: '',
          //     button2Text: 'Kaydetme',
          //     button2TextColor: AppConstants().ltWhite,
          //     button2Width: Get.width,
          //     buttonCount: 2,
          //     discription1:
          //         "Oluşturmuş olduğunuz gönderi bilgileri taslaklara kaydedilsin mi?",
          //     onPressed1: () {
          //       createPostPageController.clearPostCreateInfoController();

          Get.back();
          //     },
          //     onPressed2: () {
          //       createPostPageController.clearPostCreateInfoController();
          //       Get.back();
          //       Get.back();
          //     },
          //     title: 'Taslaklara Kaydet',
          //   ),
          // );
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
          ),
          child: SvgPicture.asset(
            height: 24.h,
            width: 24.w,
            'assets/icons/close-icon.svg',
            color: AppConstants().ltLogoGrey,
          ),
        ),
      ),
      title: Text(
        "Gönderi Oluştur",
        style: TextStyle(
          fontFamily: "Sfbold",
          fontSize: 20.sp,
          color: AppConstants().ltBlack,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(NavigationConstants.createPostPageSettings);
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
    );
  }

  Widget showAllertDialogPostSharing(BuildContext context) {
    SocialController socialController = Get.put(SocialController());
    return AlertDialog(
      title: Text(
        'Gönderi başarıyla oluşturuldu',
        style: TextStyle(
          fontFamily: 'Sfsemibold',
          fontSize: 16.sp,
          color: AppConstants().ltLogoGrey,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tebrikler gönderiniz başarıyla oluşturuldu. Arkadaşların buna çok ilgi duyacak.",
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
          Text(
            "",
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
          Text(
            "Paylaşımızını diğer uygulamalarda paylaşmak ister misiniz?",
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      socialController.facebookTap.value =
                          !socialController.facebookTap.value;
                    },
                    child: SizedBox(
                      width: 50,
                      child: SvgPicture.asset(
                        "assets/icons/facebook-icon.svg",
                        height: 48.h,
                        width: 48.w,
                        color: socialController.facebookTap.value == true
                            ? AppConstants().ltMainRed
                            : AppConstants().ltDarkGrey,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      socialController.instagramTap.value =
                          !socialController.instagramTap.value;
                    },
                    child: SizedBox(
                      width: 50,
                      child: SvgPicture.asset(
                        "assets/icons/instagram.svg",
                        height: 48.h,
                        width: 48.w,
                        color: socialController.instagramTap.value == true
                            ? AppConstants().ltMainRed
                            : AppConstants().ltDarkGrey,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      socialController.twitterTap.value =
                          !socialController.twitterTap.value;
                    },
                    child: SizedBox(
                      width: 50,
                      child: SvgPicture.asset(
                        "assets/icons/twitter.svg",
                        height: 48.h,
                        width: 48.w,
                        color: socialController.twitterTap.value == true
                            ? AppConstants().ltMainRed
                            : AppConstants().ltDarkGrey,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      socialController.tiktokTap.value =
                          !socialController.tiktokTap.value;
                    },
                    child: SizedBox(
                      width: 50,
                      child: SvgPicture.asset(
                        "assets/icons/tiktok.svg",
                        height: 48.h,
                        width: 48.w,
                        color: socialController.tiktokTap.value == true
                            ? AppConstants().ltMainRed
                            : AppConstants().ltDarkGrey,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
      actions: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
              child: CustomButtonDesign(
                text: 'Tamam',
                textColor: AppConstants().ltWhite,
                onpressed: () async {
                  // MapPageController mapPageController =
                  //     Get.find<MapPageController>();
                  MapPageMController mapPageController = Get.find();
                  GetMyCurrentLocationController
                      getMyCurrentLocationController = Get.find();
                  createPostPageController.clearPostCreateInfoController();
                  Get.back();
                  Get.back();
                  GoogleMapController googleMapController =
                      mapPageController.mapController;
                  googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 15,
                        target: LatLng(
                          getMyCurrentLocationController
                              .myLocationLatitudeDo.value,
                          getMyCurrentLocationController
                              .myLocationLongitudeDo.value,
                        ),
                      ),
                    ),
                  );

                  Get.back();
                },
                iconPath: '',
                color: AppConstants().ltMainRed,
                height: 50.h,
                width: 140.w,
              ),
            ),
          ],
        )
      ],
    );
  }

  // Widget showAllertDialogSaveInfoPost(BuildContext context) {
  //   return AlertDialog(
  //     title: Text(
  //       'Taslaklara Kaydet',
  //       style: TextStyle(
  //         fontFamily: 'Sfsemibold',
  //         fontSize: 16.sp,
  //         color: AppConstants().ltLogoGrey,
  //       ),
  //     ),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           "Oluşturmuş olduğunuz gönderi bilgileri taslaklara kaydedilsin mi? ",
  //           style: TextStyle(
  //             fontFamily: 'Sfregular',
  //             fontSize: 14.sp,
  //             color: AppConstants().ltLogoGrey,
  //           ),
  //         ),
  //       ],
  //     ),
  //     actions: <Widget>[
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
  //             child: TextButton(
  //               child: Text(
  //                 'Kaydetme',
  //                 style: TextStyle(
  //                   fontFamily: 'Sfregular',
  //                   fontSize: 14.sp,
  //                   color: AppConstants().ltMainRed,
  //                 ),
  //               ),
  //               onPressed: () async {
  //                 createPostPageController.clearPostCreateInfoController();
  //                 Get.back();
  //                 Get.back();
  //               },
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
  //             child: CustomButtonDesign(
  //               text: 'Kaydet',
  //               textColor: AppConstants().ltWhite,
  //               onpressed: () {
  //                 Get.back();
  //                 Get.back();
  //               },
  //               iconPath: '',
  //               color: AppConstants().ltMainRed,
  //               height: 50.h,
  //               width: 140.w,
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
}

class SocialController extends GetxController {
  var facebookTap = false.obs;
  var instagramTap = false.obs;
  var twitterTap = false.obs;
  var tiktokTap = false.obs;
}
