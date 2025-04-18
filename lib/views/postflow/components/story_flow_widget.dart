import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/views/postflow/components/create_story_view.dart';
import 'package:fillogo/views/postflow/components/friends_story_view.dart';
import 'package:fillogo/models/stories/get_users_with_stories.dart';
import 'package:fillogo/models/stories/have_i_story.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:story_view/story_view.dart';

class StoryFlowWiew extends StatelessWidget {
  StoryFlowWiew({super.key});

  // final RxBool haveIStory = false.obs;
  // final RxBool isLoading = false.obs;
  final StoriesController storiesController = Get.put(StoriesController());
  @override
  Widget build(BuildContext context) {
    print("HAVEISTOR -> ${storiesController.haveIStory.value}");
    return Obx(() {
      print(
          "SROTOEOY -> ${storiesController.isLoading.value}/${storiesController.haveIStory.value}");
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SizedBox(
            height: 200.h,
            child: Row(
              children: [
                const CreateStoryView(),
                10.w.spaceX,
                Obx(
                  () => storiesController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Row(
                          children: [
                            Obx(
                              () => !storiesController.haveIStory.value
                                  ? Container()
                                  : FriendsStoryView(
                                      storyImageUrl: storiesController
                                          .myStoryList.value[0].url!,
                                      profileImageUrl: storiesController
                                          .myStoryList
                                          .value[0]
                                          .stories!
                                          .profilePicture!,
                                      userName: "Hikayen",
                                      arguments: storiesController
                                          .myStoryList.value[0].stories!.id!,
                                    ),
                            ),
                            SizedBox(width: 8.w),
                            FutureBuilder<GetUsersWithStories?>(
                                future: GeneralServicesTemp().makeGetRequest(
                                  EndPoint.getUsersWithStories,
                                  {
                                    'Authorization':
                                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                    'Content-Type': 'application/json',
                                  },
                                ).then((value) {
                                  if (value != null) {
                                    return GetUsersWithStories.fromJson(
                                        json.decode(value));
                                  }
                                  return null;
                                }),
                                builder: (context, snapshot) {
                                  FutureBuilder<HaveIStory?>(
                                      future:
                                          GeneralServicesTemp().makeGetRequest(
                                        EndPoint.haveIStory,
                                        {
                                          'Authorization':
                                              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                          'Content-Type': 'application/json',
                                        },
                                      ).then((value2) {
                                        // storiesController.loading.value = false;
                                        if (value2 != null) {
                                          return HaveIStory.fromJson(
                                              json.decode(value2));
                                        }
                                        return null;
                                      }),
                                      builder: (context, snapshot2) {
                                        if (snapshot2.hasData) {
                                          if (snapshot2.data!.success == 1) {
                                            // haveIStory.value = true;

                                            return const SizedBox();
                                          }
                                          return const SizedBox();
                                        }
                                        {
                                          return const CircularProgressIndicator();
                                        }
                                      });
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.data!.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            snapshot.data!.data![index]
                                                    .followed!.stories!.isEmpty
                                                ? const SizedBox(
                                                    width: 0,
                                                  )
                                                : SizedBox(
                                                    height: 200.h,
                                                    child: Row(
                                                      children: [
                                                        10.w.spaceX,
                                                        FriendsStoryView(
                                                          storyImageUrl:
                                                              snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .followed!
                                                                  .stories![0]
                                                                  .url!,
                                                          profileImageUrl: snapshot
                                                              .data!
                                                              .data![index]
                                                              .followed!
                                                              .profilePicture!,
                                                          userName: snapshot
                                                              .data!
                                                              .data![index]
                                                              .followed!
                                                              .username!,
                                                          arguments: snapshot
                                                              .data!
                                                              .data![index]
                                                              .followed!
                                                              .id,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                }),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class StoriesController extends GetxController implements StoryService {
  final RxBool haveIStory = false.obs;
  final RxBool isLoading = false.obs;
  RxList<MyStoryDetail> myStoryList = <MyStoryDetail>[].obs;

  @override
  void onInit() {
    getMyStory();
    super.onInit();
  }

  StoryService storyService = StoryService();
  @override
  Future<HaveIStory?> getMyStory() async {
    isLoading.value = true;
    print(
        "SROTOEOY STORİCONTROLLER 2-> ${isLoading.value}/${haveIStory.value}");
    myStoryList.value.clear();
    haveIStory.value = false;
    try {
      var res = await storyService.getMyStory();
      print("MYSTORİRES VAL -> ${jsonEncode(res)}");
      if (res != null && res.success == 1) {
        if (res.data!.isNotEmpty) {
          haveIStory.value = true;
        } else {
          haveIStory.value = false;
        }
        myStoryList.value = res.data![0].stories!.myStoryList!;
        isLoading.value = false;
        print(
            "SROTOEOY STORİCONTROLLER 3.1-> ${isLoading.value}/${haveIStory.value}");
      } else {
        isLoading.value = false;

        print(
            "SROTOEOY STORİCONTROLLER 3.2-> ${isLoading.value}/${haveIStory.value}");
        return null;
      }
    } catch (e) {
      log("Get my story err contr -> $e");
    }
  }
}

class StoryService {
  Future<HaveIStory?> getMyStory() async {
    try {
      var res = await GeneralServicesTemp().makeGetRequest(
        EndPoint.haveIStory,
        {
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
          'Content-Type': 'application/json',
        },
      );

      var response = HaveIStory.fromJson(jsonDecode(res!));
      if (response.success == 1) {
        return response;
      }
    } catch (e) {
      log("Get my story err service -> $e");
    }
    return null;
  }
}
