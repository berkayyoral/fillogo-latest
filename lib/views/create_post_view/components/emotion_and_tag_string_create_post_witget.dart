import 'package:fillogo/export.dart';

class EmotionAndTagStringCreatePost extends StatelessWidget {
  const EmotionAndTagStringCreatePost({
    super.key,
    required this.name,
    required this.usersTagged,
    required this.emotion,
    required this.emotionContent,
    required this.haveTag,
    required this.haveEmotion,
  });
  final String name;
  final List usersTagged;
  final String emotion;
  final String emotionContent;
  final int haveTag;
  final bool haveEmotion;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268.w,
      child: Wrap(
        runSpacing: 2.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$name   ",
                  style: TextStyle(
                      fontFamily: "Sfbold",
                      fontSize: 16.sp,
                      color: AppConstants().ltLogoGrey),
                ),
              ],
            ),
          ),
          Visibility(
            visible: (haveTag == 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ((haveTag == 1) && (usersTagged.isNotEmpty))
                        ? usersTagged[0].name
                        : '',
                    style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 13.sp,
                      color: AppConstants().ltLogoGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ve",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " diğer",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ${(usersTagged.length - 1).toString()}",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged.length > 1),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " kişi",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged.isNotEmpty),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " ile",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (usersTagged.isNotEmpty),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: " birlikte  ",
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 13.sp,
                        color: AppConstants().ltLogoGrey),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (haveEmotion),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 10.r,
              child: Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(emotion),
                  ),
                  color: AppConstants().ltMainRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Visibility(
            visible: (haveEmotion),
            child: Text(
              "  $emotionContent",
              style: TextStyle(
                fontFamily: "Sflight",
                fontSize: 13.sp,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
