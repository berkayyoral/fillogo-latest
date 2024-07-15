import 'dart:convert';
import 'dart:convert' as convert;

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_view/components/map_page_controller.dart';
import 'package:fillogo/widgets/custom_red_button.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/bottom_navigation_bar_controller.dart';
import '../../controllers/map/get_current_location_and_listen.dart';
import '../../widgets/google_maps_widgets/general_map_view_class.dart';
import 'components/route_detail_view_card.dart';
import 'components/route_details_page_controller.dart';
import 'components/selected_route_controller.dart';

class RouteDetailsPageView extends StatelessWidget {
  RouteDetailsPageView({super.key, required this.routeId});

  int routeId;
  //  String iconPath = carType == "Otomobil"
  //             ? 'assets/icons/friendsLocationLightCommercial.png'
  //             : carType == "Tır"
  //                 ? 'assets/icons/friendsLocationTruck.png'
  //                 : 'assets/icons/friendsLocationMotorcycle.png';
  //         print("MATCHİNGROTADATA CAR TYPE -> $iconPath");

  RouteDetailsPageController routeDetailsPageController =
      Get.find<RouteDetailsPageController>();
  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();
  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  BerkayController berkayController = Get.put(BerkayController());

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
      target: LatLng(
        getMyCurrentLocationController.myLocationLatitudeDo.value,
        getMyCurrentLocationController.myLocationLongitudeDo.value,
      ),
      zoom: 14.0,
    );
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 5.h,
            ),
            child: SvgPicture.asset(
              height: 25.h,
              width: 25.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Rota Detayı",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: GetBuilder<RouteDetailsPageController>(
        init: routeDetailsPageController,
        initState: (_) async {},
        builder: (routeDetailsPageController) {
          print(
              "asdasd11 ${routeDetailsPageController.ownerRouteCarType.carBrand}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        if (routeDetailsPageController.isThisRouteMine.value) {
                          Get.back();
                          bottomNavigationBarController.selectedIndex.value = 3;
                        } else {
                          Get.toNamed(NavigationConstants.otherprofiles,
                              arguments: selectedRouteController
                                  .selectedRouteUserId.value);
                        }
                      },
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
                        Text(
                          "${routeDetailsPageController.ownerRouteCarType.carBrand} / ${routeDetailsPageController.ownerRouteCarType.carModel}",
                          style: TextStyle(
                            fontFamily: 'Sfmedium',
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 20, bottom: 20),
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
                endAdress:
                    routeDetailsPageController.ownerRouteFinishCity.value,
                endDateTime: routeDetailsPageController
                    .ownerRouteCalculatedRouteTime.value,
                id: 1,
                startAdress:
                    routeDetailsPageController.ownerRouteStartCity.value,
                startDateTime: routeDetailsPageController
                    .ownerRouteCalculatedRouteDistance.value,
                userName:
                    "${routeDetailsPageController.ownerRouteName.value} ${routeDetailsPageController.ownerRouteSurname.value}",
              ),
              SizedBox(
                height: 260.h,
                width: Get.width,
                child: GeneralMapViewClass(
                  markerSet:
                      Set<Marker>.from(routeDetailsPageController.markers),
                  initialCameraPosition: initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onCameraMoveStarted: () {},
                  onCameraMove: (p0) {},
                  polygonsSet: const <Polygon>{},
                  tileOverlaysSet: const <TileOverlay>{},
                  polylinesSet: Set<Polyline>.of(
                      routeDetailsPageController.generalPolylines),
                  mapController2: (GoogleMapController controller) async {
                    routeDetailsPageController.routeDetailsMapController
                        .complete(controller);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20),
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
                        width: 340.w,
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
              10.h.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                      width: 240.w,
                      child: Visibility(
                        visible: berkayController.canVisible.value,
                        child: CustomRedButton(
                            title: "Rotaya Başla",
                            onTap: () {
                              GeneralServicesTemp().makePatchRequest(
                                EndPoint.activateRoute,
                                ActivateRouteRequestModel(
                                    routeId: selectedRouteController
                                        .selectedRouteId.value),
                                {
                                  "Content-type": "application/json",
                                  'Authorization':
                                      'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                },
                              ).then((value) async {
                                BerkayController berkayController =
                                    Get.find<BerkayController>();
                                berkayController.isAlreadyHaveRoute = true.obs;
                                ActivateRouteResponseModel response =
                                    ActivateRouteResponseModel.fromJson(
                                        jsonDecode(value!));
                                if (response.success == 1) {
                                  // Get.back(closeOverlays: true);
                                  MapPageController mapPageController =
                                      Get.find();
                                  SetCustomMarkerIconController
                                      setCustomMarkerIconController =
                                      Get.put(SetCustomMarkerIconController());
                                  mapPageController
                                      .getMyFriendsRoutesRequestRefreshable(
                                          context);
                                  // mapPageController.getMyRoutesServicesRequestRefreshable();

                                  await GeneralServicesTemp()
                                      .makeGetRequest(
                                    EndPoint.getMyRoutes,
                                    ServicesConstants.appJsonWithToken,
                                  )
                                      .then((value) async {
                                    GetMyRouteResponseModel
                                        getMyRouteResponseModel =
                                        GetMyRouteResponseModel.fromJson(
                                            convert.json.decode(value!));
                                    mapPageController.myAllRoutes =
                                        getMyRouteResponseModel
                                            .data![0].allRoutes;
                                    GoogleMapController googleMapController =
                                        await mapPageController
                                            .mapCotroller3.future;
                                    googleMapController.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          bearing: 90,
                                          target: LatLng(
                                            getMyCurrentLocationController
                                                .myLocationLatitudeDo.value,
                                            getMyCurrentLocationController
                                                .myLocationLongitudeDo.value,
                                          ),
                                          zoom: 10,
                                        ),
                                      ),
                                    );

                                    mapPageController.myActivesRoutes =
                                        mapPageController
                                            .myAllRoutes!.activeRoutes;
                                    mapPageController.myPastsRoutes =
                                        mapPageController
                                            .myAllRoutes!.pastRoutes;
                                    mapPageController.mynotStartedRoutes =
                                        mapPageController
                                            .myAllRoutes!.notStartedRoutes;

                                    mapPageController
                                            .mapPageRouteStartLatitude.value =
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .startingCoordinates![0];
                                    mapPageController
                                            .mapPageRouteStartLongitude.value =
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .startingCoordinates![1];
                                    mapPageController.startLatLong = LatLng(
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .startingCoordinates![0],
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .startingCoordinates![1]);

                                    mapPageController
                                            .mapPageRouteFinishLatitude.value =
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .endingCoordinates![0];
                                    mapPageController
                                            .mapPageRouteFinishLongitude.value =
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .endingCoordinates![1];
                                    mapPageController.finishLatLong = LatLng(
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .endingCoordinates![0],
                                        mapPageController
                                            .myAllRoutes!
                                            .activeRoutes![0]
                                            .endingCoordinates![1]);
                                    mapPageController
                                            .generalPolylineEncode.value =
                                        mapPageController.myAllRoutes!
                                            .activeRoutes![0].polylineEncode!;

                                    mapPageController.addPointIntoPolylineList(
                                        mapPageController
                                            .generalPolylineEncode.value);
                                    mapPageController
                                        .addMarkerFunctionForMapPageWithoutOnTap(
                                      MarkerId(
                                          "myRouteStartMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                      LatLng(
                                          mapPageController
                                              .myAllRoutes!
                                              .activeRoutes![0]
                                              .startingCoordinates![0],
                                          mapPageController
                                              .myAllRoutes!
                                              .activeRoutes![0]
                                              .startingCoordinates![1]),
                                      "${mapPageController.myAllRoutes!.activeRoutes![0].startingOpenAdress}",
                                      mapPageController.myAllRoutes!
                                                  .activeRoutes![0].id
                                                  .toString() ==
                                              "myLocationMarker"
                                          ? BitmapDescriptor.fromBytes(
                                              setCustomMarkerIconController
                                                  .myRouteStartIcon!)
                                          : BitmapDescriptor.fromBytes(
                                              setCustomMarkerIconController
                                                  .myFriendsLocation!),
                                    );
                                    mapPageController
                                        .addMarkerFunctionForMapPageWithoutOnTap(
                                      MarkerId(
                                          "myRouteFinishMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                      LatLng(
                                          mapPageController
                                              .myAllRoutes!
                                              .activeRoutes![0]
                                              .endingCoordinates![0],
                                          mapPageController
                                              .myAllRoutes!
                                              .activeRoutes![0]
                                              .endingCoordinates![1]),
                                      "${mapPageController.myAllRoutes!.activeRoutes![0].endingOpenAdress}",
                                      BitmapDescriptor.fromBytes(
                                          setCustomMarkerIconController
                                              .myRouteFinishIcon!),
                                    );
                                  });
                                  bottomNavigationBarController
                                      .selectedIndex.value = 1;
                                  mapPageController.selectedDispley(5);
                                  Get.toNamed(
                                      NavigationConstants.bottomNavigationBar);
                                  Get.snackbar("Başarılı",
                                      "Başarıyla Rotaya Başlanıldı!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: AppConstants().ltBlack);
                                } else {
                                  Get.back(closeOverlays: true);
                                  Get.snackbar("Hata!", "${response.message}",
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: AppConstants().ltBlack);
                                }
                              });
                            }),
                      )),
                ),
              )
              // Padding(
              //   padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20),
              //   child: Container(
              //     height: 70.h,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(
              //           8.r,
              //         ),
              //       ),
              //       color: AppConstants().ltWhiteGrey,
              //     ),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 340.w,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: EdgeInsets.symmetric(
              //                   horizontal: 10.w,
              //                 ),
              //                 child: SvgPicture.asset(
              //                   'assets/icons/truck-tick.svg',
              //                   height: 40.w,
              //                   width: 40.w,
              //                   color: AppConstants().ltMainRed,
              //                 ),
              //               ),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                       left: 4.w,
              //                       right: 10.w,
              //                     ),
              //                     child: Text(
              //                       'Doluluk Oranı:',
              //                       style: TextStyle(
              //                         fontFamily: 'Sflight',
              //                         fontSize: 12.sp,
              //                         color: AppConstants().ltDarkGrey,
              //                       ),
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: EdgeInsets.only(
              //                       left: 4.w,
              //                       right: 10.w,
              //                     ),
              //                     child: Text(
              //                       '%80',
              //                       style: TextStyle(
              //                         fontFamily: 'Sfmedium',
              //                         fontSize: 14.sp,
              //                         color: AppConstants().ltLogoGrey,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: 16.w, right: 16.w, top: 20, bottom: 30),
              //   child: RedButton(
              //     text: 'Profile Git',
              //     onpressed: () {
              //       Get.back();
              //       if (routeDetailsPageController.isThisRouteMine.value) {
              //         Get.back();
              //         bottomNavigationBarController.selectedIndex.value = 3;
              //       } else {
              //         Get.toNamed(NavigationConstants.otherprofiles,
              //             arguments: selectedRouteController
              //                 .selectedRouteUserId.value);
              //       }
              //     },
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}

