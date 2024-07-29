import 'dart:convert';
import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
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

  final int routeId;
  //  String iconPath = carType == "Otomobil"
  //             ? 'assets/icons/friendsLocationLightCommercial.png'
  //             : carType == "Tır"
  //                 ? 'assets/icons/friendsLocationTruck.png'
  //                 : 'assets/icons/friendsLocationMotorcycle.png';
  //         print("MATCHİNGROTADATA CAR TYPE -> $iconPath");

  final RouteDetailsPageController routeDetailsPageController =
      Get.find<RouteDetailsPageController>();
  final GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();
  final SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();
  final BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  final BerkayController berkayController = Get.put(BerkayController());

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
                  "asd " +
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
                                  // MapPageController mapPageController =
                                  //     Get.find();
                                  MapPageMController mapPageController =
                                      Get.find();
                                  SetCustomMarkerIconController
                                      setCustomMarkerIconController =
                                      Get.put(SetCustomMarkerIconController());
                                  // mapPageController
                                  //     .getMyFriendsRoutesRequestRefreshable(
                                  //         context);
                                  // mapPageController.getMyRoutesServicesRequestRefreshable();

                                  await mapPageController.getMyRoutes();
                                  // await GeneralServicesTemp()
                                  //     .makeGetRequest(
                                  //   EndPoint.getMyRoutes,
                                  //   ServicesConstants.appJsonWithToken,
                                  // )
                                  //     .then((value) async {
                                  //   GetMyRouteResponseModel
                                  //       getMyRouteResponseModel =
                                  //       GetMyRouteResponseModel.fromJson(
                                  //           convert.json.decode(value!));
                                  //   mapPageController.myAllRoutes =
                                  //       getMyRouteResponseModel
                                  //           .data![0].allRoutes;
                                  //   GoogleMapController googleMapController =
                                  //       mapPageController.mapController;
                                  //   googleMapController.animateCamera(
                                  //     CameraUpdate.newCameraPosition(
                                  //       CameraPosition(
                                  //         bearing: 90,
                                  //         target: LatLng(
                                  //           getMyCurrentLocationController
                                  //               .myLocationLatitudeDo.value,
                                  //           getMyCurrentLocationController
                                  //               .myLocationLongitudeDo.value,
                                  //         ),
                                  //         zoom: 10,
                                  //       ),
                                  //     ),
                                  //   );
                                  //   // mapPageController.myActivesRoutes =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!.activeRoutes;
                                  //   // mapPageController.myPastsRoutes =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!.pastRoutes;
                                  //   // mapPageController.mynotStartedRoutes =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!.notStartedRoutes;
                                  //   // mapPageController
                                  //   //         .mapPageRouteStartLatitude.value =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .startingCoordinates![0];
                                  //   // mapPageController
                                  //   //         .mapPageRouteStartLongitude.value =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .startingCoordinates![1];
                                  //   // mapPageController.startLatLong = LatLng(
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .startingCoordinates![0],
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .startingCoordinates![1]);
                                  //   // mapPageController
                                  //   //         .mapPageRouteFinishLatitude.value =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .endingCoordinates![0];
                                  //   // mapPageController
                                  //   //         .mapPageRouteFinishLongitude.value =
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .endingCoordinates![1];
                                  //   // mapPageController.finishLatLong = LatLng(
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .endingCoordinates![0],
                                  //   //     mapPageController
                                  //   //         .myAllRoutes!
                                  //   //         .activeRoutes![0]
                                  //   //         .endingCoordinates![1]);
                                  //   // mapPageController
                                  //   //         .generalPolylineEncode.value =
                                  //   //     mapPageController.myAllRoutes!
                                  //   //         .activeRoutes![0].polylineEncode!;
                                  //   // mapPageController.addPointIntoPolylineList(
                                  //   //     mapPageController
                                  //   //         .generalPolylineEncode.value);
                                  //   // mapPageController
                                  //   //     .addMarkerFunctionForMapPageWithoutOnTap(
                                  //   //   MarkerId(
                                  //   //       "myRouteStartMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                  //   //   LatLng(
                                  //   //       mapPageController
                                  //   //           .myAllRoutes!
                                  //   //           .activeRoutes![0]
                                  //   //           .startingCoordinates![0],
                                  //   //       mapPageController
                                  //   //           .myAllRoutes!
                                  //   //           .activeRoutes![0]
                                  //   //           .startingCoordinates![1]),
                                  //   //   "${mapPageController.myAllRoutes!.activeRoutes![0].startingOpenAdress}",
                                  //   //   mapPageController.myAllRoutes!
                                  //   //               .activeRoutes![0].id
                                  //   //               .toString() ==
                                  //   //           "myLocationMarker"
                                  //   //       ? BitmapDescriptor.fromBytes(
                                  //   //           setCustomMarkerIconController
                                  //   //               .myRouteStartIcon!)
                                  //   //       : BitmapDescriptor.fromBytes(
                                  //   //           setCustomMarkerIconController
                                  //   //               .myFriendsLocation!),
                                  //   // );
                                  //   // mapPageController
                                  //   //     .addMarkerFunctionForMapPageWithoutOnTap(
                                  //   //   MarkerId(
                                  //   //       "myRouteFinishMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                  //   //   LatLng(
                                  //   //       mapPageController
                                  //   //           .myAllRoutes!
                                  //   //           .activeRoutes![0]
                                  //   //           .endingCoordinates![0],
                                  //   //       mapPageController
                                  //   //           .myAllRoutes!
                                  //   //           .activeRoutes![0]
                                  //   //           .endingCoordinates![1]),
                                  //   //   "${mapPageController.myAllRoutes!.activeRoutes![0].endingOpenAdress}",
                                  //   //   BitmapDescriptor.fromBytes(
                                  //   //       setCustomMarkerIconController
                                  //   //           .myRouteFinishIcon!),
                                  //   // );
                                  // });

                                  bottomNavigationBarController
                                      .selectedIndex.value = 1;
                                  // mapPageController.selectedDispley(5);

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
            ],
          );
        },
      ),
    );
  }
}
