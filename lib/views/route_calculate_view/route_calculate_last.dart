import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:fillogo/views/route_calculate_view/controller/route_calculate_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
// import 'package:geocoder2/geocoder2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import '../../controllers/map/get_current_location_and_listen.dart';
import '../map_page_new/controller/map_pagem_controller.dart';
import '../map_page_view/components/active_friends_list_display.dart';
import 'components/create_route_controller.dart';

import 'components/route_search_by_city_models.dart';

class RouteCalculateLastView extends StatelessWidget {
  RouteCalculateLastView({super.key});

  final CreateeRouteController createeRouteController =
      Get.find<CreateeRouteController>();

  CreateRouteController createRouteController = Get.find();

  //RouteCalculatesViewController currentLocation = Get.find();

  final GeneralDrawerController drawerController =
      Get.find<GeneralDrawerController>();

  final SetCustomMarkerIconController customMarkerIconController = Get.find();

  // final GetMyCurrentLocationController getMyCurrentLocationController =
  //     Get.find<GetMyCurrentLocationController>();
  MapPageMController mapPageMController = Get.put(MapPageMController());

  final NotificationController notificationController =
      Get.put(NotificationController());
  Completer<GoogleMapController> mapCotroller = Completer();
  final SearchRouteController searchRouteController =
      Get.put(SearchRouteController());

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
      target: LatLng(
        mapPageMController.myLocationLatitudeDo.value,
        mapPageMController.myLocationLongitudeDo.value,
      ),
      zoom: mapPageMController.zoom.value, //***  15.0,
    );
    return SafeArea(
      child: GetBuilder<CreateeRouteController>(
        id: "createRouteController",
        init: createeRouteController,
        initState: (_) {},
        builder: (_) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Obx(
              () => ((mapPageMController.myLocationLatitudeDo.value == 0.0) &&
                      (mapPageMController.myLocationLongitudeDo.value == 0.0))
                  ? const Center(
                      child:
                          CircularProgressIndicator()) //UiHelper.loadingAnimationWidget(context)
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        SizedBox(
                          height:
                              createeRouteController.calculateLevel.value == 2
                                  ? 350.h
                                  : Get.height,
                          child: GetBuilder<CreateeRouteController>(
                            init: createeRouteController,
                            initState: (_) async {
                              //await getMyCurrentLocationController.getMyCurrentLocation();
                              SetCustomMarkerIconController controller =
                                  Get.put(SetCustomMarkerIconController());
                              await controller.setCustomMarkerIcon3();
                              createeRouteController.addMarkerFunction(
                                const MarkerId("myCurrentMarker"),
                                LatLng(
                                    mapPageMController
                                        .myLocationLatitudeDo.value,
                                    mapPageMController
                                        .myLocationLongitudeDo.value),
                                'myCurrentMarker',
                                "",
                                BitmapDescriptor.fromBytes(
                                  customMarkerIconController.mayLocationIcon!,
                                ),
                              );
                            },
                            builder: (controller) {
                              return Obx(
                                () => Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    SizedBox(
                                      height: Get.height,
                                      width: Get.width,
                                      child: GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                            mapPageMController
                                                .myLocationLatitudeDo.value,
                                            mapPageMController
                                                .myLocationLongitudeDo.value,
                                          ),
                                          zoom: mapPageMController
                                              .zoom.value, //*** 15.0,
                                        ),
                                        markers: Set<Marker>.from(
                                            createeRouteController
                                                .markers.value),
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: false,
                                        mapType: MapType.normal,
                                        zoomGesturesEnabled: true,
                                        zoomControlsEnabled: false,
                                        onCameraMoveStarted: () {},
                                        onCameraMove: (p0) {},
                                        polygons: const <Polygon>{},
                                        tileOverlays: const <TileOverlay>{},
                                        polylines: Set<Polyline>.of(
                                            createeRouteController
                                                .polylines.value),
                                        onMapCreated: (GoogleMapController
                                            controller) async {
                                          // createRouteController.generalMapController
                                          //     .complete(controller);
                                          // mapCotroller = Completer();
                                          // mapCotroller.complete(controller);
                                          createeRouteController.mapController =
                                              controller;
                                        },
                                      ),
                                    ),

                                    /// GET MY LOCATİON İN MAP
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w, top: 30.h),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            try {
                                              print("KONUMUMUGETİRs");

                                              // mapPageController.isLoading.value = true;

                                              createeRouteController
                                                  .mapController
                                                  .animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                    bearing: mapPageMController
                                                        .currentHeading
                                                        .value, //90
                                                    tilt: 60, //tilt***
                                                    target: LatLng(
                                                        mapPageMController
                                                            .myLocationLatitudeDo
                                                            .value,
                                                        mapPageMController
                                                            .myLocationLongitudeDo
                                                            .value),
                                                    zoom: mapPageMController
                                                        .zoom.value, //*** 14,
                                                  ),
                                                ),
                                              );
                                            } catch (e) {
                                              print("KONUMUMUGETİR ERR -> $e");
                                            }
                                          },
                                          child: Container(
                                            height: 50.w,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                              color: AppConstants().ltMainRed,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.w),
                                              child: SvgPicture.asset(
                                                "assets/icons/getMyLocationIcon2.svg",
                                                height: 24.w,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// KESİŞEN ROTALAR BUTTONU
                                    Obx(
                                      () => Visibility(
                                        visible: createeRouteController
                                                .calculateLevel.value ==
                                            1,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.w, top: 90.h),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () async {
                                                createeRouteController
                                                    .calculateLevel.value = 2;
                                                // searchRouteController
                                                //     .selectedCarTypeOption
                                                //     .value = "";
                                              },
                                              child: Container(
                                                height: 50.w,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppConstants().ltMainRed,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.w),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/map-page-list-icon.svg",
                                                    height: 18.w,
                                                    color:
                                                        AppConstants().ltWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Obx(
                                      () => Visibility(
                                        visible: createeRouteController
                                                .middRoute.value.latitude !=
                                            0,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: 10.w,
                                            top: 150.h,
                                            // bottom: 100,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () async {
                                                try {
                                                  print("KONUMUMUGETİRs");

                                                  // mapPageController.isLoading.value = true;

                                                  createeRouteController
                                                      .getRouteInMap();
                                                } catch (e) {
                                                  print(
                                                      "KONUMUMUGETİR ERR -> $e");
                                                }
                                              },
                                              child: Container(
                                                height: 50.w,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppConstants().ltMainRed,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.w),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/route-icon.svg',
                                                    color:
                                                        AppConstants().ltWhite,
                                                    width: 24.w,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Obx(
                          () =>
                              // searchRouteController.showOnlyMap.value
                              //     ? Container()
                              //     :
                              Positioned(
                            bottom: 0.h,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                          begin: const Offset(0, 1.2),
                                          end: const Offset(0, 0))
                                      .animate(animation),
                                  child: child,
                                );
                              },
                              child: RouteCalculateButtomSheet(
                                key: ValueKey<int>(createeRouteController
                                    .calculateLevel.value),
                                calculateLevel:
                                    createeRouteController.calculateLevel.value,
                                mapController: mapCotroller,
                                mapContext: context,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),

      //     Scaffold(
      //   key: drawerController.routeCalculatePageScaffoldKey,
      //   appBar: AppBarGenel(
      //     leading: GestureDetector(
      //       onTap: () {
      //         drawerController.openRouteCalculatePageScaffoldDrawer();
      //       },
      //       child: Padding(
      //         padding: EdgeInsets.only(
      //           left: 20.w,
      //           right: 5.h,
      //         ),
      //         child: SvgPicture.asset(
      //           height: 25.h,
      //           width: 25.w,
      //           'assets/icons/open-drawer-icon.svg',
      //           color: AppConstants().ltLogoGrey,
      //         ),
      //       ),
      //     ),
      //     title: Image.asset(
      //       'assets/logo/logo-1.png',
      //       height: 40,
      //     ),
      //     actions: [
      //       GestureDetector(
      //         onTap: () {
      //           Get.toNamed(NavigationConstants.notifications);
      //           notificationController.isUnOpenedNotification.value = false;
      //         },
      //         child: Padding(
      //           padding: EdgeInsets.only(
      //             right: 5.w,
      //           ),
      //           child: Stack(
      //             alignment: Alignment.topRight,
      //             children: [
      //               SvgPicture.asset(
      //                 height: 20.h,
      //                 width: 20.w,
      //                 'assets/icons/notification-icon.svg',
      //                 color: AppConstants().ltLogoGrey,
      //               ),
      //               Obx(() => notificationController.isUnOpenedNotification.value
      //                   ? CircleAvatar(
      //                       radius: 6.h,
      //                       backgroundColor: AppConstants().ltMainRed,
      //                     )
      //                   : SizedBox())
      //             ],
      //           ),
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () async {
      //           Get.toNamed(NavigationConstants.message);
      //           notificationController.isUnReadMessage.value = false;
      //         },
      //         child: Padding(
      //           padding: EdgeInsets.only(
      //             left: 5.w,
      //             right: 20.w,
      //           ),
      //           child: Stack(
      //             alignment: Alignment.topRight,
      //             children: [
      //               SvgPicture.asset(
      //                 'assets/icons/message-icon.svg',
      //                 height: 20.h,
      //                 width: 20.w,
      //                 color: const Color(0xff3E3E3E),
      //               ),
      //               Obx(() => notificationController.isUnReadMessage.value
      //                   ? CircleAvatar(
      //                       radius: 6.h,
      //                       backgroundColor: AppConstants().ltMainRed,
      //                     )
      //                   : SizedBox())
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   drawer: NavigationDrawerWidget(),
      //   body: GetBuilder<CreateeRouteController>(
      //     id: "createRouteController",
      //     init: createRouteController,
      //     initState: (_) {},
      //     builder: (_) {
      //       return SizedBox(
      //         width: Get.width,
      //         height: Get.height,
      //         child: Obx(
      //           () => ((getMyCurrentLocationController
      //                           .myLocationLatitudeDo.value ==
      //                       0.0) &&
      //                   (getMyCurrentLocationController
      //                           .myLocationLongitudeDo.value ==
      //                       0.0))
      //               ? const Center(
      //                   child:
      //                       CircularProgressIndicator()) //UiHelper.loadingAnimationWidget(context)
      //               : Stack(
      //                   alignment: Alignment.bottomCenter,
      //                   children: <Widget>[
      //                     SizedBox(
      //                       height:
      //                           createRouteController.calculateLevel.value == 2
      //                               ? 350.h
      //                               : Get.height,
      //                       child: GetBuilder<CreateeRouteController>(
      //                         init: createRouteController,
      //                         initState: (_) async {
      //                           //await getMyCurrentLocationController.getMyCurrentLocation();
      //                           SetCustomMarkerIconController controller =
      //                               Get.put(SetCustomMarkerIconController());
      //                           await controller.setCustomMarkerIcon3();
      //                           createRouteController.addMarkerFunction(
      //                             const MarkerId("myCurrentMarker"),
      //                             LatLng(
      //                                 getMyCurrentLocationController
      //                                     .myLocationLatitudeDo.value,
      //                                 getMyCurrentLocationController
      //                                     .myLocationLongitudeDo.value),
      //                             'myCurrentMarker',
      //                             "",
      //                             BitmapDescriptor.fromBytes(
      //                               customMarkerIconController.mayLocationIcon!,
      //                             ),
      //                           );
      //                         },
      //                         builder: (controller) {
      //                           return Obx(
      //                             () => SizedBox(
      //                               height: Get.height,
      //                               width: Get.width,
      //                               child: GoogleMap(
      //                                 initialCameraPosition: CameraPosition(
      //                                   target: LatLng(
      //                                     getMyCurrentLocationController
      //                                         .myLocationLatitudeDo.value,
      //                                     getMyCurrentLocationController
      //                                         .myLocationLongitudeDo.value,
      //                                   ),
      //                                   zoom: 15.0,
      //                                 ),
      //                                 markers: Set<Marker>.from(
      //                                     createRouteController.markers.value),
      //                                 myLocationEnabled: true,
      //                                 myLocationButtonEnabled: false,
      //                                 mapType: MapType.normal,
      //                                 zoomGesturesEnabled: true,
      //                                 zoomControlsEnabled: false,
      //                                 onCameraMoveStarted: () {},
      //                                 onCameraMove: (p0) {},
      //                                 polygons: const <Polygon>{},
      //                                 tileOverlays: const <TileOverlay>{},
      //                                 polylines: Set<Polyline>.of(
      //                                     createRouteController.polylines.value),
      //                                 onMapCreated:
      //                                     (GoogleMapController controller) async {
      //                                   // createRouteController.generalMapController
      //                                   //     .complete(controller);
      //                                   // mapCotroller = Completer();
      //                                   // mapCotroller.complete(controller);
      //                                   createRouteController.mapController =
      //                                       controller;
      //                                 },
      //                               ),
      //                             ),
      //                           );
      //                         },
      //                       ),
      //                     ),
      //                     Obx(
      //                       () =>
      //                           // searchRouteController.showOnlyMap.value
      //                           //     ? Container()
      //                           //     :
      //                           AnimatedSwitcher(
      //                         duration: const Duration(milliseconds: 500),
      //                         transitionBuilder:
      //                             (Widget child, Animation<double> animation) {
      //                           return SlideTransition(
      //                             position: Tween<Offset>(
      //                                     begin: const Offset(0, 1.2),
      //                                     end: const Offset(0, 0))
      //                                 .animate(animation),
      //                             child: child,
      //                           );
      //                         },
      //                         child: RouteCalculateButtomSheet(
      //                           key: ValueKey<int>(
      //                               createRouteController.calculateLevel.value),
      //                           calculateLevel:
      //                               createRouteController.calculateLevel.value,
      //                           mapController: mapCotroller,
      //                           mapContext: context,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}

class RouteCalculateButtomSheet extends StatelessWidget {
  RouteCalculateButtomSheet(
      {super.key,
      required this.calculateLevel,
      required this.mapController,
      required this.mapContext});

  late int calculateLevel;
  BuildContext mapContext;
  Completer<GoogleMapController> mapController;
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  SetCustomMarkerIconController customMarkerIconController = Get.find();

  CreateeRouteController createRouteController =
      Get.find<CreateeRouteController>();

  SearchRouteController searchRouteController =
      Get.put(SearchRouteController());
  @override
  Widget build(BuildContext context) {
    // GetMyCurrentLocationController getMyCurrentLocationController =
    //     Get.find<GetMyCurrentLocationController>();
    MapPageMController mapPageMController = Get.find();
    if (calculateLevel == 1) {
      return _calculateLevelTwo(context, mapController, mapPageMController);
    } else if (calculateLevel == 2) {
      return _calculateLevelThree(context);
    } else {
      return _calculateLevelTwo(context, mapController, mapPageMController);
    }
  }

  // Widget _calculateLevelOne() {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 10),
  //       child: GestureDetector(
  //         onTap: () {
  //           createRouteController.calculateLevel.value = 2;
  //         },
  //         child: Container(
  //           width: 342.w,
  //           height: 48.h,
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: AppConstants().ltLogoGrey.withOpacity(0.2),
  //                 spreadRadius: 0.r,
  //                 blurRadius: 10.r,
  //               ),
  //             ],
  //             color: AppConstants().ltWhite,
  //             borderRadius: BorderRadius.circular(8.r),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   left: 12.w,
  //                   bottom: 15,
  //                   top: 15,
  //                 ),
  //                 child: SvgPicture.asset(
  //                   'assets/icons/route-icon.svg',
  //                   color: AppConstants().ltMainRed,
  //                   width: 20.w,
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   left: 12.w,
  //                   bottom: 15,
  //                   top: 15,
  //                 ),
  //                 child: Text(
  //                   "Rota ara veya oluştur",
  //                   style: TextStyle(
  //                     color: AppConstants().ltLogoGrey,
  //                     fontFamily: "SfLight",
  //                     fontSize: 12.sp,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _calculateLevelTwo(
    BuildContext context,
    Completer<GoogleMapController> mapController,
    MapPageMController getMyCurrentLocationController,
  ) {
    return Obx(() => Stack(
          clipBehavior: Clip.none,
          children: [
            Visibility(
                child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  // alignment: Alignment.topCenter,
                  child: Container(
                    height:
                        searchRouteController.showOnlyMap.value ? 85.h : 363.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppConstants().ltLogoGrey.withOpacity(0.2),
                          spreadRadius: 0.r,
                          blurRadius: 0.r,
                        ),
                      ],
                      color: AppConstants().ltWhite,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          // bottom: 12.h,
                          child: InkWell(
                            onTap: () {
                              if (searchRouteController.showOnlyMap.value) {
                                searchRouteController.showOnlyMap.value = false;
                              }
                            },
                            child: SizedBox(
                              width: Get.width,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w, top: 24.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 4.w, left: 8.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Farklı konumlarda rota oluşturan sürücüler",
                                              style: TextStyle(
                                                fontFamily: "Sflight",
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppConstants().ltBlack,
                                              ),
                                            ),
                                            Text(
                                              "Seçtiğiniz konumlarda rota oluşturan sürücü ve araçları bu sayfada listeliyebilir ve onlarla iletişim kurabilirsiniz",
                                              style: TextStyle(
                                                fontFamily: "Sflight",
                                                fontSize: 12.sp,
                                                color: AppConstants().ltBlack,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: !searchRouteController
                                            .showOnlyMap.value,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _placesAutoComplateTextFieldStart(
                                                context),
                                            const SizedBox(height: 10),
                                            _placesAutoComplateTextFieldFinish(
                                                context),
                                            const SizedBox(height: 10),
                                            datePickerWidget(context),
                                            const SizedBox(height: 10),
                                            // filterCarTypeWidget(context, false),
                                            //COMBOBAX
                                            filterCarTypeCombobax(),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () {
                                                if (!searchRouteController
                                                        .showOnlyMap.value ||
                                                    createRouteController
                                                            .calculateLevel
                                                            .value ==
                                                        2) {
                                                  getSearchRoute(context);
                                                } else {
                                                  searchRouteController
                                                      .showOnlyMap
                                                      .value = false;
                                                }

                                                print(
                                                    "showOnlyMap -> ${searchRouteController.showOnlyMap.value}  calculatelevel -> $calculateLevel");
                                              },
                                              child: Center(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 150.w,
                                                  height: 30.h,
                                                  decoration: BoxDecoration(
                                                    color: AppConstants()
                                                        .ltMainRed,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10.r,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Ara",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            // Obx(
            //   () => Visibility(
            //     visible: createRouteController.middRoute.value.latitude != 0,
            //     child: Padding(
            //       padding: EdgeInsets.only(right: 10.w, bottom: 260.h),
            //       child: Align(
            //         alignment: Alignment.bottomRight,
            //         child: GestureDetector(
            //           onTap: () async {
            //             try {
            //               print("KONUMUMUGETİRs");
            //               // mapPageController.isLoading.value = true;
            //               createRouteController.getRouteInMap();
            //             } catch (e) {
            //               print("KONUMUMUGETİR ERR -> $e");
            //             }
            //           },
            //           child: Container(
            //             height: 50.w,
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //               color: AppConstants().ltMainRed,
            //               shape: BoxShape.circle,
            //             ),
            //             child: Padding(
            //               padding: EdgeInsets.all(10.w),
            //               child: SvgPicture.asset(
            //                 'assets/icons/route-icon.svg',
            //                 color: AppConstants().ltWhite,
            //                 width: 24.w,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // /// GET MY LOCATİON İN MAP
            // Padding(
            //   padding: EdgeInsets.only(right: 10.w, bottom: 190.h),
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: GestureDetector(
            //       onTap: () async {
            //         try {
            //           print("KONUMUMUGETİRs");
            //           // mapPageController.isLoading.value = true;
            //           createRouteController.mapController.animateCamera(
            //             CameraUpdate.newCameraPosition(
            //               CameraPosition(
            //                 bearing: getMyCurrentLocationController
            //                     .currentHeading.value, //90
            //                 tilt: 60, //tilt***
            //                 target: LatLng(
            //                     getMyCurrentLocationController
            //                         .myLocationLatitudeDo.value,
            //                     getMyCurrentLocationController
            //                         .myLocationLongitudeDo.value),
            //                 zoom: getMyCurrentLocationController
            //                     .zoom.value, //*** 14,
            //               ),
            //             ),
            //           );
            //         } catch (e) {
            //           print("KONUMUMUGETİR ERR -> $e");
            //         }
            //       },
            //       child: Container(
            //         height: 50.w,
            //         width: 50.w,
            //         decoration: BoxDecoration(
            //           color: AppConstants().ltMainRed,
            //           shape: BoxShape.circle,
            //         ),
            //         child: Padding(
            //           padding: EdgeInsets.all(10.w),
            //           child: SvgPicture.asset(
            //             "assets/icons/getMyLocationIcon2.svg",
            //             height: 24.w,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Obx(
            //   () => Visibility(
            //     visible: createRouteController.calculateLevel.value == 1,
            //     child: Padding(
            //       padding: EdgeInsets.only(right: 10.w, bottom: 120.h),
            //       child: Align(
            //         alignment: Alignment.bottomRight,
            //         child: GestureDetector(
            //           onTap: () async {
            //             createRouteController.calculateLevel.value = 2;
            //           },
            //           child: Container(
            //             height: 50.w,
            //             width: 50.w,
            //             decoration: BoxDecoration(
            //               color: AppConstants().ltMainRed,
            //               shape: BoxShape.circle,
            //             ),
            //             child: Padding(
            //               padding: EdgeInsets.all(16.w),
            //               child: SvgPicture.asset(
            //                 "assets/icons/map-page-list-icon.svg",
            //                 height: 18.w,
            //                 color: AppConstants().ltWhite,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Visibility(
              // visible: searchRouteController.showOnlyMap.value,
              child: Positioned(
                // top: searchRouteController.showOnlyMap.value ? 50.h : 290.h,
                top: 5.h,
                right: searchRouteController.showOnlyMap.value ? 1.w : 1.w,
                left: searchRouteController.showOnlyMap.value ? 1.w : 1.h,
                child: InkWell(
                  onTap: () {
                    searchRouteController.showOnlyMap.value =
                        !searchRouteController.showOnlyMap.value;
                  },
                  child: Container(
                    width: 100.w,
                    height: 25.w,
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppConstants().ltWhite,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          AppConstants().ltWhiteGrey.withAlpha(10),
                          AppConstants().ltWhiteGrey,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        searchRouteController.showOnlyMap.value
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: createRouteController.middRoute.value.latitude != 0,
                child: Positioned(
                  bottom: 0,
                  child: Container(
                    height: 90.h, //240.h,
                    width: Get.width,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppConstants().ltLogoGrey.withOpacity(0.2),
                          spreadRadius: 0.r,
                          blurRadius: 10.r,
                        ),
                      ],
                      color: AppConstants().ltWhite,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
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
                                    child: Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            createRouteController
                                                .startCity.value,
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
                                            createRouteController
                                                .finishCity.value,
                                            style: TextStyle(
                                              color: AppConstants().ltLogoGrey,
                                              fontFamily: 'Sfmedium',
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => createRouteController
                                                .startCity.value.isNotEmpty ||
                                            createRouteController
                                                .finishCity.value.isNotEmpty
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.h),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Tahmini: ",
                                                  style: TextStyle(
                                                    color: AppConstants()
                                                        .ltLogoGrey,
                                                    fontFamily: 'Sflight',
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Text(
                                                  "${createRouteController.calculatedRouteDistance.value} km",
                                                  style: TextStyle(
                                                    color:
                                                        AppConstants().ltBlack,
                                                    fontFamily: 'Sflight',
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Text(
                                                  " ve ",
                                                  style: TextStyle(
                                                    color: AppConstants()
                                                        .ltLogoGrey,
                                                    fontFamily: 'Sflight',
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Text(
                                                  createRouteController
                                                      .calculatedRouteTime
                                                      .value,
                                                  style: TextStyle(
                                                    color:
                                                        AppConstants().ltBlack,
                                                    fontFamily: 'Sflight',
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                createRouteController
                                    .createRouteControllerClear(
                                        isSearchRoute: true);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: SvgPicture.asset(
                                  "assets/icons/close-icon.svg",
                                  width: 32.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  filterCarTypeCombobax() {
    return DropdownButton<String>(
      hint: Center(
        child: Text(
          "Araç Tipi Seçiniz",
          textAlign: TextAlign.center,
        ),
      ),

      isExpanded: true,
      // menuWidth: 300.w,
      // dropdownColor: AppConstants().ltWhite,
      // dropdownColor: AppConstants().ltMainRed,
      padding: EdgeInsets.symmetric(horizontal: 10.w),

      alignment: AlignmentDirectional.centerStart,
      value: searchRouteController.selectedCarTypeOption.value == ""
          ? null
          : searchRouteController.selectedCarTypeOption.value,
      items: searchRouteController.filterOptionList.map((String value) {
        return DropdownMenuItem<String>(
          alignment: Alignment.center,
          value: value,
          child: Center(child: Text(value)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        searchRouteController.carTypeList.clear();
        searchRouteController.selectedCarTypeOption.value =
            newValue ?? "Ticari Araç";

        // if (searchRouteController.selectedCarTypeOption.value ==
        //     "Ticari Araç") {
        //   searchRouteController.carTypeList.add("Otomobil");
        // } else if (searchRouteController.selectedCarTypeOption.value ==
        //     "Ağır Vasıta") {
        //   searchRouteController.carTypeList.add("Tır");
        // } else {
        //   searchRouteController.carTypeList.add("Motorsiklet");
        // }

        print("SELECTEDOPTİONCARLİST : ${searchRouteController.carTypeList}");
      },
    );
  }

  Container searchButtonWidget(BuildContext context) {
    return Container(
      width: 45.w,
      height: 35.h,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppConstants().ltMainRed,
        borderRadius: BorderRadius.circular(5.w),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        gradient: LinearGradient(
          colors: [AppConstants().ltMainRed, AppConstants().ltMainRed],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (!searchRouteController.showOnlyMap.value ||
              createRouteController.calculateLevel.value == 2) {
            getSearchRoute(context);
          } else {
            searchRouteController.showOnlyMap.value = false;
          }

          print(
              "showOnlyMap -> ${searchRouteController.showOnlyMap.value}  calculatelevel -> $calculateLevel");
        },
        child: Center(
          child: Icon(Icons.search),
          // child: Text(
          //   // searchRouteController.showOnlyMap.value ? "Rota Ara" :
          //   "Rota Ara",
          //   style: TextStyle(
          //       color: AppConstants().ltWhite,
          //       fontSize: 13.sp,
          //       fontWeight: FontWeight.bold,
          //       letterSpacing: -1,
          //       decoration: TextDecoration.underline,
          //       decorationColor: AppConstants().ltWhite),
          // ),
        ),

        // Container(
        //   height: 40.w,
        //   width: 40.w,
        //   decoration: BoxDecoration(
        //     color: AppConstants().ltWhite,
        //     shape: BoxShape.circle,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.3),
        //         spreadRadius: 1,
        //         blurRadius: 3,
        //         offset: const Offset(0, 2),
        //       ),
        //     ],
        //   ),
        //   child: Icon(
        //     !searchRouteController.showOnlyMap.value
        //         ? Icons.arrow_upward
        //         : Icons.arrow_downward,
        //     color: AppConstants().ltMainRed,
        //   ),
        // ),
      ),
    );
  }

  InkWell datePickerWidget(BuildContext context) {
    return InkWell(
      onTap: () => selectDate(context),
      child: Container(
        width: 342.w,
        height: 48.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 10.r,
            ),
          ],
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 12.w,
                    bottom: 15,
                    top: 15,
                  ),
                  child: Icon(
                    Icons.date_range,
                    color: AppConstants().ltMainRed,
                  ),
                ),
                Obx(
                  () => SizedBox(
                    width: 250.w,
                    child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                          DateFormat('yyyy-MM-dd')
                              .format(searchRouteController.selectedDate.value),
                          style: TextStyle(
                            color: AppConstants().ltLogoGrey,
                            fontFamily: "SfLight",
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _calculateLevelThree(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 0.r,
            ),
          ],
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10),
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: GestureDetector(
            //       onTap: () {
            //         createRouteController.calculateLevel.value = 1;
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 10),
            //         child: Text(
            //           "Haritada Gör",
            //           style: TextStyle(
            //             fontFamily: "Sfsemibold",
            //             fontSize: 12.sp,
            //             color: AppConstants().ltMainRed,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: EdgeInsets.only(left: 16.w, right: 16.w),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: GestureDetector(
            //       onTap: () {
            //         createRouteController.createRouteControllerClear();
            //       },
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 10),
            //         child: SvgPicture.asset(
            //           "assets/icons/close-icon.svg",
            //           width: 32.w,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              top: 200.h,
              child: SizedBox(
                width: Get.width,
                //height: Get.height,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            createRouteController.createRouteControllerClear(
                                isSearchRoute: true);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SvgPicture.asset(
                              "assets/icons/close-icon.svg",
                              width: 32.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _placesAutoComplateTextFieldStart(context),
                    const SizedBox(height: 10),
                    _placesAutoComplateTextFieldFinish(context),
                    const SizedBox(height: 10),
                    datePickerWidget(context),
                    const SizedBox(height: 10),
                    // filterCarTypeWidget(context, true),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: filterCarTypeCombobax(),
                    ),

                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        if (!searchRouteController.showOnlyMap.value ||
                            createRouteController.calculateLevel.value == 2) {
                          getSearchRoute(context);
                        } else {
                          searchRouteController.showOnlyMap.value = false;
                        }

                        print(
                            "showOnlyMap -> ${searchRouteController.showOnlyMap.value}  calculatelevel -> $calculateLevel");
                      },
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 150.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppConstants().ltMainRed,
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                          ),
                          child: Text(
                            "Ara",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppConstants().ltWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        color: AppConstants().ltWhite,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, top: 20),
                                      child: Text(
                                        "Eşleşen Rotalar",
                                        style: TextStyle(
                                          fontFamily: "Sfsemibold",
                                          fontSize: 16.sp,
                                          color: AppConstants().ltLogoGrey,
                                        ),
                                      ),
                                    ),
                                    Obx(() => SizedBox(
                                          //height: 595.h,
                                          child: !createRouteController
                                                      .isLoading.value &&
                                                  createRouteController
                                                      .searchByCityDatum!
                                                      .isNotEmpty
                                              ? SingleChildScrollView(
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        createRouteController
                                                            .searchByCityDatum!
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return ActivesFriendsRoutesCard(
                                                        matchedOn: MatchedOn(
                                                            city: null,
                                                            district: null),
                                                        profilePhotoUrl:
                                                            "https://firebasestorage.googleapis.com/v0/b/fillogo-8946b.appspot.com/o/users%2Fuser_yxtelh.png?alt=media&token=17ed0cd6-733e-4ee9-9053-767ce7269893", // 'https://picsum.photos/150',
                                                        id: createRouteController
                                                            .searchByCityDatum![
                                                                i]
                                                            .id!,
                                                        isActiveRoute:
                                                            createRouteController
                                                                    .searchByCityDatum[
                                                                        i]
                                                                    .isActive ??
                                                                false,
                                                        userName:
                                                            createRouteController
                                                                .searchByCityDatum![
                                                                    i]
                                                                .user!
                                                                .username!,
                                                        startAdress:
                                                            createRouteController
                                                                .searchByCityDatum![
                                                                    i]
                                                                .startingCity!,
                                                        endAdress:
                                                            createRouteController
                                                                .searchByCityDatum![
                                                                    i]
                                                                .endingCity!,
                                                        startDateTime:
                                                            createRouteController
                                                                .searchByCityDatum![
                                                                    i]
                                                                .departureDate!
                                                                .toString()
                                                                .split(" ")[0],
                                                        endDateTime:
                                                            createRouteController
                                                                .searchByCityDatum![
                                                                    i]
                                                                .arrivalDate!
                                                                .toString()
                                                                .split(" ")[0],
                                                        userId: createRouteController
                                                            .searchByCityDatum![
                                                                i]
                                                            .userId!,
                                                      );
                                                    },
                                                  ),
                                                )
                                              : Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: UiHelper
                                                      .notFoundAnimationWidget(
                                                          context,
                                                          "Uygun rota bulunamadı!"),
                                                ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () async {
                    createRouteController.calculateLevel.value = 1;
                    // searchRouteController.selectedCarTypeOption.value = "";
                    // await getSearchRoute(context);
                    createRouteController
                        .addNewMarkersForSearchingRoute(mapContext);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: Container(
                      height: 50.w,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: AppConstants().ltMainRed,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset(
                            "assets/icons/map-page-book-icon.svg",
                            height: 24.w,
                            color: AppConstants().ltWhiteGrey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  filterCarTypeWidget(BuildContext context, bool isList) {
    OverlayEntry? _filterOverlayEntry;

    return Container(
      width: 340.w,
      height: 55.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppConstants().ltLogoGrey.withOpacity(0.2),
            spreadRadius: 0.r,
            blurRadius: 10.r,
          ),
        ],
        color: AppConstants().ltWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 340.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
// Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     8.w.horizontalSpace,
                    //   filterOptionWidget(
                    //       text: "Ağır Vasıta",
                    //       logo: 'assets/icons/filterTruck.png',
                    //       index: 1),
                    //   18.w.horizontalSpace,
                    //   filterOptionWidget(
                    //       text: "Ticari Araç",
                    //       logo: 'assets/icons/filterLightCommercial.png',
                    //       index: 0),
                    //   18.w.horizontalSpace,
                    //   filterOptionWidget(
                    //       text: "Motorsiklet",
                    //       logo: 'assets/icons/filterMotorcycle.png',
                    //       index: 2),
                    // ],
                    // ),
                    InkWell(
                      onTap: () {
                        // showMultiSelectDialog(context);

                        searchRouteController.showFilterOption.value =
                            !searchRouteController.showFilterOption.value;
                        print(
                            "${searchRouteController.showFilterOption.value}");

                        if (searchRouteController.showFilterOption.value) {
                          toggleFilterMenu(
                              context: context,
                              filterOverlayEntry: _filterOverlayEntry,
                              isList: isList);
                        } else {
                          print("KAPANDI");
                          _filterOverlayEntry?.remove();
                          _filterOverlayEntry = null;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(2.h),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            // Icon(
                            //   Icons.filter_list,
                            //   color: AppConstants().ltMainRed,
                            // ),
                            Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Text(
                                  "Araç Türü Seç",
                                  style: TextStyle(
                                    color:
                                        AppConstants().ltBlack.withAlpha(150),
                                  ),
                                )),
                            // searchRouteController.showFilterOption.value
                            //     ? Positioned(
                            //         top: 0,
                            //         left: 20.w,
                            //         child: Container(
                            //           height: 190.h,
                            //           width: 150.w,
                            //           alignment: Alignment.topCenter,
                            //           decoration: BoxDecoration(
                            //             color: AppConstants().ltWhite,
                            //           ),
                            //           child: Column(
                            //             children: [
                            //               filterOptionWidget(
                            //                   text: "Ağır Vasıta",
                            //                   logo:
                            //                       'assets/icons/filterTruck.png',
                            //                   index: 1),
                            //               filterOptionWidget(
                            //                   text: "Ticari Araç",
                            //                   logo:
                            //                       'assets/icons/filterLightCommercial.png',
                            //                   index: 0),
                            //               filterOptionWidget(
                            //                   text: "Motorsiklet",
                            //                   logo:
                            //                       'assets/icons/filterMotorcycle.png',
                            //                   index: 2),
                            //             ],
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                    ),
                    searchButtonWidget(context)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getSearchRoute(BuildContext context) async {
    // GetMyCurrentLocationController getMyCurrentLocationController =
    //     Get.find<GetMyCurrentLocationController>();
    MapPageMController mapPageMController = Get.find();
    searchRouteController.fillCarTypeList();
    createRouteController.searchByCityDatum.clear();
    createRouteController.markers.clear();
    createRouteController.addMarkerFunction(
      MarkerId(const MarkerId('myMarker').value),
      LatLng(mapPageMController.myLocationLatitudeDo.value,
          mapPageMController.myLocationLongitudeDo.value),
      "",
      "",
      BitmapDescriptor.fromBytes(
        customMarkerIconController.mayLocationIcon!,
      ),
    );
    print(
        "STARTCİTYİNFO -> ${createRouteController.createRouteStartLatitude.value}// ${createRouteController.createRouteStartLongitude.value} // ${createRouteController.startCity.value}");
    if ((createRouteController.createRouteStartLatitude.value != 0.0) &&
        (createRouteController.createRouteStartLongitude.value != 0.0) &&
        (createRouteController.createRouteFinishLatitude.value != 0.0) &&
        (createRouteController.createRouteFinishLongitude.value != 0.0) &&
        createRouteController.startCity.value != "" &&
        createRouteController.finishCity.value != "") {
      print(
          "ARAÇTURUMNE -> ${searchRouteController.selectedCarTypeOption.value}");
      if (searchRouteController.selectedCarTypeOption.value == "") {
        Get.snackbar("Arama yapılamadı!", "Lütfen araç türü seçiniz",
            snackPosition: SnackPosition.BOTTOM,
            colorText: AppConstants().ltBlack);
      } else {
        if (searchRouteController.selectedCarTypeOption.value ==
            "Ticari Araç") {
          searchRouteController.carTypeList.add("Otomobil");
        } else if (searchRouteController.selectedCarTypeOption.value ==
            "Ağır Vasıta") {
          searchRouteController.carTypeList.add("Tır");
        } else {
          searchRouteController.carTypeList.add("Motorsiklet");
        }
        if (searchRouteController.carTypeList.isEmpty) {
          Get.snackbar("Arama yapılamadı!", "Lütfen araç türü seçiniz",
              snackPosition: SnackPosition.BOTTOM,
              colorText: AppConstants().ltBlack);
        } else {
          createRouteController.getRoute(
              createRouteController.createRouteStartLatitude.value,
              createRouteController.createRouteStartLongitude.value,
              createRouteController.createRouteFinishLatitude.value,
              createRouteController.createRouteFinishLongitude.value);
          createRouteController.isLoading.value = true;
          GetRouteSearchByCityRequestModel routeSearchByCityRequestModel =
              GetRouteSearchByCityRequestModel(
                  startLocation: createRouteController.startCity.value,
                  endLocation: createRouteController.finishCity.value,
                  departureDate: DateFormat('yyyy-MM-dd')
                      .format(searchRouteController.selectedDate.value),
                  carType: searchRouteController.carTypeList);

          print(
              "SEARCHROUTE start-> ${jsonEncode(routeSearchByCityRequestModel)} FİLTERCARTYPELİST -> ${searchRouteController.carTypeList}");
          var res = await GeneralServicesTemp()
              .makePostRequest(
            EndPoint.routesSearchByCitys,
            routeSearchByCityRequestModel,
            ServicesConstants.appJsonWithToken,
          )
              .then((value) async {
            print("VALUEE -> ${value}");
            searchRouteController.showOnlyMap.value = true;
            final response =
                GetRouteSearchByCityResponseModel.fromJson(jsonDecode(value!));
            createRouteController.searchByCityDatum.value = response.data![0];
            createRouteController.addNewMarkersForSearchingRoute(context);
          });
          print("VALUEE1 -> ${jsonEncode(res)}");
          // final response =
          //     GetRouteSearchByCityResponseModel.fromJson(jsonDecode(res));

          // print("VALUEE2 -> ${jsonEncode(response)}");
          // createRouteController.searchByCityDatum.value = response.data![0];
          // createRouteController.addNewMarkersForSearchingRoute(context);

          // searchRouteController.showOnlyMap.value = true;
          createRouteController.isLoading.value = false;
        }
      }
    } else {
      Get.snackbar(
          "Arama yapılamadı!", "Lütfen çıkış ve varış noktalarını giriniz",
          snackPosition: SnackPosition.BOTTOM,
          colorText: AppConstants().ltBlack);
    }

    // createRouteController. markers.add(
    //     Marker(
    //       markerId: MarkerId(createRouteController.searchByCityDatum[]),
    //       position: location ??
    //           LatLng(currentLocationController.myLocationLatitudeDo.value,
    //               currentLocationController.myLocationLongitudeDo.value),
    //       icon: BitmapDescriptor.fromBytes(iconByteData),
    //       zIndex: markerID == "myLocationMarker" ? 1 : 0,
    //       onTap: markerID != "myLocationMarker" ? onTap : null,
    //     ),
    //   )
  }

  Widget showNewAllertDialog(BuildContext context) {
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
            "Rotanız başarıyla oluşturuldu. Yeni rotanızı duvarınızda yayınlamak ve arkadaşlarınız ile paylaşmak ister misiniz?",
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
                  print("PAYLAŞCAMMMMMM GÖNDERİ SAYFASINA GİDİYORUM");
                  bottomNavigationBarController.selectedIndex.value = 0;
                  Get.back();
                  Get.back();
                  Get.toNamed('/createPostPage');
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
                onpressed: () {
                  bottomNavigationBarController.selectedIndex.value = 0;
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

  Widget _placesAutoComplateTextFieldFinish(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Prediction? place = await PlacesAutocomplete.show(
          overlayBorderRadius: BorderRadius.circular(8.r),
          textDecoration: InputDecoration(
            labelStyle: TextStyle(
              color: AppConstants().ltLogoGrey,
              fontFamily: "SfLight",
              fontSize: 12.sp,
            ),
          ),
          textStyle: TextStyle(
            color: AppConstants().ltLogoGrey,
            fontFamily: "SfLight",
            fontSize: 12.sp,
          ),
          resultTextStyle: TextStyle(
            color: AppConstants().ltBlack,
            fontFamily: "SfLight",
            fontSize: 12.sp,
          ),
          logo: const SizedBox(height: 0),
          backArrowIcon: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SvgPicture.asset(
              "assets/icons/close-icon.svg",
              width: 24.w,
            ),
          ),
          hint: 'Varış Noktası Giriniz',
          context: context,
          apiKey: AppConstants.googleMapsApiKey,
          mode: Mode.overlay,
          types: [],
          strictbounds: false,
          components: [Component(Component.country, 'tr')],
          onError: (err) {
            print(err);
          },
        );
        await _displayPredictionFinishLocation(place!, context);
        final plist = GoogleMapsPlaces(
          apiKey: AppConstants.googleMapsApiKey,
          // apiHeaders: await const GoogleApiHeaders().getHeaders(),
          //from google_api_headers package
        );
        String placeid = place.placeId ?? "0";
        final detail = await plist.getDetailsByPlaceId(placeid);
        final geometry = detail.result.geometry!;
        createRouteController.createRouteFinishAddress.value =
            place.description.toString();
        createRouteController.addNewMarkersForSearchingRoute(context);
        // log("finishLatitude: ${createRouteController.createRouteFinishLatitude.value.toString()}");
        // log("finishLongitude: ${createRouteController.createRouteFinishLongitude.value.toString()}");
        // log("finish description: ${place.description.toString()}");
      },
      child: Container(
        width: 342.w,
        height: 48.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 10.r,
            ),
          ],
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                bottom: 15,
                top: 15,
              ),
              child: SvgPicture.asset(
                'assets/icons/route-icon.svg',
                color: AppConstants().ltMainRed,
                width: 20.w,
              ),
            ),
            SizedBox(
              width: 300.w,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12.w,
                    bottom: 15,
                    top: 15,
                  ),
                  child: Obx(
                    () => Text(
                      createRouteController.createRouteFinishAddress.value == ""
                          ? "Varış noktasını giriniz"
                          : createRouteController
                              .createRouteFinishAddress.value,
                      style: TextStyle(
                        color: AppConstants().ltLogoGrey,
                        fontFamily: "SfLight",
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placesAutoComplateTextFieldStart(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Prediction? place = await PlacesAutocomplete.show(
          overlayBorderRadius: BorderRadius.circular(8.r),
          textDecoration: InputDecoration(
            labelStyle: TextStyle(
              color: AppConstants().ltLogoGrey,
              fontFamily: "SfLight",
              fontSize: 12.sp,
            ),
          ),
          textStyle: TextStyle(
            color: AppConstants().ltLogoGrey,
            fontFamily: "SfLight",
            fontSize: 12.sp,
          ),
          resultTextStyle: TextStyle(
            color: AppConstants().ltBlack,
            fontFamily: "SfLight",
            fontSize: 12.sp,
          ),
          logo: const SizedBox(height: 0),
          backArrowIcon: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SvgPicture.asset(
              "assets/icons/close-icon.svg",
              width: 24.w,
            ),
          ),
          hint: 'Çıkış Noktası Giriniz',
          context: context,
          apiKey: AppConstants.googleMapsApiKey,
          mode: Mode.overlay,
          types: [],
          strictbounds: false,
          components: [Component(Component.country, 'tr')],
          onError: (err) {
            print(err);
          },
        );
        await _displayPredictionStartLocation(place!, context);
        final plist = GoogleMapsPlaces(
          apiKey: AppConstants.googleMapsApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
          //from google_api_headers package
        );
        String placeid = place.placeId ?? "0";
        final detail = await plist.getDetailsByPlaceId(placeid);
        final geometry = detail.result.geometry!;
        createRouteController.createRouteStartAddress.value =
            place.description.toString();
        //createRouteController.addNewMarkersForSearchingRoute(context);
        // log("startLatitude: ${createRouteController.createRouteStartLatitude.value.toString()}");
        // log("startLongitude: ${createRouteController.createRouteStartLongitude.value.toString()}");
        // log("start description: ${place.description.toString()}");
        // log("start City: ${place.description.toString()}");
      },
      child: Container(
        width: 342.w,
        height: 48.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 10.r,
            ),
          ],
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                bottom: 15,
                top: 15.h,
              ),
              child: SvgPicture.asset(
                'assets/icons/route-icon.svg',
                color: AppConstants().ltMainRed,
                width: 20.w,
              ),
            ),
            SizedBox(
              width: 300.w,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 12.w,
                    bottom: 15,
                    top: 15,
                  ),
                  child: Obx(
                    () {
                      return Text(
                        createRouteController.createRouteStartAddress.value ==
                                ""
                            ? "Çıkış noktasını giriniz"
                            : createRouteController
                                .createRouteStartAddress.value,
                        style: TextStyle(
                          color: AppConstants().ltLogoGrey,
                          fontFamily: "SfLight",
                          fontSize: 12.sp,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayPredictionFinishLocation(
      Prediction placeInfo, BuildContext context) async {
    try {
      // Yer detaylarını al
      PlacesDetailsResponse detail = await createRouteController
          .googleMapsPlaces
          .getDetailsByPlaceId(placeInfo.placeId!);
      // Koordinatları al
      double latitude = detail.result.geometry!.location.lat;
      double longitude = detail.result.geometry!.location.lng;
      // Geocoding ile adres bilgisi al
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Adres bilgilerini ata
        createRouteController.createRouteFinishAddress.value =
            "${place.street}, ${place.locality}, ${place.administrativeArea}";
        createRouteController.finishCity.value = place.administrativeArea ?? "";
        // Koordinatları güncelle
        createRouteController.createRouteFinishLatitude.value = latitude;
        createRouteController.createRouteFinishLongitude.value = longitude;
        createRouteController.finishLatLong = LatLng(latitude, longitude);
        if (createRouteController.finishCity.value.isNotEmpty) {
          log("Finish location set successfully.");
        }
      } else {
        log("No address found for the provided coordinates.");
      }
      // Gerekli işlemler burada yapılabilir
      log("Finish location -> City: ${createRouteController.finishCity.value}, "
          "Address: ${createRouteController.createRouteFinishAddress.value}");
    } catch (e) {
      log("Error in _displayPredictionFinishLocation: $e");
    }
  }

  Future<void> _displayPredictionStartLocation(
      Prediction placeInfo, BuildContext context) async {
    try {
      // Place ID'den yer detaylarını al
      PlacesDetailsResponse detail = await createRouteController
          .googleMapsPlaces
          .getDetailsByPlaceId(placeInfo.placeId!);
      // Yer bilgilerini al ve koordinatları ata
      createRouteController.createRouteStartLatitude.value =
          detail.result.geometry!.location.lat;
      createRouteController.createRouteStartLongitude.value =
          detail.result.geometry!.location.lng;
      // Geocoding kullanarak adres bilgisi al
      List<Placemark> placemarks = await placemarkFromCoordinates(
        createRouteController.createRouteStartLatitude.value,
        createRouteController.createRouteStartLongitude.value,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Adres ve şehir bilgilerini ata
        createRouteController.createRouteStartAddress.value =
            "${place.street}, ${place.locality}, ${place.administrativeArea}";
        createRouteController.startCity.value = place.administrativeArea ?? "";
        // Koordinat bilgilerini güncelle
        createRouteController.startLatLong = LatLng(
          createRouteController.createRouteStartLatitude.value,
          createRouteController.createRouteStartLongitude.value,
        );
        // createRouteController.createRouteStartLatitude.value = data.latitude;
        // createRouteController.createRouteStartLatitude.value = data.latitude;
        // createRouteController.createRouteStartLongitude.value = data.longitude;
        // createRouteController.createRouteStartLongitude.value = data.longitude;
        // createRouteController.startLatLong = LatLng(data.latitude, data.longitude);
        log("SEARCHROUTE START -> ${createRouteController.startCity.value} end -> ${createRouteController.finishCity.value}");
      } else {
        log("No address found for the provided coordinates.");
      }
    } catch (e) {
      log("Error in _displayPredictionStartLocation: $e");
    }
  }

  filterOptionWidget(
      {required String logo, required int index, required String text}) {
    SearchRouteController routeController = Get.put(SearchRouteController());
    return Obx(() => InkWell(
          onTap: () {
            routeController.filterSelectedList[index] =
                !routeController.filterSelectedList[index];
            print("İLİSTEM -> ${routeController.filterSelectedList}");
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.w),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.center,
                    height: 20.w,
                    width: 23.w,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    // padding: EdgeInsets.symmetric(vertical: 2.w),
                    decoration: BoxDecoration(
                      color: AppConstants().ltWhiteGrey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(2.w),
                      // border: routeController.filterSelectedList[index]
                      //     ? Border.all(
                      //         color: AppConstants()
                      //             .ltMainRed, //const ui.Color.fromARGB(255, 177, 174, 174),
                      //         width: 2,
                      //       )
                      //     : null,
                      border: Border.all(
                        color: AppConstants()
                            .ltMainRed, //const ui.Color.fromARGB(255, 177, 174, 174),
                        width: 1,
                      ),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     AppConstants().ltMainRed,
                      //     AppConstants().ltBlack,
                      //   ],
                      //   begin: Alignment.center,
                      //   end: Alignment.bottomCenter,
                      // ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: routeController.filterSelectedList[index]
                          ? Icon(
                              Icons.check,
                              color: AppConstants().ltMainRed,
                              size: 20.r,
                              weight: 12.sp,
                            )
                          : null,
                    ),

                    //  Image.asset(logo,
                    //     fit: BoxFit.cover,
                    //     color: routeController.filterSelectedList[index]
                  ),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> selectDate(
    BuildContext context,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: searchRouteController.selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null &&
        pickedDate != searchRouteController.selectedDate.value) {
      searchRouteController.selectedDate.value = pickedDate;
    }
    print("SELECTEDDATE -> ${searchRouteController.selectedDate.value}");
  }

  void toggleFilterMenu(
      {required BuildContext context,
      required OverlayEntry? filterOverlayEntry,
      bool isList = false}) {
    if (filterOverlayEntry != null) {
      filterOverlayEntry?.remove();
      filterOverlayEntry = null;
      return;
    }

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    filterOverlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          // Dışarıya tıklanınca kapanır
          searchRouteController.showFilterOption.value =
              !searchRouteController.showFilterOption.value;
          filterOverlayEntry?.remove();
          filterOverlayEntry = null;
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: position.dx + 50.w,
              bottom: isList ? 330.h : 140.h,
              // top: position.dy + 150.h,
              child: Material(
                elevation: 4,
                color: Colors.transparent,
                child: Container(
                  width: 160.w,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.black26)
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      filterOptionWidget(
                          text: "Ağır Vasıta",
                          logo: 'assets/icons/filterTruck.png',
                          index: 1),
                      filterOptionWidget(
                          text: "Ticari Araç",
                          logo: 'assets/icons/filterLightCommercial.png',
                          index: 0),
                      filterOptionWidget(
                          text: "Motorsiklet",
                          logo: 'assets/icons/filterMotorcycle.png',
                          index: 2),
                      12.verticalSpace,
                      InkWell(
                        onTap: () {
                          searchRouteController.showFilterOption.value =
                              !searchRouteController.showFilterOption.value;
                          filterOverlayEntry?.remove();
                          filterOverlayEntry = null;

                          // if (!searchRouteController.showOnlyMap.value ||
                          //     createRouteController.calculateLevel.value == 2) {
                          //   getSearchRoute(context);
                          // } else {
                          //   searchRouteController.showOnlyMap.value = false;
                          // }

                          // print(
                          //     "showOnlyMap -> ${searchRouteController.showOnlyMap.value}  calculatelevel -> $calculateLevel");
                        },
                        child: Container(
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: AppConstants().ltMainRed,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "Tamam",
                              style: TextStyle(
                                color: AppConstants().ltWhite,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(filterOverlayEntry!);
  }
}