// class RouteDetailsPageView extends StatefulWidget {
//   @override
//   _RouteDetailsPageViewState createState() => _RouteDetailsPageViewState();
// }

// StartEndAdressController startEndAdressController =
//     Get.find<StartEndAdressController>();
// RouteCalculatesViewController currentLocation = Get.find();

// SetCustomMarkerIconController customMarkerIconController = Get.find();

// class _RouteDetailsPageViewState extends State<RouteDetailsPageView> {
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//     _getAddress();
//     if (markers.isNotEmpty) markers.clear();
//     if (polylines.isNotEmpty) polylines.clear();
//     if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
//     _placeDistance = null;
//     _calculateDistance().then(
//       (isCalculated) {
//         if (isCalculated) {
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 'Bir hata oluştu! Lütfen tekrar deneyiniz.',
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   CameraPosition initialLocation = CameraPosition(
//     target:
//         LatLng(currentLocation.latitude.value, currentLocation.longitude.value),
//     zoom: 15.0,
//   );
//   late GoogleMapController mapController;

//   late Position _currentPosition;
//   String _currentAddress = '';

//   String _startAddress = startEndAdressController.startAdress.value;
//   String _destinationAddress = startEndAdressController.endAdress.value;
//   String? _placeDistance;

//   Set<Marker> markers = {};

//   late PolylinePoints polylinePoints;
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];

