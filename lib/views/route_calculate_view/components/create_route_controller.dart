// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/route_calculate_view/components/route_search_by_city_models.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../controllers/map/get_current_location_and_listen.dart';
import '../../../controllers/map/marker_icon_controller.dart';
import '../../../export.dart';

class CreateeRouteController extends GetxController {
  @override
  void onInit() async {
    mapDisplayAnimationFunc2();
    super.onInit();
  }

  SetCustomMarkerIconController customMarkerIconController = Get.find();
  var calculateLevel = 1.obs;
  RxBool isLoading = false.obs;
  RxString formattedDate = ''.obs;
  Rx<DateTime?> pickedDate = DateTime.now().obs;

  GoogleMapsPlaces googleMapsPlaces =
      GoogleMapsPlaces(apiKey: AppConstants.googleMapsApiKey);

  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  RxSet<Marker> markers = <Marker>{}.obs;
  Map<PolylineId, Polyline> polylines = {};
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
    polylines = {};
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
      log("marker ekleme hatası!!  ${e.toString()}");
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
      log("marker ekleme hatası!!  ${e.toString()}");
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
      log("kamera animasyonu hatası!!!  ${e.toString()}");
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
      log("kamera animasyonu hatası!!!  ${e.toString()}");
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
      log("marker ekleme hatası!!  ${e.toString()}");
      return false;
    }
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
