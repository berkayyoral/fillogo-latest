import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/models/routes_models/get_users_on_area.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_new_route_view/create_new_route_view.dart';
import 'package:fillogo/views/map_page_new/service/map_page_service.dart';
import 'package:fillogo/views/map_page_new/service/polyline_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import '../../../controllers/bottom_navigation_bar_controller.dart';
import '../../../models/routes_models/activate_route_model.dart';

class MapPageMController extends GetxController implements MapPageService {
  ///MYLOCATİON
  var myLocationLatitudeSt = ''.obs;
  var myLocationLongitudeSt = ''.obs;
  var myLocationAddress = ''.obs;
  var myLocationLatitudeDo = 0.0.obs;
  var myLocationLongitudeDo = 0.0.obs;
  // late StreamSubscription<Position> streamSubscription;
  final RxBool isFinishRoute = false.obs;
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialLocation;

  RxDouble currentBearing = 0.0.obs;
  GoogleMapController? myLocationMapController;
  Position? myLocation;

  ///MYLOCATİON

  late BuildContext context;
  RxBool isLoading = false.obs;
  MapPageService mapPageService = MapPageService();

  SetCustomMarkerIconController customMarkerIconController = Get.find();
  // GetMyCurrentLocationController currentLocationController =
  //     Get.find<GetMyCurrentLocationController>();

  /// MAP İÇİN
  GoogleMapController? mapController;
  RxDouble zoom = 10.0.obs;
  late Position currentPosition;
  RxDouble currentHeading = 0.0.obs;
  RxDouble currentHeadingAccury = 0.0.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  final Rx<LatLng> mapCenter = Rx<LatLng>(const LatLng(0.0, 0.0));
  //aktif rotar için
  String myActiveRoutePolylineCode = "";
  final RxSet<Polyline> polylines = <Polyline>{}.obs;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  StreamSubscription<Position>? positionSubscription;
  int currentSegmentIndex = 0;

  final RxBool isCreateRoute = false.obs;

  RxBool isThereActiveRoute = false.obs; //aktif rotam var mı
  Polyline? polyline;
  RxBool finishRouteButton =
      false.obs; //aktif rotam varsa rotayı bitir butonu görünsün mü

  ///GÖRÜNÜRLÜK VE MÜSAİTLİK
  RxBool isLoadingVisibilty = false.obs;
  RxBool isRouteVisibilty = true.obs;
  RxBool isRouteAvability = true.obs;

  ///ROTALARIM
  AllRoutes myAllRoutes = AllRoutes();
  RxList<MyRoutesDetails> myActivesRoutes = <MyRoutesDetails>[].obs;
  RxList<MyRoutesDetails> myPastsRoutes = <MyRoutesDetails>[].obs;
  RxList<MyRoutesDetails> mynotStartedRoutes = <MyRoutesDetails>[].obs;

  ///KESİŞEN ROTALAR
  RxBool isOpenMatchingRoutesWidget = false.obs;
  RxList<Matching>? matchingRoutes = <Matching>[].obs;

  ///çevremdeki kişiler
  List<GetUsersOnAreaResDatum?> usersOnArea = [];

  ///FİLTER CAR
  RxBool showFilterOption = false.obs;
  RxList<bool> filterSelectedList = [true, true, true].obs;
  List<String> carTypeList = ["Otomobil", "Tır", "Motorsiklet"];

  ///HARİTADAKİ KULLANICI DOKUNMALARINI KONTROL ETMEK İÇİN (CameraPosition hareketlerinde kullanılıyor)
  RxBool shouldUpdateLocation = true.obs;
  RxBool clickCenterButton = false.obs;
  // RxBool clickMap = false.obs;
  // RxBool isMapMove = true.obs;
  bool isListenMap = true;

