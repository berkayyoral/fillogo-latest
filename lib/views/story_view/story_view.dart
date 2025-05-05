import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/home_controller/home_controller.dart';
import 'package:fillogo/controllers/stories/stories_pagination.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/stories/delete_story.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/postflow/components/story_flow_widget.dart';
import 'package:fillogo/widgets/post_video_player_widget.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:fillogo/widgets/video_player_widget.dart';
import 'package:story_view/story_view.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({super.key});

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  final storyController = StoryController();

  StoriesPaginationController storiesPaginationontroller =
      Get.put(StoriesPaginationController());

  CreatePostPageController createPostPageController = Get.find();
  var userId = Get.arguments;
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  StoriesController storiesController = Get.put(StoriesController());
  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    final duration = 15;
    return Scaffold(
        body: GetBuilder<StoriesPaginationController>(
            id: "userStories",
            initState: (state) async {
              storiesPaginationontroller.userId.value = userId;
              storiesPaginationontroller.snapshotList.value.clear();
              await storiesPaginationontroller.addList(1);
              await storiesPaginationontroller.fillList();
            },
            builder: (_) {
              if (storiesPaginationontroller.snapshotList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: StoryView(
                      controller: storyController,
                      storyItems: List.generate(
                          storiesPaginationontroller.snapshotList.length,
                          (index) {
                        return StoryItem(
                          SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: Obx(
                              () => storiesPaginationontroller.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          color: AppConstants().ltMainRed),
                                    )
                                  : storiesPaginationontroller
                                          .snapshotList[index]!.url!
                                          .contains(".mp4")
                                      ? // burda video gösterilecek
                                      StoryVideoPlayerWidget(
                                          videoUrl: storiesPaginationontroller
                                              .snapshotList[index]!.url!,
                                        )
                                      : Image.network(
                                          storiesPaginationontroller
                                              .snapshotList[index]!.url
                                              .toString(),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppConstants().ltMainRed,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                                child: Icon(Icons.error));
                                          },
                                        ),
                            ),
                          ),
                          duration: const Duration(
                            seconds: 15,
                          ),
                        );
                      })
                      /*[
                    
                    StoryItem(
                      SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: Image.asset(
                          'assets/images/1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      duration: const Duration(
                        seconds: 15,
                      ),
                    ),
                  ]*/
                      ,
                      // onStoryShow: (b) {
                      //   //print("Showing a story");
                      // },
                      onStoryShow: (storyItem, index) {
                        print("Yeni hikaye gösteriliyor: ${index}");

                        // Yeni video başlatma
                        if (storiesPaginationontroller.snapshotList[index]!.url!
                            .contains(".mp4")) {
                          // storyItem.controller.play();  // Yeni videoyu başlat
                        }
                      },
                      onVerticalSwipeComplete: (p0) {
                        LocaleManager.instance
                                    .getInt(PreferencesKeys.currentUserId) !=
                                storiesPaginationontroller
                                    .snapshotList[0]!.stories!.id
                            ? null
                            : showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                      height: Get.height * 0.9,
                                      width: Get.width,
                                      child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: storiesPaginationontroller
                                              .totalPage.value,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.all(6),
                                              width: Get.width,
                                              height: 150,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: SizedBox(
                                                      height: 150,
                                                      width: 150,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        child: Image.network(
                                                          storiesPaginationontroller
                                                              .snapshotList[
                                                                  index]!
                                                              .url
                                                              .toString(),
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: MaterialButton(
                                                      color: AppConstants()
                                                          .ltMainRed,
                                                      onPressed: () {
                                                        print(
                                                            storiesPaginationontroller
                                                                .snapshotList[
                                                                    index]!
                                                                .id);

                                                        GeneralServicesTemp()
                                                            .makeDeleteWithoutBody(
                                                          "${EndPoint.deleteStory}${storiesPaginationontroller.snapshotList[index]!.id}",
                                                          {
                                                            'Authorization':
                                                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                            'Content-Type':
                                                                'application/json',
                                                          },
                                                        ).then((value) {
                                                          var response =
                                                              DeleteStoryResponse
                                                                  .fromJson(json
                                                                      .decode(
                                                                          value!));
                                                          if (response
                                                                  .success ==
                                                              1) {
                                                            print(response
                                                                .message);
                                                            print(
                                                                response.data);
                                                            Get.back();
                                                            storyController
                                                                .dispose();
                                                            Get.back();
                                                            createPostPageController
                                                                .isAddNewStory
                                                                .value = true;
                                                            homeController
                                                                .update();
                                                            createPostPageController
                                                                .isAddNewStory
                                                                .value = false;
                                                          } else {
                                                            print(response
                                                                .message);
                                                            print(response
                                                                .success);
                                                            print(
                                                                response.data);
                                                          }
                                                          storiesController
                                                              .getMyStory();
                                                        });
                                                      },
                                                      child: Text(
                                                          "Hikayeyi Sil",
                                                          style: TextStyle(
                                                              color:
                                                                  AppConstants()
                                                                      .ltWhite,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }));
                                });
                      },
                      onComplete: () {
                        storyController.dispose();
                        Get.back();
                      },
                      progressPosition: ProgressPosition.top,
                      repeat: false,
                    ),
                  ),
                  LocaleManager.instance
                              .getInt(PreferencesKeys.currentUserId) ==
                          storiesPaginationontroller
                              .snapshotList[0]!.stories!.id
                      ? const SizedBox()
                      : Visibility(
                          visible: false,
                          child: Positioned(
                            bottom: 24.h,
                            //width: Get.width,
                            child: SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  16.w.spaceX,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppConstants().ltLogoGrey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          8.r,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppConstants()
                                              .ltLogoGrey
                                              .withOpacity(
                                                0.2.r,
                                              ),
                                          spreadRadius: 3.r,
                                          blurRadius: 3.r,
                                          offset: Offset(0.w, 0.w),
                                        ),
                                      ],
                                    ),
                                    height: 50.h,
                                    width: 300.w,
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      //controller: searchTextController,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      obscureText: false,
                                      cursorColor: AppConstants().ltMainRed,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: 'Sfregular',
                                        color: AppConstants().ltWhite,
                                      ),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.r),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: 'Mesaj yaz',
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                          fontFamily: 'Sflight',
                                          color: AppConstants().ltWhite,
                                        ),
                                      ),
                                    ),
                                  ),
                                  10.w.spaceX,
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(NavigationConstants.message);
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/message-icon.svg',
                                      height: 30.h,
                                      color: AppConstants().ltWhite,
                                    ),
                                  ),
                                  16.w.spaceX,
                                ],
                              ),
                            ),
                          ),
                        ),
                  Positioned(
                    top: 60.h,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                      child: SizedBox(
                        width: 341.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ProfilePhoto(
                                  onTap: () {
                                    if (storiesPaginationontroller
                                            .userId.value ==
                                        LocaleManager.instance.getInt(
                                            PreferencesKeys.currentUserId)) {
                                      Get.back();
                                      bottomNavigationBarController
                                          .selectedIndex.value = 3;
                                    } else {
                                      Get.toNamed(
                                          NavigationConstants.otherprofiles,
                                          arguments: storiesPaginationontroller
                                              .userId.value);
                                    }
                                  },
                                  height: 48.h,
                                  width: 48.w,
                                  url: storiesPaginationontroller
                                      .snapshotList[0]!.stories!.profilePicture
                                      .toString(),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    "${storiesPaginationontroller.snapshotList[0]!.stories!.name} ${storiesPaginationontroller.snapshotList[0]!.stories!.surname}",
                                    style: TextStyle(
                                      color: AppConstants().ltWhite,
                                      fontFamily: 'Sfregular',
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            storiesPaginationontroller.userId.value !=
                                    LocaleManager.instance
                                        .getInt(PreferencesKeys.currentUserId)
                                ? const SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                                height: Get.height * 0.9,
                                                width: Get.width,
                                                child: ListView.builder(
                                                    physics:
                                                        const AlwaysScrollableScrollPhysics(),
                                                    itemCount:
                                                        storiesPaginationontroller
                                                            .snapshotList
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        margin: const EdgeInsets
                                                            .all(6),
                                                        width: Get.width,
                                                        height: 150,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20),
                                                              child: SizedBox(
                                                                height: 150,
                                                                width: 150,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16),
                                                                  child: storiesPaginationontroller
                                                                          .snapshotList[
                                                                              index]!
                                                                          .url!
                                                                          .contains(
                                                                              ".mp4")
                                                                      ? Stack(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: double.infinity,
                                                                              height: 200,
                                                                              color: Colors.black12,
                                                                              child: Icon(Icons.videocam, size: 50, color: Colors.grey),
                                                                            ),
                                                                            Icon(Icons.play_circle_fill,
                                                                                size: 64,
                                                                                color: Colors.white),
                                                                          ],
                                                                        )
                                                                      : Image
                                                                          .network(
                                                                          storiesPaginationontroller
                                                                              .snapshotList[index]!
                                                                              .url
                                                                              .toString(),
                                                                          fit: BoxFit
                                                                              .fitHeight,
                                                                        ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          20),
                                                              child:
                                                                  MaterialButton(
                                                                color: AppConstants()
                                                                    .ltMainRed,
                                                                onPressed: () {
                                                                  print(
                                                                      "STORYVİEWWW DELEETEE");
                                                                  print(
                                                                      "storyyidd ${storiesPaginationontroller.snapshotList[index]!.id}");

                                                                  GeneralServicesTemp()
                                                                      .makeDeleteWithoutBody(
                                                                    "${EndPoint.deleteStory}${storiesPaginationontroller.snapshotList[index]!.id}",
                                                                    {
                                                                      'Authorization':
                                                                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                                      'Content-Type':
                                                                          'application/json',
                                                                    },
                                                                  ).then((value) {
                                                                    var response =
                                                                        DeleteStoryResponse.fromJson(
                                                                            json.decode(value!));
                                                                    if (response
                                                                            .success ==
                                                                        1) {
                                                                      print(response
                                                                          .message);
                                                                      print(response
                                                                          .data);
                                                                      Get.back();
                                                                      storyController
                                                                          .dispose();
                                                                      createPostPageController
                                                                          .isAddNewStory
                                                                          .value = true;

                                                                      homeController
                                                                          .update();
                                                                      createPostPageController
                                                                          .isAddNewStory
                                                                          .value = false;
                                                                      Get.back();
                                                                    } else {
                                                                      print(response
                                                                          .message);
                                                                      print(response
                                                                          .success);
                                                                      print(response
                                                                          .data);
                                                                    }
                                                                    storiesController
                                                                        .getMyStory();
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "Hikayeyi Sil",
                                                                    style: TextStyle(
                                                                        color: AppConstants()
                                                                            .ltWhite,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }));
                                          });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      size: 28.h,
                                      color: AppConstants().ltMainRed,
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: GestureDetector(
                                onTap: () {
                                  storyController.dispose();
                                  Get.back();
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/close-icon.svg',
                                  height: 28.h,
                                  width: 28.w,
                                  color: AppConstants().ltWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  Future<Uint8List?> getVideoThumbnail(String videoUrl) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // thumbnail genişliği
      quality: 75,
    );
    return uint8list;
  }
}

class StoryVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const StoryVideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<StoryVideoPlayerWidget> createState() => _StoryVideoPlayerWidgetState();
}

class _StoryVideoPlayerWidgetState extends State<StoryVideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(covariant StoryVideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Eğer video URL değişmişse, yeniden başlat
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.pause();
      _controller.seekTo(Duration.zero);
      _initializePlayer();
    }
  }

  void _initializePlayer() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Videoyu otomatik başlat
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Belleği temizle
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
