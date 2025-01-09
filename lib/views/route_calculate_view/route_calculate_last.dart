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
import 'package:fillogo/views/create_new_route_view/create_new_route_view.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/route_info_widget.dart';
import 'package:fillogo/views/route_calculate_view/controller/route_calculate_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';
import '../../controllers/map/get_current_location_and_listen.dart';
import '../map_page_view/components/active_friends_list_display.dart';
import 'components/create_route_controller.dart';

import 'components/route_search_by_city_models.dart';

class RouteCalculateLastView extends StatelessWidget {
  RouteCalculateLastView({super.key});

  final CreateeRouteController createRouteController =
      Get.find<CreateeRouteController>();

  //RouteCalculatesViewController currentLocation = Get.find();

  final GeneralDrawerController drawerController =
      Get.find<GeneralDrawerController>();

  final SetCustomMarkerIconController customMarkerIconController = Get.find();

  final GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  final NotificationController notificationController =
      Get.put(NotificationController());
  Completer<GoogleMapController> mapCotroller = Completer();
  final SearchRouteController searchRouteController =
      Get.put(SearchRouteController());

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
      target: LatLng(
        getMyCurrentLocationController.myLocationLatitudeDo.value,
        getMyCurrentLocationController.myLocationLongitudeDo.value,
      ),
      zoom: 15.0,
    );
    return SafeArea(
        child: Scaffold(
      key: drawerController.routeCalculatePageScaffoldKey,
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            drawerController.openRouteCalculatePageScaffoldDrawer();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 5.h,
            ),
            child: SvgPicture.asset(
              height: 25.h,
              width: 25.w,
              'assets/icons/open-drawer-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Image.asset(
          'assets/logo/logo-1.png',
          height: 40,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(NavigationConstants.notifications);
              notificationController.isUnOpenedNotification.value = false;
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 5.w,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(
                    height: 20.h,
                    width: 20.w,
                    'assets/icons/notification-icon.svg',
                    color: AppConstants().ltLogoGrey,
                  ),
                  Obx(() => notificationController.isUnOpenedNotification.value
                      ? CircleAvatar(
                          radius: 6.h,
                          backgroundColor: AppConstants().ltMainRed,
                        )
                      : SizedBox())
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Get.toNamed(NavigationConstants.message);
              notificationController.isUnReadMessage.value = false;
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 20.w,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(
                    'assets/icons/message-icon.svg',
                    height: 20.h,
                    width: 20.w,
                    color: const Color(0xff3E3E3E),
                  ),
                  Obx(() => notificationController.isUnReadMessage.value
                      ? CircleAvatar(
                          radius: 6.h,
                          backgroundColor: AppConstants().ltMainRed,
                        )
                      : SizedBox())
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: GetBuilder<CreateeRouteController>(
        id: "createRouteController",
        init: createRouteController,
        initState: (_) {},
        builder: (_) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: Obx(
              () => ((getMyCurrentLocationController
                              .myLocationLatitudeDo.value ==
                          0.0) &&
                      (getMyCurrentLocationController
                              .myLocationLongitudeDo.value ==
                          0.0))
                  ? const Center(
                      child:
                          CircularProgressIndicator()) //UiHelper.loadingAnimationWidget(context)
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        SizedBox(
                          height:
                              createRouteController.calculateLevel.value == 2
                                  ? 350.h
                                  : Get.height,
                          child: GetBuilder<CreateeRouteController>(
                            init: createRouteController,
                            initState: (_) async {
                              //await getMyCurrentLocationController.getMyCurrentLocation();
                              SetCustomMarkerIconController controller =
                                  Get.put(SetCustomMarkerIconController());
                              await controller.setCustomMarkerIcon3();
                              createRouteController.addMarkerFunction(
                                const MarkerId("myCurrentMarker"),
                                LatLng(
                                    getMyCurrentLocationController
                                        .myLocationLatitudeDo.value,
                                    getMyCurrentLocationController
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
                                () => SizedBox(
                                  height: Get.height,
                                  width: Get.width,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                        getMyCurrentLocationController
                                            .myLocationLatitudeDo.value,
                                        getMyCurrentLocationController
                                            .myLocationLongitudeDo.value,
                                      ),
                                      zoom: 15.0,
                                    ),
                                    markers: Set<Marker>.from(
                                        createRouteController.markers.value),
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
                                        createRouteController.polylines.value),
                                    onMapCreated:
                                        (GoogleMapController controller) async {
                                      // createRouteController.generalMapController
                                      //     .complete(controller);
                                      // mapCotroller = Completer();
                                      // mapCotroller.complete(controller);
                                      createRouteController.mapController =
                                          controller;
                                    },
                                  ),
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
                              AnimatedSwitcher(
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
                              key: ValueKey<int>(
                                  createRouteController.calculateLevel.value),
                              calculateLevel:
                                  createRouteController.calculateLevel.value,
                              mapController: mapCotroller,
                              mapContext: context,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    ));
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
    GetMyCurrentLocationController getMyCurrentLocationController =
        Get.find<GetMyCurrentLocationController>();
    if (calculateLevel == 1) {
      return _calculateLevelTwo(
          context, mapController, getMyCurrentLocationController);
    } else if (calculateLevel == 2) {
      return _calculateLevelThree(context);
    } else {
      return _calculateLevelTwo(
          context, mapController, getMyCurrentLocationController);
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
      GetMyCurrentLocationController getMyCurrentLocationController) {
    return Obx(() => Stack(
          children: [
            Visibility(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height:
                        searchRouteController.showOnlyMap.value ? 75.h : 313.h,
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
                        Positioned(
                          top: 12.h,
                          child: SizedBox(
                            width: Get.width,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 4.w, left: 45.w),
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
                                        children: [
                                          _placesAutoComplateTextFieldStart(
                                              context),
                                          const SizedBox(height: 10),
                                          _placesAutoComplateTextFieldFinish(
                                              context),
                                          const SizedBox(height: 10),
                                          datePickerWidget(context),
                                          const SizedBox(height: 10),
                                          filterCarTypeWidget(context),
                                        ],
                                      ),
                                    )
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
              ],
            )),
            Obx(
              () => Visibility(
                visible: createRouteController.middRoute.value.latitude != 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w, bottom: 260.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          print("KONUMUMUGETİRs");

                          // mapPageController.isLoading.value = true;

                          createRouteController.getRouteInMap();
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
                            'assets/icons/route-icon.svg',
                            color: AppConstants().ltWhite,
                            width: 24.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// GET MY LOCATİON İN MAP
            Padding(
              padding: EdgeInsets.only(right: 10.w, bottom: 190.h),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      print("KONUMUMUGETİRs");

                      // mapPageController.isLoading.value = true;

                      createRouteController.mapController.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            bearing: 90,
                            tilt: 45,
                            target: LatLng(
                                getMyCurrentLocationController
                                    .myLocationLatitudeDo.value,
                                getMyCurrentLocationController
                                    .myLocationLongitudeDo.value),
                            zoom: 14,
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

            Obx(
              () => Visibility(
                visible: createRouteController.calculateLevel.value == 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w, bottom: 120.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        createRouteController.calculateLevel.value = 2;
                      },
                      child: Container(
                        height: 50.w,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: AppConstants().ltMainRed,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: SvgPicture.asset(
                            "assets/icons/map-page-list-icon.svg",
                            height: 18.w,
                            color: AppConstants().ltWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: searchRouteController.showOnlyMap.value,
              child: Positioned(
                top: 50.h,
                right: 10.w,
                child: InkWell(
                  onTap: () {
                    searchRouteController.showOnlyMap.value =
                        !searchRouteController.showOnlyMap.value;
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppConstants().ltWhite,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          AppConstants().ltMainRed,
                          AppConstants().ltMainRed
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: Icon(Icons.arrow_drop_down),
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
                                    .createRouteControllerClear();
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

  Container searchButtonWidget(BuildContext context) {
    return Container(
      width: 75.w,
      height: 35.h,
      padding: EdgeInsets.all(4.w),
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
        child: Obx(
          () => Center(
            child: Text(
              searchRouteController.showOnlyMap.value ? "Rota Ara" : "Rota Ara",
              style: TextStyle(
                  color: AppConstants().ltWhite,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppConstants().ltWhite),
            ),
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

            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    createRouteController.createRouteControllerClear();
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
            Positioned(
              top: 52.h,
              child: SizedBox(
                width: Get.width,
                //height: Get.height,
                child: Column(
                  children: [
                    _placesAutoComplateTextFieldStart(context),
                    const SizedBox(height: 10),
                    _placesAutoComplateTextFieldFinish(context),
                    const SizedBox(height: 10),
                    datePickerWidget(context),
                    const SizedBox(height: 10),
                    filterCarTypeWidget(context),
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

  Obx filterCarTypeWidget(BuildContext context) {
    return Obx(
      () => Container(
        width: 342.w,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   padding: EdgeInsets.only(
                //     left: 12.w,
                //     bottom: 15,
                //     top: 15,
                //   ),
                //   child: Image.asset(
                //     'assets/icons/filter.png',
                //     fit: BoxFit.cover,
                //     width: 20.w,
                //     color: AppConstants().ltMainRed,
                //   ),
                // ),
                SizedBox(
                  width: 330.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          8.w.horizontalSpace,
                          filterOptionWidget(
                              logo: 'assets/icons/filterTruck.png', index: 1),
                          18.w.horizontalSpace,
                          filterOptionWidget(
                              logo: 'assets/icons/filterLightCommercial.png',
                              index: 0),
                          18.w.horizontalSpace,
                          filterOptionWidget(
                              logo: 'assets/icons/filterMotorcycle.png',
                              index: 2),
                        ],
                      ),
                      searchButtonWidget(context)
                    ],
                  ),
                ),
              ],
            ),
            // Expanded(
            //   child: Visibility(
            //       child: TextButton(
            //           onPressed: () {
            //             getSearchRoute(context);
            //           },
            //           child: Text(
            //             "Uygula",
            //             style: TextStyle(
            //                 decoration: TextDecoration.underline,
            //                 color: AppConstants().ltMainRed),
            //           ))),
            // )
          ],
        ),
      ),
    );
  }

  Future<void> getSearchRoute(BuildContext context) async {
    GetMyCurrentLocationController getMyCurrentLocationController =
        Get.find<GetMyCurrentLocationController>();
    searchRouteController.fillCarTypeList();
    createRouteController.searchByCityDatum.clear();
    createRouteController.markers.clear();
    createRouteController.addMarkerFunction(
      MarkerId(const MarkerId('myMarker').value),
      LatLng(getMyCurrentLocationController.myLocationLatitudeDo.value,
          getMyCurrentLocationController.myLocationLongitudeDo.value),
      "",
      "",
      BitmapDescriptor.fromBytes(
        customMarkerIconController.mayLocationIcon!,
      ),
    );

    if ((createRouteController.createRouteStartLatitude.value != 0.0) &&
        (createRouteController.createRouteStartLongitude.value != 0.0) &&
        (createRouteController.createRouteFinishLatitude.value != 0.0) &&
        (createRouteController.createRouteFinishLongitude.value != 0.0) &&
        createRouteController.startCity.value != "" &&
        createRouteController.finishCity.value != "") {
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
          final response =
              GetRouteSearchByCityResponseModel.fromJson(jsonDecode(value!));
          createRouteController.searchByCityDatum.value = response.data![0];
          createRouteController.addNewMarkersForSearchingRoute(context);

          searchRouteController.showOnlyMap.value = true;
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
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
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
                      createRouteController.createRouteStartAddress.value == ""
                          ? "Çıkış noktasını giriniz"
                          : createRouteController.createRouteStartAddress.value,
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

  Future _displayPredictionFinishLocation(
      Prediction placeInfo, BuildContext context) async {
    PlacesDetailsResponse detail = await createRouteController.googleMapsPlaces
        .getDetailsByPlaceId(placeInfo.placeId!);

    var placeId = placeInfo.placeId;

    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: detail.result.geometry!.location.lat,
        longitude: detail.result.geometry!.location.lng,
        googleMapApiKey: AppConstants.googleMapsApiKey);

    createRouteController.createRouteFinishAddress.value = data.address;
    createRouteController.finishCity.value = data.state;

    createRouteController.createRouteFinishLatitude.value = data.latitude;

    createRouteController.createRouteFinishLongitude.value = data.longitude;
    createRouteController.finishLatLong = LatLng(data.latitude, data.longitude);

    if (createRouteController.finishCity.value != "") {}
    log("Finish");
    // if ((createRouteController.createRouteStartLatitude.value != 0.0) &&
    //     (createRouteController.createRouteStartLongitude.value != 0.0) &&
    //     (createRouteController.createRouteFinishLatitude.value != 0.0) &&
    //     (createRouteController.createRouteFinishLongitude.value != 0.0) &&
    //     createRouteController.startCity.value != "" &&
    //     createRouteController.finishCity.value != "") {
    //   log("createRouteController createRouteController.startCity:  ${createRouteController.startCity.value}");
    //   log("createRouteController createRouteController.finishCity:  ${createRouteController.finishCity.value}");
    //   GetRouteSearchByCityRequestModel routeSearchByCityRequestModel =
    //       GetRouteSearchByCityRequestModel(
    //           startLocation: createRouteController.startCity.value,
    //           endLocation: createRouteController.finishCity.value,
    //           departureDate: DateFormat('yyyy-MM-dd')
    //               .format(searchRouteController.selectedDate.value),
    //           carType: searchRouteController.carTypeList);
    //   GeneralServicesTemp()
    //       .makePostRequest(
    //     EndPoint.routesSearchByCitys,
    //     routeSearchByCityRequestModel,
    //     ServicesConstants.appJsonWithToken,
    //   )
    //       .then((value) async {
    //     final response =
    //         GetRouteSearchByCityResponseModel.fromJson(jsonDecode(value!));
    //     print("createRouteController response1 -> ${jsonEncode(response)}");
    //     createRouteController.searchByCityDatum.value = response.data![0];
    //   });
    //   //log(createRouteController.searchByCityDatum![0].endingOpenAdress!);

    // createRouteController.calculateLevel.value = 2;
    // }
    // await getSearhRoute(context);
  }

  Future _displayPredictionStartLocation(
      Prediction placeInfo, BuildContext context) async {
    PlacesDetailsResponse detail = await createRouteController.googleMapsPlaces
        .getDetailsByPlaceId(placeInfo.placeId!);

    var placeId = placeInfo.placeId;
    createRouteController.createRouteStartLatitude.value =
        detail.result.geometry!.location.lat;
    createRouteController.createRouteStartLongitude.value =
        detail.result.geometry!.location.lng;

    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: createRouteController.createRouteStartLatitude.value,
        longitude: createRouteController.createRouteStartLongitude.value,
        googleMapApiKey: AppConstants.googleMapsApiKey);

    createRouteController.createRouteStartAddress.value = data.address;
    createRouteController.startCity.value = data.state;
    createRouteController.createRouteStartLatitude.value = data.latitude;
    createRouteController.createRouteStartLatitude.value = data.latitude;
    createRouteController.createRouteStartLongitude.value = data.longitude;
    createRouteController.createRouteStartLongitude.value = data.longitude;
    createRouteController.startLatLong = LatLng(data.latitude, data.longitude);

    log("SEARCHROUTE START -> ${createRouteController.startCity.value} end -> ${createRouteController.finishCity.value}");
  }

  InkWell filterOptionWidget({required String logo, required int index}) {
    SearchRouteController routeController = Get.put(SearchRouteController());
    return InkWell(
      onTap: () {
        routeController.filterSelectedList[index] =
            !routeController.filterSelectedList[index];
      },
      child: Container(
        height: 40.w,
        width: 40.w,
        margin: EdgeInsets.all(1.w),
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppConstants().ltWhiteGrey.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.w),
          border: routeController.filterSelectedList[index]
              ? Border.all(
                  color: AppConstants()
                      .ltMainRed, //const ui.Color.fromARGB(255, 177, 174, 174),
                  width: 2,
                )
              : null,
          // gradient: LinearGradient(
          //   colors: [
          //     AppConstants().ltMainRed,
          //     AppConstants().ltBlack,
          //   ],
          //   begin: Alignment.center,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Image.asset(logo,
            fit: BoxFit.cover,
            color: routeController.filterSelectedList[index]
                ? AppConstants().ltMainRed
                : AppConstants().ltLogoGrey),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
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
}