  @override
  Future<void> onInit() async {
    print("MYCURRENTLOCATİON 1-> BAŞLADI");

    // if (LocaleManager.instance.getString(PreferencesKeys.accessToken) != null) {
    //   currentPosition = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);
    //   myLocationLatitudeDo.value = currentPosition.latitude;
    //   myLocationLongitudeDo.value = currentPosition.longitude;
    // }

    _startLocationUpdates();

    await getMyRoutes().then((value) {});

    await updateLocation(
        lat: myLocationLatitudeDo.value, long: myLocationLongitudeDo.value);

    bool isLocaleVisi =
        LocaleManager.instance.getBool(PreferencesKeys.isVisibility) ?? false;
    bool isLocaleAvabi =
        LocaleManager.instance.getBool(PreferencesKeys.isAvability) ?? false;
    isRouteVisibilty.value = isLocaleVisi;
    isRouteAvability.value = isLocaleAvabi;

    if (!isRouteVisibilty.value) {
      filterSelectedList.value = [false, false, false];
      carTypeList.clear();
    }

    addMarkerIcon(
        markerID: "myLocationMarker",
        location:
            LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value));

    await getUsersOnArea(carTypeFilter: carTypeList);

    getMyLocationInMap();
    super.onInit();
  }

  void startLocationTracking() {
    positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      if (polylineCoordinates.isNotEmpty) {
        // Bulunan ilk koordinatı kaldır

        double distanceInMeters = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          polylineCoordinates[0].latitude,
          polylineCoordinates[0].longitude,
        );
        print("POLYLİNEİLKÇİZGİMESAFE -> ${distanceInMeters}");
        if (distanceInMeters > 20 && distanceInMeters < 40) {
          //distanceInMeters > 20 && distanceInMeters < 40
          polylineCoordinates.removeAt(0);
        } else {}
        updatePolyline();
      }
    });
  }

  Future<void> checkProgressOnRoute2(LatLng current) async {
    if (polylineCoordinates.length < 2) return;

    LatLng point1 = polylineCoordinates[0];
    LatLng point2 = polylineCoordinates[1];

    double distance = distanceToLineSegment(current, point1, point2);
    print("ROTADIŞI NE YAPCAM DİSTANCE -> $distance");
    // 🚨 ROTADAN ÇIKTI MI?
    if (distance > 25) {
      print("ROTADIŞI ROTADŞINA ÇIKTIN..");
      polyline = await PolylineService().getPolyline(
          myLocationLatitudeDo.value,
          myLocationLongitudeDo.value,
          myActivesRoutes[0].endingCoordinates.first,
          myActivesRoutes[0].endingCoordinates.last);

      polylineCoordinates = polyline!.points;

      // Get.snackbar("Rotadan Çıktınız!", "Rota yeniden oluşturuluyor.",
      //     colorText: AppConstants().ltMainRed,
      //     snackPosition: SnackPosition.BOTTOM);
    }

    // ✅ SEGMENT SONUNA YAKLAŞTI MI?
    double distanceToNextPoint = Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      point2.latitude,
      point2.longitude,
    );
    print("ROTADIŞI NE YAPCAM DİSTANCEpoint -> $distanceToNextPoint");
    if (distanceToNextPoint <= 21) {
      print("ROTADIŞI ROTADA İLERLEDİN..");
      polylineCoordinates.removeAt(0);
      // polylineCoordinates[0] =
      //     LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value);
    }
    updatePolyline();
    // setState(() {}); // Haritayı güncelle
  }

  Future<GetMyRouteResponseModel?> getMyRoutes(
      {bool isStartRoute = true}) async {
    try {
      GetMyRouteResponseModel myRouteResponseModel;
      await GeneralServicesTemp().makeGetRequest(
        EndPoint.getMyRoutes,
        {
          "Content-type": "application/json",
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
        },
      ).then((value) async {
        myRouteResponseModel =
            GetMyRouteResponseModel.fromJson(json.decode(value!));
        myAllRoutes = myRouteResponseModel.data[0].allRoutes;
        if (myRouteResponseModel
            .data[0].allRoutes.notStartedRoutes!.isNotEmpty) {
          mynotStartedRoutes.value =
              myRouteResponseModel.data[0].allRoutes.notStartedRoutes!;
        }
        if (myRouteResponseModel.data[0].allRoutes.pastRoutes!.isNotEmpty) {
          myPastsRoutes.value =
              myRouteResponseModel.data[0].allRoutes.pastRoutes!;
        }
        if (myRouteResponseModel.data[0].allRoutes.activeRoutes!.isNotEmpty) {
          myActivesRoutes.value =
              myRouteResponseModel.data[0].allRoutes.activeRoutes!;

          isThereActiveRoute.value = myActivesRoutes.isNotEmpty ? true : false;

          if (isThereActiveRoute.value) {
            // isRouteVisibilty.value = true; //!myActivesRoutes.first.isInvisible;
            // isRouteAvability.value = myActivesRoutes.first.isAvailable;
            if (isStartRoute) {
              polyline = await PolylineService().getPolyline(
                  myLocationLatitudeDo.value,
                  myLocationLongitudeDo.value,
                  myActivesRoutes[0].endingCoordinates.first,
                  myActivesRoutes[0].endingCoordinates.last);

              if (polyline == null) {
                List<List<double>> coordinatesList =
                    myActivesRoutes[0].polylineDecode;

                for (var coord in coordinatesList) {
                  polylineCoordinates.add(LatLng(coord[0], coord[1]));
                }
                polyline = Polyline(
                  polylineId: const PolylineId("myRoute"),
                  color: AppConstants().ltBlue,
                  points: polylineCoordinates,
                  width: 9,
                );
              }
              polylines.add(polyline!);
              myActiveRoutePolylineCode = myRouteResponseModel
                  .data[0].allRoutes.activeRoutes![0].polylineEncode;
            }
            updatePolyline();

            ///start
            addMarkerIcon(
              location: LatLng(
                myActivesRoutes[0].startingCoordinates.first,
                myActivesRoutes[0].startingCoordinates.last,
              ),
              markerID: 'myLocationMarker',
            );

            ///finish
            addMarkerIcon(
              location: LatLng(
                myActivesRoutes[0].endingCoordinates.first,
                myActivesRoutes[0].endingCoordinates.last,
              ),
              markerID: 'myLocationFinishMarker',
            );
            startLocationTracking();
          } else {
            shouldUpdateLocation.value = false;
          }
        }

        await getUsersOnArea(carTypeFilter: carTypeList);
      });
    } catch (e) {
      log("GETMYROUTES error -> $e");
    }
    return null;
  }

  addMarkerIcon({
    required String markerID,
    LatLng? location,
    Function()? onTap,
    CarType? carType,
  }) async {
    Uint8List? iconByteData =
        await customMarkerIconController.setCustomMarkerIcon3();
    // await customMarkerIconController.setCustomMarkerIcon3();

    if (customMarkerIconController.mayLocationIcon != null) {
      iconByteData = markerID == "myLocationMarker"
          ? customMarkerIconController.mayLocationIcon!
          : markerID == "myLocationFinishMarker"
              ? customMarkerIconController.myRouteFinishIcon!
              : await customMarkerIconController.friendsCustomMarkerIcon(
                  carType: carType!);
    }

    markers.add(
      Marker(
        markerId: MarkerId(markerID),
        position: location ??
            LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value),
        icon: BitmapDescriptor.fromBytes(iconByteData!),
        zIndex: markerID == "myLocationMarker" ? 1 : 0,
        onTap: markerID != "myLocationMarker" ? onTap : null,
        // rotation: currentHeading.value,
        // anchor: Offset(0.5, 0.8),
        // flat: true,
      ),
    );
  }

  BottomNavigationBarController bottomNavigationBarController =
      Get.put(BottomNavigationBarController());

  ///Harita hareketlerini dinler
  void _startLocationUpdates() {
    positionSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentHeading.value = position.heading;
      currentHeadingAccury.value = position.headingAccuracy;
      myLocationLatitudeSt.value = 'Latitude : ${position.latitude}';
      myLocationLongitudeSt.value = 'Longitude : ${position.longitude}';
      myLocationLatitudeDo.value = position.latitude;
      myLocationLongitudeDo.value = position.longitude;
      myLocation = position;

      mapCenter.value = LatLng(
          position.latitude +
              (isThereActiveRoute.value ? currentBearing.value : 0),
          position.longitude);
      markers
          .removeWhere((marker) => marker.markerId.value == 'myLocationMarker');
      addMarkerIcon(
        markerID: "myLocationMarker",
        location:
            LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value),
      );
      print(
          "KAMERAHAREKETİ HEAD - ${position.heading} / ${position.headingAccuracy}");
      try {
        ///Haritaya dokunulduğunda CameraPosition'un direkt bulunulan konumuna gelmemesi için ///
        print(
            "MESAFEMM ONCAMERAMOVE LİSTENN -> ${shouldUpdateLocation.value} / $isListenMap / $mapController");
        updateFinishRouteInfo();
        checkProgressOnRoute2(LatLng(position.latitude, position.longitude));

        if (shouldUpdateLocation.value && isListenMap) {
          LatLng newLatLng = LatLng(
              position.latitude +
                  (isThereActiveRoute.value ? currentBearing.value : 0),
              position.longitude);
          mapCenter.value = newLatLng;
          // LatLng newLatLng = LatLng(
          //     position.latitude + (isThereActiveRoute.value ? 0.0008 : 0),
          //     position.longitude);
          if (bottomNavigationBarController.selectedIndex.value == 1) {}
          if (mapCenter.value != newLatLng) {
            try {
              if (isThereActiveRoute.value) {
                getCameraUpdate();
                if (isFinishRoute.value) {
                  polylineCoordinates.clear();
                  print("POLYLİNEE -> ${polylineCoordinates.length}");
                }
              } else {
                mapController!.animateCamera(
                  CameraUpdate.newLatLng(
                    newLatLng,
                  ),
                );
              }
            } catch (e) {
              log("STARTMAP ERROR -> $e");
            }

            updateLocation(lat: position.latitude, long: position.longitude);
          }
        }
      } catch (e) {
        log("ADDMARKER ERROR -> $e");
      }
    });
  }

  void getCameraUpdate() {
    final bearing = isThereActiveRoute.value
        ? calculateBearing(
            LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value),
            polylineCoordinates[2],
          )
        : 0.0;
    currentBearing.value = getDirectionFromBearing(bearing);
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing:
              bearing, // currentHeading.value, //isThereActiveRoute.value ? 0 : 90,
          tilt: isThereActiveRoute.value ? 90 : 45,

          target: LatLng(
            myLocationLatitudeDo.value +
                (isThereActiveRoute.value ? currentBearing.value : 0),
            myLocationLongitudeDo.value,
          ),
          zoom: zoom.value, //***  isThereActiveRoute.value ? 17.5 : 15,
        ),
      ),
    );
  }

  void updatePolyline() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId("myRoute"),
      color: AppConstants().ltBlue,
      points: polylineCoordinates,
      width: 9,
    );
    polylines.clear();
    polylines.add(polyline);
  }

  LatLng getCameraTargetPosition(LatLng currentLocation, double heading) {
    const double forwardOffsetInMeters = 100; // Ne kadar önünü gösterelim?

    final double latOffset =
        forwardOffsetInMeters * 0.0000089 * math.cos(heading * math.pi / 180);
    final double lngOffset = forwardOffsetInMeters *
        0.0000089 *
        math.sin(heading * math.pi / 180) /
        math.cos(currentLocation.latitude * math.pi / 180);

    return LatLng(
      currentLocation.latitude + latOffset,
      currentLocation.longitude + lngOffset,
    );
  }

  LatLng getReversedOffsetTarget(LatLng currentLocation, double heading) {
    const double offsetInMeters = 150; // Kaç metre geriye gösterelim

    // Ters yön = heading + 180 derece
    final reversedHeading = (heading + 180) % 360;

    final double latOffset =
        offsetInMeters * 0.0000089 * math.cos(reversedHeading * math.pi / 180);
    final double lngOffset = offsetInMeters *
        0.0000089 *
        math.sin(reversedHeading * math.pi / 180) /
        math.cos(currentLocation.latitude * math.pi / 180);

    return LatLng(
      currentLocation.latitude + latOffset,
      currentLocation.longitude + lngOffset,
    );
  }

  double calculateBearing(LatLng from, LatLng to) {
    final lat1 = from.latitude * math.pi / 180;
    final lon1 = from.longitude * math.pi / 180;
    final lat2 = to.latitude * math.pi / 180;
    final lon2 = to.longitude * math.pi / 180;

    final dLon = lon2 - lon1;

    final y = math.sin(dLon) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final bearing = math.atan2(y, x) * 180 / math.pi;
    return (bearing + 360) % 360;
  }

  double getDirectionFromBearing(double bearing) {
    if (bearing >= 337.5 || bearing < 22.5) return 0.000;
    if (bearing >= 22.5 && bearing < 67.5) return 0.0000;
    if (bearing >= 67.5 && bearing < 112.5) return 0.0000;
    if (bearing >= 112.5 && bearing < 157.5) return 0.0000;
    if (bearing >= 157.5 && bearing < 202.5) return 0.0000;
    if (bearing >= 202.5 && bearing < 247.5) return -0.0004;
    if (bearing >= 247.5 && bearing < 292.5) return 0.0000;
    if (bearing >= 292.5 && bearing < 337.5) return 0.0000;
    return 0;
  }

  ///Haritada bulunduğum konumu ortalar
  void getMyLocationInMap() {
    zoom.value = isThereActiveRoute.value ? 17.5 : 15;
    try {
      shouldUpdateLocation.value = isThereActiveRoute.value ? true : false;
      print(
          "MESAFEMM shoudldupdate **** -> ${shouldUpdateLocation.value} bear -> ${currentHeading.value} zoom -> ${zoom.value}");

      getCameraUpdate();
      //  final bearing = isThereActiveRoute.value
      //       ? calculateBearing(
      //           LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value),
      //           polylineCoordinates[2],
      //         )
      //       : 0.0;
      //   currentBearing.value = getDirectionFromBearing(bearing);
      //   print(
      //       "BEARİNGMY -> ${bearing} / ${currentBearing.value} / ${currentHeadingAccury.value} / ${currentHeading.value}");
      //   mapController!.animateCamera(
      //     CameraUpdate.newCameraPosition(
      //       CameraPosition(
      //         bearing:
      //             bearing, // currentHeading.value, //isThereActiveRoute.value ? 0 : 90,
      //         tilt: isThereActiveRoute.value ? 90 : 45,
      //         target: LatLng(
      //           myLocationLatitudeDo.value +
      //               (isThereActiveRoute.value ? currentBearing.value : 0),
      //           myLocationLongitudeDo.value,
      //         ),
      //         zoom: zoom.value +
      //             (isThereActiveRoute.value
      //                 ? 0
      //                 : 0), //***  isThereActiveRoute.value ? 17.5 : 15,
      //       ),
      //     ),
      //   );

      shouldUpdateLocation.value = isThereActiveRoute.value ? true : false;

      print("ONCAMERAMOVEM GET -> $shouldUpdateLocation");
    } catch (e) {
      log("NEWMAP getMyLocationButton -> $e");
    }
  }

  filterButtonOnTap() async {
    try {
      isLoading.value = true;
      markers.value.clear();
      usersOnArea.clear();

      showFilterOption.value = false;

      // isLoading.value = true;

      addMarkerIcon(
          markerID: "myLocationMarker",
          location:
              LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value));
      if (isThereActiveRoute.value) {
        addMarkerIcon(
            markerID: "myLocationFinishMarker",
            location: LatLng(myActivesRoutes[0].endingCoordinates.first,
                myActivesRoutes[0].endingCoordinates.last));
      }

      carTypeList.clear();
      if (filterSelectedList[0]) {
        carTypeList.add("Otomobil");
      }
      if (filterSelectedList[1]) {
        carTypeList.add("Tır");
      }
      if (filterSelectedList[2]) {
        carTypeList.add("Motorsiklet");
      }

      isLoading.value = false;
      await getUsersOnArea(carTypeFilter: carTypeList);
    } catch (e) {
      log("MAPPAGEİSLOAD ERR -> $e");
    }
  }

