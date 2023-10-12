import 'dart:convert';

import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/following/search_following_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();
    ChatController chatController = Get.find();
    UserStateController userStateController = Get.find();

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
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextField(
                  onChanged: (value) {
                    chatController.searchRequestText =
                        searchTextController.text;

                    chatController.searchFollowingRequest.text =
                        chatController.searchRequestText;
                    chatController.update(['search']);

                    GeneralServicesTemp()
                        .makePostRequest(
                          '/users/search-followings',
                          chatController.searchFollowingRequest,
                          ServicesConstants.appJsonWithToken,
                        )
                        .then(
                          (value) => SearchFollowingResponse.fromJson(
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
                    hintText: 'Kullanıcı ara',
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Sflight',
                      color: AppConstants().ltDarkGrey,
                    ),
                  ),
                ),
              ),
            ),
            FittedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 13.h, bottom: 13.h),
                child: SvgPicture.asset(
                  height: 24.h,
                  width: 24.w,
                  'assets/icons/search-icon.svg',
                  color: AppConstants().ltLogoGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
