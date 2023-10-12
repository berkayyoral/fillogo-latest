import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

class MyComment extends StatelessWidget {
  const MyComment(
      {Key? key,
      required this.beforeHours,
      required this.content,
      required this.name,
      required this.url})
      : super(key: key);

  final String url;
  final String name;
  final String content;
  final int beforeHours;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: ListTile(
        leading: ProfilePhoto(
          height: 50.h,
          width: 50.w,
          url: url,
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
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
          padding: EdgeInsets.only(top: 5.h),
          child: Row(
            children: [
              Text(beforeHours.toString(),
                  style: TextStyle(
                      fontFamily: "Sfmedium",
                      fontSize: 12.sp,
                      color: AppConstants().ltDarkGrey)),
              Text(" saat önce",
                  style: TextStyle(
                      fontFamily: "Sfmedium",
                      fontSize: 12.sp,
                      color: AppConstants().ltDarkGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
