import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:fillogo/export.dart';
import 'package:fillogo/views/route_details_page_view/components/route_detail_view_card.dart';
import 'package:fillogo/views/route_details_page_view/components/route_details_page_controller.dart';
import 'package:fillogo/widgets/google_maps_widgets/general_map_view_class.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ShareMediaControlller extends GetxController {
  final GlobalKey previewContainer = GlobalKey();

  final RouteDetailsPageController routeDetailsPageController =
      Get.put(RouteDetailsPageController());

  Future<Uint8List?> captureWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      log("Widget görüntüleme hatası: $e");
      return null;
    }
  }

  Future<Uint8List> getImageInWidget({required int routeId}) async {
    await routeDetailsPageController.getRouteDetailsById(routeId);
    log("ROUTEPAGEİNF-> ${routeDetailsPageController.ownerRouteStartCity.value}");

    final controller = ScreenshotController();
    final bytes =
        await controller.captureFromWidget(Material(child: widgetImage()));

    return bytes;
  }

  widgetImage() {
    CameraPosition initialLocation = CameraPosition(
      target: LatLng(39.0000, 35.0000
          // mapPageMController.myLocationLatitudeDo.value,
          // mapPageMController.myLocationLongitudeDo.value,
          ),
      zoom: 5.0,
    );

    return RepaintBoundary(
      key: previewContainer,
      child: Container(
        height: 360.h,
        decoration: BoxDecoration(
            color: AppConstants().ltWhite,
            border: Border.all(
              width: 5.w,
              color: AppConstants().ltBlack,
            )),
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        margin: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ProfilePhoto(
                      height: 48.h,
                      width: 48.w,
                      url: routeDetailsPageController
                          .ownerRouteProfilePicture.value,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${routeDetailsPageController.ownerRouteName.value} ${routeDetailsPageController.ownerRouteSurname.value}",
                        style: TextStyle(
                          fontFamily: 'Sfmedium',
                          fontSize: 16.sp,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                      routeDetailsPageController.ownerRouteCarType.carBrand !=
                              ""
                          ? Text(
                              "${routeDetailsPageController.ownerRouteCarType.carBrand} / ${routeDetailsPageController.ownerRouteCarType.carModel}",
                              style: TextStyle(
                                fontFamily: 'Sfmedium',
                                fontSize: 12.sp,
                                color: AppConstants().ltDarkGrey,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, top: 15.h, bottom: 15.h),
              child: Text(
                routeDetailsPageController.ownerRouteDiscription.value,
                style: TextStyle(
                  fontFamily: 'Sfmedium',
                  fontSize: 14.sp,
                  color: AppConstants().ltLogoGrey,
                ),
              ),
            ),
            RouteDatailsPageRouteCard(
              endAdress: routeDetailsPageController.ownerRouteFinishCity.value,
              endDateTime: routeDetailsPageController
                  .ownerRouteCalculatedRouteTime.value,
              id: 1,
              startAdress: routeDetailsPageController.ownerRouteStartCity.value,
              startDateTime: routeDetailsPageController
                  .ownerRouteCalculatedRouteDistance.value,
              userName:
                  "${routeDetailsPageController.ownerRouteName.value} ${routeDetailsPageController.ownerRouteSurname.value}",
            ),
            // Container(
            //   padding: EdgeInsets.all(16.h),
            //   height: 260.h,
            //   width: Get.width,
            //   child: GeneralMapViewClass(
            //     markerSet: Set<Marker>.from(routeDetailsPageController.markers),
            //     initialCameraPosition: initialLocation,
            //     myLocationEnabled: true,
            //     myLocationButtonEnabled: false,
            //     mapType: MapType.normal,
            //     zoomGesturesEnabled: true,
            //     zoomControlsEnabled: false,
            //     onCameraMoveStarted: () {},
            //     onCameraMove: (p0) {},
            //     polygonsSet: const <Polygon>{},
            //     tileOverlaysSet: const <TileOverlay>{},
            //     polylinesSet: Set<Polyline>.of(
            //         routeDetailsPageController.generalPolylines),
            //     // mapController2: (GoogleMapController controller) {
            //     //   routeDetailsPageController.mapController = controller;
            //     // },
            //     mapController2: (GoogleMapController controller) {
            //       try {
            //         if (!routeDetailsPageController
            //             .routeDetailsMapController.isCompleted) {
            //           print("completed");
            //           routeDetailsPageController.routeDetailsMapController
            //               .complete(controller);
            //           routeDetailsPageController.routeDetailsMapController =
            //               Completer<GoogleMapController>();
            //         }
            //       } catch (e) {
            //         print("ERORORO -> $e");
            //       }
            //     },
            //   ),
            // ),

            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
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
                      width: 310.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/calendar-tick.svg',
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
                                  'Çıkış Tarihi:',
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
                                  routeDetailsPageController
                                      .ownerRouteStartDate.value
                                      .split(" ")[0],
                                  style: TextStyle(
                                    fontFamily: 'Sfmedium',
                                    fontSize: 14.sp,
                                    color: AppConstants().ltLogoGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/line-icon.svg',
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
                                  'Varış Tarihi:',
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
                                  routeDetailsPageController
                                      .ownerRouteFinishDate.value
                                      .split(" ")[0],
                                  style: TextStyle(
                                    fontFamily: 'Sfmedium',
                                    fontSize: 14.sp,
                                    color: AppConstants().ltLogoGrey,
                                  ),
                                ),
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

            // 10.h.verticalSpace,
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Center(
            //     child: SizedBox(
            //         width: 240.w,
            //         child: Visibility(
            //           visible: berkayController.canVisible.value,
            //           child: CustomRedButton(
            //               title: "Rotaya Başla",
            //               onTap: () {
            //                 GeneralServicesTemp().makePatchRequest(
            //                   EndPoint.activateRoute,
            //                   ActivateRouteRequestModel(
            //                       routeId: selectedRouteController
            //                           .selectedRouteId.value),
            //                   {
            //                     "Content-type": "application/json",
            //                     'Authorization':
            //                         'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
            //                   },
            //                 ).then((value) async {
            //                   // BerkayController berkayController =
            //                   //     Get.find<BerkayController>();
            //                   // berkayController.isAlreadyHaveRoute = true.obs;
            //                   // ActivateRouteResponseModel response =
            //                   //     ActivateRouteResponseModel.fromJson(
            //                   //         jsonDecode(value!));
            //                   // if (response.success == 1) {
            //                   //   MapPageMController mapPageController =
            //                   //       Get.find();
            //                   //   SetCustomMarkerIconController
            //                   //       setCustomMarkerIconController =
            //                   //       Get.put(SetCustomMarkerIconController());
            //                   //   await mapPageController.getMyRoutes();
            //                   //   bottomNavigationBarController
            //                   //       .selectedIndex.value = 1;
            //                   //   // mapPageController.selectedDispley(5);
            //                   //   Get.toNamed(
            //                   //       NavigationConstants.bottomNavigationBar);
            //                   //   Get.snackbar("Başarılı",
            //                   //       "Başarıyla Rotaya Başlanıldı!",
            //                   //       snackPosition: SnackPosition.BOTTOM,
            //                   //       colorText: AppConstants().ltBlack);
            //                   // } else {
            //                   //   Get.back(closeOverlays: true);
            //                   //   Get.snackbar("Hata!", "${response.message}",
            //                   //       snackPosition: SnackPosition.BOTTOM,
            //                   //       colorText: AppConstants().ltBlack);
            //                   // }
            //                 });
            //               }),
            //         )),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Future saveImage(Uint8List bytes) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/image.png");
    file.writeAsBytes(bytes);
  }
}
