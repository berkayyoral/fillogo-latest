import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:fillogo/views/route_details_page_view/components/route_details_page_controller.dart';

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
    required this.isActiveRoute,
    required this.matchedOn,
  });

  final MatchedOn? matchedOn;
  final int userId;
  final int id;
  final String userName;
  final String startAdress;
  final String endAdress;
  final String startDateTime;
  final String endDateTime;
  final String profilePhotoUrl;
  final bool isActiveRoute;

  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();
  RouteDetailsPageController routeDetailsPageController =
      Get.put(RouteDetailsPageController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: () async {
          RouteDetailsPageController routeDetailsPageController =
              Get.put(RouteDetailsPageController());
          selectedRouteController.selectedRouteId.value = id;
          selectedRouteController.selectedRouteUserId.value = userId;
          selectedRouteController.matchedOn = matchedOn;
          routeDetailsPageController.markers.clear();
          await routeDetailsPageController.getRouteDetailsById(id);
          await routeDetailsPageController.getMyCurrentLocation();
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 330.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ProfilePhoto(
                        height: 46.h,
                        width: 46.w,
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
                              padding: const EdgeInsets.only(),
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
                    Expanded(
                      child: Visibility(
                        visible: isActiveRoute,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 5.r,
                            ),
                            2.w.horizontalSpace,
                            Text(
                              "Aktif Rota",
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 5.w,
                      ),
                      child: GestureDetector(
                        onTap: () async {},
                        child: SvgPicture.asset(
                          'assets/icons/arrow-right.svg',
                          height: 20.w,
                          width: 20.w,
                          color: AppConstants().ltDarkGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
