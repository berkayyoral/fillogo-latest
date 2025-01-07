import 'package:fillogo/export.dart';

class FollowersCountRowWidget extends StatelessWidget {
  const FollowersCountRowWidget({
    super.key,
    required this.followersCount,
    required this.followedCount,
    required this.routesCount,
    required this.onTapFollowers,
    required this.onTapFollowed,
    required this.onTapRoutes,
  });

  final String followersCount;
  final String followedCount;
  final String routesCount;
  final VoidCallback onTapFollowers;
  final VoidCallback onTapFollowed;
  final VoidCallback onTapRoutes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: onTapFollowers,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.h,
                  ),
                  child: Text(
                    'Takipçilerim',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Sfmedium',
                      color: AppConstants().ltDarkGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.h,
                  ),
                  child: Text(
                    followersCount,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Sfbold',
                      color: AppConstants().ltLogoGrey,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTapFollowed,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.h,
                  ),
                  child: Text(
                    'Takip Ettiklerim',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Sfmedium',
                      color: AppConstants().ltDarkGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.h,
                  ),
                  child: Text(
                    followedCount,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Sfbold',
                      color: AppConstants().ltLogoGrey,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // InkWell(
          //   onTap: onTapRoutes,
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(
          //           top: 4.h,
          //         ),
          //         child: Text(
          //           'Rotalarım',
          //           textAlign: TextAlign.start,
          //           style: TextStyle(
          //             fontFamily: 'Sfmedium',
          //             color: AppConstants().ltDarkGrey,
          //             fontSize: 14.sp,
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(
          //           top: 4.h,
          //         ),
          //         child: Text(
          //           routesCount,
          //           textAlign: TextAlign.start,
          //           style: TextStyle(
          //             fontFamily: 'Sfbold',
          //             color: AppConstants().ltLogoGrey,
          //             fontSize: 16.sp,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
