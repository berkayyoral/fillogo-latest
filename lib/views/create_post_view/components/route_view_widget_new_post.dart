import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/create_post_view/components/mfuController.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';

class RouteViewWidgetNewPostPage extends StatelessWidget {
  RouteViewWidgetNewPostPage({
    super.key,
    required this.userName,
    required this.routeContent,
    required this.routeStartDate,
    required this.routeEndDate,
    required this.closeButtonVisible,
    // required this.routeId,
  });

  final String userName;
  // final int routeId;
  final String routeContent;
  final String routeStartDate;
  final String routeEndDate;
  final bool closeButtonVisible;

  CreatePostPageController createPostPageController =
      Get.put(CreatePostPageController());
  MfuController mfuController = Get.find();

  CreateRouteController createRouteController = Get.find();
  @override
  Widget build(BuildContext context) {
    log("CREATEPOST ROUTE ${createPostPageController.routeContent}");
    return Container(
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
                        mfuController.sehirler.value,
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
                            routeStartDate,
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
                            '-',
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
                            routeEndDate,
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
          Visibility(
            visible: closeButtonVisible,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              child: GestureDetector(
                onTap: () async {
                  createPostPageController.changeHaveRoute(0);
                },
                child: SvgPicture.asset(
                  'assets/icons/close-icon.svg',
                  height: 24.w,
                  width: 24.w,
                  color: AppConstants().ltMainRed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
