import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fillogo/export.dart';
import 'package:lottie/lottie.dart';

class UiHelper {
  static const Size designSize = Size(375, 812);

  static TextStyle headline1 = TextStyle(
    fontSize: 24.sp,
  );

  static SizedBox defaultSpaceHeight = SizedBox(
    height: 12.h,
  );

  static SizedBox defaultSpaceWidth = SizedBox(
    height: 12.w,
  );

  static void showWarningSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1600,
        ),
        content: ListTile(
          leading: Icon(
            Icons.error_rounded,
            color: Colors.redAccent,
            size: 24.w,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          title: RichText(
            text: TextSpan(
              text: message,
              style: TextStyle(
                fontFamily: FontConstants.sfSemiBold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1600,
        ),
        content: ListTile(
          leading: Icon(
            Icons.thumb_up_rounded,
            color: Colors.greenAccent,
            size: 24.w,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 8.w,
          ),
          title: RichText(
            text: TextSpan(
              text: message,
              style: TextStyle(
                fontFamily: FontConstants.sfSemiBold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showLoadingAnimation() {
    Get.dialog(Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            'assets/json/loading_animation.json',
            width: 140.w,
            height: 140.w,
          ),
          12.h.spaceY,
          SizedBox(
            height: 30.h,
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: FontConstants.sfSemiBold,
                color: AppConstants().ltMainRed,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText('Yükleniyor...'),
                ],
                repeatForever: true,
              ),
            ),
          ),
          12.h.spaceY,
        ],
      ),
    ));
  }

  static Widget loadingAnimationWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset(
          'assets/json/loading_animation.json',
          width: 140.w,
          height: 140.w,
        ),
        12.h.spaceY,
        SizedBox(
          height: 30.h,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: FontConstants.sfSemiBold,
              color: AppConstants().ltMainRed,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                FadeAnimatedText('Yükleniyor...'),
              ],
              repeatForever: true,
            ),
          ),
        ),
        12.h.spaceY,
      ],
    );
  }

  static Widget notFoundAnimationWidget(BuildContext context, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottieBuilder.asset(
          'assets/json/not_found_animation.json',
          width: 140.w,
          height: 140.w,
        ),
        12.h.spaceY,
        SizedBox(
          height: 30.h,
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: FontConstants.sfSemiBold,
              color: AppConstants().ltDarkGrey,
            ),
            child: Text(text),
          ),
        ),
        12.h.spaceY,
      ],
    );
  }
}

extension SpaceXY on double {
  SizedBox get spaceX => SizedBox(
        width: this,
      );
  SizedBox get spaceY => SizedBox(
        height: this,
      );
}
