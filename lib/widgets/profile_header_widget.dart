import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({
    super.key,
    this.isMyProfile = false,
    this.profilePictureUrl,
    this.coverPictureUrl,
    this.onTapEditProfilePicture,
    this.onTapEditCoverPicture,
  });

  final bool isMyProfile;
  final String? profilePictureUrl;
  final String? coverPictureUrl;
  final VoidCallback? onTapEditProfilePicture;
  final VoidCallback? onTapEditCoverPicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 210.h,
      color: AppConstants().ltWhite,
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: 190.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppConstants().ltLogoGrey.withOpacity(0.2),
                  spreadRadius: 0.r,
                  //blurRadius: 15.r,
                ),
              ],
              image: DecorationImage(
                  image: NetworkImage(
                    coverPictureUrl ??
                        'https://firebasestorage.googleapis.com/v0/b/fillogo-8946b.appspot.com/o/stories%2F1690375016005_image_cropper_B9E5E237-22E9-4850-929B-0B5A133F2023-66909-00029AF97736A997.jpg?alt=media&token=fc9dd12c-bd38-4a12-9cd8-dfbcec06d7c1',
                  ),
                  fit: BoxFit.cover),
              color: AppConstants().ltWhite,
              //borderRadius: BorderRadius.circular(0.r),
            ),
          ),
          Container(
            width: Get.width,
            height: 190.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppConstants().ltBlack,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
              //borderRadius: BorderRadius.circular(0.r),
            ),
          ),
          Positioned(
            top: 12.h,
            left: 24.w,
            child: SizedBox(
              width: 132.w,
              height: 144.h,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/kalkan-full-icon.svg',
                      height: 144.h,
                      width: 132.w,
                      color: AppConstants().ltMainRed,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ProfilePhoto(
                      height: 124.h,
                      width: 112.w,
                      url: profilePictureUrl, //'https://picsum.photos/150',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isMyProfile,
            child: Positioned(
              left: 108.w,
              top: 112.h,
              child: GestureDetector(
                onTap: onTapEditProfilePicture ?? () {},
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  decoration: BoxDecoration(
                    color: AppConstants().ltMainRed,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      6.w,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/camera-icon.svg',
                      height: 20.h,
                      width: 20.w,
                      color: AppConstants().ltWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isMyProfile,
            child: Positioned(
              left: 328.w,
              top: 172.h,
              child: GestureDetector(
                onTap: onTapEditCoverPicture ??
                    () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            ShowAllertDialogWidget(
                          button1Color: AppConstants().ltMainRed,
                          button1Height: 50.h,
                          button1IconPath: '',
                          button1Text: 'Tamam',
                          button1TextColor: AppConstants().ltWhite,
                          button1Width: Get.width,
                          buttonCount: 1,
                          discription1:
                              "Tebrikler seçmiş olduğunuz kapak fotoğrafınız başarıyla güncellendi.",
                          onPressed1: () {
                            Get.back();
                          },
                          title: 'Kapak Fotoğrafı Güncellendi',
                        ),
                      );
                    },
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  decoration: BoxDecoration(
                    color: AppConstants().ltMainRed,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      6.w,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/camera-icon.svg',
                      height: 20.h,
                      width: 20.w,
                      color: AppConstants().ltWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
