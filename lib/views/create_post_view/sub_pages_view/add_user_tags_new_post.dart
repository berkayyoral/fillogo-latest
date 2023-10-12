import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/user/search_user_request.dart';
import 'package:fillogo/models/search/user/search_user_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

// ignore: must_be_immutable
class CreatePostAddTagsPageView extends StatelessWidget {
  CreatePostAddTagsPageView({super.key});

  CreatePostPageController createPostPageController =
      Get.find<CreatePostPageController>();

  TextEditingController searchTextController = TextEditingController();
  SearchUserRequest searchUserRequest = SearchUserRequest();

  @override
  Widget build(BuildContext context) {
    searchUserRequest.text = " ";

    return Scaffold(
      appBar: appBar(),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchBox(),
              SizedBox(height: 20.h),
              Obx(
                () => createPostPageController.tagIdList.isNotEmpty
                    ? Expanded(
                        child: GetBuilder<CreatePostPageController>(
                        id: "taggedList",
                        builder: (controller) {
                          return ListView.builder(
                            itemCount:
                                createPostPageController.tagIdList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListUsersItemsRemove(
                                user: createPostPageController.tagList[index],
                              );
                            },
                          );
                        },
                      ))
                    : const SizedBox(),
              ),
              Expanded(
                flex: 9,
                child: GetBuilder<CreatePostPageController>(
                  id: 'search',
                  builder: (controller) {
                    return FutureBuilder<SearchUserResponse?>(
                        future: GeneralServicesTemp().makePostRequest(
                          '/users/search-user',
                          searchUserRequest,
                          {
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                            'Content-Type': 'application/json',
                          },
                        ).then((value) =>
                            SearchUserResponse.fromJson(json.decode(value!))),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.success == 1
                                ? GetBuilder<CreatePostPageController>(
                                    id: 'taggedList',
                                    builder: (controller) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.data![0]
                                            .searchResult!.result!.length,
                                        itemBuilder: (context, index) {
                                          UserResult user = snapshot
                                              .data!
                                              .data![0]
                                              .searchResult!
                                              .result![index];
                                          return InkWell(
                                            onTap: () {
                                              createPostPageController
                                                  .changeTagList(user);

                                              createPostPageController
                                                  .changeTagIdList(user.id!);

                                              if (createPostPageController
                                                  .tagIdList.value.isEmpty) {
                                                createPostPageController
                                                    .haveTag.value = 0;
                                              } else {
                                                createPostPageController
                                                    .haveTag.value = 1;
                                              }
                                              createPostPageController
                                                  .update(['taggedList']);
                                            },
                                            child: ListUsersItems(
                                              user: user,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text("Kullanıcı Bulunamadı"),
                                  );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBarGenel appBar() {
    return AppBarGenel(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 2.w,
          ),
          child: SvgPicture.asset(
            height: 20.h,
            width: 20.w,
            'assets/icons/back-icon.svg',
            color: AppConstants().ltLogoGrey,
          ),
        ),
      ),
      title: Text(
        "Kişileri Etiketle",
        style: TextStyle(
          fontFamily: "Sfbold",
          fontSize: 20.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      width: 340.w,
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
            width: 296.w,
            height: 50.h,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: TextField(
                onChanged: (value) {
                  createPostPageController.searchRequestText =
                      searchTextController.text;

                  searchUserRequest.text =
                      createPostPageController.searchRequestText;

                  createPostPageController.update(['search']);

                  GeneralServicesTemp()
                      .makePostRequest(
                        '/users/search-user',
                        searchUserRequest,
                        ServicesConstants.appJsonWithToken,
                      )
                      .then(
                        (value) => SearchUserResponse.fromJson(
                          json.decode(value!),
                        ),
                      );
                },
                textAlignVertical: TextAlignVertical.center,
                controller: searchTextController,
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
                  hintText: 'Arkadaşlarında ara',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Sflight',
                    color: AppConstants().ltDarkGrey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 13.h, bottom: 13.h),
            child: SvgPicture.asset(
              height: 24.h,
              width: 24.w,
              'assets/icons/search-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class ListUsersItems extends StatelessWidget {
  ListUsersItems({
    super.key,
    required this.user,
  });

  final UserResult user;

  CreatePostPageController createPostPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 70.h,
        width: 340.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.r,
            ),
          ),
          color: AppConstants().ltWhiteGrey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ProfilePhoto(
                      height: 48.h,
                      width: 48.w,
                      url: user.profilePicture ?? ""),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, bottom: 3.h),
                      child: Text(
                        user.name ?? "",
                        style: TextStyle(
                          fontFamily: 'Sfsemibold',
                          fontSize: 16.sp,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                      ),
                      child: Text(
                        user.title ?? "",
                        style: TextStyle(
                          fontFamily: 'Sflight',
                          fontSize: 14.sp,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SvgPicture.asset(
                  height: 40.h,
                  width: 40.w,
                  createPostPageController.tagIdList.contains(user.id)
                      ? 'assets/icons/add-tag-icon.svg'
                      : 'assets/icons/been-added-user-icon.svg',
                  color: createPostPageController.tagIdList.contains(user.id)
                      ? AppConstants().ltMainRed
                      : AppConstants().ltLogoGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListUsersItemsRemove extends StatelessWidget {
  ListUsersItemsRemove({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserResult user;

  CreatePostPageController createPostPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: SizedBox(
        height: 55.h,
        width: 56.w,
        child: Stack(
          children: [
            ProfilePhoto(
              height: 48.h,
              width: 48.w,
              url: createPostPageController.userPhoto.value,
            ),
            Positioned(
              left: 32.w,
              child: InkWell(
                onTap: () async {
                  log("Heyy");
                  createPostPageController.changeTagList(user);
                  createPostPageController.changeTagIdList(user.id!);

                  if (createPostPageController.tagIdList.value.length == 0) {
                    createPostPageController.haveTag.value = 0;
                  } else {
                    createPostPageController.haveTag.value = 1;
                  }
                  createPostPageController.update(['taggedList']);
                },
                child: SvgPicture.asset(
                  height: 24.h,
                  width: 24.w,
                  'assets/icons/remove-tag-icon.svg',
                  color: AppConstants().ltMainRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