//   bool onTapThreePointButton = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {},
//                     child: ProfilePhoto(
//                       height: 48.h,
//                       width: 48.w,
//                       url: 'https://picsum.photos/150',
//                     ),
//                   ),
//                   12.w.spaceX,
//                   SizedBox(
//                     width: 283.w,
//                     child: EmotionAndTagStringCreatePost(
//                       name: 'Ahmet Pehlivan',
//                       usersTagged: const [
//                         'Furkan Semiz',
//                         'Doğukan Tek',
//                         'İnanç Telci',
//                         'Berkay Oral',
//                       ],
//                       emotion: 'https://picsum.photos/150',
//                       emotionContent: 'mutlu hissediyor',
//                       haveTag: 1,
//                       haveEmotion: true,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             20.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: RichText(
//                 text: TextSpan(
//                   text:
//                       '''Akşam 8’de ${startEndAdressController.startAdress.value}'dan yola çıkacağım, 12 saat sürecek yarın 10 gibi ${startEndAdressController.endAdress.value}'da olacağım. Yolculuk sırasında Çorumda mola vereceğim. Eğer yükü olan varsa alabilirim.''',
//                   style: TextStyle(
//                     color: AppConstants().ltLogoGrey,
//                     fontFamily: 'SFregular',
//                     fontSize: 14.sp,
//                   ),
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: Container(
//                 height: 70.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.r,
//                     ),
//                   ),
//                   color: AppConstants().ltWhiteGrey,
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 290.w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10.w,
//                             ),
//                             child: SvgPicture.asset(
//                               'assets/icons/route-icon.svg',
//                               height: 40.w,
//                               width: 40.w,
//                               color: AppConstants().ltMainRed,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   'Ahmet Pehlivan',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   '${startEndAdressController.startAdress.value} -> ${startEndAdressController.endAdress.value}',
//                                   style: TextStyle(
//                                     fontFamily: 'Sfmedium',
//                                     fontSize: 14.sp,
//                                     color: AppConstants().ltLogoGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   top: 2.w,
//                                   left: 4.w,
//                                   right: 4.w,
//                                 ),
//                                 child: Text(
//                                   'Tahmini: 741 km ve 9 Saat 46 Dakika',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             // Map View
//             SizedBox(
//               height: 260.h,
//               width: Get.width,
//               child: GoogleMap(
//                 markers: Set<Marker>.from(markers),
//                 initialCameraPosition: initialLocation,
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: false,
//                 mapType: MapType.normal,
//                 zoomGesturesEnabled: true,
//                 zoomControlsEnabled: true,
//                 polylines: Set<Polyline>.of(polylines.values),
//                 onMapCreated: (GoogleMapController controller) {
//                   mapController = controller;
//                 },
//               ),
//             ),
//             20.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: Container(
//                 height: 70.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.r,
//                     ),
//                   ),
//                   color: AppConstants().ltWhiteGrey,
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 340.w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10.w,
//                             ),
//                             child: SvgPicture.asset(
//                               'assets/icons/calendar-tick.svg',
//                               height: 40.w,
//                               width: 40.w,
//                               color: AppConstants().ltMainRed,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   'Çıkış Tarihi:',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   '13 Ocak, 2023',
//                                   style: TextStyle(
//                                     fontFamily: 'Sfmedium',
//                                     fontSize: 14.sp,
//                                     color: AppConstants().ltLogoGrey,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10.w,
//                             ),
//                             child: SvgPicture.asset(
//                               'assets/icons/line-icon.svg',
//                               height: 40.w,
//                               width: 40.w,
//                               color: AppConstants().ltMainRed,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   'Varış Tarihi:',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   '13 Ocak, 2023',
//                                   style: TextStyle(
//                                     fontFamily: 'Sfmedium',
//                                     fontSize: 14.sp,
//                                     color: AppConstants().ltLogoGrey,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             10.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: Container(
//                 height: 70.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.r,
//                     ),
//                   ),
//                   color: AppConstants().ltWhiteGrey,
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 340.w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10.w,
//                             ),
//                             child: SvgPicture.asset(
//                               'assets/icons/truck-tick.svg',
//                               height: 40.w,
//                               width: 40.w,
//                               color: AppConstants().ltMainRed,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   'Doluluk Oranı:',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   '%80',
//                                   style: TextStyle(
//                                     fontFamily: 'Sfmedium',
//                                     fontSize: 14.sp,
//                                     color: AppConstants().ltLogoGrey,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: GestureDetector(
//                 onTap: () {
//                   Get.toNamed('/otherprofiles');
//                 },
//                 child: Container(
//                   height: 50.h,
//                   width: 340.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         8.r,
//                       ),
//                     ),
//                     color: AppConstants().ltMainRed,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Profile Git',
//                       style: TextStyle(
//                         fontFamily: 'Sfbold',
//                         fontSize: 16.sp,
//                         color: AppConstants().ltWhite,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             40.h.spaceY,
//           ],
//         ),
//       ),
//     );
//   }

//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         print('CURRENT POS: $_currentPosition');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(
//                 currentLocation.latitude.value,
//                 currentLocation.longitude.value,
//               ),
//               zoom: 20,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddress() async {
//     try {
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);
//       Placemark place = p[0];
//       setState(() {
//         _currentAddress =
//             "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<bool> _calculateDistance() async {
//     try {
//       List<Location> startPlacemark = await locationFromAddress(_startAddress);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(_destinationAddress);
//       // Use the retrieved coordinates of the current position,
//       // instead of the address if the start position is user's
//       // current position, as it results in better accuracy.
//       double startLatitude = _startAddress == _currentAddress
//           ? _currentPosition.latitude
//           : startPlacemark[0].latitude;

