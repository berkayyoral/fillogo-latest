import 'dart:convert';

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/create_route_post_models.dart';
import 'package:fillogo/models/routes_models/delete_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';

import 'package:intl/intl.dart';

// Kullanıcı tanımlı sınıflar

class StartOrRouteRouteDialog {
  static void show({
    required bool isStartDatePast,
    required int routeId,
    required String startCity,
    required String finishCity,
    required DateTime departureTime,
    MyRoutesDetails? myNextRoute,
  }) {
    print("StartOrRouteRouteDialog AÇILDI");
    print("APPLİFEE3");
    LocaleManager.instance.setBool(PreferencesKeys.showStartRouteAlert, true);
    MapPageMController mapPageController = Get.find();
    final BottomNavigationBarController bottomNavigationBarController =
        Get.find<BottomNavigationBarController>();
    Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: AppConstants().ltWhite,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Rotanızın başlangıç saati geldi.",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 24.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/route-icon.svg',
                              color: AppConstants().ltMainRed,
                              width: 20.w,
                            ),
                            Text(
                              "Rota: ",
                              style: TextStyle(
                                  fontFamily: "Sfbold",
                                  fontSize: 14.sp,
                                  color: AppConstants().ltBlack),
                            ),
                            Text(
                              " $startCity -> $finishCity",
                              style: TextStyle(
                                  fontFamily: "Sfregular",
                                  fontSize: 14.sp,
                                  color: AppConstants().ltBlack),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Başlangıç Tarihi: ",
                              style: TextStyle(
                                  fontFamily: "Sfbold",
                                  fontSize: 14.sp,
                                  color: AppConstants().ltBlack),
                            ),
                            Text(
                              " ${DateFormat('yyyy-MM-dd HH:mm').format(departureTime.toLocal())}",
                              style: TextStyle(
                                  fontFamily: "Sfregular",
                                  fontSize: 14.sp,
                                  color: AppConstants().ltBlack),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                16.h.horizontalSpace,
                Text("Rotayı başlatmak ister misiniz?"),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isStartDatePast) {
                          GeneralServicesTemp().makeDeleteRequest(
                            EndPoint.deleteRoute,
                            DeleteRouteRequestModel(routeId: routeId),
                            {
                              "Content-type": "application/json",
                              'Authorization':
                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                            },
                          ).then((value) async {
                            print(
                                "ROTANIZINBASLANGICSAATİ BURDAYIMMESKİROTA value -> ${value}");
                            var response1 = DeleteRouteResponseModel.fromJson(
                                jsonDecode(value!));
                            if (response1.success == 1) {
                              print("ROTANIZINBASLANGICSAATİ ROTAYI SLDİMMM");
                              mapPageController.mynotStartedRoutes
                                  .removeWhere((item) => item.id == routeId);
                              String dateTimeFormatDeparture =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(DateTime.now());
                              String dateTimeFormatArrival =
                                  DateFormat('yyyy-MM-dd HH:mm')
                                      .format(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                DateTime.now().hour,
                                DateTime.now().minute,
                              ).add(
                                Duration(
                                  minutes: myNextRoute!.travelTime,
                                ),
                              ));
                              print(
                                  "ROTANIZINBASLANGICSAATİ başlan -> ${dateTimeFormatDeparture} bitis -> ${dateTimeFormatArrival}");
                              GeneralServicesTemp().makePostRequest(
                                EndPoint.routesNew,
                                PostCreateRouteRequestModel(
                                  departureDate: dateTimeFormatDeparture,
                                  arrivalDate: dateTimeFormatArrival,
                                  routeDescription:
                                      myNextRoute.routeDescription,
                                  vehicleCapacity: 100,
                                  startingCoordinates:
                                      myNextRoute.startingCoordinates,
                                  startingOpenAdress:
                                      myNextRoute.startingOpenAdress,
                                  startingCity: myNextRoute.startingCity,
                                  endingCoordinates:
                                      myNextRoute.endingCoordinates,
                                  endingOpenAdress:
                                      myNextRoute.endingOpenAdress,
                                  endingCity: myNextRoute.endingCity,
                                  distance: myNextRoute.distance,
                                  travelTime: myNextRoute.travelTime,
                                  polylineEncode: myNextRoute.polylineEncode,
                                ),
                                {
                                  "Content-type": "application/json",
                                  'Authorization':
                                      'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                },
                              ).then((value) async {
                                PostCreateRouteResponseModel routeResponse =
                                    PostCreateRouteResponseModel.fromJson(
                                        jsonDecode(value!));
                                print(
                                    "ROTANIZINBASLANGICSAATİ yeni rota oluştu id -> ${routeResponse.data![0].id}");
                                GeneralServicesTemp().makePatchRequest(
                                  EndPoint.activateRoute,
                                  ActivateRouteRequestModel(
                                      routeId: routeResponse.data![0].id),
                                  {
                                    "Content-type": "application/json",
                                    'Authorization':
                                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                  },
                                ).then((value) async {
                                  BerkayController berkayController =
                                      Get.find<BerkayController>();
                                  berkayController.isAlreadyHaveRoute =
                                      true.obs;
                                  ActivateRouteResponseModel response =
                                      ActivateRouteResponseModel.fromJson(
                                          jsonDecode(value!));
                                  if (response.success == 1) {
                                    print(
                                        "ROTANIZINBASLANGICSAATİ active edildi");
                                    MapPageMController mapPageController =
                                        Get.find();
                                    SetCustomMarkerIconController
                                        setCustomMarkerIconController = Get.put(
                                            SetCustomMarkerIconController());

                                    await mapPageController.getMyRoutes();

                                    bottomNavigationBarController
                                        .selectedIndex.value = 1;
                                    // mapPageController.selectedDispley(5);

                                    Get.toNamed(NavigationConstants
                                        .bottomNavigationBar);
                                    Get.snackbar("Başarılı",
                                        "Başarıyla Rotaya Başlanıldı!",
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: AppConstants().ltBlack);
                                  } else {
                                    Get.back(closeOverlays: true);
                                    Get.snackbar("Hata!", "${response.message}",
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: AppConstants().ltBlack);

                                    print(
                                        "ROTANIZINBASLANGICSAATİ active edilemedi -> ${response.message}");
                                  }
                                });
                              });
                              Get.back();
                            } else {
                              print("ROTAYI SİLEMEİDMM");
                            }
                          });
                        } else {
                          GeneralServicesTemp().makePatchRequest(
                            EndPoint.activateRoute,
                            ActivateRouteRequestModel(routeId: routeId),
                            {
                              "Content-type": "application/json",
                              'Authorization':
                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                            },
                          ).then((value) {
                            ActivateRouteResponseModel response =
                                ActivateRouteResponseModel.fromJson(
                                    jsonDecode(value!));
                            if (response.success == 1) {
                              BerkayController berkayController =
                                  Get.find<BerkayController>();
                              berkayController.isAlreadyHaveRoute = false.obs;
                              mapPageController.polylineCoordinates.clear();
                              mapPageController.polylines.clear();
                              mapPageController.markers.clear();
                              mapPageController.isThereActiveRoute.value =
                                  false;
                              mapPageController.getMyRoutes();
                              mapPageController.getUsersOnArea(
                                  carTypeFilter: mapPageController.carTypeList);
                            }
                          });
                        }
                        LocaleManager.instance.setBool(
                            PreferencesKeys.showStartRouteAlert, false);
                        Get.back();
                      },
                      child: Center(
                        child: Container(
                          height: 45.h,
                          width: 95.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                              color: AppConstants().ltMainRed,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            isStartDatePast
                                ? "Rotayı Şimdi Başlat"
                                : "Rotayı Başlat",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppConstants().ltWhite),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        GeneralServicesTemp().makeDeleteRequest(
                          EndPoint.deleteRoute,
                          DeleteRouteRequestModel(routeId: routeId),
                          {
                            "Content-type": "application/json",
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                          },
                        ).then((value) {
                          var response = DeleteRouteResponseModel.fromJson(
                              jsonDecode(value!));
                          if (response.success == 1) {
                            mapPageController.mynotStartedRoutes
                                .removeWhere((item) => item.id == routeId);
                            Get.back(closeOverlays: true);
                            Get.snackbar("Başarılı!", "Rota başarıyla silindi.",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: AppConstants().ltBlack);
                          } else {
                            Get.back(closeOverlays: true);
                            Get.snackbar("Bir hata ile karşılaşıldı!",
                                "Lütfen tekrar deneyiniz.",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: AppConstants().ltBlack);
                          }
                        });
                        LocaleManager.instance.setBool(
                            PreferencesKeys.showStartRouteAlert, false);
                        LocaleManager.instance
                            .remove(PreferencesKeys.dialogStartRoute);
                      },
                      child: Center(
                        child: Container(
                          height: 45.h,
                          width: 95.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppConstants().ltWhiteGrey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: const Text("Rotayı Sil"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
