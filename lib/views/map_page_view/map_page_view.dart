import 'dart:convert';
import 'dart:developer';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/delete_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:fillogo/services/locationservice.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../controllers/map/get_current_location_and_listen.dart';
import '../../controllers/map/marker_icon_controller.dart';
import '../../models/routes_models/create_route_post_models.dart';
import '../../models/routes_models/get_my_routes_model.dart';
import '../../services/general_sevices_template/general_services.dart';
import '../../widgets/custom_button_design.dart';
import '../../widgets/google_maps_widgets/general_map_view_class.dart';
import '../../widgets/google_maps_widgets/maps_general_widgets_controller.dart';
import 'components/active_friends_list_display.dart';
import 'components/map_page_controller.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:intl/intl.dart';

class MapPageView extends GetView<MapPageController> {
  MapPageView({super.key});

  bool statusRoute = true;
  GeneralDrawerController mapPageDrawerController =
      Get.find<GeneralDrawerController>();

  final SetCustomMarkerIconController setCustomMarkerIconController =
      Get.find();

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  MapPageController mapPageController = Get.find<MapPageController>();

  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  GoogleMapsGeneralWidgetsController googleMapsGeneralWidgetsController =
      Get.find<GoogleMapsGeneralWidgetsController>();

  late CameraPosition initialLocation;

  RxBool finishRouteButton = true.obs;

  @override
  Widget build(BuildContext context) {
    mapPageController;
    return Scaffold(
      key: mapPageDrawerController.mapPageScaffoldKey,
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            mapPageDrawerController.openMapPageScaffoldDrawer();
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
          height: 45,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(NavigationConstants.notifications);
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 5.w,
              ),
              child: SvgPicture.asset(
                height: 25.h,
                width: 25.w,
                'assets/icons/notification-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(NavigationConstants.message);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 20.w,
              ),
              child: SvgPicture.asset(
                'assets/icons/message-icon.svg',
                height: 25.h,
                width: 25.w,
                color: const Color(0xff3E3E3E),
              ),
            ),
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: GetBuilder<MapPageController>(
        id: "mapPageController",
        init: mapPageController,
        initState: (_) async {
          // await GeneralServicesTemp()
          //     .makeGetRequest(
          //   EndPoint.getMyfriendsRoute,
          //   ServicesConstants.appJsonWithToken,
          // )
          //     .then(
          //   (value) async {
          //     GetMyFriendsRouteResponseModel getMyFriendsRouteResponseModel =
          //         GetMyFriendsRouteResponseModel.fromJson(
          //             convert.json.decode(value!));
          //     mapPageController.myFriendsLocations =
          //         getMyFriendsRouteResponseModel.data!;

          //     for (var i = 0;
          //         i < mapPageController.myFriendsLocations.length;
          //         i++) {
          //       mapPageController.addMarkerFunctionForMapPage(
          //         mapPageController.myFriendsLocations[i]!.followed!.id!,
          //         MarkerId(mapPageController.myFriendsLocations[i]!.followed!.id
          //             .toString()),
          //         LatLng(
          //             mapPageController.myFriendsLocations[i]!.followed!
          //                 .userpostroutes![0].currentRoute![0],
          //             mapPageController.myFriendsLocations[i]!.followed!
          //                 .userpostroutes![0].currentRoute![1]),
          //         BitmapDescriptor.fromBytes(
          //             setCustomMarkerIconController.myFriendsLocation!),
          //         context,
          //         "${mapPageController.myFriendsLocations[i]!.followed!.name!} ${mapPageController.myFriendsLocations[i]!.followed!.surname!}",
          //         mapPageController.myFriendsLocations[i]!.followed!
          //             .userpostroutes![0].departureDate
          //             .toString(),
          //         mapPageController.myFriendsLocations[i]!.followed!
          //             .userpostroutes![0].arrivalDate
          //             .toString(),
          //         "Tır",
          //         mapPageController.myFriendsLocations[i]!.followed!
          //             .userpostroutes![0].startingCity!,
          //         mapPageController.myFriendsLocations[i]!.followed!
          //             .userpostroutes![0].endingCity!,
          //         "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
          //         mapPageController
          //             .myFriendsLocations[i]!.followed!.profilePicture!,
          //       );
          //     }
          //   },
          // );

          mapPageController.getMyFriendsRoutesRequestRefreshable(context);

          // mapPageController.getMyRoutesServicesRequestRefreshable();
          await GeneralServicesTemp().makeGetRequest(
            EndPoint.getMyRoutes,
            {
              "Content-type": "application/json",
              'Authorization':
                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
            },
          ).then(
            (value) async {
              GetMyRouteResponseModel getMyRouteResponseModel =
                  GetMyRouteResponseModel.fromJson(convert.json.decode(value!));
              //Anlık arkadaş konumu bağlandı
              mapPageController.getMyFriendsMatchingRoutes(
                  context,
                  getMyRouteResponseModel
                      .data![0].allRoutes!.activeRoutes![0].polylineEncode);

              log("QQQQQQ$value");

              mapPageController.myAllRoutes =
                  getMyRouteResponseModel.data![0].allRoutes!;

              mapPageController.myActivesRoutes =
                  getMyRouteResponseModel.data![0].allRoutes!.activeRoutes;
              mapPageController.myPastsRoutes =
                  mapPageController.myAllRoutes!.pastRoutes;
              mapPageController.mynotStartedRoutes =
                  mapPageController.myAllRoutes!.notStartedRoutes;

              mapPageController.mapPageRouteStartLatitude.value =
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].startingCoordinates![0]
                      : 0.0;
              mapPageController.mapPageRouteStartLongitude.value =
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].startingCoordinates![1]
                      : 0.0;
              mapPageController.startLatLong = LatLng(
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].startingCoordinates![0]
                      : 0.0,
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].startingCoordinates![1]
                      : 0.0);

