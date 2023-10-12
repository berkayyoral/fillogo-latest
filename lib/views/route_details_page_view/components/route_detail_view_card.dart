import 'package:fillogo/views/route_details_page_view/components/route_details_page_controller.dart';

import '../../../export.dart';
import '../../../widgets/popup_view_widget.dart';

class RouteDatailsPageRouteCard extends StatelessWidget {
  RouteDatailsPageRouteCard({
    super.key,
    required this.userName,
    required this.id,
    required this.startAdress,
    required this.endAdress,
    required this.startDateTime,
    required this.endDateTime,
  });
  final int id;
  final String userName;
  final String startAdress;
  final String endAdress;
  final String startDateTime;
  final String endDateTime;

  RouteDetailsPageController routeDetailsPageController =
      Get.find<RouteDetailsPageController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20),
      child: GestureDetector(
        onTap: () async {},
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
              Container(
                width: 290.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/route-icon.svg',
                        height: 40.w,
                        width: 40.w,
                        color: AppConstants().ltMainRed,
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
                              fontSize: 14.sp,
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
                              fontSize: 16.sp,
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
                                "Tahmini ${startDateTime} ",
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 14.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                've',
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 14.sp,
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
                                "${endDateTime}",
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 14.sp,
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
            ],
          ),
        ),
      ),
    );
  }
}
