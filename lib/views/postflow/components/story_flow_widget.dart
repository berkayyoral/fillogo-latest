import 'dart:convert';

import 'package:fillogo/export.dart';
import 'package:fillogo/views/postflow/components/create_story_view.dart';
import 'package:fillogo/views/postflow/components/friends_story_view.dart';
import 'package:fillogo/models/stories/get_users_with_stories.dart';
import 'package:fillogo/models/stories/have_i_story.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

class StoryFlowWiew extends StatelessWidget {
  StoryFlowWiew({super.key});

  final RxBool haveIStory = false.obs;
  @override
  Widget build(BuildContext context) {
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
              FutureBuilder<HaveIStory?>(
                  future: GeneralServicesTemp().makeGetRequest(
                    EndPoint.haveIStory,
                    {
                      'Authorization':
                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                      'Content-Type': 'application/json',
                    },
                  ).then((value2) {
                    print("value2 ss$value2");
                    if (value2 != null) {
                      return HaveIStory.fromJson(json.decode(value2));
                    }
                    return null;
                  }),
                  builder: (context, snapshot2) {
                    if (snapshot2.hasData) {
                      if (snapshot2.data!.success == 1) {
                        haveIStory.value = true;
                        return FriendsStoryView(
                          storyImageUrl:
                              snapshot2.data!.data![0].stories!.result![0].url!,
                          profileImageUrl: snapshot2.data!.data![0].stories!
                              .result![0].stories!.profilePicture!,
                          userName: "Hikayen",
                          arguments: snapshot2
                              .data!.data![0].stories!.result![0].stories!.id!,
                        );
                      }
                      return const SizedBox();
                    }
                    {
                      return const CircularProgressIndicator();
                    }
                  }),
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
                      return GetUsersWithStories.fromJson(json.decode(value));
                    }
                    return null;
                  }),
                  builder: (context, snapshot) {
                    FutureBuilder<HaveIStory?>(
                        future: GeneralServicesTemp().makeGetRequest(
                          EndPoint.haveIStory,
                          {
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                            'Content-Type': 'application/json',
                          },
                        ).then((value2) {
                          print("value2 hh$value2");
                          if (value2 != null) {
                            return HaveIStory.fromJson(json.decode(value2));
                          }
                          return null;
                        }),
                        builder: (context, snapshot2) {
                          if (snapshot2.hasData) {
                            if (snapshot2.data!.success == 1) {
                              haveIStory.value = true;

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
                              snapshot.data!.data![index].followed!.stories!
                                      .isEmpty
                                  ? const SizedBox(
                                      width: 0,
                                    )
                                  : SizedBox(
                                      height: 200.h,
                                      child: Row(
                                        children: [
                                          10.w.spaceX,
                                          FriendsStoryView(
                                            storyImageUrl: snapshot
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
                                            arguments: snapshot.data!
                                                .data![index].followed!.id,
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