//       double startLongitude = _startAddress == _currentAddress
//           ? _currentPosition.longitude
//           : startPlacemark[0].longitude;

//       double destinationLatitude = destinationPlacemark[0].latitude;

//       double destinationLongitude = destinationPlacemark[0].longitude;

//       String startCoordinatesString = '($startLatitude, $startLongitude)';
//       String destinationCoordinatesString =
//           '($destinationLatitude, $destinationLongitude)';

//       // Start Location Marker
//       Marker startMarker = Marker(
//         markerId: MarkerId(startCoordinatesString),
//         position: LatLng(startLatitude, startLongitude),
//         infoWindow: InfoWindow(
//           title: 'Start $startCoordinatesString',
//           snippet: _startAddress,
//         ),
//         icon: BitmapDescriptor.fromBytes(
//           customMarkerIconController.currentIcon!,
//         ),
//       );

//       // Destination Location Marker
//       Marker destinationMarker = Marker(
//         markerId: MarkerId(destinationCoordinatesString),
//         position: LatLng(destinationLatitude, destinationLongitude),
//         infoWindow: InfoWindow(
//           title: 'Destination $destinationCoordinatesString',
//           snippet: _destinationAddress,
//         ),
//         icon: BitmapDescriptor.fromBytes(
//           customMarkerIconController.markerIcon!,
//         ),
//       );

