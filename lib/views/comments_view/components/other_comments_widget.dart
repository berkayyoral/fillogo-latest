import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:flutter/gestures.dart';

class OtherComments extends StatelessWidget {
  OtherComments(
      {Key? key,
      required this.url,
      required this.beforeHours,
      required this.likeCount,
      required this.name,
      required this.content,
      required this.didILiked,
      this.onTap})
      : super(key: key);

  final String url;
  final String name;
  final String content;
  final String beforeHours;
  final int likeCount;
  final bool didILiked;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var likeControll = didILiked == true ? true.obs : false.obs;

    // var likeCount = othersLikeCount.obs;

    return Padding(
      padding: EdgeInsets.all(10.w),
      child: ListTile(
        leading: GestureDetector(
          onTap: onTap,
          child: ProfilePhoto(
            height: 50.h,
            width: 50.w,
            url: url,
          ),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = onTap,
                  text: name,
                  style: TextStyle(
                      fontFamily: "Sfsemibold",
                      fontSize: 14.sp,
                      color: AppConstants().ltLogoGrey)),
              TextSpan(
                  text: "     ",
                  style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 14.sp,
                      color: AppConstants().ltLogoGrey)),
              TextSpan(
                  text: content,
                  style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 14.sp,
                      color: AppConstants().ltLogoGrey))
            ],
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              Text(
                "${beforeHours}",
                style: TextStyle(
                  fontFamily: "Sfmedium",
                  fontSize: 12.sp,
                  color: AppConstants().ltDarkGrey,
                ),
              ),
              15.w.spaceX,
              Text(likeCount.toString(),
                  style: TextStyle(
                      fontFamily: "Sfmedium",
                      fontSize: 12.sp,
                      color: AppConstants().ltDarkGrey)),
              Text(
                " beğenme",
                style: TextStyle(
                    fontFamily: "Sfmedium",
                    fontSize: 12.sp,
                    color: AppConstants().ltDarkGrey),
              ),
            ],
          ),
        ),
        trailing: Visibility(
          visible: false,
          child: Obx(
            () => IconButton(
              icon: likeControll.value == true
                  ? SvgPicture.asset(
                      'assets/icons/like-icon.svg',
                      height: 20.h,
                      color: AppConstants().ltMainRed,
                    )
                  : SvgPicture.asset(
                      "assets/icons/heart.svg",
                      color: AppConstants().ltDarkGrey,
                      height: 20.h,
                    ),
              onPressed: () {
                likeControll.value = likeControll.value == true ? false : true;
              },
            ),
          ),
        ),
      ),
    );
  }
}
