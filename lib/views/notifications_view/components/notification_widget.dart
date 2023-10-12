import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:flutter/gestures.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key,
      required this.notificationType,
      required this.name,
      required this.postPhotoUrl,
      required this.profilePhotoUrl,
      this.onTap,
      this.profilePhotoOnTap,
      this.nameOnTap,
      required this.color});

  final int notificationType;
  final String name;
  final String profilePhotoUrl;
  final String postPhotoUrl;
  final void Function()? onTap;
  final void Function()? profilePhotoOnTap;
  final void Function()? nameOnTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: AppConstants().ltWhiteGrey,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ProfilePhoto(
                  onTap: profilePhotoOnTap,
                  height: 48.h,
                  width: 48.w,
                  url: profilePhotoUrl,
                ),
              ),
              SizedBox(
                width: 222.w,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: name,
                        style: TextStyle(
                            fontFamily: 'Sfbold',
                            color: AppConstants().ltLogoGrey),
                        recognizer: TapGestureRecognizer()..onTap = nameOnTap),
                    TextSpan(text: "  "),
                    TextSpan(
                      text: 'adlı kullanıcı ',
                      style: TextStyle(
                        fontFamily: 'Sfmedium',
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                    TextSpan(
                      text: notificationType == 1
                          ? 'seni takip etmeye başladı'
                          : notificationType == 2
                              ? 'yeni bir yolculuğa başladı'
                              : notificationType == 3
                                  ? 'gönderine yorum yaptı'
                                  : notificationType == 99
                                      ? "selektör yaptı"
                                      : 'gönderini beğendi',
                      style: TextStyle(
                        fontFamily: 'Sfmedium',
                        color: AppConstants().ltDarkGrey,
                      ),
                    ),
                  ]),
                ),
              ),
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Container(
                    child: notificationType == 3
                        ? Image.network(
                            postPhotoUrl,
                            height: 30.h,
                            width: 30.w,
                          )
                        : notificationType == 4
                            ? Image.network(
                                postPhotoUrl,
                                height: 30.h,
                                width: 30.w,
                              )
                            : notificationType == 1
                                ? SvgPicture.asset(
                                    'assets/icons/been-added-user-icon.svg',
                                    height: 30.h,
                                    width: 30.w,
                                    color: color,
                                  )
                                : notificationType == 99
                                    ? SizedBox()
                                    : SvgPicture.asset(
                                        'assets/icons/route-icon.svg',
                                        height: 30.h,
                                        width: 30.w,
                                        color: AppConstants().ltMainRed,
                                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
        10.h.spaceY
      ],
    );
  }
}
