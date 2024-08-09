// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/service/polyline_service.dart';
import 'package:fillogo/views/route_calculate_view/components/route_search_by_city_models.dart';
import 'package:fillogo/views/testFolder/test19/route_api_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../controllers/map/get_current_location_and_listen.dart';
import '../../../controllers/map/marker_icon_controller.dart';
import '../../../export.dart';

class CreateeRouteController extends GetxController implements PolylineService {
  @override
  void onInit() async {
    mapDisplayAnimationFunc2();
    super.onInit();
  }

  late GoogleMapController mapController;
  SetCustomMarkerIconController customMarkerIconController = Get.find();
  var calculateLevel = 1.obs;
  RxBool isLoading = false.obs;
  RxString formattedDate = ''.obs;
  Rx<DateTime?> pickedDate = DateTime.now().obs;

  var calculatedRouteDistance = "".obs;
  int calculatedRouteDistanceInt = 0;
  var calculatedRouteTime = "".obs;
  int calculatedRouteTimeInt = 0;

  Rx<LatLng> middRoute = LatLng(0, 0).obs;
  int distanceMeters = 0;

  GoogleMapsPlaces googleMapsPlaces =
      GoogleMapsPlaces(apiKey: AppConstants.googleMapsApiKey);

  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polylines = <Polyline>{}.obs;
  List<LatLng> polylineCoordinates = [];
  List<List<double>> polylineCoordinatesListForB = [];
  var generalPolylineEncode = "".obs;

  Completer<GoogleMapController> generalMapController =
      Completer<GoogleMapController>();

  RxList<SearchByCityDatum> searchByCityDatum = <SearchByCityDatum>[].obs;

  var createRouteStartAddress = "".obs;
  var createRouteStartLatitude = 0.0.obs;
  var createRouteStartLongitude = 0.0.obs;
  var createRouteFinishAddress = "".obs;
  var createRouteFinishLatitude = 0.0.obs;
  var createRouteFinishLongitude = 0.0.obs;
  var startCity = "".obs;
  var startLatLong = const LatLng(0.0, 0.0);
  var finishCity = "".obs;
  var finishLatLong = const LatLng(0.0, 0.0);

  //Anlık arkadas konumu bağlandı
  void addNewMarkersForSearchingRoute(BuildContext context) async {
    print("BURDAYIMaddNewMarkersForSearchingRoute");
    if (searchByCityDatum.value.isNotEmpty) {
      print("SEARCROUTEMARKER lnegt -> ${searchByCityDatum.value.length}");
      for (var i = 0; i < searchByCityDatum.length; i++) {
        String carTypeString = searchByCityDatum.value[i].user!
            .usertousercartypes![0].cartypetousercartypes!.carType!;
        CarType carType = carTypeString == "Tır"
            ? CarType.tir
            : carTypeString == "Otomobil"
                ? CarType.otomobil
                : CarType.motorsiklet;
        Uint8List iconByteData = await customMarkerIconController
            .friendsCustomMarkerIcon(carType: carType);
        addMarkerFunctionForSearchRoutePage(
            searchByCityDatum.value[i].userId!,
            searchByCityDatum.value[i].id!,
            MarkerId("${searchByCityDatum[i].userId!}"),
            LatLng(searchByCityDatum.value[i].startingCoordinates![0],
                searchByCityDatum.value[i].startingCoordinates![1]),
            BitmapDescriptor.fromBytes(iconByteData),
            context,
            searchByCityDatum.value[i].user!.username!,
            searchByCityDatum.value[i].departureDate!.toString(),
            searchByCityDatum.value[i].arrivalDate!.toString(),
            "TIR",
            searchByCityDatum.value[i].startingCity!,
            searchByCityDatum.value[i].endingCity!,
            searchByCityDatum.value[i].routeDescription ?? "",
            "https://firebasestorage.googleapis.com/v0/b/fillogo-8946b.appspot.com/o/users%2Fuser_yxtelh.png?alt=media&token=17ed0cd6-733e-4ee9-9053-767ce7269893",
            searchByCityDatum.value[i].isActive ?? false);
      }
    }
  }

  void createRouteControllerClear() async {
    searchByCityDatum.clear();
    middRoute.value = const LatLng(0, 0);
    calculateLevel.value = 1;
    createRouteStartAddress.value = "";
    createRouteStartLatitude.value = 0.0;
    createRouteStartLongitude.value = 0.0;
    createRouteFinishAddress.value = "";
    createRouteFinishLatitude.value = 0.0;
    createRouteFinishLongitude.value = 0.0;
    finishCity = "".obs;
    startCity = "".obs;

    markers.value = {};
    polylines.value = {};
    polylineCoordinates = [];
    generalPolylineEncode.value = "";
    addMarkerFunction(
      MarkerId(const MarkerId('myMarker').value),
      LatLng(getMyCurrentLocationController.myLocationLatitudeDo.value,
          getMyCurrentLocationController.myLocationLongitudeDo.value),
      "",
      "",
      BitmapDescriptor.fromBytes(
        customMarkerIconController.mayLocationIcon!,
      ),
    );

    update(["createRouteController"]);
  }

