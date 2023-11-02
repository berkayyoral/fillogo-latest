import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:convert' as convert;

import '../../../controllers/map/get_current_location_and_listen.dart';
import '../../../controllers/map/marker_icon_controller.dart';
import '../../../export.dart';
import '../../../models/routes_models/get_friends_routes_circular.dart';
import '../../../models/routes_models/get_my_friends_routes_model.dart';
import '../../../models/routes_models/get_my_routes_model.dart';
import '../../../services/general_sevices_template/general_services.dart';
import '../../testFolder/test19/route_api_models.dart';

class MapPageController extends GetxController {
  SetCustomMarkerIconController customMarkerIconController = Get.find();
  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  @override
  void onInit() async {
    await getMyRoutesServicesRequestRefreshable();
    await updateMyLocationMarkers();

    super.onInit();
  }

  /* Rx<CameraPosition> cameraPosition(animateLat,animateLong) {
    Rx<CameraPosition> cameraPosition =
        CameraPosition(
           bearing: 90,
                  tilt: 45,
                   zoom: 14,
          target: LatLng(animateLat.value, animateLong.value)).obs;
    return cameraPosition;
  }
  */
  var myNameAndSurname = "".obs;
  var myUserId = 0.obs;

  RxString differentTime = "".obs;
  RxString dateTimeFormatCikis = "".obs;
  RxString dateTimeFormatVaris = "".obs;
  var dateTimeFormatLast = DateTime.now().obs;

  List<MyRoutesDetails>? myActivesRoutes;
  List<MyRoutesDetails>? myPastsRoutes;
  List<MyRoutesDetails>? mynotStartedRoutes;

  TextEditingController cikisController = TextEditingController();
  TextEditingController varisController = TextEditingController();
  TextEditingController kapasiteController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController(text: "");

  var iWantTrackerMyLocation = 0.obs;
  var selectedDispley = 0.obs;
  var calculateLevel = 1.obs;
  RxString formattedDate = ''.obs;
  Rx<DateTime?> pickedDate = DateTime.now().obs;

  var calculatedRouteDistance = "".obs;
  var calculatedRouteTime = "".obs;
  int calculatedRouteDistanceInt = 0;
  int calculatedRouteTimeInt = 0;

  Completer<GoogleMapController> mapCotroller3 =
      Completer<GoogleMapController>();

  GoogleMapsPlaces googleMapsPlaces =
      GoogleMapsPlaces(apiKey: AppConstants.googleMapsApiKey);

  PolylineId generalPolylineId = const PolylineId('1');
  PolylineId generalPolylineId2 = const PolylineId('2');
  PolylineId rotationPolyline = const PolylineId('3');
  var selectedPolyline = 1.obs;

  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints2 = PolylinePoints();
  Set<Marker> markers2 = {};
  Map<PolylineId, Polyline> polylines2 = {};
  List<LatLng> polylineCoordinates2 = [];

  List<List<double>> polylineCoordinatesListForB = [];
  var generalPolylineEncode = "".obs;
  var generalPolylineEncode2 = "".obs;
  var generalPolylineEncodeForB = "".obs;

  var mapPageRouteStartAddress = "".obs;
  var mapPageRouteStartLatitude = 0.0.obs;
  var mapPageRouteStartLongitude = 0.0.obs;
  var mapPageRouteFinishAddress = "".obs;
  var mapPageRouteFinishLatitude = 0.0.obs;
  var mapPageRouteFinishLongitude = 0.0.obs;

  var mapPageRouteStartAddress2 = "".obs;
  var mapPageRouteStartLatitude2 = 0.0.obs;
  var mapPageRouteStartLongitude2 = 0.0.obs;
  var mapPageRouteFinishAddress2 = "".obs;
  var mapPageRouteFinishLatitude2 = 0.0.obs;
  var mapPageRouteFinishLongitude2 = 0.0.obs;

  var startCity = "".obs;
  var startLatLong = const LatLng(0.0, 0.0);
  var finishCity = "".obs;
  var finishLatLong = const LatLng(0.0, 0.0);

  late StreamSubscription<Position> streamSubscriptionForMyMarker;

  List<GetMyFriendsResDatum?> myFriendsLocations = [];
  List<GetMyFriendsMatchingResDatum?> myFriendsLocationsMatching = [];
  AllRoutes? myAllRoutes;

