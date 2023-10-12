import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';

class AddNewPropertyNotContentCreatePost extends StatelessWidget {
  AddNewPropertyNotContentCreatePost({super.key});

  CreatePostPageController createPostPageController =
      Get.find<CreatePostPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 80.h,
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
            ]),
        margin: EdgeInsets.only(
          top: 640.h,
          left: 0.w,
          right: 0.w,
          bottom: 0.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(
                20.w,
              ),
              child: InkWell(
                onTap: () async {
                  createPostPageController.havePostPhoto.value = 1;
                  //Get.toNamed('/createPostPageAddPhoto');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ShowAllertDialogWidget(
                      button1Color: AppConstants().ltMainRed,
                      button1Height: 50.h,
                      button1IconPath: '',
                      button1Text: 'Tamam',
                      button1TextColor: AppConstants().ltWhite,
                      button1Width: Get.width,
                      buttonCount: 1,
                      discription1:
                          "Tebrikler seçmiş olduğunuz fotoğrafınız başarıyla gönderinize eklendi.",
                      onPressed1: () {
                        Get.back();
                      },
                      title: 'Fotoğrafınız Başarıyla eklendi',
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/gallery-add.svg',
                  height: 28.w,
                  width: 28.w,
                  color: (createPostPageController.havePostPhoto.value == 1)
                      ? AppConstants().ltMainRed
                      : AppConstants().ltLogoGrey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                20.w,
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/createPostPageAddRoute');
                },
                child: SvgPicture.asset(
                  'assets/icons/route-icon.svg',
                  height: 28.w,
                  width: 28.w,
                  color: (createPostPageController.haveRoute.value == 1)
                      ? AppConstants().ltMainRed
                      : AppConstants().ltLogoGrey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                20.w,
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/createPostPageAddTags');
                },
                child: SvgPicture.asset(
                  'assets/icons/add-tag-icon.svg',
                  height: 28.w,
                  width: 28.w,
                  color: (createPostPageController.haveTag.value == 1)
                      ? AppConstants().ltMainRed
                      : AppConstants().ltLogoGrey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                20.w,
              ),
              child: InkWell(
                onTap: () {
                  Get.toNamed('/createPostPageAddEmotion');
                },
                child: SvgPicture.asset(
                  'assets/icons/add-emotion-icon.svg',
                  height: 28.w,
                  width: 28.w,
                  color: (createPostPageController.isSelectedEmotion.value)
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
