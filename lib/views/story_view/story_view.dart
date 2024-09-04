import 'dart:convert';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/home_controller/home_controller.dart';
import 'package:fillogo/controllers/stories/stories_pagination.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/stories/delete_story.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:story_view/story_view.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({super.key});

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  final storyController = StoryController();

  var userId = Get.arguments;

  StoriesPaginationController storiesController =
      Get.put(StoriesPaginationController());

  CreatePostPageController createPostPageController = Get.find();

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  @override
  void dispose() {
    super.dispose();
    storyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: GetBuilder<StoriesPaginationController>(
            id: "userStories",
            initState: (state) async {
              storiesController.userId.value = userId;
              await storiesController.addList(1);
              storiesController.fillList();
            },
            builder: (_) {
              if (storiesController.snapshotList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: StoryView(
                      controller: storyController,
                      storyItems: List.generate(
                          storiesController.totalPage.value, (index) {
                        print(storiesController.snapshotList[index]!.id);
                        //https://res.cloudinary.com/dmpfzfgrb/image/upload/v1688989683/post/1/1688989682790.jpg
                        return StoryItem(
                          SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: Image.network(
                              storiesController.snapshotList[index]!.url
                                  .toString(),
                              fit: BoxFit.cover,
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
                      onVerticalSwipeComplete: (p0) {
                        LocaleManager.instance
                                    .getInt(PreferencesKeys.currentUserId) !=
                                storiesController.snapshotList[0]!.stories!.id
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
                                          itemCount:
                                              storiesController.totalPage.value,
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
                                                          storiesController
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
                                                        print(storiesController
                                                            .snapshotList[
                                                                index]!
                                                            .id);

                                                        GeneralServicesTemp()
                                                            .makeDeleteWithoutBody(
                                                          "${EndPoint.deleteStory}${storiesController.snapshotList[index]!.id}",
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
                          storiesController.snapshotList[0]!.stories!.id
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
                                    if (storiesController.userId.value ==
                                        LocaleManager.instance.getInt(
                                            PreferencesKeys.currentUserId)) {
                                      Get.back();
                                      bottomNavigationBarController
                                          .selectedIndex.value = 3;
                                    } else {
                                      Get.toNamed(
                                          NavigationConstants.otherprofiles,
                                          arguments:
                                              storiesController.userId.value);
                                    }
                                  },
                                  height: 48.h,
                                  width: 48.w,
                                  url: storiesController
                                      .snapshotList[0]!.stories!.profilePicture
                                      .toString(),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    "${storiesController.snapshotList[0]!.stories!.name} ${storiesController.snapshotList[0]!.stories!.surname}",
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
                            storiesController.userId.value !=
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
                                                    itemCount: storiesController
                                                        .totalPage.value,
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
                                                                  child: Image
                                                                      .network(
                                                                    storiesController
                                                                        .snapshotList[
                                                                            index]!
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
                                                                  print(storiesController
                                                                      .snapshotList[
                                                                          index]!
                                                                      .id);

                                                                  GeneralServicesTemp()
                                                                      .makeDeleteWithoutBody(
                                                                    "${EndPoint.deleteStory}${storiesController.snapshotList[index]!.id}",
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
}