  void changeCalculateLevel(int newCalculateLevel) {
    calculateLevel.value = newCalculateLevel;
    update(["mapPageController"]);
  }

  void changeSelectedDispley(int newSelectedDispley) {
    selectedDispley.value = newSelectedDispley;
    update(["mapPageController"]);
  }

  void mapPageRouteControllerClear() async {
    iWantTrackerMyLocation.value = 1;
    cikisController.clear();
    varisController.clear();
    kapasiteController.clear();
    aciklamaController.clear();

    calculateLevel.value = 1;
    finishCity = "".obs;
    startCity = "".obs;

    mapPageRouteStartAddress2.value = "";
    mapPageRouteStartLatitude2.value = 0.0;
    mapPageRouteStartLongitude2.value = 0.0;
    mapPageRouteFinishAddress2.value = "";
    mapPageRouteFinishLatitude2.value = 0.0;
    mapPageRouteFinishLongitude2.value = 0.0;

    startLatLong = const LatLng(0.0, 0.0);
    finishLatLong = const LatLng(0.0, 0.0);

    calculatedRouteDistance.value = "";
    calculatedRouteTime.value = "";

    polylinePoints2 = PolylinePoints();
    markers2.clear();
    polylines2.clear();
    polylineCoordinates2 = [];
    generalPolylineEncode2.value = "";

    addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myLocationMarker"),
      LatLng(
        getMyCurrentLocationController.myLocationLatitudeDo.value,
        getMyCurrentLocationController.myLocationLongitudeDo.value,
      ),
      mapPageRouteStartAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
    );
    addMarkerFunctionForMapPageWithoutOnTap(
      const MarkerId("myLocationMarker"),
      LatLng(
        getMyCurrentLocationController.myLocationLatitudeDo.value,
        getMyCurrentLocationController.myLocationLongitudeDo.value,
      ),
      mapPageRouteStartAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
    );
    update(["mapPageController"]);
  }

  getMyFriendsMatchingRoutes(BuildContext context, polylineEncode) async {
    await GeneralServicesTemp().makePostRequest(
      EndPoint.getMyfriendsMatchingRoutes,
      GetMyFriendsMatchingRoutesRequest(
          startingCity: "", endingCity: "", route: polylineEncode),
      {
        "Content-type": "application/json",
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
      },
    ).then(
      (value) async {
        GetMyFriendsMatchingRoutesResponse response =
            GetMyFriendsMatchingRoutesResponse.fromJson(
                convert.json.decode(value!));
        print("Matching Success = ${response.success}");
        print("Matching Message = ${response.message}");

        print("Matching response data = ${response.data!.length}");
        print("Matching response data = ${response.data![0].matching}");
        print("Matching${response.data![0].matching![0].followed!.name}");
        myFriendsLocationsMatching = response.data!;

        for (var i = 0; i < myFriendsLocations.length; i++) {
          addMarkerFunctionForMapPage(
            myFriendsLocations[i]!.followed!.id!,
            MarkerId(myFriendsLocations[i]!.followed!.id.toString()),
            LatLng(
                myFriendsLocations[i]!
                    .followed!
                    .userpostroutes![0]
                    .currentRoute![0],
                myFriendsLocations[i]!
                    .followed!
                    .userpostroutes![0]
                    .currentRoute![1]),
            BitmapDescriptor.fromBytes(
                customMarkerIconController.myFriendsLocation!),
            context,
            "${myFriendsLocations[i]!.followed!.name!} ${myFriendsLocations[i]!.followed!.surname!}",
            myFriendsLocations[i]!
                .followed!
                .userpostroutes![0]
                .departureDate
                .toString(),
            myFriendsLocations[i]!
                .followed!
                .userpostroutes![0]
                .arrivalDate
                .toString(),
            "Tır",
            myFriendsLocations[i]!.followed!.userpostroutes![0].startingCity!,
            myFriendsLocations[i]!.followed!.userpostroutes![0].endingCity!,
            "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
            myFriendsLocations[i]!.followed!.profilePicture!,
          );
        }
      },
    );
  }

  getMyFriendsRoutesRequestRefreshable(BuildContext context) async {
    await GeneralServicesTemp().makeGetRequest(
      EndPoint.getMyfriendsRoute,
      {
        "Content-type": "application/json",
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
      },
    ).then(
      (value) async {
        GetMyFriendsRouteResponseModel getMyFriendsRouteResponseModel =
            GetMyFriendsRouteResponseModel.fromJson(
                convert.json.decode(value!));
        myFriendsLocations = getMyFriendsRouteResponseModel.data!;

        for (var i = 0; i < myFriendsLocations.length; i++) {
          addMarkerFunctionForMapPage(
            myFriendsLocations[i]!.followed!.id!,
            MarkerId(myFriendsLocations[i]!.followed!.id.toString()),
            LatLng(
                myFriendsLocations[i]!
                    .followed!
                    .userpostroutes![0]
                    .currentRoute![0],
                myFriendsLocations[i]!
                    .followed!
                    .userpostroutes![0]
                    .currentRoute![1]),
            BitmapDescriptor.fromBytes(
                customMarkerIconController.myFriendsLocation!),
            context,
            "${myFriendsLocations[i]!.followed!.name!} ${myFriendsLocations[i]!.followed!.surname!}",
            myFriendsLocations[i]!
                .followed!
                .userpostroutes![0]
                .departureDate
                .toString(),
            myFriendsLocations[i]!
                .followed!
                .userpostroutes![0]
                .arrivalDate
                .toString(),
            "Tır",
            myFriendsLocations[i]!.followed!.userpostroutes![0].startingCity!,
            myFriendsLocations[i]!.followed!.userpostroutes![0].endingCity!,
            "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
            myFriendsLocations[i]!.followed!.profilePicture!,
          );
        }
      },
    );
  }

  getMyRoutesServicesRequestRefreshable() async {
    mapPageRouteControllerClear();
    await GeneralServicesTemp().makeGetRequest(
      EndPoint.getMyRoutes,
      {
        "Content-type": "application/json",
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
      },
    ).then(
      (value) async {
        GetMyRouteResponseModel getMyRouteResponseModel =
            GetMyRouteResponseModel.fromJson(convert.json.decode(value!));

        //myAllRoutes = getMyRouteResponseModel.data![0].allRoutes;

        myActivesRoutes =
            getMyRouteResponseModel.data![0].allRoutes!.activeRoutes;
        myPastsRoutes = getMyRouteResponseModel.data![0].allRoutes!.pastRoutes;
        mynotStartedRoutes =
            getMyRouteResponseModel.data![0].allRoutes!.notStartedRoutes;
      },
    );
    update(["mapPageController"]);
  }

