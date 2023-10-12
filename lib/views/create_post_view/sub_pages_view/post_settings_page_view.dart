import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PostSettingsPageView extends StatelessWidget {
  PostSettingsPageView({super.key});

  CreatePostPageController createPostStatusController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
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
          "Gönderi Tercihleri",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                  height: 70.h,
                  width: 341.w,
                  child: ListTile(
                    title: Text(
                      'Yorumlar',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 14.sp,
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                    subtitle: Text(
                      'Gönderiniz yorumlara açık olacak',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 12.sp,
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                    trailing: Obx(
                      () => SizedBox(
                        width: 44.w,
                        height: 28.h,
                        child: FlutterSwitch(
                          activeToggleColor:
                              const Color.fromARGB(255, 107, 221, 69),
                          inactiveToggleColor: AppConstants().ltDarkGrey,
                          inactiveColor: AppConstants().ltWhiteGrey,
                          activeColor: AppConstants().ltWhiteGrey,
                          showOnOff: false,
                          toggleSize: 26.w,
                          padding: 0.w,
                          borderRadius: 16.r,
                          value: createPostStatusController.commentStatus.value,
                          onToggle: (val) {
                            createPostStatusController.changeCommentStatus(val);
                            // createPostStatusController.commentStatus.value =
                            //     val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                  height: 70.h,
                  width: 341.w,
                  child: ListTile(
                    title: Text(
                      'Gizlilik',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 14.sp,
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                    subtitle: Text(
                      'Gönderinizi sadece arkadaşlarınız görecek',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 12.sp,
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                    trailing: Obx(
                      () => SizedBox(
                        width: 44.w,
                        height: 28.h,
                        child: FlutterSwitch(
                          activeToggleColor:
                              const Color.fromARGB(255, 107, 221, 69),
                          inactiveToggleColor: AppConstants().ltDarkGrey,
                          inactiveColor: AppConstants().ltWhiteGrey,
                          activeColor: AppConstants().ltWhiteGrey,
                          showOnOff: false,
                          toggleSize: 26.w,
                          padding: 0.w,
                          borderRadius: 16.r,
                          value: createPostStatusController.secureStatus.value,
                          onToggle: (val) {
                            createPostStatusController.secureStatus.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                  height: 70.h,
                  width: 341.w,
                  child: ListTile(
                    title: Text(
                      'Paylaşım İzinleri',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 14.sp,
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                    subtitle: Text(
                      'Gönderiniz başka kişilerle paylaşıma açık olacak',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 12.sp,
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                    trailing: Obx(
                      () => SizedBox(
                        width: 44.w,
                        height: 28.h,
                        child: FlutterSwitch(
                          activeToggleColor:
                              const Color.fromARGB(255, 107, 221, 69),
                          inactiveToggleColor: AppConstants().ltDarkGrey,
                          inactiveColor: AppConstants().ltWhiteGrey,
                          activeColor: AppConstants().ltWhiteGrey,
                          showOnOff: false,
                          toggleSize: 26.w,
                          padding: 0.w,
                          borderRadius: 16.r,
                          value: createPostStatusController.sharedStatus.value,
                          onToggle: (val) {
                            createPostStatusController.sharedStatus.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                  height: 70.h,
                  width: 341.w,
                  child: ListTile(
                    title: Text(
                      'Beğeniler',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 14.sp,
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                    subtitle: Text(
                      'Gönderiniz beğenilere açık olacak',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 12.sp,
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                    trailing: Obx(
                      () => SizedBox(
                        width: 44.w,
                        height: 28.h,
                        child: FlutterSwitch(
                          activeToggleColor:
                              const Color.fromARGB(255, 107, 221, 69),
                          inactiveToggleColor: AppConstants().ltDarkGrey,
                          inactiveColor: AppConstants().ltWhiteGrey,
                          activeColor: AppConstants().ltWhiteGrey,
                          showOnOff: false,
                          toggleSize: 26.w,
                          padding: 0.w,
                          borderRadius: 16.r,
                          value: createPostStatusController.likedStatus.value,
                          onToggle: (val) {
                            createPostStatusController.likedStatus.value = val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: SizedBox(
                  height: 70.h,
                  width: 341.w,
                  child: ListTile(
                    title: Text(
                      'Hikayeye Ekleme',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 14.sp,
                        color: AppConstants().ltLogoGrey,
                      ),
                    ),
                    subtitle: Text(
                      'Gönderiniz hikayeye eklemeye açık olacak',
                      style: TextStyle(
                        fontFamily: 'Sfbold',
                        fontSize: 12.sp,
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                    trailing: Obx(
                      () => SizedBox(
                        width: 44.w,
                        height: 28.h,
                        child: FlutterSwitch(
                          activeToggleColor:
                              const Color.fromARGB(255, 107, 221, 69),
                          inactiveToggleColor: AppConstants().ltDarkGrey,
                          inactiveColor: AppConstants().ltWhiteGrey,
                          activeColor: AppConstants().ltWhiteGrey,
                          showOnOff: false,
                          toggleSize: 26.w,
                          padding: 0.w,
                          borderRadius: 16.r,
                          value:
                              createPostStatusController.addedStoryStatus.value,
                          onToggle: (val) {
                            createPostStatusController.addedStoryStatus.value =
                                val;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
