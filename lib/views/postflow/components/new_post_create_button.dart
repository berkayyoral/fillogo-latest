import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/testFolder/test19/route_api_services.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

class NewPostCreateButtonView extends StatelessWidget {
  NewPostCreateButtonView({super.key});

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  GetPollylineRequest getPollylineRequest = GetPollylineRequest();
  CreatePostPageController createPostPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              bottomNavigationBarController.selectedIndex.value = 3;
            },
            child: ProfilePhoto(
                height: 48.h,
                width: 48.w,
                url: LocaleManager.instance.getString(
                      PreferencesKeys.currentUserProfilPhoto,
                    ) ??
                    'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png'),
          ),
          12.w.spaceX,
          GestureDetector(
            onTap: () {
              createPostPageController.routeId.value == 0;
              createPostPageController.routeId.value == 0;
              createPostPageController.userName.value = LocaleManager.instance
                  .getString(PreferencesKeys.currentUserUserName)!;
              createPostPageController.userPhoto.value = LocaleManager.instance
                  .getString(PreferencesKeys.currentUserProfilPhoto)!;
              final newPost = Get.toNamed('/createPostPage');

              print(
                  "POOSSTTTNEWW 1-> ${createPostPageController.routeId.value}");
            },
            child: Container(
              width: 281.w,
              height: 48.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppConstants().ltLogoGrey.withOpacity(0.2),
                    spreadRadius: 0.r,
                    blurRadius: 10.r,
                  ),
                ],
                color: AppConstants().ltWhite,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12.w,
                      bottom: 12.h,
                      top: 12.h,
                    ),
                    child: Text(
                      "Ne düşünüyorsunuz?",
                      style: TextStyle(
                        color: AppConstants().ltLogoGrey,
                        fontFamily: "SfLight",
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 12.w,
                      bottom: 12.h,
                      top: 12.h,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/gallery-add.svg',
                      color: AppConstants().ltMainRed,
                      height: 24.h,
                      width: 24.w,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
