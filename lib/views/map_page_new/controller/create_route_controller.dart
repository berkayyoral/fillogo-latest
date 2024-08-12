import 'dart:convert';
import 'dart:math';

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
import 'package:fillogo/views/create_post_view/components/mfuController.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/service/polyline_service.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/route_alert_dialog.dart';
import 'package:fillogo/views/testFolder/test19/route_api_models.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';

class CreateRouteController extends GetxController implements PolylineService {
  @override
  Future<void> onInit() async {
    startRouteLocation.value = LatLng(
        currentLocationController.myLocationLatitudeDo.value,
        currentLocationController.myLocationLongitudeDo.value);
    await getRouteInfo();
    setDate();
    super.onInit();
  }

  RxBool isKeyboardVisible = false.obs;
  ScrollController scrollController = ScrollController();

  MapPageMController mapPageMController = Get.find();
  GetMyCurrentLocationController currentLocationController =
      Get.find<GetMyCurrentLocationController>();
  GoogleMapsPlaces googleMapsPlaces =
      GoogleMapsPlaces(apiKey: AppConstants.googleMapsApiKey);

  Rx<LatLng> startRouteLocation = const LatLng(0.0, 0.0).obs;
  RxString startRouteAdress = "".obs;
  RxString startRouteCity = "".obs;

  Rx<LatLng> finishRouteLocation = const LatLng(0.0, 0.0).obs;
  RxString finishRouteAdress = "".obs;
  RxString finishRouteCity = "".obs;

  RxString routePolyline = "".obs;

  var calculatedRouteDistance = "".obs;
  int calculatedRouteDistanceInt = 0;
  var calculatedRouteTime = "".obs;
  int calculatedRouteTimeInt = 0;

  RxBool isOpenRouteDetailEntrySection = false.obs;
  Rx<TextEditingController> departureController = TextEditingController().obs;
  Rx<TextEditingController> arrivalController = TextEditingController().obs;
  TextEditingController kapasiteController = TextEditingController();
  TextEditingController routeDescriptionController =
      TextEditingController(text: "");

  RxString differentTime = "".obs;
  RxString dateTimeFormatDeparture = "".obs;
  RxString dateTimeFormatArrival = "".obs;
  var dateTimeFormatLast = DateTime.now().obs;
  Rx<DateTime?> pickedDate = DateTime.now().obs;

