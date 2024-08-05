import 'dart:convert';

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/create_route_post_models.dart';
import 'package:fillogo/models/routes_models/delete_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../export.dart';

class RouteAlertDialog {
  Widget showSelectDeleteOrShareDialog(BuildContext context, int id) {
    BottomNavigationBarController bottomNavigationBarController =
        Get.find<BottomNavigationBarController>();
    MapPageMController mapPageMController = Get.find();
    CreateRouteController createRouteController = Get.find();
    return AlertDialog(
      title: Text(
        'Uyarı',
        style: TextStyle(
          fontFamily: 'Sfsemibold',
          fontSize: 16.sp,
          color: AppConstants().ltLogoGrey,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Text(
                "Belirlenen tarihlerde mevcut rotanız bulunmakta.",
                style: TextStyle(
                  fontFamily: 'Sfregular',
                  fontSize: 16.sp,
                  color: AppConstants().ltDarkGrey,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Daha önceki rotanız silip yeni oluşturduğunuz rotayı bu tarihler arasında oluşturmak ister misiniz?",
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
              child: CustomButtonDesign(
                text: 'Eski rotayı sil ve yenisini ekle',
                textColor: AppConstants().ltWhite,
                onpressed: () {
                  print("BURDAYIMMESKİROTA SİL");
                  try {
                    GeneralServicesTemp().makeDeleteRequest(
                      EndPoint.deleteRoute,
                      DeleteRouteRequestModel(routeId: id),
                      {
                        "Content-type": "application/json",
                        'Authorization':
                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                      },
                    ).then((value) async {
                      print("BURDAYIMMESKİROTA value -> ${value}");
                      var response1 =
                          DeleteRouteResponseModel.fromJson(jsonDecode(value!));
                      if (response1.success == 1) {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) => AlertDialog(
                        //     title: const Text("UYARI!"),
                        //     content: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         Column(
                        //           children: [
                        //             Text(
                        //               "Görünüşe göre anlık bir rota oluşturdunuz.",
                        //               style: TextStyle(
                        //                 fontFamily: 'Sfregular',
                        //                 fontSize: 16.sp,
                        //                 color: AppConstants().ltDarkGrey,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: 20.h,
                        //         ),
                        //         Text(
                        //           "Rotayı başlatmak ister misiniz?",
                        //           style: TextStyle(
                        //             fontFamily: 'Sfregular',
                        //             fontSize: 14.sp,
                        //             color: AppConstants().ltLogoGrey,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     actions: <Widget>[
                        //       Column(
                        //         children: [
                        //           Padding(
                        //             padding: EdgeInsets.only(
                        //                 bottom: 12.w, right: 12.w, left: 12.w),
                        //             child: CustomButtonDesign(
                        //               text: 'Rotayı Başlat',
                        //               textColor: AppConstants().ltWhite,
                        //               onpressed: () {
                        //                 MapPageMController mapPageController =
                        //                     MapPageMController();
                        //                 GeneralServicesTemp().makePatchRequest(
                        //                   EndPoint.activateRoute,
                        //                   ActivateRouteRequestModel(
                        //                       routeId: id),
                        //                   {
                        //                     "Content-type": "application/json",
                        //                     'Authorization':
                        //                         'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                        //                   },
                        //                 ).then((value) async {
                        //                   ActivateRouteResponseModel response =
                        //                       ActivateRouteResponseModel
                        //                           .fromJson(jsonDecode(value!));
                        //                   if (response.success == 1) {
                        //                     await showDialog(
                        //                         context: context,
                        //                         builder:
                        //                             (BuildContext context2) {
                        //                           return showShareRouteAllertDialog(
                        //                             context,
                        //                             "${createRouteController.startRouteCity} -> ${createRouteController.finishRouteCity}",
                        //                             (LocaleManager.instance
                        //                                 .getString(PreferencesKeys
                        //                                     .currentUserUserName)),
                        //                             createRouteController
                        //                                 .dateTimeFormatDeparture
                        //                                 .value
                        //                                 .toString()
                        //                                 .substring(0, 11),
                        //                             createRouteController
                        //                                 .dateTimeFormatArrival
                        //                                 .value
                        //                                 .toString()
                        //                                 .substring(0, 11),
                        //                             0,
                        //                           );
                        //                         });
                        //                     Get.back();
                        //                     await GeneralServicesTemp()
                        //                         .makeGetRequest(
                        //                       EndPoint.getMyRoutes,
                        //                       {
                        //                         "Content-type":
                        //                             "application/json",
                        //                         'Authorization':
                        //                             'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                        //                       },
                        //                     ).then((value) async {
                        //                       BerkayController
                        //                           berkayController =
                        //                           Get.find<BerkayController>();
                        //                       berkayController
                        //                               .isAlreadyHaveRoute =
                        //                           true.obs;
                        //                       GetMyRouteResponseModel
                        //                           getMyRouteResponseModel =
                        //                           GetMyRouteResponseModel
                        //                               .fromJson(
                        //                                   json.decode(value!));
                        //                       GoogleMapController
                        //                           googleMapController =
                        //                           mapPageController
                        //                               .mapController!;
                        //                       googleMapController.animateCamera(
                        //                         CameraUpdate.newCameraPosition(
                        //                           CameraPosition(
                        //                             bearing: 90,
                        //                             target: LatLng(
                        //                               createRouteController
                        //                                   .currentLocationController
                        //                                   .myLocationLatitudeDo
                        //                                   .value,
                        //                               createRouteController
                        //                                   .currentLocationController
                        //                                   .myLocationLongitudeDo
                        //                                   .value,
                        //                             ),
                        //                             zoom: 10,
                        //                           ),
                        //                         ),
                        //                       );
                        //                       await mapPageController
                        //                           .getUsersOnArea(
                        //                         carTypeFilter: mapPageController
                        //                             .carTypeList,
                        //                       );
                        //                     });
                        //                   } else {
                        //                     Get.back(closeOverlays: true);
                        //                     Get.snackbar(
                        //                         "Hata!", "${response.message}",
                        //                         snackPosition:
                        //                             SnackPosition.BOTTOM,
                        //                         colorText:
                        //                             AppConstants().ltBlack);
                        //                   }
                        //                   await GeneralServicesTemp()
                        //                       .makePostRequest(
                        //                     EndPoint.routesNew,
                        //                     PostCreateRouteRequestModel(
                        //                       departureDate:
                        //                           createRouteController
                        //                               .departureController
                        //                               .value
                        //                               .text,
                        //                       arrivalDate: createRouteController
                        //                           .arrivalController.value.text,
                        //                       routeDescription: createRouteController
                        //                                   .routeDescriptionController
                        //                                   .text ==
                        //                               ""
                        //                           ? "${createRouteController.dateTimeFormatDeparture.value} tarihinde ${createRouteController.startRouteCity} şehrinden başlayan yolculuk ${createRouteController.dateTimeFormatArrival.value} tarihinde ${createRouteController.finishRouteCity} şehrinde son bulacak."
                        //                           : createRouteController
                        //                               .routeDescriptionController
                        //                               .text,
                        //                       vehicleCapacity: 100,
                        //                       startingCoordinates: [
                        //                         createRouteController
                        //                             .startRouteLocation
                        //                             .value
                        //                             .latitude,
                        //                         createRouteController
                        //                             .startRouteLocation
                        //                             .value
                        //                             .longitude
                        //                       ],
                        //                       startingOpenAdress:
                        //                           createRouteController
                        //                               .startRouteAdress.value,
                        //                       startingCity:
                        //                           createRouteController
                        //                               .startRouteCity,
                        //                       endingCoordinates: [
                        //                         createRouteController
                        //                             .finishRouteLocation
                        //                             .value
                        //                             .latitude,
                        //                         createRouteController
                        //                             .finishRouteLocation
                        //                             .value
                        //                             .longitude
                        //                       ],
                        //                       endingOpenAdress:
                        //                           createRouteController
                        //                               .finishRouteAdress.value,
                        //                       endingCity: createRouteController
                        //                           .finishRouteCity,
                        //                       distance: int.parse(
                        //                           createRouteController
                        //                               .calculatedRouteDistance
                        //                               .value),
                        //                       travelTime: createRouteController
                        //                           .calculatedRouteTimeInt,
                        //                       polylineEncode:
                        //                           createRouteController
                        //                               .routePolyline.value,
                        //                     ),
                        //                     {
                        //                       "Content-type":
                        //                           "application/json",
                        //                       'Authorization':
                        //                           'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                        //                     },
                        //                   ).then(
                        //                     (value) async {
                        //                       if (value != null) {
                        //                         final response =
                        //                             PostCreateRouteResponseModel
                        //                                 .fromJson(
                        //                                     jsonDecode(value));
                        //                         CreatePostPageController
                        //                             createPostPageController =
                        //                             Get.put(
                        //                                 CreatePostPageController());
                        //                         if (response.success == 1) {
                        //                           createPostPageController
                        //                                   .routeId.value =
                        //                               response.data![0].id!;
                        //                           Get.back();
                        //                           showDialog(
                        //                             context: context,
                        //                             builder: (BuildContext
                        //                                     context) =>
                        //                                 showShareRouteAllertDialog(
                        //                               context,
                        //                               "${response.data![0].startingCity!} -> ${response.data![0].endingCity!}",
                        //                               "Furkan Semiz",
                        //                               response.data![0]
                        //                                   .departureDate!
                        //                                   .toString()
                        //                                   .substring(0, 11),
                        //                               response
                        //                                   .data![0].arrivalDate!
                        //                                   .toString()
                        //                                   .substring(0, 11),
                        //                               response.data![0].id!,
                        //                             ),
                        //                           );
                        //                         } else if (response.success ==
                        //                             -1) {
                        //                           print(
                        //                               "BURDAYIMMESKİROTA BURASI1");
                        //                           showDialog(
                        //                             context: context,
                        //                             builder: (BuildContext
                        //                                     context) =>
                        //                                 showSelectDeleteOrShareDialog(
                        //                                     context,
                        //                                     response
                        //                                         .data![0].id!),
                        //                           );
                        //                         } else {
                        //                           UiHelper.showWarningSnackBar(
                        //                               context,
                        //                               'Bir hata oluştu... Lütfen daha sonra tekrar deneyiniz.');
                        //                           Get.back();
                        //                         }
                        //                       }
                        //                     },
                        //                   );
                        //                   Get.snackbar("Başarılı!",
                        //                       "Rota başarıyla silindi.",
                        //                       snackPosition:
                        //                           SnackPosition.BOTTOM,
                        //                       colorText:
                        //                           AppConstants().ltBlack);
                        //                 });
                        //                 Get.back();
                        //                 Get.back();
                        //               },
                        //               iconPath: '',
                        //               color: AppConstants().ltMainRed,
                        //               height: 50.h,
                        //               width: 341.w,
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(
                        //                 bottom: 12.w, right: 12.w, left: 12.w),
                        //             child: CustomButtonDesign(
                        //               text: 'Rotayı Başlatma',
                        //               textColor: AppConstants().ltWhite,
                        //               onpressed: () async {
                        //                 // mapPageMController.polylines.clear();
                        //                 // mapPageMController.polylineCoordinates
                        //                 //     .clear();
                        //                 mapPageMController.getMyRoutes(
                        //                     isStartRoute: false);
                        //                 await showDialog(
                        //                     context: context,
                        //                     builder: (BuildContext context2) {
                        //                       return showShareRouteAllertDialog(
                        //                           context,
                        //                           "${createRouteController.startRouteCity} -> ${createRouteController.finishRouteCity}",
                        //                           (LocaleManager.instance
                        //                               .getString(PreferencesKeys
                        //                                   .currentUserUserName)),
                        //                           createRouteController
                        //                               .dateTimeFormatDeparture
                        //                               .value
                        //                               .toString()
                        //                               .substring(0, 11),
                        //                           createRouteController
                        //                               .dateTimeFormatArrival
                        //                               .value
                        //                               .toString()
                        //                               .substring(0, 11),
                        //                           0);
                        //                     });
                        //               },
                        //               iconPath: '',
                        //               color: AppConstants().ltDarkGrey,
                        //               height: 50.h,
                        //               width: 341.w,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // );
                        print("ROTAYI SLDİMMM");

                        // GeneralServicesTemp().makePostRequest(
                        //   EndPoint.routesNew,
                        //   PostCreateRouteRequestModel(
                        //     departureDate: departureController.value.text,
                        //     arrivalDate: arrivalController.value.text,
                        //     routeDescription: routeDescriptionController.text ==
                        //             ""
                        //         ? "${departureController.value.text} tarihinde $startRouteCity şehrinden başlayan yolculuk ${arrivalController.value.text} tarihinde $finishRouteCity şehrinde son bulacak."
                        //         : routeDescriptionController.text,
                        //     vehicleCapacity: 100,
                        //     startingCoordinates: [
                        //       startRouteLocation.value.latitude,
                        //       startRouteLocation.value.longitude
                        //     ],
                        //     startingOpenAdress: startRouteAdress.value,
                        //     startingCity: startRouteCity,
                        //     endingCoordinates: [
                        //       finishRouteLocation.value.latitude,
                        //       finishRouteLocation.value.longitude
                        //     ],
                        //     endingOpenAdress: finishRouteAdress.value,
                        //     endingCity: finishRouteCity,
                        //     distance: int.parse(calculatedRouteDistance.value
                        //         .replaceAll(RegExp(r'[^0-9]'), '')),
                        //     travelTime: calculatedRouteTimeInt,
                        //     polylineEncode: routePolyline.value,
                        //   ),
                        //   {
                        //     "Content-type": "application/json",
                        //     'Authorization':
                        //         'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                        //   },
                        // );
                        createRouteController.createRoute(context: context);
                        // mapPageMController.isCreateRoute.value = false;
                        // createRouteController
                        //     .isOpenRouteDetailEntrySection.value = false;
                        // createRouteController.routeControllerClear();
                        // mapPageMController.getMyRoutes();
                        Get.back();
                      } else {
                        print("ROTAYI SİLEMEİDMM");
                        Get.back();
                        Get.back();
                      }
                    });
                  } catch (e) {
                    print("DELETEROUTE ERROR -> $e");
                  }
                },
                iconPath: '',
                color: AppConstants().ltMainRed,
                height: 50.h,
                width: 341.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
              child: CustomButtonDesign(
                text: 'Eski rotayı silme',
                textColor: AppConstants().ltWhite,
                onpressed: () {
                  bottomNavigationBarController.selectedIndex.value = 1;
                  Get.back();
                  Get.back();
                },
                iconPath: '',
                color: AppConstants().ltDarkGrey,
                height: 50.h,
                width: 341.w,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showShareRouteAllertDialog(
    BuildContext context,
    String? routeContent,
    String? userName,
    String? startDate,
    String? endDate,
    int routeId,
  ) {
    MapPageMController mapPageMController = Get.find();
    CreateRouteController createRouteController = Get.find();
    BottomNavigationBarController bottomNavigationBarController =
        Get.find<BottomNavigationBarController>();
    CreatePostPageController createPostPageController =
        Get.put(CreatePostPageController());
    GetMyCurrentLocationController getMyCurrentLocationController =
        Get.find<GetMyCurrentLocationController>();
    return AlertDialog(
      title: Text(
        'Tebrikler',
        style: TextStyle(
          fontFamily: 'Sfsemibold',
          fontSize: 16.sp,
          color: AppConstants().ltLogoGrey,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Text(
                "Rotanız başarıyla oluşturuldu.",
                style: TextStyle(
                  fontFamily: 'Sfregular',
                  fontSize: 16.sp,
                  color: AppConstants().ltDarkGrey,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Yeni rotanızı duvarınızda yayınlamak ve arkadaşlarınız ile paylaşmak ister misiniz?",
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
          10.h.spaceY,
          Text(
            "Rotayı paylaşmak istemezseniz arkadaşlarınız ve diğer kullanıcılar rota araması yaparak rotanızı görüntüleyebilecek.",
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
              child: CustomButtonDesign(
                text: 'Rotayı Paylaş',
                textColor: AppConstants().ltWhite,
                onpressed: () {
                  print("PAYLAŞCAMMMMMM");
                  createPostPageController.haveRoute.value = 1;
                  createPostPageController.userName.value = userName!;
                  createPostPageController.routeContent.value = routeContent!;
                  createPostPageController.routeStartDate.value = startDate!;
                  createPostPageController.routeEndDate.value = endDate!;

                  bottomNavigationBarController.selectedIndex.value = 1;
                  if (mapPageMController != null) {
                    mapPageMController.update();
                  }

                  Get.back();
                  Get.back();
                  Get.back();
                  Get.toNamed(NavigationConstants.createPostPage,
                      arguments: routeId);
                  mapPageMController.isCreateRoute.value = false;
                  createRouteController.isOpenRouteDetailEntrySection.value =
                      false;
                  mapPageMController.getMyLocationInMap();

                  createRouteController.routeControllerClear();
                  mapPageMController.getMyRoutes();
                },
                iconPath: '',
                color: AppConstants().ltMainRed,
                height: 50.h,
                width: 341.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
              child: CustomButtonDesign(
                text: 'Rotayı Paylaşma',
                textColor: AppConstants().ltWhite,
                onpressed: () async {
                  MapPageMController mapPageController =
                      Get.find<MapPageMController>();
                  bottomNavigationBarController.selectedIndex.value = 1;
                  Get.back();
                  Get.back();
                  Get.back();
                  mapPageMController.isCreateRoute.value = false;
                  createRouteController.isOpenRouteDetailEntrySection.value =
                      false;
                  GoogleMapController googleMapController =
                      mapPageController.mapController!;
                  googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 13.5,
                        target: LatLng(
                          getMyCurrentLocationController
                              .myLocationLatitudeDo.value,
                          getMyCurrentLocationController
                              .myLocationLongitudeDo.value,
                        ),
                      ),
                    ),
                  );
                  createRouteController.routeControllerClear();
                  mapPageMController.getMyRoutes();
                },
                iconPath: '',
                color: AppConstants().ltDarkGrey,
                height: 50.h,
                width: 341.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
