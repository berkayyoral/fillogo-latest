import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

class SearchProfileCard extends StatelessWidget {
  const SearchProfileCard({
    Key? key,
    required this.allRoute,
    required this.name,
    required this.nickName,
    this.onPress,
    this.profilPhoto,
  }) : super(key: key);

  final String nickName;
  final String name;
  final int allRoute;
  final Function()? onPress;
  final String? profilPhoto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants().ltWhiteGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: InkWell(
        onTap: onPress, // profile git
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProfilePhoto(
                    height: 48.h,
                    width: 48.w,
                    url: profilPhoto ??
                        'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png',
                  ),
                  10.w.spaceX,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nickName,
                        style: TextStyle(
                          color: AppConstants().ltDarkGrey,
                          fontFamily: 'Sflight',
                          fontSize: 12.sp,
                        ),
                      ), //userTitle
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: AppConstants().ltBlack,
                          fontFamily: 'Sfbold',
                          fontSize: 14.sp,
                        ),
                      ), // fullname
                      2.h.spaceY,
                      Text(
                        "Yolculuklar: $allRoute",
                        style: TextStyle(
                          color: AppConstants().ltDarkGrey,
                          fontFamily: 'Sflight',
                          fontSize: 12.sp,
                        ),
                      ), // is follow
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                'assets/icons/next-icon.svg',
                height: 16.h,
                width: 16.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
