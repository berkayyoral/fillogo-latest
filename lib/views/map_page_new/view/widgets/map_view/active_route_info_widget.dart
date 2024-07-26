import 'dart:convert';

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ActiveRouteInfoWidget extends StatelessWidget {
  final BuildContext context;

  ActiveRouteInfoWidget({
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final MapPageMController mapPageMController = Get.find();
    final GetMyCurrentLocationController getMyCurrentLocationController =
        Get.find();
    return Obx(() => mapPageMController.isThereActiveRoute.value
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:
                  mapPageMController.finishRouteButton.value ? 160.h : 110.h,
              padding: EdgeInsets.all(12.w),
              constraints: BoxConstraints(maxHeight: 160.h, minHeight: 100.h),
              decoration: BoxDecoration(
                color: AppConstants().ltWhite.withOpacity(0.95),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mapPageMController.finishRouteButton.value
                            ? Text(
                                mapPageMController.myActivesRoutes!.isNotEmpty
                                    ? "${DateFormat('HH:mm').format(DateTime(
                                        2023,
                                        1,
                                        1,
                                        (mapPageMController.myActivesRoutes![0]
                                                .arrivalDate.hour) +
                                            3,
                                        mapPageMController.myActivesRoutes![0]
                                            .arrivalDate.minute,
                                      ))} varış"
                                    : "",
                                style: TextStyle(
                                  color: AppConstants().ltLogoGrey,
                                  fontFamily: "SfBold",
                                  fontSize: 28.sp,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  richTextWidget(
                                      title: "varış",
                                      textInfo: mapPageMController
                                              .myActivesRoutes!.isNotEmpty
                                          ? DateFormat('HH:mm').format(DateTime(
                                              2023,
                                              1,
                                              1,
                                              (mapPageMController
                                                      .myActivesRoutes![0]
                                                      .arrivalDate
                                                      .hour) +
                                                  3,
                                              mapPageMController
                                                  .myActivesRoutes![0]
                                                  .arrivalDate
                                                  .minute,
                                            ))
                                          : ""),
                                  18.w.horizontalSpace,
                                  richTextWidget(
                                      title: "dakika",
                                      textInfo: mapPageMController
                                              .myActivesRoutes!.isNotEmpty
                                          ? (mapPageMController
                                                  .myActivesRoutes![0]
                                                  .arrivalDate
                                                  .difference(DateTime.now())
                                                  .inMinutes)
                                              .toString()
                                          : ""),
                                  18.w.horizontalSpace,
                                  richTextWidget(
                                      title: "km",
                                      textInfo: mapPageMController
                                              .myActivesRoutes!.isNotEmpty
                                          ? mapPageMController
                                              .myActivesRoutes![0].distance
                                              .toString()
                                          : "")
                                ],
                              ),
                        GestureDetector(
                          onTap: () {
                            mapPageMController.finishRouteButton.value =
                                !mapPageMController.finishRouteButton.value;
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor:
                                AppConstants().ltWhiteGrey.withOpacity(1),
                            child: Icon(
                              mapPageMController.finishRouteButton.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppConstants().ltDarkGrey,
                              size: 42,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  16.h.verticalSpace,
                  Visibility(
                    visible: mapPageMController.finishRouteButton.value,
                    child: SizedBox(
                      width: 350.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          mapPageMController.isLoading.value = true;
                          mapPageMController.isThereActiveRoute.value = false;
                          GeneralServicesTemp().makePatchRequest(
                            EndPoint.activateRoute,
                            ActivateRouteRequestModel(
                                routeId:
                                    mapPageMController.myActivesRoutes![0].id),
                            {
                              "Content-type": "application/json",
                              'Authorization':
                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                            },
                          ).then((value) async {
                            mapPageMController.isLoading.value = true;
                            ActivateRouteResponseModel response =
                                ActivateRouteResponseModel.fromJson(
                                    jsonDecode(value!));
                            if (response.success == 1) {
                              BerkayController berkayController =
                                  Get.find<BerkayController>();
                              berkayController.isAlreadyHaveRoute = false.obs;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Başarılı rotanız başarıyla bitirilmiştir."),
                                ),
                              );

                              mapPageMController.markers.clear();
                              mapPageMController.addMarkerIcon(
                                  markerID: "myLocationMarker",
                                  location: LatLng(
                                      mapPageMController
                                          .currentLocationController
                                          .myLocationLatitudeDo
                                          .value,
                                      mapPageMController
                                          .currentLocationController
                                          .myLocationLongitudeDo
                                          .value));

                              mapPageMController.polylines.clear();

                              mapPageMController.update();
                            }

                            await mapPageMController.getUsersOnArea(
                                carTypeFilter: mapPageMController.carTypeList);
                            mapPageMController.getMyLocationInMap();
                            mapPageMController.isLoading.value = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants().ltMainRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Rotayı Bitir",
                          style: TextStyle(
                            fontFamily: "SfSemibold",
                            fontSize: 20.sp,
                            color: AppConstants().ltWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container());
  }

  RichText richTextWidget({required String title, required String textInfo}) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: textInfo,
          style: TextStyle(
            color: AppConstants().ltLogoGrey,
            fontFamily: "SfBold",
            fontSize: 28.sp,
          ),
        ),
        TextSpan(
          text: "\n$title",
          style: TextStyle(
            color: AppConstants().ltLogoGrey.withOpacity(0.6),
            fontFamily: "SfMedium",
            fontSize: 18.sp,
          ),
        )
      ]),
    );
  }
}
