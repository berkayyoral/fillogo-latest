import 'dart:convert';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/search/search_user_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/user/search_user_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/search_user_view/components/search_profile_card.dart';

// ignore: must_be_immutable
class SearchUserView extends StatelessWidget {
  SearchUserView({Key? key}) : super(key: key);

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  TextEditingController searchTextController = TextEditingController();
  SearchUserController searchUserController = Get.find();
  UserStateController userStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    searchUserController.searchUserRequest.text = "";
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
            ),
            child: SvgPicture.asset(
              height: 24.h,
              width: 24.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Kullanıcı Ara",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchBar(),
            16.h.spaceY,
            GetBuilder<SearchUserController>(
              id: 'search',
              builder: (GetxController controller) {
                return FutureBuilder<SearchUserResponse?>(
                  future: GeneralServicesTemp().makePostRequest(
                    '/users/search-user',
                    searchUserController.searchUserRequest,
                    {
                      'Authorization':
                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                      'Content-Type': 'application/json',
                    },
                  ).then(
                    (value) => SearchUserResponse.fromJson(
                      json.decode(value!),
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data!.isEmpty) {
                        return Center(
                          child: UiHelper.notFoundAnimationWidget(
                              context, 'Kullanıcı bulunamadı...'),
                        );
                      } else {
                        return snapshot
                                .data!.data![0].searchResult!.result!.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.data![0].searchResult!
                                    .result!.length,
                                itemBuilder: (context, index) {
                                  var user = snapshot.data!.data![0]
                                      .searchResult!.result![index];
                                  return Column(
                                    children: [
                                      SearchProfileCard(
                                        onPress: () {
                                          if (LocaleManager.instance
                                                  .getInt(PreferencesKeys
                                                      .currentUserId)
                                                  .toString() ==
                                              user.id.toString()) {
                                            Get.back();
                                            bottomNavigationBarController
                                                .selectedIndex.value = 3;
                                          } else {
                                            Get.toNamed('/otherprofiles',
                                                arguments: user.id);
                                          }
                                        },
                                        nickName: user.username!,
                                        name: user.name!,
                                        allRoute: user.routeCount!,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: UiHelper.notFoundAnimationWidget(
                                    context, 'Kullanıcı bulunamadı...'),
                              );
                      }
                    } else {
                      return Center(
                        child: UiHelper.loadingAnimationWidget(context),
                      );
                    }
                  },
                );
              },
            ),
            30.h.spaceY,
          ],
        ),
      ),
    );
  }

  Padding searchBar() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
      child: Container(
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
              child: Center(
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: searchTextController,
                  onChanged: (value) {
                    searchUserController.searchRequestText =
                        searchTextController.text;

                    searchUserController.searchUserRequest.text =
                        searchUserController.searchRequestText;
                    searchUserController.update(['search']);

                    GeneralServicesTemp()
                        .makePostRequest(
                          '/users/search-user',
                          searchUserController.searchUserRequest,
                          ServicesConstants.appJsonWithToken,
                        )
                        .then(
                          (value) => SearchUserResponse.fromJson(
                            json.decode(value!),
                          ),
                        );
                  },
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
                    contentPadding: EdgeInsets.zero,
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Kullanıcı ara',
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: SvgPicture.asset(
                        width: 12.w,
                        'assets/icons/search-icon.svg',
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Sflight',
                      color: AppConstants().ltDarkGrey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