  bool addMarkerFunctionForSearchRoutePage(
      int userID,
      int routeID,
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
      bool isActiveRoute) {
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
                isActiveRoute: isActiveRoute,
                userId: userID,
                routeId: routeID,
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
      //    markers.add(
      //   Marker(
      //     markerId: MarkerId(markerID),
      //     position: location ??
      //         LatLng(currentLocationController.myLocationLatitudeDo.value,
      //             currentLocationController.myLocationLongitudeDo.value),
      //     icon: BitmapDescriptor.fromBytes(iconByteData),
      //     zIndex: markerID == "myLocationMarker" ? 1 : 0,
      //     onTap: markerID != "myLocationMarker" ? onTap : null,
      //   ),
      // )
      update(["createRouteController"]);
      return true;
    } catch (e) {
      print("marker ekleme hatası!!  ${e.toString()}");
      update(["createRouteController"]);
      return false;
    }
  }

  bool addMarkerFunctionForSearchRoutePageWithoutOnTap(
    MarkerId markerId,
    LatLng latLng,
    BitmapDescriptor icon,
  ) {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        icon: icon,
      );
      markers.add(marker);
      update(["createRouteController"]);
      return true;
    } catch (e) {
      print("marker ekleme hatası!!  ${e.toString()}");
      update(["createRouteController"]);
      return false;
    }
  }

  void mapDisplayAnimationFunc() async {
    try {
      double miny =
          (createRouteStartLatitude.value <= createRouteFinishLatitude.value)
              ? createRouteStartLatitude.value
              : createRouteFinishLatitude.value;
      double minx =
          (createRouteStartLongitude.value <= createRouteFinishLongitude.value)
              ? createRouteStartLongitude.value
              : createRouteFinishLongitude.value;
      double maxy =
          (createRouteStartLatitude.value <= createRouteFinishLatitude.value)
              ? createRouteFinishLatitude.value
              : createRouteStartLatitude.value;
      double maxx =
          (createRouteStartLongitude.value <= createRouteFinishLongitude.value)
              ? createRouteFinishLongitude.value
              : createRouteStartLongitude.value;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;
      GoogleMapController mapController = await generalMapController.future;

      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100,
        ),
      );
    } catch (e) {
      print("kamera animasyonu hatası!!!  ${e.toString()}");
    }
  }

  void mapDisplayAnimationFunc2() async {
    try {
      GoogleMapController mapController = await generalMapController.future;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15.0,
            target: LatLng(
              getMyCurrentLocationController.myLocationLatitudeDo.value,
              getMyCurrentLocationController.myLocationLongitudeDo.value,
            ),
          ),
        ),
      );
    } catch (e) {
      print("kamera animasyonu hatası!!!  ${e.toString()}");
    }
  }

  bool addMarkerFunction(MarkerId markerId, LatLng latLng, String title,
      String address, BitmapDescriptor icon) {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
          title: title,
          snippet: address,
        ),
        icon: icon,
      );
      markers.add(marker);
      return true;
    } catch (e) {
      print("marker ekleme hatası!!  ${e.toString()}");
      return false;
    }
  }

  @override
  getPolyline(
      double startLat, double startLng, double endLat, double endLng) async {
    try {
      await PolylineService()
          .getPolyline(startLat, startLng, endLat, endLng)
          .then((value) {
        print("GETPOLYLİNE -> ${value}");
        polylines.add(value!);
      });
    } catch (e) {
      print("createroutecontroller Get polyline error -> $e");
    }
    return null;
  }

  @override
  Future<GetPollylineResponseModel?> getRoute(
      double startLat, double startLng, double endLat, double endLng) async {
    try {
      polylines.clear();
      PolylineService()
          .getRoute(startLat, startLng, endLat, endLng)
          .then((value) async {
        if (value!.routes != null) {
          getPolyline(startLat, startLng, endLat, endLng);

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
          // markers.add(Marker(
          //   markerId: const MarkerId("searchRouteStart"),
          //   position: LatLng(startLat, startLng),
          //   icon: BitmapDescriptor.fromBytes(
          //       customMarkerIconController.myRouteStartIconnoSee!),
          // ));

          markers.add(Marker(
            markerId: const MarkerId("searchRouteFinish"),
            position: LatLng(endLat, endLng),
            icon: BitmapDescriptor.fromBytes(
                customMarkerIconController.myRouteFinishIcon!),
          ));

          print(
              "distamce merter -> ${((value.routes![0].distanceMeters)! / 1000)}");
          distanceMeters = int.parse(
              ((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0));

          Map<String, double> midPoint =
              calculateMiddleroute(startLat, startLng, endLat, endLng);
          middRoute.value =
              LatLng(midPoint['latitude']!, midPoint['longitude']!);

          print("DİSTANCEMETERS -> ${distanceMeters}");
          getRouteInMap();
        }
      });
    } catch (e) {
      print("Get polyline error -> $e");
    }
    return null;
  }

  void getRouteInMap() {
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
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          tilt: 180,
          target: middRoute.value,
          // LatLng(mid.latitude, 34.261775
          //     //     // getMyCurrentLocationController.myLocationLatitudeDo.value,
          //     //     //getMyCurrentLocationController.myLocationLongitudeDo.value
          //     ),
          zoom: zoom,
        ),
      ),
    );
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

  // addPointIntoPolylineList(String encodedPolyline) async {
  //   List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
  //   print(result);
  //   for (var point in result) {
  //     polylineCoordinatesListForB.add([point.latitude, point.longitude]);
  //     polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //   }

  //   //var newPolylineCoordinates = polylineCoordinates.toSet().toList();

  //   Polyline polyline = Polyline(
  //     polylineId: generalPolylineId,
  //     color: selectedPolyline.value != 3
  //         ? AppConstants().ltMainRed
  //         : AppConstants().ltLogoGrey,
  //     points: polylineCoordinates,
  //     width: 4,
  //   );
  //   polylines[generalPolylineId] = polyline;
  //   update();
  // }

  // Future<GetPollylineResponseModel> getPolylineEncodeRequest(
  //   int selectedPolyline,
  //   double lati1,
  //   double longi1,
  //   double lati2,
  //   double longi2,
  // ) async {
  //   GetPollylineResponseModel getPollylineResponseModel =
  //       GetPollylineResponseModel(
  //     routes: [
  //       RouteMyModel(
  //         distanceMeters: 0,
  //         duration: "0s",
  //         polyline: PolylineMyModel(
  //           encodedPolyline: "",
  //         ),
  //       ),
  //     ],
  //   );
  //   GetPollylineRequestModel getPollylineRequestModel =
  //       GetPollylineRequestModel(
  //     languageCode: "en-US",
  //     computeAlternativeRoutes: false,
  //     departureTime: "2023-10-15T15:01:23.045123456Z",
  //     destination: OriginMyModel.fromJson(
  //       {
  //         "location": {
  //           "latLng": {"latitude": lati1, "longitude": longi1}
  //         }
  //       },
  //     ),
  //     origin: OriginMyModel.fromJson(
  //       {
  //         "location": {
  //           "latLng": {"latitude": lati2, "longitude": longi2}
  //         }
  //       },
  //     ),
  //     routeModifiers: RouteModifiersMyModel(
  //       avoidTolls: false,
  //       avoidHighways: false,
  //       avoidFerries: false,
  //     ),
  //     routingPreference: "TRAFFIC_AWARE",
  //     travelMode: "DRIVE",
  //     units: "METRIC",
  //   );

  //   await GeneralServicesTemp()
  //       .makePostRequestForPolyline(
  //     AppConstants.googleMapsGetPolylineLink,
  //     getPollylineRequestModel,
  //     ServicesConstants.getPolylineRequestHeader,
  //   )
  //       .then(
  //     (value) {
  //       if (value != null) {
  //         //log("sonunda oldu  $value");
  //         getPollylineResponseModel =
  //             GetPollylineResponseModel.fromJson(convert.json.decode(value));
  //         calculatedRouteDistance.value =
  //             "${((getPollylineResponseModel.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
  //         log("calculatedRouteDistance:  ${calculatedRouteDistance.value}");
  //         calculatedRouteDistanceInt =
  //             getPollylineResponseModel.routes![0].distanceMeters! ~/ 1000;
  //         int calculatedTime = int.parse(
  //             getPollylineResponseModel.routes![0].duration!.split("s")[0]);
  //         calculatedRouteTime.value =
  //             "${calculatedTime ~/ 3600} saat ${((calculatedTime / 60) % 60).toInt()} dk";
  //         log("calculatedRouteTime:  ${calculatedRouteTime.value}");
  //         log("duration deneme ${getPollylineResponseModel.routes![0].duration!.split("s").first}");
  //         calculatedRouteTimeInt = ((calculatedTime ~/ 3600) * 60) +
  //             ((calculatedTime / 60) % 60).toInt();
  //         log('######## $calculatedRouteDistanceInt - $calculatedRouteTimeInt');
  //         var newEncodedPolyline = [];
  //         getPollylineResponseModel.routes![0].polyline!.encodedPolyline!;
  //         update();
  //         return getPollylineResponseModel;
  //       }
  //     },
  //   );
  //   return getPollylineResponseModel;
  // }
}
