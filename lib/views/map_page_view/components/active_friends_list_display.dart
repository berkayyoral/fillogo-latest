import '../../../export.dart';
import '../../../widgets/profilePhoto.dart';
import '../../route_details_page_view/components/selected_route_controller.dart';

class ActivesFriendsRoutesCard extends StatelessWidget {
  ActivesFriendsRoutesCard({
    super.key,
    required this.userId,
    required this.userName,
    required this.id,
    required this.startAdress,
    required this.endAdress,
    required this.startDateTime,
    required this.endDateTime,
    required this.profilePhotoUrl,
  });
  final int userId;
  final int id;
  final String userName;
  final String startAdress;
  final String endAdress;
  final String startDateTime;
  final String endDateTime;
  final String profilePhotoUrl;

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: () async {
          
          selectedRouteController.selectedRouteId.value = id;
          selectedRouteController.selectedRouteUserId.value = userId;
          Get.toNamed(NavigationConstants.routeDetails);
        },
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8.r,
              ),
            ),
            color: AppConstants().ltWhiteGrey,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 290.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ProfilePhoto(
                        height: 48.h,
                        width: 48.w,
                        url: profilePhotoUrl,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.w,
                            right: 10.w,
                          ),
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                              color: AppConstants().ltDarkGrey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.w,
                            right: 10.w,
                          ),
                          child: Text(
                            "$startAdress -> $endAdress",
                            style: TextStyle(
                              fontFamily: 'Sfmedium',
                              fontSize: 14.sp,
                              color: AppConstants().ltLogoGrey,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 4.w,
                                right: 4.w,
                              ),
                              child: Text(
                                startDateTime,
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 12.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 12.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 4.w,
                                right: 10.w,
                              ),
                              child: Text(
                                endDateTime,
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 12.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                child: GestureDetector(
                  onTap: () async {},
                  child: SvgPicture.asset(
                    'assets/icons/arrow-right.svg',
                    height: 24.w,
                    width: 24.w,
                    color: AppConstants().ltDarkGrey,
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
