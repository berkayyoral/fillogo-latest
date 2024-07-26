import 'dart:convert';

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/create_route_post_models.dart';
import 'package:fillogo/models/routes_models/delete_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/date_picker_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/route_description_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/vehicle_type_widget.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateRouteInfoWidget extends StatelessWidget {
  const CreateRouteInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateRouteController createRouteController = Get.find();
    final MapPageMController mapPageController = Get.find();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SvgPicture.asset(
                  'assets/icons/route-icon.svg',
                  color: AppConstants().ltMainRed,
                  height: 32.h,
                  width: 32.w,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Text(
                      'Rota',
                      style: TextStyle(
                        color: AppConstants().ltDarkGrey,
                        fontFamily: 'Sflight',
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          createRouteController.startRouteCity,
                          style: TextStyle(
                            color: AppConstants().ltLogoGrey,
                            fontFamily: 'Sfmedium',
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          ' -> ',
                          style: TextStyle(
                            color: AppConstants().ltLogoGrey,
                            fontFamily: 'Sfmedium',
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          createRouteController.finishRouteCity,
                          style: TextStyle(
                            color: AppConstants().ltLogoGrey,
                            fontFamily: 'Sfmedium',
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Row(
                        children: [
                          Text(
                            "Tahmini: ",
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            "${createRouteController.calculatedRouteDistance.value} km",
                            style: TextStyle(
                              color: AppConstants().ltBlack,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            " ve ",
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            createRouteController.calculatedRouteTime.value,
                            style: TextStyle(
                              color: AppConstants().ltBlack,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => createRouteController.isOpenRouteDetailEntrySection.value
                ? SingleChildScrollView(
                    child: Container(
                      height: 450.h,
                      child: ListView(
                        children: [
                          const RouteDateTimePicker(isDeparture: true),
                          const RouteDateTimePicker(isDeparture: false),
                          const VehicleInfoWidget(),
                          const RouteDescriptionWidget(),
                          20.h.spaceY,

                          /// BUTTON

                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                createRouteController.createRoute(
                                    context: context);
                                createRouteController.routeControllerClear();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstants().ltMainRed,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                fixedSize: Size(342.w, 50.h),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  "Rota Oluştur",
                                  style: TextStyle(
                                    fontFamily: "Sfsemidold",
                                    fontSize: 16.sp,
                                    color: AppConstants().ltWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          20.h.spaceY
                        ],
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(8.w),
                    width: 150.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        createRouteController
                            .isOpenRouteDetailEntrySection.value = true;
                        createRouteController.setDate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants().ltMainRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        fixedSize: Size(342.w, 50.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                          "Devam Et",
                          style: TextStyle(
                            fontFamily: "Sfsemidold",
                            fontSize: 16.sp,
                            color: AppConstants().ltWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