              mapPageController.mapPageRouteFinishLatitude.value =
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].endingCoordinates![0]
                      : 0.0;
              mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                  ? mapPageController.mapPageRouteFinishLongitude.value =
                      mapPageController
                          .myAllRoutes!.activeRoutes![0].endingCoordinates![1]
                  : 0.0;
              mapPageController.finishLatLong = LatLng(
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].endingCoordinates![0]
                      : 0.0,
                  mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                      ? mapPageController
                          .myAllRoutes!.activeRoutes![0].endingCoordinates![1]
                      : 0.0);
              mapPageController.myAllRoutes!.activeRoutes!.isNotEmpty
                  ? mapPageController.generalPolylineEncode.value =
                      mapPageController
                          .myAllRoutes!.activeRoutes![0].polylineEncode!
                  : "";

              mapPageController.addPointIntoPolylineList(
                  mapPageController.generalPolylineEncode.value);
              mapPageController.addMarkerFunctionForMapPageWithoutOnTap(
                                                                    MarkerId(
                                                                        "myRouteStartMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                                                    LatLng(
                                                                        mapPageController.myAllRoutes!.activeRoutes![0].startingCoordinates![
                                                                            0],
                                                                        mapPageController
                                                                            .myAllRoutes!
                                                                            .activeRoutes![0]
                                                                            .startingCoordinates![1]),
                                                                    "${mapPageController.myAllRoutes!.activeRoutes![0].startingOpenAdress}",
                                                                    BitmapDescriptor.fromBytes(
                                                                        setCustomMarkerIconController
                                                                            .myRouteStartIconnoSee!),
                                                                  );
              mapPageController.addMarkerFunctionForMapPageWithoutOnTap(
                MarkerId(
                    "myRouteFinishMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                LatLng(
                    mapPageController
                        .myAllRoutes!.activeRoutes![0].endingCoordinates![0],
                    mapPageController
                        .myAllRoutes!.activeRoutes![0].endingCoordinates![1]),
                "${mapPageController.myAllRoutes!.activeRoutes![0].endingOpenAdress}",
                BitmapDescriptor.fromBytes(
                    setCustomMarkerIconController.myRouteFinishIcon!),
              );
              if (mapPageController.myActivesRoutes!.isNotEmpty) {
                mapPageController.selectedDispley.value = 5;
              }
            },
          );
        },
        builder: (mapPageController) {
          log("AAAAAAAAAAAAAAAAA Builder Update");

          mapPageController.myAllRoutes == null
              ? initialLocation = CameraPosition(
                  bearing: 90,
                  tilt: 45,
                  target: LatLng(
                    getMyCurrentLocationController.myLocationLatitudeDo.value,
                    getMyCurrentLocationController.myLocationLongitudeDo.value,
                  ),
                  zoom: 15,
                )
              : mapPageController.myAllRoutes!.activeRoutes!.isEmpty
                  ? initialLocation = CameraPosition(
                      bearing: 90,
                      tilt: 45,
                      target: LatLng(
                        getMyCurrentLocationController
                            .myLocationLatitudeDo.value,
                        getMyCurrentLocationController
                            .myLocationLongitudeDo.value,
                      ),
                      zoom: 15,
                    )
                  : initialLocation = CameraPosition(
                      bearing: 90,
                      tilt: 45,
                      target: LatLng(
                          mapPageController.myAllRoutes!.activeRoutes![0]
                              .startingCoordinates![0],
                          mapPageController.myAllRoutes!.activeRoutes![0]
                              .startingCoordinates![1]),
                      zoom: 15,
                    );

          return Stack(
            children: [
              Obx(
                () => ((getMyCurrentLocationController
                                .myLocationLatitudeDo.value ==
                            0.0) &&
                        (getMyCurrentLocationController
                                .myLocationLongitudeDo.value ==
                            0.0))
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: mapPageController.calculateLevel.value == 3
                            ? 340.h
                            : Get.height,
                        width: Get.width,
                        child: GeneralMapViewClass(
                          markerSet: mapPageController.calculateLevel.value == 1
                              ? Set<Marker>.from(mapPageController.markers)
                              : Set<Marker>.from(mapPageController.markers2),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          initialCameraPosition:
                              getMyCurrentLocationController.initialLocation,
                          mapController2:
                              (GoogleMapController controller) async {
                            mapPageController.mapCotroller3
                                .complete(controller);

                            getMyCurrentLocationController.streamSubscription =
                                Geolocator.getPositionStream()
                                    .listen((Position position) async {
                              if (mapPageController
                                      .iWantTrackerMyLocation.value !=
                                  1) {
                                LocationData userLocation =
                                    await LocationService.location
                                        .getLocation();

                                double userBearing =
                                    userLocation.heading ?? 0.0;
                                GoogleMapController googleMapController =
                                    await mapPageController
                                        .mapCotroller3.future;
                                googleMapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      bearing: userBearing,

                                      tilt: 67,
                                      //Zoom ayarı burada
                                      zoom: 16.5,
                                      target: LatLng(
                                        position.latitude,
                                        position.longitude,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                          onCameraMoveStarted: () async {
                            mapPageController.iWantTrackerMyLocation.value = 1;
                          },
                          onCameraMove: (CameraPosition position) async {
                            if (mapPageController
                                    .iWantTrackerMyLocation.value ==
                                1) {
                              Future.delayed(Duration(seconds: 5), () {
                                if (mapPageController
                                        .iWantTrackerMyLocation.value ==
                                    1) {
                                  mapPageController
                                      .iWantTrackerMyLocation.value = 2;
                                }
                              });
                            }
                          },
                          polygonsSet: const <Polygon>{},
                          tileOverlaysSet: const <TileOverlay>{},
                          polylinesSet:
                              mapPageController.calculateLevel.value == 1
                                  ? Set<Polyline>.of(
                                      mapPageController.polylines.values)
                                  : Set<Polyline>.of(
                                      mapPageController.polylines2.values),
                        ),
                      ),
              ),

              Obx(
                () => Visibility(
                  visible: mapPageController.selectedDispley.value == 1,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: AppConstants().ltWhite,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: Text(
                                "Arkadaşlarının Rotaları",
                                style: TextStyle(
                                  fontFamily: "Sfsemibold",
                                  fontSize: 16.sp,
                                  color: AppConstants().ltLogoGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 595.h,
                              child: mapPageController
                                      .myFriendsLocations.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: mapPageController
                                          .myFriendsLocations.length,
                                      itemBuilder: (context, i) {
                                        return ActivesFriendsRoutesCard(
                                          profilePhotoUrl: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .profilePicture!,
                                          id: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .userpostroutes![0]
                                              .id!,
                                          userName:
                                              "${mapPageController.myFriendsLocations[i]!.followed!.name!} ${mapPageController.myFriendsLocations[i]!.followed!.surname!}",
                                          startAdress: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .userpostroutes![0]
                                              .startingCity!,
                                          endAdress: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .userpostroutes![0]
                                              .endingCity!,
                                          startDateTime: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .userpostroutes![0]
                                              .departureDate!
                                              .toString()
                                              .split(" ")[0],
                                          endDateTime: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .userpostroutes![0]
                                              .arrivalDate!
                                              .toString()
                                              .split(" ")[0],
                                          userId: mapPageController
                                              .myFriendsLocations[i]!
                                              .followed!
                                              .id!,
                                        );
                                      },
                                    )
                                  : UiHelper.notFoundAnimationWidget(context,
                                      "Şu an aktif rotada arkadaşın yok!"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: mapPageController.selectedDispley.value == 2,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: AppConstants().ltWhite,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: Text(
                                "Arkadaşlarının Seninle Kesişen Rotaları",
                                style: TextStyle(
                                  fontFamily: "Sfsemibold",
                                  fontSize: 16.sp,
                                  color: AppConstants().ltLogoGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 595.h,
                              child: mapPageController
                                      .myFriendsLocationsMatching.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: mapPageController
                                          .myFriendsLocationsMatching.length,
                                      itemBuilder: (context, i) {
                                        return ActivesFriendsRoutesCard(
                                          profilePhotoUrl: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .profilePicture!,
                                          id: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .userpostroutes![0]
                                              .id!,
                                          userName:
                                              "${mapPageController.myFriendsLocationsMatching[0]!.matching![i].followed!.name!} ${mapPageController.myFriendsLocationsMatching[0]!.matching![i].followed!.surname!}",
                                          startAdress: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .userpostroutes![0]
                                              .startingCity!,
                                          endAdress: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .userpostroutes![0]
                                              .endingCity!,
                                          startDateTime: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .userpostroutes![0]
                                              .departureDate!
                                              .toString()
                                              .split(" ")[0],
                                          endDateTime: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .userpostroutes![0]
                                              .arrivalDate!
                                              .toString()
                                              .split(" ")[0],
                                          userId: mapPageController
                                              .myFriendsLocationsMatching[0]!
                                              .matching![i]
                                              .followed!
                                              .id!,
                                        );
                                      },
                                    )
                                  : UiHelper.notFoundAnimationWidget(context,
                                      "Şu an aktif rotada eşleşen arkadaşın yok!"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // mapPageController.selectedDispley.value == 0
              //     ? Obx(
              //         () => ((getMyCurrentLocationController
              //                         .myLocationLatitudeDo.value ==
              //                     0.0) &&
              //                 (getMyCurrentLocationController
              //                         .myLocationLongitudeDo.value ==
              //                     0.0))
              //             ? const Center(
              //                 child:
              //                     CircularProgressIndicator()) //UiHelper.loadingAnimationWidget(context)
              //             : SizedBox(
              //                 height:
              //                     mapPageController.calculateLevel.value == 3
              //                         ? 340.h
              //                         : Get.height,
              //                 width: Get.width,
              //                 child: GeneralMapViewClass(
              //                   markerSet:
              //                       mapPageController.calculateLevel.value == 1
              //                           ? Set<Marker>.from(
              //                               mapPageController.markers)
              //                           : Set<Marker>.from(
              //                               mapPageController.markers2),
              //                   initialCameraPosition: initialLocation,
              //                   myLocationEnabled: true,
              //                   myLocationButtonEnabled: false,
              //                   mapType: MapType.normal,
              //                   zoomGesturesEnabled: true,
              //                   zoomControlsEnabled: false,
              //                   onCameraMoveStarted: () {
              //                     if (mapPageController
              //                             .iWantTrackerMyLocation.value !=
              //                         0) {
              //                       mapPageController
              //                           .iWantTrackerMyLocation.value = 1;
              //                     }
              //                     //log("onCameraMoveStarted");
              //                   },
              //                   onCameraMove: (p0) {
              //                     //log("onCameraMove");
              //                   },
              //                   polygonsSet: <Polygon>{},
              //                   tileOverlaysSet: <TileOverlay>{},
              //                   polylinesSet: mapPageController
              //                               .calculateLevel.value ==
              //                           1
              //                       ? Set<Polyline>.of(
              //                           mapPageController.polylines.values)
              //                       : Set<Polyline>.of(
              //                           mapPageController.polylines2.values),
              //                   mapController2:
              //                       (GoogleMapController controller) async {
              //                     mapPageController.mapCotroller3
              //                         .complete(controller);
              //                   },
              //                 ),
              //               ),
              //       )
              //     : mapPageController.selectedDispley.value == 1
              //         ? Container(
              //             width: Get.width,
              //             height: Get.height,
              //             color: AppConstants().ltWhite,
              //             child: SingleChildScrollView(
              //               child: Padding(
              //                 padding: EdgeInsets.only(left: 16.w, right: 16.w),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.only(
              //                           bottom: 10, top: 20),
              //                       child: Text(
              //                         "Arkadaşlarının Rotaları",
              //                         style: TextStyle(
              //                           fontFamily: "Sfsemibold",
              //                           fontSize: 16.sp,
              //                           color: AppConstants().ltLogoGrey,
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 595.h,
              //                       child: mapPageController
              //                               .myFriendsLocations.isNotEmpty
              //                           ? ListView.builder(
              //                               itemCount: mapPageController
              //                                   .myFriendsLocations.length,
              //                               itemBuilder: (context, i) {
              //                                 return ActivesFriendsRoutesCard(
              //                                   profilePhotoUrl:
              //                                       mapPageController
              //                                           .myFriendsLocations[i]!
              //                                           .followed!
              //                                           .profilePicture!,
              //                                   id: mapPageController
              //                                       .myFriendsLocations[i]!
              //                                       .followed!
              //                                       .id!,
              //                                   userName:
              //                                       "${mapPageController.myFriendsLocations[i]!.followed!.name!} ${mapPageController.myFriendsLocations[i]!.followed!.surname!}",
              //                                   startAdress: mapPageController
              //                                       .myFriendsLocations[i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .startingCity!,
              //                                   endAdress: mapPageController
              //                                       .myFriendsLocations[i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .endingCity!,
              //                                   startDateTime: mapPageController
              //                                       .myFriendsLocations[i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .departureDate!
              //                                       .toString()
              //                                       .split(" ")[0],
              //                                   endDateTime: mapPageController
              //                                       .myFriendsLocations[i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .arrivalDate!
              //                                       .toString()
              //                                       .split(" ")[0],
              //                                   userId: mapPageController
              //                                       .myFriendsLocations[i]!
              //                                       .followed!
              //                                       .id!,
              //                                 );
              //                               },
              //                             )
              //                           : UiHelper.notFoundAnimationWidget(
              //                               context,
              //                               "Şu an aktif rotada arkadaşın yok!"),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           )
              //         : Container(
              //             width: Get.width,
              //             height: Get.height,
              //             color: AppConstants().ltWhite,
              //             child: SingleChildScrollView(
              //               child: Padding(
              //                 padding: EdgeInsets.only(left: 16.w, right: 16.w),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.only(
              //                           bottom: 10, top: 20),
              //                       child: Text(
              //                         "Arkadaşlarının Seninle Kesişen Rotaları",
              //                         style: TextStyle(
              //                           fontFamily: "Sfsemibold",
              //                           fontSize: 16.sp,
              //                           color: AppConstants().ltLogoGrey,
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: 595.h,
              //                       child: mapPageController
              //                               .myFriendsLocationsMatching
              //                               .isNotEmpty
              //                           ? ListView.builder(
              //                               itemCount: mapPageController
              //                                   .myFriendsLocationsMatching
              //                                   .length,
              //                               itemBuilder: (context, i) {
              //                                 return ActivesFriendsRoutesCard(
              //                                   profilePhotoUrl: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .profilePicture!,
              //                                   id: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .id!,
              //                                   userName:
              //                                       "${mapPageController.myFriendsLocationsMatching[i]!.followed!.name!} ${mapPageController.myFriendsLocationsMatching[i]!.followed!.surname!}",
              //                                   startAdress: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .startingCity!,
              //                                   endAdress: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .endingCity!,
              //                                   startDateTime: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .departureDate!
              //                                       .toString()
              //                                       .split(" ")[0],
              //                                   endDateTime: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .userpostroutes![0]
              //                                       .arrivalDate!
              //                                       .toString()
              //                                       .split(" ")[0],
              //                                   userId: mapPageController
              //                                       .myFriendsLocationsMatching[
              //                                           i]!
              //                                       .followed!
              //                                       .id!,
              //                                 );
              //                               },
              //                             )
              //                           : UiHelper.notFoundAnimationWidget(
              //                               context,
              //                               "Şu an aktif rotada eşleşen arkadaşın yok!"),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              Obx(
                () => Visibility(
                  visible: mapPageController.selectedDispley.value == 0,
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
                    child: RouteCalculateButtomSheet2(
                      key:
                          ValueKey<int>(mapPageController.calculateLevel.value),
                      calculateLevel: mapPageController.calculateLevel.value,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: mapPageController.calculateLevel.value == 1 &&
                      (mapPageController.selectedDispley.value == 5 ||
                          mapPageController.selectedDispley.value == 2),
                  child: Padding(
                    padding: mapPageController.selectedDispley.value == 5
                        ? EdgeInsets.only(right: 16.w, bottom: 105.h)
                        : EdgeInsets.only(right: 16.w, bottom: 50.h),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () async {
                          await GeneralServicesTemp().makeGetRequest(
                            EndPoint.getMyRoutes,
                            {
                              "Content-type": "application/json",
                              'Authorization':
                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                            },
                          ).then((value) {
                            GetMyRouteResponseModel getMyRouteResponseModel =
                                GetMyRouteResponseModel.fromJson(
                                    convert.json.decode(value!));
                            //Anlık arkadaş konumu bağlandı
                            mapPageController.getMyFriendsMatchingRoutes(
                                context,
                                getMyRouteResponseModel.data![0].allRoutes!
                                    .activeRoutes![0].polylineEncode);
                          });
                          if (mapPageController.selectedDispley.value == 5) {
                            mapPageController.selectedDispley.value = 2;
                            //mapPageController.changeSelectedDispley(2);
                          } else {
                            mapPageController.selectedDispley.value = 5;
                            //mapPageController.changeSelectedDispley(0);
                          }
                          //mapPageController.selectedDispley.value = 1;
                          mapPageController.changeCalculateLevel(1);
                        },
                        child: Container(
                          height: 50.w,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: AppConstants().ltMainRed,
                            shape: BoxShape.circle,
                          ),
                          child: mapPageController.selectedDispley.value == 5
                              ? Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: SvgPicture.asset(
                                    "assets/icons/map-page-list-icon-kesisen.svg",
                                    height: 18.w,
                                    color: AppConstants().ltWhite,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: SvgPicture.asset(
                                    "assets/icons/map-page-book-icon.svg",
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
              // Obx(
              //   () => Visibility(
              //     visible: false,
              //     child: Visibility(
              //       visible: mapPageController.calculateLevel.value == 1 &&
              //           (mapPageController.selectedDispley.value == 0 ||
              //               mapPageController.selectedDispley.value == 1),
              //       child: Padding(
              //         padding: EdgeInsets.only(right: 16, bottom: 68.h),
              //         child: Align(
              //           alignment: Alignment.topRight,
              //           child: GestureDetector(
              //             onTap: () async {
              //               if (mapPageController.selectedDispley.value == 0) {
              //                 mapPageController.selectedDispley.value = 1;
              //                 //mapPageController.changeSelectedDispley(1);
              //               } else {
              //                 mapPageController.selectedDispley.value = 0;
              //                 //mapPageController.changeSelectedDispley(0);
              //               }
              //               //mapPageController.selectedDispley.value = 1;
              //               mapPageController.changeCalculateLevel(1);
              //             },
              //             child: Container(
              //               height: 50.w,
              //               width: 50.w,
              //               decoration: BoxDecoration(
              //                 color: AppConstants().ltMainRed,
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Padding(
              //                 padding: EdgeInsets.all(16.w),
              //                 child: SvgPicture.asset(
              //                   mapPageController.selectedDispley.value == 0
              //                       ? "assets/icons/map-page-list-icon.svg"
              //                       : "assets/icons/map-page-book-icon.svg",
              //                   height: 18.w,
              //                   color: AppConstants().ltWhite,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Visibility(
                visible: (mapPageController.calculateLevel.value == 1) &&
                    (mapPageController.selectedDispley.value == 0 ||
                        mapPageController.selectedDispley.value == 5),
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w, top: 45.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () async {
                        await googleMapsGeneralWidgetsController
                            .animatedCameraPosition(
                          mapPageController.mapCotroller3,
                          LatLng(
                            getMyCurrentLocationController
                                .myLocationLatitudeDo.value,
                            getMyCurrentLocationController
                                .myLocationLongitudeDo.value,
                          ),
                          "mapPageController",
                        );
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
              ),

              Obx(() => Visibility(
                  visible: mapPageController.selectedDispley.value == 5,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: finishRouteButton.value == true ? 100.h : 160.h,
                      decoration: BoxDecoration(
                          color: AppConstants().ltWhite.withOpacity(0.95),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r))),
                      padding: const EdgeInsets.all(12),
                      constraints:
                          BoxConstraints(maxHeight: 160.h, minHeight: 100.h),
                      child: mapPageController.myActivesRoutes?.isNotEmpty ??
                              false
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    children: [
                                      Visibility(
                                        visible: !finishRouteButton.value,
                                        child: Text(
                                          mapPageController
                                                  .myActivesRoutes!.isNotEmpty
                                              ? "${DateFormat('HH:mm').format(DateTime(
                                                  2023,
                                                  1,
                                                  1,
                                                  (mapPageController
                                                          .myActivesRoutes![0]
                                                          .arrivalDate!
                                                          .hour) +
                                                      3,
                                                  mapPageController
                                                      .myActivesRoutes![0]
                                                      .arrivalDate!
                                                      .minute,
                                                ))} varış"
                                              : "",
                                          style: TextStyle(
                                            color: AppConstants().ltLogoGrey,
                                            fontFamily: "SfBold",
                                            fontSize: 28.sp,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: finishRouteButton.value,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: mapPageController
                                                      .myActivesRoutes!
                                                      .isNotEmpty
                                                  ? DateFormat('HH:mm')
                                                      .format(DateTime(
                                                      2023,
                                                      1,
                                                      1,
                                                      (mapPageController
                                                              .myActivesRoutes![
                                                                  0]
                                                              .arrivalDate!
                                                              .hour) +
                                                          3,
                                                      mapPageController
                                                          .myActivesRoutes![0]
                                                          .arrivalDate!
                                                          .minute,
                                                    ))
                                                  : "",
                                              style: TextStyle(
                                                color:
                                                    AppConstants().ltLogoGrey,
                                                fontFamily: "SfBold",
                                                fontSize: 28.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "\nvarış",
                                              style: TextStyle(
                                                color: AppConstants()
                                                    .ltLogoGrey
                                                    .withOpacity(0.6),
                                                fontFamily: "SfMedium",
                                                fontSize: 18.sp,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      18.w.horizontalSpace,
                                      Visibility(
                                        visible: finishRouteButton.value,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: mapPageController
                                                      .myActivesRoutes!
                                                      .isNotEmpty
                                                  ? (mapPageController
                                                          .myActivesRoutes![0]
                                                          .arrivalDate!
                                                          .difference(
                                                              DateTime.now())
                                                          .inMinutes)
                                                      .toString()
                                                  : "",
                                              style: TextStyle(
                                                color:
                                                    AppConstants().ltLogoGrey,
                                                fontFamily: "SfBold",
                                                fontSize: 28.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "\ndakika",
                                              style: TextStyle(
                                                color: AppConstants()
                                                    .ltLogoGrey
                                                    .withOpacity(0.6),
                                                fontFamily: "SfMedium",
                                                fontSize: 18.sp,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      18.w.horizontalSpace,
                                      Visibility(
                                        visible: finishRouteButton.value,
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: mapPageController
                                                      .myActivesRoutes!
                                                      .isNotEmpty
                                                  ? mapPageController
                                                      .myActivesRoutes![0]
                                                      .distance
                                                      .toString()
                                                  : "",
                                              style: TextStyle(
                                                color:
                                                    AppConstants().ltLogoGrey,
                                                fontFamily: "SfBold",
                                                fontSize: 28.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "\nkm",
                                              style: TextStyle(
                                                color: AppConstants()
                                                    .ltLogoGrey
                                                    .withOpacity(0.6),
                                                fontFamily: "SfMedium",
                                                fontSize: 18.sp,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          finishRouteButton.value =
                                              !finishRouteButton.value;
                                        },
                                        child: CircleAvatar(
                                          radius: 24,
                                          backgroundColor: AppConstants()
                                              .ltWhiteGrey
                                              .withOpacity(1),
                                          child: Icon(
                                            finishRouteButton.value == true
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
                                const Spacer(),
                                Visibility(
                                  visible: !finishRouteButton.value,
                                  child: SizedBox(
                                    width: 348.w,
                                    height: 50.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        MapPageController mappageController =
                                            MapPageController();
                                        mappageController
                                            .getMyRoutesServicesRequestRefreshable();
                                        GeneralServicesTemp().makePatchRequest(
                                          EndPoint.activateRoute,
                                          ActivateRouteRequestModel(
                                              routeId: mapPageController
                                                  .myActivesRoutes![0].id),
                                          {
                                            "Content-type": "application/json",
                                            'Authorization':
                                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                          },
                                        ).then((value) {
                                          ActivateRouteResponseModel response =
                                              ActivateRouteResponseModel
                                                  .fromJson(jsonDecode(value!));
                                          if (response.success == 1) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Başarılı rotanız başarıyla bitirilmiştir."),
                                              ),
                                            );

                                            print(response.success);
                                            print(response.message);

                                            finishRouteButton.value = true;
                                            mapPageController
                                                .changeCalculateLevel(1);
                                            mapPageController
                                                .selectedDispley(0);

                                            mapPageController.markers.clear();

                                            mapPageController
                                                .polylineCoordinates
                                                .clear();
                                            mapPageController
                                                .polylineCoordinates2
                                                .clear();
                                            mapPageController
                                                .polylineCoordinatesListForB
                                                .clear();
                                            mapPageController.polylines.clear();
                                            mapPageController.polylines2
                                                .clear();
                                            mapPageController
                                                .polylineCoordinatesListForB
                                                .clear();
                                          } else {
                                            print(response.success);
                                            print(response.message);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppConstants().ltMainRed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
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
                                ),
                                8.h.verticalSpace
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  )))
            ],
          );
        },
      ),
    );
  }
}

class RouteCalculateButtomSheet2 extends StatelessWidget {
  RouteCalculateButtomSheet2({
    super.key,
    required this.calculateLevel,
  });

  late int calculateLevel;
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  MapPageController createRouteController = Get.find<MapPageController>();
  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  GoogleMapsGeneralWidgetsController googleMapsGeneralWidgetsController =
      Get.find<GoogleMapsGeneralWidgetsController>();

  @override
  Widget build(BuildContext context) {
    if (calculateLevel == 1) {
      return _calculateLevelOne();
    } else if (calculateLevel == 2) {
      return _calculateLevelTwo(context);
    } else if (calculateLevel == 3) {
      return _calculateLevelThree(context);
    } else if (calculateLevel == 4) {
      return _calculateLevelFour(context);
    } else {
      return _calculateLevelOne();
    }
  }

  Widget _calculateLevelOne() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () async {
            await googleMapsGeneralWidgetsController
                .getAddressFromLatLang(
              LatLng(
                getMyCurrentLocationController.myLocationLatitudeDo.value,
                getMyCurrentLocationController.myLocationLongitudeDo.value,
              ),
            )
                .then((value) async {
              createRouteController.mapPageRouteStartAddress2.value = value[0];
              createRouteController.mapPageRouteStartLatitude2.value =
                  getMyCurrentLocationController.myLocationLatitudeDo.value;
              createRouteController.mapPageRouteStartLongitude2.value =
                  getMyCurrentLocationController.myLocationLongitudeDo.value;
              createRouteController.startCity.value = value[1];
            });
            log("mapPageRouteStartAddress2 = ${createRouteController.mapPageRouteStartAddress2.value}");
            log("createRouteController.startCity.value = ${createRouteController.startCity.value}");
            // createRouteController.mapPageRouteStartAddress2.value = "";
            createRouteController.iWantTrackerMyLocation.value = 2;
            createRouteController.changeCalculateLevel(2);
            createRouteController.addMarkerFunctionForMapPageWithoutOnTap2(
              const MarkerId("myLocationMarker"),
              LatLng(
                getMyCurrentLocationController.myLocationLatitudeDo.value,
                getMyCurrentLocationController.myLocationLongitudeDo.value,
              ),
              createRouteController.mapPageRouteStartAddress2.value,
              BitmapDescriptor.fromBytes(createRouteController
                  .customMarkerIconController.mayLocationIcon!),
            );
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
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.w,
                    bottom: 15,
                    top: 15,
                  ),
                  child: Text(
                    "Rota ara veya oluştur",
                    style: TextStyle(
                      color: AppConstants().ltLogoGrey,
                      fontFamily: "SfLight",
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _calculateLevelTwo(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 240,
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    createRouteController.mapPageRouteControllerClear();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Lütfen hesaplamak istediğiniz rotanın başlangıç ve bitiş noktalarını giriniz",
                            style: TextStyle(
                              fontFamily: "Sflight",
                              fontSize: 12.sp,
                              color: AppConstants().ltLogoGrey,
                            ),
                          ),
                        ),
                        _placesAutoComplateTextFieldStart(context),
                        const SizedBox(
                          height: 10,
                        ),
                        _placesAutoComplateTextFieldFinish(context),
                      ],
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

  Widget _calculateLevelThree(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 310.h,
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    createRouteController.mapPageRouteControllerClear();
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
                height: 260.h,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Column(
                      children: [
                        _placesAutoComplateTextFieldStart(context),
                        const SizedBox(
                          height: 10,
                        ),
                        _placesAutoComplateTextFieldFinish(context),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      child: SvgPicture.asset(
                                        'assets/icons/route-icon.svg',
                                        color: AppConstants().ltMainRed,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Text(
                                              'Rota',
                                              style: TextStyle(
                                                color:
                                                    AppConstants().ltDarkGrey,
                                                fontFamily: 'Sflight',
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 2.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Obx(
                                                  () => Text(
                                                    createRouteController
                                                        .startCity.value,
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltLogoGrey,
                                                      fontFamily: 'Sfmedium',
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  ' -> ',
                                                  style: TextStyle(
                                                    color: AppConstants()
                                                        .ltLogoGrey,
                                                    fontFamily: 'Sfmedium',
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Obx(
                                                  () => Text(
                                                    createRouteController
                                                        .finishCity.value,
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltLogoGrey,
                                                      fontFamily: 'Sfmedium',
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
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
                                                Obx(
                                                  () => Text(
                                                    "${createRouteController.calculatedRouteDistance}",
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltBlack,
                                                      fontFamily: 'Sflight',
                                                      fontSize: 12.sp,
                                                    ),
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
                                                Obx(
                                                  () => Text(
                                                    "${createRouteController.calculatedRouteTime}",
                                                    style: TextStyle(
                                                      color: AppConstants()
                                                          .ltBlack,
                                                      fontFamily: 'Sflight',
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (createRouteController.startCity !=
                                                "" &&
                                            createRouteController.finishCity !=
                                                "") {
                                          createRouteController
                                              .changeCalculateLevel(4);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppConstants().ltMainRed,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  Widget _calculateLevelFour(BuildContext context) {
    ScrollController scrollController = ScrollController();
    DateTime dateTimeFormatLast;
    VehicleInfoController vehicleInfoController = Get.find();

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
              blurRadius: 10.r,
            ),
          ],
          color: AppConstants().ltWhite,
          //borderRadius: BorderRadius.circular(8.r),
        ),
        child: SizedBox(
          width: Get.width,
          height: 650.h,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            createRouteController.changeCalculateLevel(3);
                          },
                          child: Text(
                            "Rotayı Gör",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppConstants().ltMainRed,
                              fontFamily: 'SfBold',
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            createRouteController.mapPageRouteControllerClear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SvgPicture.asset(
                              "assets/icons/close-icon.svg",
                              width: 32.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width,
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
                              Padding(
                                padding: EdgeInsets.all(5.w),
                                child: Column(
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
                                    Obx(() {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Tahmini: ",
                                              style: TextStyle(
                                                color:
                                                    AppConstants().ltLogoGrey,
                                                fontFamily: 'Sflight',
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Text(
                                              "${createRouteController.calculatedRouteDistance}",
                                              style: TextStyle(
                                                color: AppConstants().ltBlack,
                                                fontFamily: 'Sflight',
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Text(
                                              " ve ",
                                              style: TextStyle(
                                                color:
                                                    AppConstants().ltLogoGrey,
                                                fontFamily: 'Sflight',
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            Text(
                                              "${createRouteController.calculatedRouteTime}",
                                              style: TextStyle(
                                                color: AppConstants().ltBlack,
                                                fontFamily: 'Sflight',
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 340.w,
                            child: Text(
                              'Çıkış Tarihi:',
                              style: TextStyle(
                                fontFamily: 'Sfbold',
                                fontSize: 16.sp,
                                color: AppConstants().ltLogoGrey,
                              ),
                            ),
                          ),
                        ),
                        3.h.spaceY,
                        SizedBox(
                          width: 340.w,
                          child: Text(
                            'Belirlenen rotaya ne zaman başlayacaksın?',
                            style: TextStyle(
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                              color: AppConstants().ltLogoGrey,
                            ),
                          ),
                        ),
                        10.h.spaceY,
                        Container(
                          width: 340.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppConstants().ltDarkGrey.withOpacity(0.15),
                                spreadRadius: 5.r,
                                blurRadius: 7.r,
                                offset: Offset(0, 3.h),
                              ),
                            ],
                          ),
                          child: TextField(
                            readOnly: true,
                            controller: createRouteController.cikisController,
                            onTap: () async {
                              var pickedDate = await showDatePicker(
                                confirmText: "Devam",
                                locale: const Locale("tr", "TR"),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: AppConstants().ltMainRed,
                                      colorScheme: ColorScheme.light(
                                        primary: AppConstants().ltMainRed,
                                        secondary: AppConstants().ltLogoGrey,
                                      ),
                                      buttonTheme: const ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              var pickedTime = await showTimePicker(
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        primaryColor: AppConstants().ltMainRed,
                                        colorScheme: ColorScheme.light(
                                          primary: AppConstants().ltMainRed,
                                          secondary: AppConstants().ltLogoGrey,
                                        ),
                                        buttonTheme: const ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary),
                                      ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialTime:
                                      TimeOfDay.fromDateTime(DateTime.now()));

                              String formattedDate1 =
                                  DateFormat('dd/MM/yyyy').format(pickedDate!);

                              String formattedDate2 =
                                  DateFormat('dd-MM-yyyy HH:mm').format(
                                      pickedDate); //TODO: DB ye bu şekilde gönderilmeli

                              //  log(formattedDate2.toString());

                              String dateTimeFormatted =
                                  "$formattedDate1 ${pickedTime.toString().substring(10, 15)}";
                              // log(dateTimeFormatted);

                              dateTimeFormatLast = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                      pickedTime!.hour,
                                      pickedTime.minute)
                                  .add(Duration(
                                      minutes: createRouteController
                                          .calculatedRouteTimeInt));

                              createRouteController.dateTimeFormatLast.value =
                                  DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute)
                                      .add(Duration(
                                          minutes: createRouteController
                                              .calculatedRouteTimeInt));

                              createRouteController.dateTimeFormatVaris.value =
                                  DateFormat('yyyy-MM-dd HH:mm').format(
                                      createRouteController
                                          .dateTimeFormatLast.value);
                              print(
                                  "aaaaaa ${createRouteController.dateTimeFormatVaris.value}");
                              dateTimeFormatLast = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                      pickedTime.hour,
                                      pickedTime.minute)
                                  .add(Duration(
                                      minutes: createRouteController
                                          .calculatedRouteTimeInt));

                              createRouteController.dateTimeFormatCikis.value =
                                  DateFormat('yyyy-MM-dd HH:mm').format(
                                      DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute));
                              print(
                                  "aaaaaa ${createRouteController.dateTimeFormatCikis.value}");
                              if (pickedDate != null) {
                                createRouteController.cikisController.text =
                                    createRouteController
                                        .dateTimeFormatCikis.value;
                                createRouteController.pickedDate.value =
                                    DateTime.parse(createRouteController
                                        .dateTimeFormatCikis.value);
                                //varisController.clear();
                              } else {
                                //print("Date is not selected");
                              }
                            },

                            //controller: _controller1,
                            cursorColor: AppConstants().ltMainRed,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: AppConstants().ltWhite,
                              hintStyle: TextStyle(
                                fontFamily: "Sflight",
                                fontSize: 14.sp,
                                color: AppConstants().ltDarkGrey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(15.w),
                              hintText: 'Çıkış tarihi giriniz',
                            ),
                            style: TextStyle(
                              fontFamily: "Sflight",
                              fontSize: 14.sp,
                              color: AppConstants().ltBlack,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 340.w,
                            child: Text(
                              'Varış Tarihi:',
                              style: TextStyle(
                                fontFamily: 'Sfbold',
                                fontSize: 16.sp,
                                color: AppConstants().ltLogoGrey,
                              ),
                            ),
                          ),
                        ),
                        3.h.spaceY,
                        SizedBox(
                          width: 340.w,
                          child: Text(
                            'Yolculuğun ne zaman son bulacak?',
                            style: TextStyle(
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                              color: AppConstants().ltLogoGrey,
                            ),
                          ),
                        ),
                        10.h.spaceY,
                        Container(
                          width: 340.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppConstants().ltDarkGrey.withOpacity(0.15),
                                spreadRadius: 5.r,
                                blurRadius: 7.r,
                                offset: Offset(0, 3.h),
                              ),
                            ],
                          ),
                          child: Obx(
                            () {
                              return TextField(
                                readOnly: true,
                                onTap: createRouteController.pickedDate.value ==
                                        null
                                    ? () {}
                                    : () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          locale: const Locale("tr", "TR"),
                                          context: context,
                                          initialDate: createRouteController
                                              .dateTimeFormatLast.value,
                                          firstDate: createRouteController
                                              .dateTimeFormatLast.value,
                                          lastDate: DateTime(2101),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    AppConstants().ltMainRed,
                                                colorScheme: ColorScheme.light(
                                                  primary:
                                                      AppConstants().ltMainRed,
                                                  secondary:
                                                      AppConstants().ltLogoGrey,
                                                ),
                                                buttonTheme:
                                                    const ButtonThemeData(
                                                        textTheme:
                                                            ButtonTextTheme
                                                                .primary),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );

                                        var pickedTime = await showTimePicker(
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    ThemeData.light().copyWith(
                                                  primaryColor:
                                                      AppConstants().ltMainRed,
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: AppConstants()
                                                        .ltMainRed,
                                                    secondary: AppConstants()
                                                        .ltLogoGrey,
                                                  ),
                                                  buttonTheme:
                                                      const ButtonThemeData(
                                                          textTheme:
                                                              ButtonTextTheme
                                                                  .primary),
                                                ),
                                                child: child!,
                                              );
                                            },
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                                createRouteController
                                                    .dateTimeFormatLast.value));

                                        String formattedDate1 =
                                            DateFormat('dd/MM/yyyy')
                                                .format(pickedDate!);

                                        String formattedDate2 = DateFormat(
                                                'yyyy-MM-dd HH:mm')
                                            .format(
                                                pickedDate); //TODO: DB ye bu şekilde gönderilmeli

                                        String dateTimeFormatted =
                                            "$formattedDate1 ${pickedTime.toString().substring(10, 15)}";

                                        createRouteController
                                                .differentTime.value =
                                            DateFormat('yyyy-MM-dd HH:mm')
                                                .format(DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                    pickedTime!.hour,
                                                    pickedTime.minute));
                                        print(
                                            "DENEME 55 = ${createRouteController.differentTime.value}");

                                        /* createRouteController.dateTimeFormatVaris.value =
                                  DateFormat('yyyy-MM-dd HH:mm').format(
                                      createRouteController
                                          .dateTimeFormatLast.value);*/

                                        if (pickedDate != null) {
                                          if (createRouteController
                                                  .differentTime.value !=
                                              createRouteController
                                                  .dateTimeFormatVaris.value) {
                                            createRouteController
                                                    .varisController.text =
                                                createRouteController
                                                    .differentTime.value;

                                            createRouteController
                                                    .pickedDate.value =
                                                DateTime.parse(
                                                    createRouteController
                                                        .differentTime.value
                                                        .toString());
                                          } else {
                                            createRouteController
                                                    .varisController.text =
                                                createRouteController
                                                    .dateTimeFormatVaris.value;

                                            createRouteController
                                                    .pickedDate.value =
                                                DateTime.parse(
                                                    createRouteController
                                                        .dateTimeFormatVaris
                                                        .value
                                                        .toString());
                                          }
                                        } else {
                                          //print("Date is not selected");
                                        }

                                        scrollController.animateTo(
                                            scrollController
                                                    .position.maxScrollExtent +
                                                1,
                                            duration:
                                                const Duration(microseconds: 1),
                                            curve: Curves.bounceOut);
                                      },
                                controller:
                                    createRouteController.varisController,
                                cursorColor: AppConstants().ltMainRed,
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: AppConstants().ltWhite,
                                  hintStyle: TextStyle(
                                    fontFamily: "Sflight",
                                    fontSize: 14.sp,
                                    color: AppConstants().ltDarkGrey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.all(15.w),
                                  hintText: 'Varış tarihi giriniz',
                                ),
                                style: TextStyle(
                                  fontFamily: "Sflight",
                                  fontSize: 14.sp,
                                  color: AppConstants().ltBlack,
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 340.w,
                            child: Text(
                              'Araç Bilgileri:',
                              style: TextStyle(
                                fontFamily: 'Sfbold',
                                fontSize: 16.sp,
                                color: AppConstants().ltLogoGrey,
                              ),
                            ),
                          ),
                        ),
                        3.h.spaceY,
                        Obx(() => SizedBox(
                              width: 340.w,
                              child: Row(
                                children: [
                                  Text(
                                    'Yolculuğa çıkılacak araç: ',
                                    style: TextStyle(
                                      fontFamily: 'Sflight',
                                      fontSize: 12.sp,
                                      color: AppConstants().ltLogoGrey,
                                    ),
                                  ),
                                  Text(
                                    '${vehicleInfoController.vehicleMarka.value} / ${vehicleInfoController.vehicleModel.value}',
                                    style: TextStyle(
                                      fontFamily: 'Sfbold',
                                      fontSize: 12.sp,
                                      color: AppConstants().ltLogoGrey,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          NavigationConstants.vehicleSettings);
                                    },
                                    child: Text(
                                      "Düzenle",
                                      style: TextStyle(
                                        fontFamily: 'Sfbold',
                                        fontSize: 12.sp,
                                        color: AppConstants().ltMainRed,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        // 3.h.spaceY,
                        // SizedBox(
                        //   width: 340.w,
                        //   child: Text(
                        //     'Aracının doluluk oranını % kaç? Arkadaşların için bu bilgi çok önemli!',
                        //     style: TextStyle(
                        //       fontFamily: 'Sflight',
                        //       fontSize: 12.sp,
                        //       color: AppConstants().ltLogoGrey,
                        //     ),
                        //   ),
                        // ),
                        // 10.h.spaceY,
                        // Container(
                        //   width: 340.w,
                        //   height: 50.h,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: AppConstants()
                        //             .ltDarkGrey
                        //             .withOpacity(0.15),
                        //         spreadRadius: 5.r,
                        //         blurRadius: 7.r,
                        //         offset: Offset(
                        //             0, 3.h), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   child: TextField(
                        //     // onChanged: (value) {
                        //     //   _controller3.text = "%";
                        //     // },
                        //     keyboardType: TextInputType.number,
                        //     maxLength: 4,
                        //     cursorColor: AppConstants().ltMainRed,
                        //     controller:
                        //         createRouteController.kapasiteController,
                        //     inputFormatters: [
                        //       MaskTextInputFormatter(
                        //         mask: '% ##',
                        //         filter: {"#": RegExp('[0-9]')},
                        //         type: MaskAutoCompletionType.lazy,
                        //       ),
                        //     ],
                        //     decoration: InputDecoration(
                        //       counterText: '',
                        //       filled: true,
                        //       fillColor: AppConstants().ltWhite,
                        //       hintStyle: TextStyle(
                        //         fontFamily: "Sflight",
                        //         fontSize: 14.sp,
                        //         color: AppConstants().ltDarkGrey,
                        //       ),
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.all(
                        //           Radius.circular(8.r),
                        //         ),
                        //         borderSide: BorderSide.none,
                        //       ),
                        //       contentPadding: EdgeInsets.all(15.w),
                        //       hintText: 'Doluluk oranı giriniz',
                        //     ),
                        //     style: TextStyle(
                        //       fontFamily: "Sflight",
                        //       fontSize: 14.sp,
                        //       color: AppConstants().ltBlack,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 340.w,
                            child: Text(
                              'Açıklama:',
                              style: TextStyle(
                                fontFamily: 'Sfbold',
                                fontSize: 16.sp,
                                color: AppConstants().ltLogoGrey,
                              ),
                            ),
                          ),
                        ),
                        3.h.spaceY,
                        SizedBox(
                          width: 340.w,
                          child: Text(
                            'Yolculuğun hakkında arkadaşlarını bilgilendir!',
                            style: TextStyle(
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                              color: AppConstants().ltLogoGrey,
                            ),
                          ),
                        ),
                        10.h.spaceY,
                        Container(
                          width: 340.w,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    AppConstants().ltDarkGrey.withOpacity(0.15),
                                spreadRadius: 5.r,
                                blurRadius: 7.r,
                                offset: Offset(
                                    0, 3.h), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            maxLines: 6,
                            keyboardType: TextInputType.text,
                            cursorColor: AppConstants().ltMainRed,
                            controller:
                                createRouteController.aciklamaController,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: AppConstants().ltWhite,
                              hintStyle: TextStyle(
                                fontFamily: "Sflight",
                                fontSize: 14.sp,
                                color: AppConstants().ltDarkGrey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.all(15.w),
                              hintText: 'Açıklama giriniz',
                            ),
                            style: TextStyle(
                              fontFamily: "Sflight",
                              fontSize: 14.sp,
                              color: AppConstants().ltBlack,
                            ),
                          ),
                        ),
                        20.h.spaceY,
                        SizedBox(
                          width: Get.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (createRouteController
                                  .cikisController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Lütfen Çıkış Tarihi giriniz.',
                                    ),
                                  ),
                                );
                              } else if (createRouteController
                                  .varisController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Lütfen Varış Tarihi giriniz.',
                                    ),
                                  ),
                                );
                              } else {
                                UiHelper.showLoadingAnimation(context);
                                GeneralServicesTemp().makePostRequest(
                                  EndPoint.routesNew,
                                  PostCreateRouteRequestModel(
                                    departureDate: createRouteController
                                        .cikisController.text,
                                    arrivalDate: createRouteController
                                        .varisController.text,
                                    // departureDate: createRouteController
                                    //     .cikisController.text
                                    //     .split('/')
                                    //     .reversed
                                    //     .join('-'),
                                    // arrivalDate: createRouteController
                                    //     .varisController.text
                                    //     .split('/')
                                    //     .reversed
                                    //     .join('-'),
                                    routeDescription: createRouteController
                                                .aciklamaController.text ==
                                            ""
                                        ? "${createRouteController.cikisController.text} tarihinde ${createRouteController.startCity.value} şehrinden başlayan yolculuk ${createRouteController.varisController.text} tarihinde ${createRouteController.finishCity.value} şehrinde son bulacak."
                                        : createRouteController
                                            .aciklamaController.text,
                                    vehicleCapacity: 100,
                                    startingCoordinates: [
                                      createRouteController
                                          .mapPageRouteStartLatitude2.value,
                                      createRouteController
                                          .mapPageRouteStartLongitude2.value
                                    ],
                                    startingOpenAdress: createRouteController
                                        .mapPageRouteStartAddress2.value,
                                    startingCity:
                                        createRouteController.startCity.value,
                                    endingCoordinates: [
                                      createRouteController
                                          .mapPageRouteFinishLatitude2.value,
                                      createRouteController
                                          .mapPageRouteFinishLongitude2.value
                                    ],
                                    endingOpenAdress: createRouteController
                                        .mapPageRouteFinishAddress2.value,
                                    endingCity:
                                        createRouteController.finishCity.value,
                                    distance: createRouteController
                                        .calculatedRouteDistanceInt,
                                    travelTime: createRouteController
                                        .calculatedRouteTimeInt,
                                    polylineEncode: createRouteController
                                        .generalPolylineEncode2.value,
                                  ),
                                  {
                                    "Content-type": "application/json",
                                    'Authorization':
                                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                  },
                                ).then(
                                  (value) async {
                                    if (value != null) {
                                      log(value);
                                      final response =
                                          PostCreateRouteResponseModel.fromJson(
                                              jsonDecode(value));
                                      log(response.message.toString());
                                      log(response.success.toString());
                                      if (response.success == 1) {
                                        CreatePostPageController
                                            createPostPageController =
                                            Get.put(CreatePostPageController());
                                        createPostPageController.routeId.value =
                                            response.data![0].id!;
                                        log("ROUTEIDD: " +
                                            createPostPageController
                                                .routeId.value
                                                .toString());
                                        createRouteController
                                            .mapPageRouteControllerClear();
                                        // createRouteController.cikisController.clear();
                                        // createRouteController.varisController.clear();
                                        // createRouteController.kapasiteController.clear();
                                        // createRouteController.aciklamaController.clear();
                                        log("paylaşıldıııı");
                                        // showDialog(
                                        //   context: context,
                                        //   builder: (BuildContext context) =>
                                        //       showNewAllertDialog(
                                        //           context,
                                        //           response.data![0].startingCity!
                                        //                   .toString() +
                                        //               " -> " +
                                        //               response
                                        //                   .data![0].endingCity!
                                        //                   .toString(),
                                        //           "Furkan Semiz",
                                        //           response.data![0].departureDate!
                                        //               .toString()
                                        //               .substring(0, 11),
                                        //           response.data![0].arrivalDate!
                                        //               .toString()
                                        //               .substring(0, 11)),
                                        // );
                                        if (DateTime.now().day.toString() ==
                                            DateTime.parse(createRouteController
                                                    .cikisController.text)
                                                .day
                                                .toString()) {
                                          if (DateTime.now().minute + 5 == DateTime.parse(createRouteController.cikisController.text).minute ||
                                              DateTime.now().minute + 4 ==
                                                  DateTime.parse(createRouteController.cikisController.text)
                                                      .minute ||
                                              DateTime.now().minute + 3 ==
                                                  DateTime.parse(createRouteController.cikisController.text)
                                                      .minute ||
                                              DateTime.now().minute + 2 ==
                                                  DateTime.parse(createRouteController.cikisController.text)
                                                      .minute ||
                                              DateTime.now().minute + 1 ==
                                                  DateTime.parse(createRouteController.cikisController.text)
                                                      .minute ||
                                              DateTime.now().minute - 1 ==
                                                  DateTime.parse(createRouteController.cikisController.text)
                                                      .minute ||
                                              DateTime.now().minute - 2 ==
                                                  DateTime.parse(
                                                          createRouteController
                                                              .cikisController
                                                              .text)
                                                      .minute ||
                                              DateTime.now().minute ==
                                                  DateTime.parse(
                                                          createRouteController
                                                              .cikisController
                                                              .text)
                                                      .minute) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text("UYARI!"),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "Görünüşe göre anlık bir rota oluşturdunuz.",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Sfregular',
                                                            fontSize: 16.sp,
                                                            color:
                                                                AppConstants()
                                                                    .ltDarkGrey,
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
                                                        color: AppConstants()
                                                            .ltLogoGrey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 12.w,
                                                                right: 12.w,
                                                                left: 12.w),
                                                        child:
                                                            CustomButtonDesign(
                                                          text: 'Rotayı Başlat',
                                                          textColor:
                                                              AppConstants()
                                                                  .ltWhite,
                                                          onpressed: () {
                                                            MapPageController
                                                                mappageController =
                                                                MapPageController();
                                                            mappageController
                                                                .getMyRoutesServicesRequestRefreshable();
                                                            GeneralServicesTemp()
                                                                .makePatchRequest(
                                                              EndPoint
                                                                  .activateRoute,
                                                              ActivateRouteRequestModel(
                                                                  routeId:
                                                                      response
                                                                          .data![
                                                                              0]
                                                                          .id),
                                                              {
                                                                "Content-type":
                                                                    "application/json",
                                                                'Authorization':
                                                                    'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                                              },
                                                            ).then((value) async {
                                                              ActivateRouteResponseModel
                                                                  response =
                                                                  ActivateRouteResponseModel
                                                                      .fromJson(
                                                                          jsonDecode(
                                                                              value!));

                                                              if (response
                                                                      .success ==
                                                                  1) {
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context2) {
                                                                      return showNewAllertDialog(
                                                                          context,
                                                                          "${createRouteController.startCity.value} -> ${createRouteController.finishCity.value}",
                                                                          (LocaleManager.instance.getString(PreferencesKeys
                                                                              .currentUserUserName)),
                                                                          createRouteController
                                                                              .cikisController
                                                                              .value
                                                                              .toString()
                                                                              .substring(0,
                                                                                  11),
                                                                          createRouteController
                                                                              .varisController
                                                                              .value
                                                                              .toString()
                                                                              .substring(0, 11),
                                                                          0);
                                                                    });
                                                                MapPageController
                                                                    mapPageController =
                                                                    Get.put(
                                                                        MapPageController());
                                                                SetCustomMarkerIconController
                                                                    setCustomMarkerIconController =
                                                                    Get.put(
                                                                        SetCustomMarkerIconController());
                                                                mapPageController
                                                                    .getMyFriendsRoutesRequestRefreshable(
                                                                        context);
                                                                // mapPageController.getMyRoutesServicesRequestRefreshable();

                                                                await GeneralServicesTemp()
                                                                    .makeGetRequest(
                                                                  EndPoint
                                                                      .getMyRoutes,
                                                                  {
                                                                    "Content-type":
                                                                        "application/json",
                                                                    'Authorization':
                                                                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                                                  },
                                                                ).then((value) async {
                                                                  GetMyRouteResponseModel
                                                                      getMyRouteResponseModel =
                                                                      GetMyRouteResponseModel.fromJson(convert
                                                                          .json
                                                                          .decode(
                                                                              value!));
                                                                  mapPageController
                                                                          .myAllRoutes =
                                                                      getMyRouteResponseModel
                                                                          .data![
                                                                              0]
                                                                          .allRoutes!;
                                                                  GoogleMapController
                                                                      googleMapController =
                                                                      await mapPageController
                                                                          .mapCotroller3
                                                                          .future;
                                                                  googleMapController
                                                                      .animateCamera(
                                                                    CameraUpdate
                                                                        .newCameraPosition(
                                                                      CameraPosition(
                                                                        bearing:
                                                                            90,
                                                                        target:
                                                                            LatLng(
                                                                          getMyCurrentLocationController
                                                                              .myLocationLatitudeDo
                                                                              .value,
                                                                          getMyCurrentLocationController
                                                                              .myLocationLongitudeDo
                                                                              .value,
                                                                        ),
                                                                        zoom:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  );
                                                                  mapPageController
                                                                      .selectedDispley(
                                                                          5);
                                                                  mapPageController
                                                                          .myActivesRoutes =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes;
                                                                  mapPageController
                                                                          .myPastsRoutes =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .pastRoutes;
                                                                  mapPageController
                                                                          .mynotStartedRoutes =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .notStartedRoutes;

                                                                  mapPageController
                                                                          .mapPageRouteStartLatitude
                                                                          .value =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .startingCoordinates![0];
                                                                  mapPageController
                                                                          .mapPageRouteStartLongitude
                                                                          .value =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .startingCoordinates![1];
                                                                  mapPageController.startLatLong = LatLng(
                                                                      mapPageController
                                                                              .myAllRoutes!.activeRoutes![0].startingCoordinates![
                                                                          0],
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .startingCoordinates![1]);

                                                                  mapPageController
                                                                          .mapPageRouteFinishLatitude
                                                                          .value =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .endingCoordinates![0];
                                                                  mapPageController
                                                                          .mapPageRouteFinishLongitude
                                                                          .value =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .endingCoordinates![1];
                                                                  mapPageController.finishLatLong = LatLng(
                                                                      mapPageController
                                                                              .myAllRoutes!.activeRoutes![0].endingCoordinates![
                                                                          0],
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .endingCoordinates![1]);
                                                                  mapPageController
                                                                          .generalPolylineEncode
                                                                          .value =
                                                                      mapPageController
                                                                          .myAllRoutes!
                                                                          .activeRoutes![
                                                                              0]
                                                                          .polylineEncode!;

                                                                  mapPageController.addPointIntoPolylineList(
                                                                      mapPageController
                                                                          .generalPolylineEncode
                                                                          .value);
                                                                  mapPageController
                                                                      .addMarkerFunctionForMapPageWithoutOnTap(
                                                                    MarkerId(
                                                                        "myRouteStartMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                                                    LatLng(
                                                                        mapPageController.myAllRoutes!.activeRoutes![0].startingCoordinates![
                                                                            0],
                                                                        mapPageController
                                                                            .myAllRoutes!
                                                                            .activeRoutes![0]
                                                                            .startingCoordinates![1]),
                                                                    "${mapPageController.myAllRoutes!.activeRoutes![0].startingOpenAdress}",
                                                                    BitmapDescriptor.fromBytes(
                                                                        setCustomMarkerIconController
                                                                            .myRouteStartIconnoSee!),
                                                                  );
                                                                  mapPageController
                                                                      .addMarkerFunctionForMapPageWithoutOnTap(
                                                                    MarkerId(
                                                                        "myRouteFinishMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                                                    LatLng(
                                                                        mapPageController.myAllRoutes!.activeRoutes![0].endingCoordinates![
                                                                            0],
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
                                                                    .selectedIndex
                                                                    .value = 1;
                                                                // mfu added
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context2) {
                                                                      return showNewAllertDialog(
                                                                          context,
                                                                          "${createRouteController.startCity.value} -> ${createRouteController.finishCity.value}",
                                                                          (LocaleManager.instance.getString(PreferencesKeys
                                                                              .currentUserUserName)),
                                                                          createRouteController
                                                                              .cikisController
                                                                              .value
                                                                              .toString()
                                                                              .substring(0,
                                                                                  11),
                                                                          createRouteController
                                                                              .varisController
                                                                              .value
                                                                              .toString()
                                                                              .substring(0, 11),
                                                                          0);
                                                                    });
                                                              } else {
                                                                Get.back(
                                                                    closeOverlays:
                                                                        true);
                                                                Get.snackbar(
                                                                    "Hata!",
                                                                    "${response.message}",
                                                                    snackPosition:
                                                                        SnackPosition
                                                                            .BOTTOM,
                                                                    colorText:
                                                                        AppConstants()
                                                                            .ltBlack);
                                                              }
                                                              Get.back();
                                                            });
                                                          },
                                                          iconPath: '',
                                                          color: AppConstants()
                                                              .ltMainRed,
                                                          height: 50.h,
                                                          width: 341.w,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 12.w,
                                                                right: 12.w,
                                                                left: 12.w),
                                                        child:
                                                            CustomButtonDesign(
                                                          text:
                                                              'Rotayı Başlatma',
                                                          textColor:
                                                              AppConstants()
                                                                  .ltWhite,
                                                          onpressed: () async {
                                                            await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context2) {
                                                                  return showNewAllertDialog(
                                                                      context,
                                                                      "${createRouteController.startCity.value} -> ${createRouteController.finishCity.value}",
                                                                      (LocaleManager
                                                                          .instance
                                                                          .getString(PreferencesKeys
                                                                              .currentUserUserName)),
                                                                      createRouteController
                                                                          .cikisController
                                                                          .value
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              11),
                                                                      createRouteController
                                                                          .varisController
                                                                          .value
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              11),
                                                                      0);
                                                                });
                                                          },
                                                          iconPath: '',
                                                          color: AppConstants()
                                                              .ltDarkGrey,
                                                          height: 50.h,
                                                          width: 341.w,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }
                                      } else if (response.success == -1) {
                                        CreatePostPageController
                                            createPostPageController =
                                            Get.put(CreatePostPageController());
                                        createPostPageController.routeId.value =
                                            response.data![0].id!;
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              showSelectDeleteOrShareDialog(
                                                  context,
                                                  response.data![0].id!),
                                        );
                                      } else {
                                        CreatePostPageController
                                            createPostPageController =
                                            Get.put(CreatePostPageController());
                                        createPostPageController.routeId.value =
                                            response.data![0].id!;
                                        UiHelper.showWarningSnackBar(context,
                                            'Bir hata oluştu... Lütfen daha sonra tekrar deneyiniz.');
                                        Get.back();
                                      }
                                    }
                                  },
                                );
                              }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showNewAllertDialog(BuildContext context, String? routeContent,
      String? userName, String? startDate, String? endDate, int routeId) {
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
                  CreatePostPageController createPostPageController =
                      Get.find();
                  createPostPageController.haveRoute.value = 1;
                  createPostPageController.userName.value = userName!;
                  createPostPageController.routeContent.value = routeContent!;
                  createPostPageController.routeStartDate.value = startDate!;
                  createPostPageController.routeEndDate.value = endDate!;

                  bottomNavigationBarController.selectedIndex.value = 1;
                  Get.back();
                  Get.back();
                  Get.toNamed(NavigationConstants.createPostPage,
                      arguments: routeId);
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
                  MapPageController mapPageController =
                      Get.find<MapPageController>();
                  bottomNavigationBarController.selectedIndex.value = 1;
                  Get.back();
                  Get.back();
                  Get.back();
                  GoogleMapController googleMapController =
                      await mapPageController.mapCotroller3.future;
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

  Widget showSelectDeleteOrShareDialog(BuildContext context, int id) {
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
                  GeneralServicesTemp().makeDeleteRequest(
                    EndPoint.deleteRoute,
                    DeleteRouteRequestModel(routeId: id),
                    {
                      "Content-type": "application/json",
                      'Authorization':
                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                    },
                  ).then((value) async {
                    var response1 =
                        DeleteRouteResponseModel.fromJson(jsonDecode(value!));
                    if (response1.success == 1) {
                      log("AAAAAAAAAAAAAA");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
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
                                      MapPageController mappageController =
                                          MapPageController();
                                      mappageController
                                          .getMyRoutesServicesRequestRefreshable();
                                      MapPageController mapPageController =
                                          Get.find();
                                      SetCustomMarkerIconController
                                          setCustomMarkerIconController =
                                          Get.put(
                                              SetCustomMarkerIconController());
                                      GeneralServicesTemp().makePatchRequest(
                                        EndPoint.activateRoute,
                                        ActivateRouteRequestModel(
                                            routeId: mapPageController
                                                .myAllRoutes!
                                                .activeRoutes![0]
                                                .id),
                                        {
                                          "Content-type": "application/json",
                                          'Authorization':
                                              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                        },
                                      ).then((value) async {
                                        ActivateRouteResponseModel response =
                                            ActivateRouteResponseModel.fromJson(
                                                jsonDecode(value!));

                                        if (response.success == 1) {
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context2) {
                                                return showNewAllertDialog(
                                                    context,
                                                    "${createRouteController.startCity.value} -> ${createRouteController.finishCity.value}",
                                                    (LocaleManager.instance
                                                        .getString(PreferencesKeys
                                                            .currentUserUserName)),
                                                    createRouteController
                                                        .cikisController.value
                                                        .toString()
                                                        .substring(0, 11),
                                                    createRouteController
                                                        .varisController.value
                                                        .toString()
                                                        .substring(0, 11),
                                                    0);
                                              });
                                          Get.back();

                                          mapPageController
                                              .myRouteStartIconNotShow(
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
                                          );

                                          // mapPageController.getMyRoutesServicesRequestRefreshable();

                                          await GeneralServicesTemp()
                                              .makeGetRequest(
                                            EndPoint.getMyRoutes,
                                            {
                                              "Content-type":
                                                  "application/json",
                                              'Authorization':
                                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                            },
                                          ).then((value) async {
                                            GetMyRouteResponseModel
                                                getMyRouteResponseModel =
                                                GetMyRouteResponseModel
                                                    .fromJson(convert.json
                                                        .decode(value!));
                                            mapPageController.myAllRoutes =
                                                getMyRouteResponseModel
                                                    .data![0].allRoutes!;
                                            GoogleMapController
                                                googleMapController =
                                                await mapPageController
                                                    .mapCotroller3.future;
                                            googleMapController.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  bearing: 90,
                                                  target: LatLng(
                                                    getMyCurrentLocationController
                                                        .myLocationLatitudeDo
                                                        .value,
                                                    getMyCurrentLocationController
                                                        .myLocationLongitudeDo
                                                        .value,
                                                  ),
                                                  zoom: 10,
                                                ),
                                              ),
                                            );
                                            mapPageController
                                                .selectedDispley(5);
                                            mapPageController.myActivesRoutes =
                                                mapPageController
                                                    .myAllRoutes!.activeRoutes;
                                            mapPageController.myPastsRoutes =
                                                mapPageController
                                                    .myAllRoutes!.pastRoutes;
                                            mapPageController
                                                    .mynotStartedRoutes =
                                                mapPageController.myAllRoutes!
                                                    .notStartedRoutes;

                                            mapPageController
                                                    .mapPageRouteStartLatitude
                                                    .value =
                                                mapPageController
                                                    .myAllRoutes!
                                                    .activeRoutes![0]
                                                    .startingCoordinates![0];
                                            mapPageController
                                                    .mapPageRouteStartLongitude
                                                    .value =
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
                                                    .mapPageRouteFinishLatitude
                                                    .value =
                                                mapPageController
                                                    .myAllRoutes!
                                                    .activeRoutes![0]
                                                    .endingCoordinates![0];
                                            mapPageController
                                                    .mapPageRouteFinishLongitude
                                                    .value =
                                                mapPageController
                                                    .myAllRoutes!
                                                    .activeRoutes![0]
                                                    .endingCoordinates![1];
                                            mapPageController.finishLatLong =
                                                LatLng(
                                                    mapPageController
                                                        .myAllRoutes!
                                                        .activeRoutes![0]
                                                        .endingCoordinates![0],
                                                    mapPageController
                                                        .myAllRoutes!
                                                        .activeRoutes![0]
                                                        .endingCoordinates![1]);
                                            mapPageController
                                                    .generalPolylineEncode
                                                    .value =
                                                mapPageController
                                                    .myAllRoutes!
                                                    .activeRoutes![0]
                                                    .polylineEncode!;

                                            mapPageController
                                                .addPointIntoPolylineList(
                                                    mapPageController
                                                        .generalPolylineEncode
                                                        .value);
                                            mapPageController
                                                .addMarkerFunctionForMapPageWithoutOnTap(
                                                                    MarkerId(
                                                                        "myRouteStartMarker:${mapPageController.myAllRoutes!.activeRoutes![0].id.toString()}"),
                                                                    LatLng(
                                                                        mapPageController.myAllRoutes!.activeRoutes![0].startingCoordinates![
                                                                            0],
                                                                        mapPageController
                                                                            .myAllRoutes!
                                                                            .activeRoutes![0]
                                                                            .startingCoordinates![1]),
                                                                    "${mapPageController.myAllRoutes!.activeRoutes![0].startingOpenAdress}",
                                                                    BitmapDescriptor.fromBytes(
                                                                        setCustomMarkerIconController
                                                                            .myRouteStartIconnoSee!),
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
                                        } else {
                                          Get.back(closeOverlays: true);
                                          Get.snackbar(
                                              "Hata!", "${response.message}",
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              colorText:
                                                  AppConstants().ltBlack);
                                        }
                                        await GeneralServicesTemp()
                                            .makePostRequest(
                                          EndPoint.routesNew,
                                          PostCreateRouteRequestModel(
                                            departureDate: createRouteController
                                                .cikisController.text,
                                            arrivalDate: createRouteController
                                                .varisController.text,
                                            // departureDate: createRouteController
                                            //     .cikisController.text
                                            //     .split('/')
                                            //     .reversed
                                            //     .join('-'),
                                            // arrivalDate: createRouteController
                                            //     .varisController.text
                                            //     .split('/')
                                            //     .reversed
                                            //     .join('-'),
                                            routeDescription: createRouteController
                                                        .aciklamaController
                                                        .text ==
                                                    ""
                                                ? "${createRouteController.cikisController.text} tarihinde ${createRouteController.startCity.value} şehrinden başlayan yolculuk ${createRouteController.varisController.text} tarihinde ${createRouteController.finishCity.value} şehrinde son bulacak."
                                                : createRouteController
                                                    .aciklamaController.text,
                                            vehicleCapacity: 100,
                                            startingCoordinates: [
                                              createRouteController
                                                  .mapPageRouteStartLatitude2
                                                  .value,
                                              createRouteController
                                                  .mapPageRouteStartLongitude2
                                                  .value
                                            ],
                                            startingOpenAdress:
                                                createRouteController
                                                    .mapPageRouteStartAddress2
                                                    .value,
                                            startingCity: createRouteController
                                                .startCity.value,
                                            endingCoordinates: [
                                              createRouteController
                                                  .mapPageRouteFinishLatitude2
                                                  .value,
                                              createRouteController
                                                  .mapPageRouteFinishLongitude2
                                                  .value
                                            ],
                                            endingOpenAdress:
                                                createRouteController
                                                    .mapPageRouteFinishAddress2
                                                    .value,
                                            endingCity: createRouteController
                                                .finishCity.value,
                                            distance: createRouteController
                                                .calculatedRouteDistanceInt,
                                            travelTime: createRouteController
                                                .calculatedRouteTimeInt,
                                            polylineEncode:
                                                createRouteController
                                                    .generalPolylineEncode2
                                                    .value,
                                          ),
                                          {
                                            "Content-type": "application/json",
                                            'Authorization':
                                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                          },
                                        ).then(
                                          (value) async {
                                            if (value != null) {
                                              log(value);
                                              final response =
                                                  PostCreateRouteResponseModel
                                                      .fromJson(
                                                          jsonDecode(value));
                                              log(response.message.toString());
                                              log(response.success.toString());
                                              if (response.success == 1) {
                                                CreatePostPageController
                                                    createPostPageController =
                                                    Get.put(
                                                        CreatePostPageController());
                                                createPostPageController
                                                        .routeId.value =
                                                    response.data![0].id!;
                                                createRouteController
                                                    .mapPageRouteControllerClear();
                                                Get.back();
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      showNewAllertDialog(
                                                          context,
                                                          "${response.data![0].startingCity!} -> ${response.data![0].endingCity!}",
                                                          "Furkan Semiz",
                                                          response.data![0]
                                                              .departureDate!
                                                              .toString()
                                                              .substring(0, 11),
                                                          response.data![0]
                                                              .arrivalDate!
                                                              .toString()
                                                              .substring(0, 11),
                                                          response
                                                              .data![0].id!),
                                                );
                                              } else if (response.success ==
                                                  -1) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      showSelectDeleteOrShareDialog(
                                                          context,
                                                          response
                                                              .data![0].id!),
                                                );
                                              } else {
                                                UiHelper.showWarningSnackBar(
                                                    context,
                                                    'Bir hata oluştu... Lütfen daha sonra tekrar deneyiniz.');
                                                Get.back();
                                              }
                                            }
                                          },
                                        );
                                        Get.snackbar("Başarılı!",
                                            "Rota başarıyla silindi.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            colorText: AppConstants().ltBlack);
                                      });
                                      Get.back();
                                      Get.back();
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
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context2) {
                                            return showNewAllertDialog(
                                                context,
                                                "${createRouteController.startCity.value} -> ${createRouteController.finishCity.value}",
                                                (LocaleManager.instance
                                                    .getString(PreferencesKeys
                                                        .currentUserUserName)),
                                                createRouteController
                                                    .cikisController.value
                                                    .toString()
                                                    .substring(0, 11),
                                                createRouteController
                                                    .varisController.value
                                                    .toString()
                                                    .substring(0, 11),
                                                0);
                                          });
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

  Widget _placesAutoComplateTextFieldFinish(BuildContext context) {
    createRouteController.cikisController.text =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    createRouteController.varisController.text = DateFormat('yyyy-MM-dd HH:mm')
        .format(DateTime.now().add(
            Duration(minutes: createRouteController.calculatedRouteTimeInt)));

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
        await _displayPredictionFinishLocation(place!);
        final plist = GoogleMapsPlaces(
          apiKey: AppConstants.googleMapsApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
          //from google_api_headers package
        );
        String placeid = place.placeId ?? "0";
        final detail = await plist.getDetailsByPlaceId(placeid);
        final geometry = detail.result.geometry!;
        createRouteController.mapPageRouteFinishAddress2.value =
            place.description.toString();
        // log("finishLatitude: ${createRouteController.mapPageRouteFinishLatitude2.value.toString()}");
        // log("finishLongitude: ${createRouteController.mapPageRouteFinishLongitude2.value.toString()}");
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
                      createRouteController.mapPageRouteFinishAddress2.value ==
                              ""
                          ? "Varış noktasını giriniz"
                          : createRouteController
                              .mapPageRouteFinishAddress2.value,
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
        await _displayPredictionStartLocation(place!);
        final plist = GoogleMapsPlaces(
          apiKey: AppConstants.googleMapsApiKey,
          apiHeaders: await const GoogleApiHeaders().getHeaders(),
          //from google_api_headers package
        );
        String placeid = place.placeId ?? "0";
        final detail = await plist.getDetailsByPlaceId(placeid);
        final geometry = detail.result.geometry!;
        createRouteController.mapPageRouteStartAddress2.value =
            place.description.toString();

        // log("startLatitude: ${createRouteController.mapPageRouteStartLatitude2.value.toString()}");
        // log("startLongitude: ${createRouteController.mapPageRouteStartLongitude2.value.toString()}");
        // log("start description: ${place.description.toString()}");
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
                      createRouteController.mapPageRouteStartAddress2.value ==
                              ""
                          ? "Çıkış noktasını giriniz"
                          : createRouteController
                              .mapPageRouteStartAddress2.value,
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

  Future _displayPredictionFinishLocation(Prediction placeInfo) async {
    PlacesDetailsResponse detail = await createRouteController.googleMapsPlaces
        .getDetailsByPlaceId(placeInfo.placeId!);

    var placeId = placeInfo.placeId;

    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: detail.result.geometry!.location.lat,
        longitude: detail.result.geometry!.location.lng,
        googleMapApiKey: AppConstants.googleMapsApiKey);

    createRouteController.mapPageRouteFinishAddress2.value = data.address;
    createRouteController.finishCity.value = data.state;

    createRouteController.mapPageRouteFinishLatitude2.value = data.latitude;

    createRouteController.mapPageRouteFinishLongitude2.value = data.longitude;
    createRouteController.finishLatLong = LatLng(data.latitude, data.longitude);

    log("Finish");
    if ((createRouteController.mapPageRouteStartLatitude2.value != 0.0) &&
        (createRouteController.mapPageRouteStartLongitude2.value != 0.0) &&
        (createRouteController.mapPageRouteFinishLatitude2.value != 0.0) &&
        (createRouteController.mapPageRouteFinishLongitude2.value != 0.0)) {
      // log("Finish createRouteController.finishCity:  ${createRouteController.finishCity}");
      // log("Finish createRouteController.startLatitude:  ${createRouteController.mapPageRouteStartLatitude2.value}");
      // log("Finish createRouteController.startLongitude:  ${createRouteController.mapPageRouteStartLongitude2.value}");
      // log("Finish createRouteController.finishLatitude:  ${createRouteController.mapPageRouteFinishLatitude2.value}");
      // log("Finish createRouteController.finishLongitude:  ${createRouteController.mapPageRouteFinishLongitude2.value}");
      createRouteController.drawIntoMapPolyline();
      createRouteController.changeCalculateLevel(3);
    }
  }

  Future _displayPredictionStartLocation(Prediction placeInfo) async {
    PlacesDetailsResponse detail = await createRouteController.googleMapsPlaces
        .getDetailsByPlaceId(placeInfo.placeId!);

    var placeId = placeInfo.placeId;
    createRouteController.mapPageRouteStartLatitude2.value =
        detail.result.geometry!.location.lat;
    createRouteController.mapPageRouteStartLongitude2.value =
        detail.result.geometry!.location.lng;

    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: createRouteController.mapPageRouteStartLatitude2.value,
        longitude: createRouteController.mapPageRouteStartLongitude2.value,
        googleMapApiKey: AppConstants.googleMapsApiKey);

    createRouteController.mapPageRouteStartAddress2.value = data.address;
    createRouteController.startCity.value = data.state;
    createRouteController.mapPageRouteStartLatitude2.value = data.latitude;
    createRouteController.mapPageRouteStartLongitude2.value = data.longitude;
    createRouteController.startLatLong = LatLng(data.latitude, data.longitude);

    log("Start");
    if ((createRouteController.mapPageRouteStartLatitude2.value != 0.0) &&
        (createRouteController.mapPageRouteStartLongitude2.value != 0.0) &&
        (createRouteController.mapPageRouteFinishLatitude2.value != 0.0) &&
        (createRouteController.mapPageRouteFinishLongitude2.value != 0.0)) {
      // log("Start createRouteController.startCity:  ${createRouteController.startCity.value}");
      // log("Start createRouteController.startLatitude:  ${createRouteController.mapPageRouteStartLatitude2.value}");
      // log("Start createRouteController.startLongitude:  ${createRouteController.mapPageRouteStartLongitude2.value}");
      // log("Start createRouteController.finishLatitude:  ${createRouteController.mapPageRouteFinishLatitude2.value}");
      // log("Start createRouteController.finishLongitude:  ${createRouteController.mapPageRouteFinishLongitude2.value}");
      createRouteController.drawIntoMapPolyline();
      createRouteController.changeCalculateLevel(3);
    }
  }
}