  getRouteInfo({bool isStartLocation = true}) async {
    try {
      MfuController mfuController = Get.find();
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: isStartLocation
              ? startRouteLocation.value.latitude
              : finishRouteLocation.value.latitude,
          longitude: isStartLocation
              ? startRouteLocation.value.longitude
              : finishRouteLocation.value.longitude,
          googleMapApiKey: AppConstants.googleMapsApiKey);
      if (isStartLocation) {
        startRouteLocation.value = LatLng(data.latitude, data.longitude);
        startRouteAdress.value = data.address;
        startRouteCity.value = data.state;
        print(
            "STARTLOCATİON İNFO -> ${startRouteCity.value} finish -> ${finishRouteCity.value}");
      } else {
        finishRouteLocation.value = LatLng(data.latitude, data.longitude);
        finishRouteAdress.value = data.address;
        finishRouteCity.value = data.state;

        mfuController.sehirler.value =
            "${startRouteCity.value} -> ${finishRouteCity.value}";

        print(
            "CREATEROUTE START -> ${startRouteCity.value} finif -> ${finishRouteCity.value}");
        print("CREATEROUTE mfu ${mfuController.sehirler.value}");
        print("CREATEROUTE DATA ${data.state}");

        if (data.state.isNotEmpty) {
          await getRoute(
              startRouteLocation.value.latitude,
              startRouteLocation.value.longitude,
              finishRouteLocation.value.latitude,
              finishRouteLocation.value.longitude);
        }

        // await getPolyline(
        //     startRouteLocation.value.latitude,
        //     startRouteLocation.value.longitude,
        //     finishRouteLocation.value.latitude,
        //     finishRouteLocation.value.longitude);

        // calculatedRouteDistance = GetPolylineService().calculateDistance(
        //     startRouteLocation.value.latitude,
        //     finishRouteLocation.value.latitude,
        //     finishRouteLocation.value.latitude,
        //     finishRouteLocation.value.longitude);
      }
    } catch (e) {
      print("CREATEROUTECONTROLLER GET CİTY ERROR -> $e");
    }
  }

  void clearFinishRouteInfo() {
    calculatedRouteDistance.value = "";
    calculatedRouteDistanceInt = 0;
    calculatedRouteTime.value = "";
    calculatedRouteTimeInt = 0;
    finishRouteAdress.value = "";
    finishRouteLocation.value = const LatLng(0.0, 0.0);
    finishRouteCity.value = "";
  }

  setDate() {
    departureController.value.text =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    dateTimeFormatArrival.value =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
    ).add(
      Duration(
        minutes: calculatedRouteTimeInt,
      ),
    ));
    arrivalController.value.text = dateTimeFormatArrival.value;
    dateTimeFormatDeparture.value = departureController.value.text;
  }

  @override
  Future<GetPollylineResponseModel?> getRoute(
      double startLat, double startLng, double endLat, double endLng) async {
    try {
      PolylineService()
          .getRoute(startLat, startLng, endLat, endLng)
          .then((value) async {
        if (value!.routes != null) {
          await getPolyline(startLat, startLng, endLat, endLng);

          calculatedRouteDistance.value =
              "${((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
          calculatedRouteTime.value =
              "${int.parse(value.routes![0].duration!.split("s")[0]) ~/ 3600} saat ${((int.parse(value.routes![0].duration!.split("s")[0]) / 60) % 60).toInt()} dk";
          int calculatedTime =
              int.parse(value.routes![0].duration!.split("s")[0]);
          calculatedRouteTime.value =
              "${calculatedTime ~/ 3600} saat ${((calculatedTime / 60) % 60).toInt()} dk";
          calculatedRouteTimeInt = ((calculatedTime ~/ 3600) * 60) +
              ((calculatedTime / 60) % 60).toInt();
          routePolyline.value = value.routes![0].polyline!.encodedPolyline!;
          routePolyline.value = value.routes![0].polyline!.encodedPolyline!;
          print("GETPOLYLİNE -> $routePolyline");
          dateTimeFormatArrival.value =
              DateFormat('yyyy-MM-dd HH:mm').format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            DateTime.now().hour,
            DateTime.now().minute,
          ).add(
            Duration(
              minutes: calculatedRouteTimeInt,
            ),
          ));
          arrivalController.value.text = dateTimeFormatArrival.value;

          mapPageMController.addMarkerIcon(
            location: LatLng(endLat, endLng),
            markerID: 'myLocationFinishMarker',
          );

          Map<String, double> midPoint =
              calculateMiddleroute(startLat, startLng, endLat, endLng);
          LatLng middRoute =
              LatLng(midPoint['latitude']!, midPoint['longitude']!);

          print(
              "distamce merter -> ${((value.routes![0].distanceMeters)! / 1000)}");
          int distanceMeters = int.parse(
              ((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0));

          calculatedRouteDistance.value = distanceMeters.toString();

          print("DİSTANCEMETERS -> ${distanceMeters}");
          double zoom = 5;

          if (distanceMeters < 3) {
            zoom = 18;
          } else if (distanceMeters < 10) {
            zoom = 12;
          } else if (distanceMeters < 50) {
            zoom = 10;
          } else if (distanceMeters < 150) {
            zoom = 9;
          } else if (distanceMeters < 350) {
            zoom = 8;
          } else if (distanceMeters < 550) {
            zoom = 7;
          } else if (distanceMeters < 900) {
            zoom = 6;
          } else if (distanceMeters < 1200) {
            zoom = 5.5;
          } else {
            zoom = 5;
          }
          mapPageMController.mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 0,
                tilt: 180,
                target: middRoute,
                // LatLng(mid.latitude, 34.261775
                //     //     // getMyCurrentLocationController.myLocationLatitudeDo.value,
                //     //     //getMyCurrentLocationController.myLocationLongitudeDo.value
                //     ),
                zoom: zoom,
              ),
            ),
          );
          print(
              "CREATEROUTE START -> ${startRouteCity.value} finif -> ${finishRouteCity.value}");
          print("CALCULATEDİSTANCE -> ${calculatedRouteDistance.value}");
        }
      });
    } catch (e) {
      print("Get polyline error -> $e");
    }
    return null;
  }

  double toRadians(double degrees) => degrees * (pi / 180.0);
  double toDegrees(double radians) => radians * (180.0 / pi);

  Map<String, double> calculateMiddleroute(
      double lat1, double lon1, double lat2, double lon2) {
    double lat1Rad = toRadians(lat1);
    double lon1Rad = toRadians(lon1);
    double lat2Rad = toRadians(lat2);
    double lon2Rad = toRadians(lon2);

    double dLon = lon2Rad - lon1Rad;

    double x = cos(lat2Rad) * cos(dLon);
    double y = cos(lat2Rad) * sin(dLon);

    double midLatRad = atan2(
      sin(lat1Rad) + sin(lat2Rad),
      sqrt(
        (cos(lat1Rad) + x) * (cos(lat1Rad) + x) + y * y,
      ),
    );

    double midLonRad = lon1Rad + atan2(y, cos(lat1Rad) + x);

    double midLat = toDegrees(midLatRad);
    double midLon = toDegrees(midLonRad);

    // return LatLng(midLat, midLon);
    print("ORTANOKTASI -> ${midLon}");
    return {'latitude': midLat, 'longitude': midLon};
  }

  @override
  getPolyline(
      double startLat, double startLng, double endLat, double endLng) async {
    try {
      await PolylineService()
          .getPolyline(startLat, startLng, endLat, endLng)
          .then((value) {
        print("GETPOLYLİNE -> ${value}");
        mapPageMController.polylines.add(value!);
      });
    } catch (e) {
      print("createroutecontroller Get polyline error -> $e");
    }
    return null;
  }

  void routeControllerClear() {
    startRouteLocation = const LatLng(0.0, 0.0).obs;
    startRouteAdress = "".obs;
    startRouteCity.value = "";

    finishRouteLocation = const LatLng(0.0, 0.0).obs;
    finishRouteAdress = "".obs;
    finishRouteCity.value = "";

    routePolyline.value = "";

    calculatedRouteDistance = "".obs;
    calculatedRouteTime = "".obs;
    calculatedRouteTimeInt = 0;

    isOpenRouteDetailEntrySection = false.obs;
    departureController = TextEditingController().obs;
    arrivalController = TextEditingController().obs;
    mapPageMController.polylines.value.clear();
    mapPageMController.polylineCoordinates.clear();
  }

  createRoute() {
    CreatePostPageController createPostPageController =
        Get.put(CreatePostPageController());

    if (departureController.value.text.isEmpty) {
      Get.snackbar(
        "",
        'Lütfen Çıkış Tarihi giriniz.',
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //       'Lütfen Çıkış Tarihi giriniz.',
      //     ),
      //   ),
      // );
    } else if (arrivalController.value.text.isEmpty) {
      Get.snackbar(
        "",
        'Lütfen Varış Tarihi giriniz.',
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //       'Lütfen Varış Tarihi giriniz.',
      //     ),
      //   ),
      // );
    } else {
      try {
        print(
            "ROTANIZINBİTİSSAATİ arrival  -> ${arrivalController.value.text} depar -> ${departureController.value.text}");

        UiHelper.showLoadingAnimation();
        GeneralServicesTemp().makePostRequest(
          EndPoint.routesNew,
          PostCreateRouteRequestModel(
            departureDate: departureController.value.text,
            arrivalDate: arrivalController.value.text,
            routeDescription: routeDescriptionController.text == ""
                ? "${departureController.value.text} tarihinde ${startRouteCity.value} şehrinden başlayan yolculuk ${arrivalController.value.text} tarihinde ${finishRouteCity.value} şehrinde son bulacak."
                : routeDescriptionController.text,
            vehicleCapacity: 100,
            startingCoordinates: [
              startRouteLocation.value.latitude,
              startRouteLocation.value.longitude
            ],
            startingOpenAdress: startRouteAdress.value,
            startingCity: startRouteCity.value,
            endingCoordinates: [
              finishRouteLocation.value.latitude,
              finishRouteLocation.value.longitude
            ],
            endingOpenAdress: finishRouteAdress.value,
            endingCity: finishRouteCity.value,
            distance: int.parse(calculatedRouteDistance.value
                .replaceAll(RegExp(r'[^0-9]'), '')),
            travelTime: calculatedRouteTimeInt,
            polylineEncode: routePolyline.value,
          ),
          {
            "Content-type": "application/json",
            'Authorization':
                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
          },
        ).then(
          (value) async {
            if (value != null) {
              final response =
                  PostCreateRouteResponseModel.fromJson(jsonDecode(value));
              print(
                  "ROTANIZINBİTİSSAATİ createroute ->  ${jsonEncode(response)}");
              print("DEPARTUREFORMAT _> ${dateTimeFormatDeparture.value}");
              if (response.success == 1) {
                createPostPageController.routeId.value = response.data![0].id!;

                int startMinute =
                    DateTime.parse(dateTimeFormatDeparture.value).minute - 5;
                int endMinute =
                    DateTime.parse(dateTimeFormatDeparture.value).minute + 5;

                int currentMinute = DateTime.now().minute;
                if (DateTime.now().day.toString() ==
                    DateTime.parse(dateTimeFormatDeparture.value)
                        .day
                        .toString()) {
                  if (currentMinute >= startMinute &&
                      currentMinute <= endMinute) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text("UYARI!"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                Text(
                                  "Görünüşe göre anlık bir rota oluşturdunuz.",
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
                              "Rotayı başlatmak ister misiniz?",
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
                                padding: EdgeInsets.only(
                                    bottom: 12.w, right: 12.w, left: 12.w),
                                child: CustomButtonDesign(
                                  text: 'Rotayı Başlat',
                                  textColor: AppConstants().ltWhite,
                                  onpressed: () {
                                    BerkayController berkayController =
                                        Get.find<BerkayController>();
                                    berkayController.isAlreadyHaveRoute =
                                        true.obs;

                                    GeneralServicesTemp().makePatchRequest(
                                      EndPoint.activateRoute,
                                      ActivateRouteRequestModel(
                                          routeId: response.data![0].id),
                                      {
                                        "Content-type": "application/json",
                                        'Authorization':
                                            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                      },
                                    ).then((value) async {
                                      print("başlattımm 3-> ");
                                      ActivateRouteResponseModel response =
                                          ActivateRouteResponseModel.fromJson(
                                              jsonDecode(value!));

                                      if (response.success == 1) {
                                        print("başlattımm 4-> ");
                                        String tarihiAl(String text) {
                                          text = text.replaceAll('┤', '');
                                          text = text.replaceAll('├', '');
                                          String datePart = text.split(' ')[0];
                                          return datePart;
                                        }

                                        print("başlattımm 5-> ");
                                        String varisdate = tarihiAl(
                                            arrivalController.value.text);
                                        String cikisdate = tarihiAl(
                                            departureController.value.text);

                                        createPostPageController.update();

                                        createPostPageController
                                            .routeStartDate.value = cikisdate;
                                        createPostPageController
                                            .routeEndDate.value = varisdate;
                                        createPostPageController
                                                .routeContent.value =
                                            "${startRouteCity.value} -> ${finishRouteCity.value}";
                                        print("başlattımm 6-> ");
                                        await Get.dialog(RouteAlertDialog()
                                            .showShareRouteAllertDialog(
                                          "${startRouteCity.value} -> ${finishRouteCity.value}",
                                          (LocaleManager.instance.getString(
                                              PreferencesKeys
                                                  .currentUserUserName)),
                                          dateTimeFormatDeparture.value
                                              .toString()
                                              .substring(0, 11),
                                          dateTimeFormatArrival.value
                                              .toString()
                                              .substring(0, 11),
                                          0,
                                        ));

                                        UiHelper.showLoadingAnimation();

                                        await mapPageMController.getMyRoutes();
                                        // await GeneralServicesTemp()
                                        //     .makeGetRequest(
                                        //   EndPoint.getMyRoutes,
                                        //   {
                                        //     "Content-type": "application/json",
                                        //     'Authorization':
                                        //         'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                        //   },
                                        // ).then((value) async {
                                        //   GoogleMapController
                                        //       googleMapController =
                                        //       mapPageMController.mapController;
                                        //   googleMapController.animateCamera(
                                        //     CameraUpdate.newCameraPosition(
                                        //       CameraPosition(
                                        //         bearing: 90,
                                        //         target: LatLng(
                                        //           currentLocationController
                                        //               .myLocationLatitudeDo
                                        //               .value,
                                        //           currentLocationController
                                        //               .myLocationLongitudeDo
                                        //               .value,
                                        //         ),
                                        //         zoom: 10,
                                        //       ),
                                        //     ),
                                        //   );
                                        //   print("başlattımm 9-> ");
                                        //   await mapPageMController
                                        //       .getUsersOnArea(carTypeFilter: [
                                        //     "Otomobil",
                                        //     "Tır",
                                        //     "Motorsiklet"
                                        //   ]);
                                        // });

                                        BottomNavigationBarController
                                            bottomNavigationBarController =
                                            Get.find<
                                                BottomNavigationBarController>();
                                        bottomNavigationBarController
                                            .selectedIndex.value = 1;

                                        Get.back(); //showLoadingAnimation kapatmak  için
                                      } else {
                                        print("başlattımm 16-> ");
                                        Get.back(closeOverlays: true);
                                        Get.snackbar(
                                            "Hata!", "${response.message}",
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: AppConstants().ltBlack);
                                      }
                                    });
                                  },
                                  iconPath: '',
                                  color: AppConstants().ltMainRed,
                                  height: 50.h,
                                  width: 341.w,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 12.w, right: 12.w, left: 12.w),
                                child: CustomButtonDesign(
                                  text: 'Rotayı Başlatma',
                                  textColor: AppConstants().ltWhite,
                                  onpressed: () async {
                                    mapPageMController.isLoading.value = true;
                                    await Get.dialog(RouteAlertDialog()
                                        .showShareRouteAllertDialog(
                                            "${startRouteCity.value} -> ${finishRouteCity.value}",
                                            (LocaleManager.instance.getString(
                                                PreferencesKeys
                                                    .currentUserUserName)),
                                            departureController.value.text
                                                .toString()
                                                .substring(0, 11),
                                            arrivalController.value.text
                                                .toString()
                                                .substring(0, 11),
                                            0));

                                    await mapPageMController.getMyRoutes(
                                        isStartRoute: false);
                                    mapPageMController.polylines.clear();
                                    mapPageMController.polylineCoordinates
                                        .clear();
                                    mapPageMController.isLoading.value = false;
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
                      ),
                    );
                  } else {
                    print("BURDAYIMMM");
                    Get.dialog(RouteAlertDialog().showShareRouteAllertDialog(
                      "${startRouteCity.value} -> ${finishRouteCity.value}",
                      (LocaleManager.instance
                          .getString(PreferencesKeys.currentUserUserName)),
                      dateTimeFormatDeparture.value.toString().substring(0, 11),
                      dateTimeFormatArrival.value.toString().substring(0, 11),
                      0,
                    ));
                    await mapPageMController.getMyRoutes();
                    // Get.back();
                  }
                } else {
                  print("BURDAYIMMM");
                  Get.dialog(RouteAlertDialog().showShareRouteAllertDialog(
                    "${startRouteCity.value} -> ${finishRouteCity.value}",
                    (LocaleManager.instance
                        .getString(PreferencesKeys.currentUserUserName)),
                    dateTimeFormatDeparture.value.toString().substring(0, 11),
                    dateTimeFormatArrival.value.toString().substring(0, 11),
                    0,
                  ));
                }
              } else if (response.success == -1) {
                createPostPageController.routeId.value = response.data![0].id!;
                print("ROTASİLOLUŞTUR -> ${jsonEncode(response)}");
                Get.dialog(
                  RouteAlertDialog()
                      .showSelectDeleteOrShareDialog(response.data![0].id!),
                );
              } else {
                createPostPageController.routeId.value = response.data![0].id!;
                Get.snackbar("",
                    'Bir hata oluştu... Lütfen daha sonra tekrar deneyiniz.');

                Get.back();
              }
            }
          },
        );
      } catch (e) {
        print("CREATEROUTE ERROR -> $e");
      }
    }
  }
}