//haritada görünen
  addPointIntoPolylineList(String encodedPolyline) async {
    List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
    polylineCoordinates.clear();
    for (var point in result) {
      //polylineCoordinatesListForB.add([point.latitude, point.longitude]);
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }
    log("polylineCoordinates1:  ${polylineCoordinates.toString()}");
    var newPolylineCoordinates = polylineCoordinates.toSet().toList();

    Polyline polyline = Polyline(
      polylineId: generalPolylineId,
      color: selectedPolyline.value != 3
          ? AppConstants().ltBlue
          : AppConstants().ltLogoGrey,
      points: newPolylineCoordinates,
      width: 4,
    );
    polylines[generalPolylineId] = polyline;
    update(["mapPageController"]);
  }

//rotada görünen
  addPointIntoPolylineList2(String encodedPolyline) async {
    List<PointLatLng> result = polylinePoints2.decodePolyline(encodedPolyline);

    for (var point in result) {
      polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
    }
    log("polylineCoordinates2:  ${polylineCoordinates2.toString()}");
    var newPolylineCoordinates = polylineCoordinates2.toSet().toList();

    Polyline polyline = Polyline(
      polylineId: generalPolylineId,
      color: selectedPolyline.value != 3
          ? AppConstants().ltMainRed
          : AppConstants().ltLogoGrey,
      points: newPolylineCoordinates,
      width: 4,
    );
    polylines2[generalPolylineId2] = polyline;
    update(["mapPageController"]);
  }

  updatePolyline(LatLng newPoint) {

   // myAllRoutes!.activeRoutes![0].endingCoordinates![1];
    mapPageRouteFinishLatitude2.value = finishLatLong.latitude;
    mapPageRouteFinishLongitude2.value = finishLatLong.longitude;

    double thresholdDistance = 30.0;
    // Kullanıcının hedefe olan mesafesini kontrol edin
    double distanceToDestination = Geolocator.distanceBetween(
      newPoint.latitude,
      newPoint.longitude,
      mapPageRouteFinishLatitude2.value,
      mapPageRouteFinishLongitude2.value,
    );

    log("updatePolyLine:  ${distanceToDestination.toString()}");

    if (distanceToDestination > thresholdDistance) {
      drawIntoMapPolyline2();
      getMyFriendsRoutesCircular(newPoint);
    }
  }

  updateMyLocationMarkers() async {
    bool serviceEnabled;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    streamSubscriptionForMyMarker =
        Geolocator.getPositionStream().listen((Position position) async {
      mapPageRouteStartLatitude2.value = position.latitude;
      mapPageRouteStartLongitude2.value = position.longitude;
      if (polylines.isNotEmpty) {
        updatePolyline(LatLng(position.latitude, position.longitude));
      }
      Marker newMarker1 = markers.firstWhere(
          (marker) => marker.markerId.value == "myLocationMarker",
          orElse: () => const Marker(markerId: MarkerId("")));
      markers.remove(newMarker1);
      //log("marker myLocationMarker1 silindi: ${newMarker1.markerId.value}");

      Marker newMarker2 = markers2.firstWhere(
          (marker) => marker.markerId.value == "myLocationMarker",
          orElse: () => const Marker(markerId: MarkerId("")));
      markers2.remove(newMarker2);
      //log("marker myLocationMarker2 silindi: ${newMarker2.markerId.value}");

      addMarkerFunctionForMapPageWithoutOnTap2(
        const MarkerId("myLocationMarker"),
        LatLng(
          position.latitude,
          position.longitude,
        ),
        "",
        BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
      );
      //log("marker myLocationMarker2 eklendi");

      addMarkerFunctionForMapPageWithoutOnTap(
        const MarkerId("myLocationMarker"),
        LatLng(
          position.latitude,
          position.longitude,
        ),
        "",
        BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
      );
      //log("marker myLocationMarker1 eklendi");

      update(["mapPageController"]);
    });
    update(["mapPageController"]);
  }

  getMyFriendsRoutesCircular(LatLng point) async {
    await GeneralServicesTemp()
        .makePostRequest(
            EndPoint.getMyFriendsCircular,
            {"lat": point.latitude, "long": point.longitude},
            ServicesConstants.appJsonWithToken)
        .then((value) {
      log("Circular request response -> {$value}");
      if (value != null) {
        final response = FriendsRoutesCircular.fromJson(jsonDecode(value));
        Marker newMarker1 = markers.firstWhere(
                (marker) => marker.markerId.value == "myFriendLocation",
            orElse: () => const Marker(markerId: MarkerId("")));
        markers.remove(newMarker1);

        addMarkerFunctionForMapPageWithoutOnTap(
          const MarkerId("myLocationMarker"),
          LatLng(
            response.latitude as double,
            response.longitude as double,
          ),
          "",
          BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
        );
      }
      update(["mapPageController"]);
    });
  }

  void mapDisplayAnimationFuncMap1() async {
    try {
      double miny = (mapPageRouteStartLatitude2.value <=
              mapPageRouteFinishLatitude2.value)
          ? mapPageRouteStartLatitude2.value
          : mapPageRouteFinishLatitude2.value;

      double minx = (mapPageRouteStartLongitude2.value <=
              mapPageRouteFinishLongitude2.value)
          ? mapPageRouteStartLongitude2.value
          : mapPageRouteFinishLongitude2.value;

      double maxy = (mapPageRouteStartLatitude2.value <=
              mapPageRouteFinishLatitude2.value)
          ? mapPageRouteFinishLatitude2.value
          : mapPageRouteStartLatitude2.value;

      double maxx = (mapPageRouteStartLongitude2.value <=
              mapPageRouteFinishLongitude2.value)
          ? mapPageRouteFinishLongitude2.value
          : mapPageRouteStartLongitude2.value;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      GoogleMapController generalMapController = await mapCotroller3.future;
      generalMapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100,
        ),
      );
      update(["mapPageController"]);
    } catch (e) {
      log("kamera animasyonu hatası!!! 55555  ${e.toString()}");
      update(["mapPageController"]);
    }
  }

  bool addMarkerFunctionForMapPage(
    int userID,
    MarkerId markerId,
    LatLng latLng,
    BitmapDescriptor icon,
    BuildContext context,
    String name,
    String firstDestination,
    String secondDestination,
    String vehicleType,
    String startCity,
    String endCity,
    String description,
    String userProfilePhotoLink,
  ) {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        icon: icon,
        onTap: () {
          showModalBottomSheet(
            context: context,
            useRootNavigator: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r)),
            ),
            builder: (builder) {
              return PopupPrifilInfo(
                userId: userID,
                name: name,
                emptyPercent: 70,
                firstDestination: firstDestination,
                secondDestination: secondDestination,
                vehicleType: vehicleType,
                startCity: startCity,
                endCity: endCity,
                description: description,
                userProfilePhotoLink: userProfilePhotoLink,
              );
            },
          );
        },
      );
      markers.add(marker);
      update(["mapPageController"]);
      return true;
    } catch (e) {
      log("marker ekleme hatası!!  ${e.toString()}");
      update(["mapPageController"]);
      return false;
    }
  }

  bool addMarkerFunctionForMapPageWithoutOnTap(
    MarkerId markerId,
    LatLng latLng,
    // String title,
    String address,
    BitmapDescriptor icon,
  ) {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
          //title: title,
          snippet: address,
        ),
        icon: icon,
      );
      markers.add(marker);
      update(["mapPageController"]);
      return true;
    } catch (e) {
      log("marker ekleme hatası!!  ${e.toString()}");
      update(["mapPageController"]);
      return false;
    }
  }

  bool addMarkerFunctionForMapPageWithoutOnTap2(
    MarkerId markerId,
    LatLng latLng,
    // String title,
    String address,
    BitmapDescriptor icon,
  ) {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
          //title: title,
          snippet: address,
        ),
        icon: icon,
      );
      markers2.add(marker);
      update(["mapPageController"]);
      return true;
    } catch (e) {
      log("marker ekleme hatası!!  ${e.toString()}");
      update(["mapPageController"]);
      return false;
    }
  }

  void drawIntoMapPolyline() async {
    if (markers2.isNotEmpty) markers2.clear();
    if (polylines2.isNotEmpty) polylines2.clear();
    if (polylineCoordinates2.isNotEmpty) polylineCoordinates2.clear();
    if (calculatedRouteDistance.value != "") calculatedRouteDistance.value = "";

    await getPolylineEncodeRequest(
      selectedPolyline.value,
      mapPageRouteStartLatitude2.value,
      mapPageRouteStartLongitude2.value,
      mapPageRouteFinishLatitude2.value,
      mapPageRouteFinishLongitude2.value,
    ).then((value) async {
      calculatedRouteDistance.value =
          "${((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
      calculatedRouteTime.value =
          "${int.parse(value.routes![0].duration!.split("s")[0]) ~/ 3600} saat ${((int.parse(value.routes![0].duration!.split("s")[0]) / 60) % 60).toInt()} dk";
      generalPolylineEncode2.value =
          value.routes![0].polyline!.encodedPolyline!;

      update(["mapPageController"]);
    });

    addPointIntoPolylineList2(generalPolylineEncode2.value);

    addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myLocationMarker"),
      LatLng(
        getMyCurrentLocationController.myLocationLatitudeDo.value,
        getMyCurrentLocationController.myLocationLongitudeDo.value,
      ),
      mapPageRouteStartAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
    );

    addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myRouteStartMarker2"),
      LatLng(
        mapPageRouteStartLatitude2.value,
        mapPageRouteStartLongitude2.value,
      ),
      mapPageRouteStartAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
    );

    addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myRouteFinishMarker2"),
      LatLng(
        mapPageRouteFinishLatitude2.value,
        mapPageRouteFinishLongitude2.value,
      ),
      mapPageRouteFinishAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
    );

    mapDisplayAnimationFuncMap1();

    update(["mapPageController"]);
  }

  void drawIntoMapPolyline2() async {
    if (markers2.isNotEmpty) markers2.clear();
    if (polylines2.isNotEmpty) polylines2.clear();
    if (polylineCoordinates2.isNotEmpty) polylineCoordinates2.clear();
    if (calculatedRouteDistance.value != "") calculatedRouteDistance.value = "";

    await getPolylineEncodeRequest(
      selectedPolyline.value,
      mapPageRouteStartLatitude2.value,
      mapPageRouteStartLongitude2.value,
      mapPageRouteFinishLatitude2.value,
      mapPageRouteFinishLongitude2.value,
    ).then((value) async {
      calculatedRouteDistance.value =
          "${((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
      calculatedRouteTime.value =
          "${int.parse(value.routes![0].duration!.split("s")[0]) ~/ 3600} saat ${((int.parse(value.routes![0].duration!.split("s")[0]) / 60) % 60).toInt()} dk";
      generalPolylineEncode2.value =
          value.routes![0].polyline!.encodedPolyline!;

      update(["mapPageController"]);
    });

    addPointIntoPolylineList(generalPolylineEncode2.value);

    /*  addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myLocationMarker"),
      LatLng(
        getMyCurrentLocationController.myLocationLatitudeDo.value,
        getMyCurrentLocationController.myLocationLongitudeDo.value,
      ),
      mapPageRouteStartAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
    );

    addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myRouteStartMarker2"),
      LatLng(
        mapPageRouteStartLatitude2.value,
        mapPageRouteStartLongitude2.value,
      ),
      mapPageRouteStartAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
    );

    addMarkerFunctionForMapPageWithoutOnTap2(
      const MarkerId("myRouteFinishMarker2"),
      LatLng(
        mapPageRouteFinishLatitude2.value,
        mapPageRouteFinishLongitude2.value,
      ),
      mapPageRouteFinishAddress2.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
    );
*/
    //   mapDisplayAnimationFuncMap1();

    update(["mapPageController"]);
  }

  Future<GetPollylineResponseModel> getPolylineEncodeRequest(
    int selectedPolyline,
    double lati1,
    double longi1,
    double lati2,
    double longi2,
  ) async {
    GetPollylineResponseModel getPollylineResponseModel =
        GetPollylineResponseModel();
    // GetPollylineResponseModel getPollylineResponseModel =
    //     GetPollylineResponseModel(
    //   routes: [
    //     RouteMyModel(
    //       distanceMeters: 0,
    //       duration: "0s",
    //       polyline: PolylineMyModel(
    //         encodedPolyline: "",
    //       ),
    //     ),
    //   ],
    // );
    GetPollylineRequestModel getPollylineRequestModel =
        GetPollylineRequestModel(
      languageCode: "tr",
      computeAlternativeRoutes: false,
      //departureTime: "2023-10-15T15:01:23.045123456Z",
      destination: OriginMyModel.fromJson(
        {
          "location": {
            "latLng": {"latitude": lati2, "longitude": longi2}
          }
        },
      ),
      origin: OriginMyModel.fromJson(
        {
          "location": {
            "latLng": {"latitude": lati1, "longitude": longi1}
          }
        },
      ),
      routeModifiers: RouteModifiersMyModel(
        avoidTolls: false,
        avoidHighways: false,
        avoidFerries: false,
      ),
      routingPreference: "TRAFFIC_AWARE",
      travelMode: "DRIVE",
      units: "METRIC",
    );

    await GeneralServicesTemp()
        .makePostRequestForPolyline(
      AppConstants.googleMapsGetPolylineLink,
      getPollylineRequestModel,
      ServicesConstants.getPolylineRequestHeader,
    )
        .then(
      (value) {
        if (value != null) {
          print("ZAAAAAAAAAAA");
          getPollylineResponseModel =
              GetPollylineResponseModel.fromJson(convert.json.decode(value));
          calculatedRouteDistance.value =
              "${((getPollylineResponseModel.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
          calculatedRouteDistanceInt =
              getPollylineResponseModel.routes![0].distanceMeters! ~/ 1000;
          int calculatedTime = int.parse(
              getPollylineResponseModel.routes![0].duration!.split("s")[0]);
          calculatedRouteTime.value =
              "${calculatedTime ~/ 3600} saat ${((calculatedTime / 60) % 60).toInt()} dk";
          calculatedRouteTimeInt = ((calculatedTime ~/ 3600) * 60) +
              ((calculatedTime / 60) % 60).toInt();
          getPollylineResponseModel.routes![0].polyline!.encodedPolyline!;
          update(["mapPageController"]);
          return getPollylineResponseModel;
        }
        update(["mapPageController"]);
      },
    );
    update(["mapPageController"]);
    return getPollylineResponseModel;
  }
}