//       // Adding the markers to the list
//       markers.add(startMarker);
//       markers.add(destinationMarker);

//       print(
//         'START COORDINATES: ($startLatitude, $startLongitude)',
//       );
//       print(
//         'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
//       );

//       // Calculating to check that the position relative
//       // to the frame, and pan & zoom the camera accordingly.
//       double miny = (startLatitude <= destinationLatitude)
//           ? startLatitude
//           : destinationLatitude;
//       double minx = (startLongitude <= destinationLongitude)
//           ? startLongitude
//           : destinationLongitude;
//       double maxy = (startLatitude <= destinationLatitude)
//           ? destinationLatitude
//           : startLatitude;
//       double maxx = (startLongitude <= destinationLongitude)
//           ? destinationLongitude
//           : startLongitude;

//       double southWestLatitude = miny;
//       double southWestLongitude = minx;

//       double northEastLatitude = maxy;
//       double northEastLongitude = maxx;

//       // Accommodate the two locations within the
//       // camera view of the map
//       mapController.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             northeast: LatLng(northEastLatitude, northEastLongitude),
//             southwest: LatLng(southWestLatitude, southWestLongitude),
//           ),
//           100.0,
//         ),
//       );

//       // Calculating the distance between the start and the end positions
//       // with a straight path, without considering any route
//       // double distanceInMeters = await Geolocator.bearingBetween(
//       //   startLatitude,
//       //   startLongitude,
//       //   destinationLatitude,
//       //   destinationLongitude,
//       // );

//       await _createPolylines(startLatitude, startLongitude, destinationLatitude,
//           destinationLongitude);

//       double totalDistance = 0.0;

//       // Calculating the total distance by adding the distance
//       // between small segments
//       for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//         print("AAAAAAAAA polylineCoordinates.length " +
//             polylineCoordinates.length.toString());
//         totalDistance += _coordinateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude,
//         );
//       }
//       print("AAAAAAAAA polylineCoordinates " + polylineCoordinates.toString());

//       setState(() {
//         _placeDistance = totalDistance.toStringAsFixed(2);
//         print('DISTANCE: $_placeDistance km');
//       });

//       return true;
//     } catch (e) {
//       print(e);
//     }
//     print("AAAAAAAAA  222222");
//     return false;
//   }

//   // Formula for calculating distance between two coordinates
//   // https://stackoverflow.com/a/54138876/11910277
//   double _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   _createPolylines(
//     double startLatitude,
//     double startLongitude,
//     double destinationLatitude,
//     double destinationLongitude,
//   ) async {
//     polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       Secrets.apiKey,
//       PointLatLng(startLatitude, startLongitude),
//       PointLatLng(destinationLatitude, destinationLongitude),
//       travelMode: TravelMode.walking,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }

//     PolylineId id = PolylineId('1');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: AppConstants().ltMainRed,
//       points: polylineCoordinates,
//       width: 4,
//     );
//     polylines[id] = polyline;
//   }
// }

// class Secrets {
//   // Add your Google Maps API Key here
//   static const apiKey = 'AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8';
// }