//ROTA DIŞINA ÇIKMAYI KONTROL EDER
  bool isOffRoute(LatLng currentLocation, List<LatLng> routePoints,
      double thresholdInMeters) {
    LatLng point1 = routePoints[0];
    LatLng point2 = routePoints[0 + 1];

    double distance = distanceToLineSegment(currentLocation, point1, point2);
    print(
        "ROTADIŞI MIYIM -> $distance myloc -> $currentLocation / $point1 / $point2 list -> ${polylineCoordinates.length}");
    if (distance <= thresholdInMeters) {
      return false; // Rota içindesin
    }

    return true; // Rota dışındasın
  }

  double distanceToLineSegment(LatLng p, LatLng v, LatLng w) {
    double l2 = Geolocator.distanceBetween(
        v.latitude, v.longitude, w.latitude, w.longitude);
    if (l2 == 0.0)
      return Geolocator.distanceBetween(
          p.latitude, p.longitude, v.latitude, v.longitude);

    double t = ((p.latitude - v.latitude) * (w.latitude - v.latitude) +
            (p.longitude - v.longitude) * (w.longitude - v.longitude)) /
        l2;

    t = t < 0.0
        ? 0.0
        : t > 1.0
            ? 1.0
            : t;

    double projectionLatitude = v.latitude + t * (w.latitude - v.latitude);
    double projectionLongitude = v.longitude + t * (w.longitude - v.longitude);

    return Geolocator.distanceBetween(
        p.latitude, p.longitude, projectionLatitude, projectionLongitude);
  }

  @override
  Future<UsersOnAreaModel?> getUsersOnArea(
      {required List<String> carTypeFilter}) async {
    try {
      // isLoading.value = true;

      await mapPageService
          .getUsersOnArea(carTypeFilter: carTypeFilter)
          .then((value) async {
        if (value!.data!.first.isNotEmpty) {
          usersOnArea = value.data!.first;
        } else {
          usersOnArea = [];
        }

        for (var i = 0; i < usersOnArea.length; i++) {
          if (usersOnArea[i]!.userId !=
              LocaleManager.instance.getInt(PreferencesKeys.currentUserId)) {
            String userCarType = usersOnArea[i]!
                .usertousercartypes!
                .first
                .cartypetousercartypes!
                .carType!;
            CarType carType = userCarType == "Otomobil"
                ? CarType.otomobil
                : userCarType == "Tır"
                    ? CarType.tir
                    : CarType.motorsiklet;

            addMarkerIcon(
              markerID: usersOnArea[i]!.userId!.toString(),
              location: usersOnArea[i]!.userpostroutes!.isNotEmpty
                  ? LatLng(
                      usersOnArea[i]!
                          .userpostroutes!
                          .first
                          .polylineDecode!
                          .first
                          .first,
                      usersOnArea[i]!
                          .userpostroutes!
                          .first
                          .polylineDecode!
                          .first
                          .last)
                  : LatLng(
                      usersOnArea[i]!.latitude!,
                      usersOnArea[i]!.longitude!,
                    ),
              carType: carType,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    useRootNavigator: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r)),
                    ),
                    builder: (BuildContext context) {
                      return usersOnArea[i]!.userpostroutes!.isNotEmpty
                          ? PopupPrifilInfo(
                              isActiveRoute: false,
                              userId: usersOnArea[i]!.userId!,
                              routeId: usersOnArea[i]!.userpostroutes![0].id!,
                              name:
                                  "${usersOnArea[i]!.name!}  ${usersOnArea[i]!.surname}",
                              emptyPercent: 70,
                              firstDestination: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .departureDate!
                                  .toString(),
                              secondDestination: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .arrivalDate
                                  .toString(),
                              vehicleType: usersOnArea[i]!
                                  .usertousercartypes![0]
                                  .cartypetousercartypes!
                                  .carType!,
                              startCity: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .startingCity!,
                              endCity: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .endingCity!,
                              description: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .routeDescription!,
                              userProfilePhotoLink: usersOnArea[i]!.profilePic!,
                            )
                          : PopupPrifilInfo(
                              isActiveRoute: false,
                              userId: usersOnArea[i]!.userId!,
                              routeId: null,
                              name:
                                  "${usersOnArea[i]!.name!}  ${usersOnArea[i]!.surname}",
                              userProfilePhotoLink: usersOnArea[i]!.profilePic!,
                              vehicleType: usersOnArea[i]!
                                  .usertousercartypes![0]
                                  .cartypetousercartypes!
                                  .carType!,
                              emptyPercent: 70,
                              firstDestination: "",
                              secondDestination: "",
                              startCity: "",
                              endCity: "",
                              description: "",
                            );
                    });
              },
            );
          }
        }
      });

      // isLoading.value = false;
    } catch (e) {
      log("MAPPAGECONTROLLER error getUsersOnArea -> $e");
    }
    return null;
  }

  @override
  Future updateLocation({required double lat, required double long}) async {
    print("MESAFEMM update rotation");
    try {
      await mapPageService.updateLocation(lat: lat, long: long);
    } catch (e) {
      log("MAPPAGECONTROLLER error -> $e");
    }
  }

  void updateFinishRouteInfo() {
    if (myActivesRoutes.isNotEmpty) {
      double distanceInMeters = Geolocator.distanceBetween(
        myLocationLatitudeDo.value,
        myLocationLongitudeDo.value,
        myActivesRoutes[0].endingCoordinates.first,

        myActivesRoutes[0].endingCoordinates.last, // Nokta 2: Ankara (örnek)
      );
      print("MESAFEMM: $distanceInMeters metre");

      if (distanceInMeters < 35) {
        print("MESAFEMM durdu: $distanceInMeters metre");
        isFinishRoute.value = true;

        GeneralServicesTemp().makePatchRequest(
          EndPoint.activateRoute,
          ActivateRouteRequestModel(routeId: myActivesRoutes[0].id),
          {
            "Content-type": "application/json",
            'Authorization':
                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
          },
        ).then((value) async {
          // mapPageMController.isLoading.value = true;
          ActivateRouteResponseModel response =
              ActivateRouteResponseModel.fromJson(jsonDecode(value!));
          if (response.success == 1) {
            print("MESAFEMM: rota bitti ");
          } else {
            print("MESAFEMM: rota bitemedi ");
          }

          myActivesRoutes.value
              .removeWhere((element) => element.id == myActivesRoutes[0].id);
        });
      }
    }
  }

  @override
  Future<List<Matching>?> getMatchingRoutes(
      {required String routePolylineCode}) async {
    try {
      isLoading.value = true;
      mapPageService
          .getMatchingRoutes(routePolylineCode: routePolylineCode)
          .then((value) {
        matchingRoutes!.value = value!;
        print("MATCHED dolu -> ${jsonEncode(value)}");
        markers.removeWhere(
            (marker) => marker.markerId.value == 'myLocationMarker');
        matchingRoutes!.value.removeWhere((element) =>
            element.id ==
            LocaleManager.instance.getInt(PreferencesKeys.currentUserId));
      });
      isLoading.value = false;
    } catch (e) {
      log("Mappagecontroller getMatchingRoutes error -> $e");
    }
  }

  void checkProgressOnRoute(Position position) {
    // Kullanıcının mevcut konumu
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    // Rota üzerindeki en yakın noktayı bul
    double minDistance = double.infinity;
    LatLng? closestPoint;

    for (var point in polylines.value.first.points) {
      double distance = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        point.latitude,
        point.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        closestPoint = point;
      }
    }

    if (minDistance > 50) {
      shouldUpdateLocation.value = false;
    }
  }

  final String myMapStyle = '''
 [
  {
    "featureType": "landscape.man_made",
    "stylers": [
      {
        "visibility": "off"
      }
      
    ]
  }
]
''';
}

enum CarType { motorsiklet, tir, otomobil }
