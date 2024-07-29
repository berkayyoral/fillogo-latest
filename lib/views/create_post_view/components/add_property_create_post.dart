import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/core/init/bussiness_helper/bussiness_helper.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

class AddNewPropertyCreatePost extends StatefulWidget {
  const AddNewPropertyCreatePost({super.key});

  @override
  State<AddNewPropertyCreatePost> createState() =>
      _AddNewPropertyCreatePostState();
}

class _AddNewPropertyCreatePostState extends State<AddNewPropertyCreatePost> {
  CreatePostPageController createPostPageController =
      Get.find<CreatePostPageController>();

  MediaPickerController mediaPickerController =
      Get.put(MediaPickerController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 250.h,
        width: 375.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.r),
          color: AppConstants().ltWhite,
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(
                    0.2.r,
                  ),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0.w, 0.w),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          top: 500.h,
          left: 0.w,
          right: 0.w,
          bottom: 0.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.w,
                ),
                child: InkWell(
                  onTap: () async {
                    mediaPickerController.media =
                        await BussinessHelper.pickFile(context).then((value) {
                      if (value != null) {
                        Logger().e("Yes Picked");

                        //log('file picked ${value.name}');
                        mediaPickerController.isMediaPicked = true;
                        createPostPageController.havePostPhoto.value = 1;

                        if (value.name.split('.').last == 'mp4') {
                          mediaPickerController.isVideo = true;
                        } else {
                          mediaPickerController.isVideo = false;
                        }
                      } else {
                        mediaPickerController.isVideo = false;
                      }

                      return value;
                    });

                    setState(() {});
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/gallery-add.svg',
                        height: 28.w,
                        width: 28.w,
                        color:
                            (createPostPageController.havePostPhoto.value == 1)
                                ? AppConstants().ltMainRed
                                : AppConstants().ltLogoGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                        ),
                        child: Text(
                          'Fotoğraf / video ekle',
                          style: TextStyle(
                            fontFamily: 'Sfmedium',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.w,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/createPostPageAddRoute');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/route-icon.svg',
                        height: 28.w,
                        width: 28.w,
                        color: (createPostPageController.haveRoute.value == 1)
                            ? AppConstants().ltMainRed
                            : AppConstants().ltLogoGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                        ),
                        child: Text(
                          'Rota ekle',
                          style: TextStyle(
                            fontFamily: 'Sfmedium',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.w,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/createPostPageAddTags');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/add-tag-icon.svg',
                        height: 28.w,
                        width: 28.w,
                        color: (createPostPageController.haveTag.value == 1)
                            ? AppConstants().ltMainRed
                            : AppConstants().ltLogoGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                        ),
                        child: Text(
                          'Kişileri etiketle',
                          style: TextStyle(
                            fontFamily: 'Sfmedium',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.w,
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/createPostPageAddEmotion');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/add-emotion-icon.svg',
                        height: 28.w,
                        width: 28.w,
                        color:
                            (createPostPageController.isSelectedEmotion.value)
                                ? AppConstants().ltMainRed
                                : AppConstants().ltLogoGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                        ),
                        child: Text(
                          'His / hareket ekle',
                          style: TextStyle(
                            fontFamily: 'Sfmedium',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                      ),
                    ],
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
