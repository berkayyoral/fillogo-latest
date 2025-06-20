import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fillogo/controllers/home_controller/home_controller.dart';
import 'package:fillogo/models/stories/create_story.dart';
import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/core/init/bussiness_helper/bussiness_helper.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/postflow/components/story_flow_widget.dart';
import 'package:fillogo/widgets/video_player_widget.dart';

import '../../export.dart';

class AddStoryView extends StatefulWidget {
  const AddStoryView({Key? key}) : super(key: key);

  @override
  State<AddStoryView> createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  CreatePostPageController createPostPageController = Get.find();
  MediaPickerController mediaPickerController =
      Get.put(MediaPickerController());

  StoriesController storiesController = Get.put(StoriesController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants().ltWhiteGrey,
      appBar: AppBarGenel(
        title: Text(
          'Hikaye Ekle',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/icons/back-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        log("STORYATCAM SEÇTİM Mİ -> ${mediaPickerController.isMediaPicked} / ${mediaPickerController.media}");
        return storiesController.isLoading.value
            ? Center(
                child:
                    CircularProgressIndicator(color: AppConstants().ltMainRed),
              )
            : Stack(
                children: [
                  mediaPickerController.isMediaPicked != false
                      ? SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: mediaPickerController.media!.name
                                  .contains(".mp4")
                              ? VideoPlayerWidget(
                                  file:
                                      File(mediaPickerController.media!.path!),
                                )
                              : Image.file(
                                  File(mediaPickerController.media!.path!),
                                  fit: BoxFit.cover,
                                ))
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RedButton(
                                text: 'Fotoğraf/Video Yükle',
                                onpressed: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 60.w, vertical: 36.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                mediaPickerController.media =
                                                    await BussinessHelper
                                                            .pickFile(context,
                                                                isStory: true,
                                                                type: "galery")
                                                        .then((value) {
                                                  if (value != null) {
                                                    Get.back();
                                                    log("STORYATCAM");
                                                    //log('file picked ${value.name}');
                                                    mediaPickerController
                                                        .isMediaPicked = true;
                                                    if (value.name
                                                            .split('.')
                                                            .last ==
                                                        'mp4') {
                                                      mediaPickerController
                                                          .isVideo = true;
                                                    } else {
                                                      mediaPickerController
                                                          .isVideo = false;
                                                    }
                                                  } else {
                                                    mediaPickerController
                                                        .isVideo = false;
                                                  }
                                                  print("value = $value");
                                                  return value;
                                                });
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Galeriden Seç",
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltMainRed,
                                                      letterSpacing: -1,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () async {
                                                mediaPickerController.media =
                                                    await BussinessHelper
                                                            .pickFile(context,
                                                                isStory: true,
                                                                type: "foto")
                                                        .then((value) {
                                                  Get.back();
                                                  if (value != null) {
                                                    log("STORYATCAM");
                                                    //log('file picked ${value.name}');
                                                    mediaPickerController
                                                        .isMediaPicked = true;
                                                    if (value.name
                                                            .split('.')
                                                            .last ==
                                                        'mp4') {
                                                      mediaPickerController
                                                          .isVideo = true;
                                                    } else {
                                                      mediaPickerController
                                                          .isVideo = false;
                                                    }
                                                  } else {
                                                    mediaPickerController
                                                        .isVideo = false;
                                                  }
                                                  print("value = $value");
                                                  return value;
                                                });
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Fotoğraf Çek",
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltMainRed,
                                                      letterSpacing: -1,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            ElevatedButton(
                                              onPressed: () async {
                                                mediaPickerController.media =
                                                    await BussinessHelper
                                                            .pickFile(context,
                                                                isStory: true,
                                                                type: "video")
                                                        .then((value) {
                                                  Get.back();
                                                  if (value != null) {
                                                    log("STORYATCAM");
                                                    //log('file picked ${value.name}');
                                                    mediaPickerController
                                                        .isMediaPicked = true;
                                                    if (value.name
                                                            .split('.')
                                                            .last ==
                                                        'mp4') {
                                                      mediaPickerController
                                                          .isVideo = true;
                                                    } else {
                                                      mediaPickerController
                                                          .isVideo = false;
                                                    }
                                                  } else {
                                                    mediaPickerController
                                                        .isVideo = false;
                                                  }
                                                  print("value = $value");
                                                  return value;
                                                });
                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Video Çek",
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltMainRed,
                                                      letterSpacing: -1,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                  mediaPickerController.isMediaPicked != false
                      ? Positioned(
                          bottom: 12.h,
                          left: 16.w,
                          right: 16.w,
                          child: RedButton(
                            text: 'Paylaş',
                            onpressed: () async {
                              storiesController.isLoading.value = true;

                              Map<String, dynamic> formData1 = {
                                'file': mediaPickerController.media
                              };
                              await GeneralServicesTemp()
                                  .makePostRequestWithFormData(
                                EndPoint.createStories,
                                formData1,
                                {
                                  "Content-Type": "multipart/form-data",
                                  'Authorization':
                                      'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                },
                              ).then((value) {
                                log("STORYATCAM VALUE ${value.toString()}");
                                if (value != null) {
                                  final response = CreateStoryResponse.fromJson(
                                      jsonDecode(value));
                                  if (response.success == 1) {
                                    homeController.update();
                                    Get.back();

                                    Get.snackbar(
                                        'Hikaye başarıyla eklendi...', "",
                                        colorText: AppConstants().ltBlack,
                                        snackPosition: SnackPosition.BOTTOM);

                                    storiesController.getMyStory();
                                    createPostPageController
                                        .isAddNewStory.value = true;
                                  } else {
                                    Get.back();
                                    Get.snackbar(
                                        "Hikayeniz paylaşılamadı. Lütfen tekrar deneyiniz",
                                        "",
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: AppConstants().ltMainRed);
                                  }
                                }
                              });
                              mediaPickerController.media = null;
                              await storiesController.getMyStory();
                              storiesController.isLoading.value = false;
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              );
      }),
    );
  }
}
