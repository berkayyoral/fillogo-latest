import 'dart:async';
import 'dart:developer';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:fillogo/views/route_details_page_view/components/selected_route_controller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../controllers/map/marker_icon_controller.dart';
import '../../../models/routes_models/get_route_details_by_id_model.dart';
import '../../../services/general_sevices_template/general_services.dart';
import 'dart:convert' as convert;

class RouteDetailsPageController extends GetxController {
  SetCustomMarkerIconController customMarkerIconController = Get.find();
  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  GoogleMapController? mapController;

  @override
  void onInit() async {
    await getMyCurrentLocation();
    //updateInitialCameraPosition();
    print("");
    getRouteDetailsById(selectedRouteController.selectedRouteId.value);
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
  }

  var myLocationLatitudeSt = 'Getting Latitude..'.obs;
  var myLocationLongitudeSt = 'Getting Longitude..'.obs;
  var myLocationAddress = 'Getting Address..'.obs;
  var myLocationLatitudeDo = 0.0.obs;
  var myLocationLongitudeDo = 0.0.obs;
  late StreamSubscription<Position> streamSubscription;
  Position? myLocation;

  var selectedRouteId = 0.obs;
  var isThisRouteMine = false.obs;
  var haveRouteMe = false.obs;
  var isThisRouteActive = false.obs;

  var ownerRouteName = "".obs;
  var ownerRouteSurname = "".obs;
  var ownerRouteDiscription = "".obs;
  var ownerRouteProfilePicture = "".obs;
  GetRouteDetailsUsertousercartype ownerRouteCarType =
      GetRouteDetailsUsertousercartype(id: 0, carBrand: "", carModel: "");
  var ownerVehicleCapacity = 0.obs;

  var ownerRouteStartAddress = "".obs;
  var ownerRouteStartCity = "".obs;
  var ownerRouteStartLatitude = 0.0.obs;
  var ownerRouteStartLongitude = 0.0.obs;
  var ownerRouteStartDate = "".obs;
  var ownerRouteStartLatLong = const LatLng(0.0, 0.0);
  var ownerRouteFinishAddress = "".obs;
  var ownerRouteFinishCity = "".obs;
  var ownerRouteFinishLatitude = 0.0.obs;
  var ownerRouteFinishLongitude = 0.0.obs;
  var ownerRouteFinishDate = "".obs;
  var ownerRouteFinishLatLong = const LatLng(0.0, 0.0);

  var ownerRoutePolylineEncode = "".obs;
  var ownerRoutePolylineDecode = [].obs;

  var ownerRouteCalculatedRouteDistance = "".obs;
  var ownerRouteCalculatedRouteTime = "".obs;

  var myRoutePolylineEncode = "".obs;

  var myRouteStartLatitude = 0.0.obs;
  var myRouteStartLongitude = 0.0.obs;
  var myRouteStartAddress = "".obs;
  var myRouteFinishLatitude = 0.0.obs;
  var myRouteFinishLongitude = 0.0.obs;
  var myRouteFinishAddress = "".obs;

  GoogleMapsPlaces googleMapsPlaces =
      GoogleMapsPlaces(apiKey: AppConstants.googleMapsApiKey);

  PolylineId ownerPolylineId = const PolylineId('ownerPolyline');
  PolylineId myPolylineId = const PolylineId('myPolyline');
  var selectedPolyline = 1.obs;

  PolylinePoints ownerPolylinePoints = PolylinePoints();
  PolylinePoints myPolylinePoints = PolylinePoints();
  Set<Marker> markers = {};
  Map<PolylineId, Polyline> ownerPolylines = {};
  Map<PolylineId, Polyline> myPolylines = {};
  Set<Polyline> generalPolylines = {};
  List<LatLng> ownerPolylineCoordinates = [];
  List<LatLng> myPolylineCoordinates = [];

  //GoogleMapController? routeDetailsMapController;

  Completer<GoogleMapController> routeDetailsMapController =
      Completer<GoogleMapController>();
  // late GoogleMapController mapController;

  addAllElements() async {
    await addPointIntoPolylineList(ownerRoutePolylineEncode.value, true);
    await addPointIntoPolylineList(myRoutePolylineEncode.value, false);
    addMarkerFunctionRouteDetails(
      const MarkerId("myLocationMarker"),
      LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value),
      myLocationAddress.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
    );
    addMarkerFunctionRouteDetails(
      const MarkerId("ownerRouteStartMarker"),
      LatLng(ownerRouteStartLatitude.value, ownerRouteStartLongitude.value),
      ownerRouteStartAddress.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
    );
    addMarkerFunctionRouteDetails(
      const MarkerId("ownerRouteFinishMarker"),
      LatLng(ownerRouteFinishLatitude.value, ownerRouteFinishLongitude.value),
      ownerRouteFinishAddress.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
    );
    addMarkerFunctionRouteDetails(
      const MarkerId("myRouteStartMarker"),
      LatLng(myRouteStartLatitude.value, myRouteStartLongitude.value),
      ownerRouteStartAddress.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
    );
    addMarkerFunctionRouteDetails(
      const MarkerId("myRouteFinishMarker"),
      LatLng(myRouteFinishLatitude.value, myRouteFinishLongitude.value),
      myRouteFinishAddress.value,
      BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
    );
    mapDisplayAnimationFuncForOwner();
    update();
  }

  getRouteDetailsById(int routeId) async {
    try {
      GetRouteDetailsByIdRequestModel getRouteDetailsByIdRequestModel =
          GetRouteDetailsByIdRequestModel(routeId: routeId);
      await GeneralServicesTemp().makePostRequest(
        EndPoint.getRouteDetailsById,
        getRouteDetailsByIdRequestModel,
        {
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
          'Content-Type': 'application/json',
        },
      ).then(
        (value) async {
          selectedRouteController.matchedOn = MatchedOn();
          generalPolylines.clear();
          myPolylines.clear();
          ownerPolylineCoordinates.clear();
          ownerPolylines.clear();
          print("GETROUTEDETA,İL İD -> ${routeId}");
          GetRouteDetailsByIdResponseModel responseBody =
              GetRouteDetailsByIdResponseModel.fromJson(
            convert.jsonDecode(value!),
          );
          print(responseBody.data!);
          //log("rota kime ait: ${responseBody.data![0].routeBelongsTo!.name}");
          isThisRouteMine.value = responseBody.data![0].routeBelongsToMe!;
          haveRouteMe.value = responseBody.data![0].doIHaveAActiveRoute!;
          // if (responseBody.data![0].isRouteActive != null) {
          //   isThisRouteActive.value = responseBody.data![0].isRouteActive!;
          // }
          ownerRouteName.value = responseBody.data![0].routeBelongsTo!.name!;
          ownerRouteSurname.value =
              responseBody.data![0].routeBelongsTo!.surname!;
          ownerRouteDiscription.value =
              responseBody.data![0].route!.routeDescription!;
          ownerRouteProfilePicture.value =
              responseBody.data![0].routeBelongsTo!.profilePicture!;
          /*ownerRouteCarType =
            responseBody.data![0].routeBelongsTo!.usertousercartypes![0];*/
          ownerRouteStartDate.value =
              responseBody.data![0].route!.departureDate!.toString();
          ownerRouteFinishDate.value =
              responseBody.data![0].route!.arrivalDate!.toString();
          //log("ownerRouteStartDate   ${ownerRouteStartDate.value} - ownerRouteFinishDate  ${ownerRouteFinishDate.value}");
          ownerVehicleCapacity.value =
              responseBody.data![0].route!.vehicleCapacity!;
          ownerRouteStartLatitude.value =
              responseBody.data![0].route!.startingCoordinates!.first;
          ownerRouteStartLongitude.value =
              responseBody.data![0].route!.startingCoordinates!.last;
          ownerRouteStartLatLong = LatLng(
              responseBody.data![0].route!.startingCoordinates!.first,
              responseBody.data![0].route!.startingCoordinates!.last);
          ownerRouteFinishLatitude.value =
              responseBody.data![0].route!.endingCoordinates!.first;
          ownerRouteFinishLongitude.value =
              responseBody.data![0].route!.endingCoordinates!.last;
          ownerRouteFinishLatLong = LatLng(
              responseBody.data![0].route!.endingCoordinates!.first,
              responseBody.data![0].route!.endingCoordinates!.last);
          ownerRouteStartAddress.value =
              responseBody.data![0].route!.startingOpenAdress!;
          ownerRouteFinishAddress.value =
              responseBody.data![0].route!.endingOpenAdress!;
          ownerRouteStartCity.value =
              responseBody.data![0].route!.startingCity!;
          ownerRouteFinishCity.value = responseBody.data![0].route!.endingCity!;
          ownerRouteCalculatedRouteDistance.value =
              "${((responseBody.data![0].route!.distance!)).toStringAsFixed(0)} km";
          ownerRouteCalculatedRouteTime.value =
              "${responseBody.data![0].route!.travelTime! ~/ 60} saat ${((responseBody.data![0].route!.travelTime!) % 60).toInt()} dk";
          //log("ownerRouteCalculatedRouteDistance   ${ownerRouteCalculatedRouteDistance.value}   -   ownerRouteCalculatedRouteTime   ${ownerRouteCalculatedRouteTime.value}");
          ownerRoutePolylineEncode.value =
              responseBody.data![0].route!.polylineEncode!;
          //log("ownerRoutePolylineEncode  ${ownerRoutePolylineEncode.value}");
          ownerRoutePolylineDecode.value =
              responseBody.data![0].route!.polylineDecode!;
          myRoutePolylineEncode.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.polylineEncode!
              : responseBody.data![0].myRoute!.polylineEncode!;
          //log("myRoutePolylineEncode  ${myRoutePolylineEncode.value}");
          myRouteStartLatitude.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.startingCoordinates!.first
              : responseBody.data![0].myRoute!.startingCoordinates!.first;
          myRouteStartLongitude.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.startingCoordinates!.last
              : responseBody.data![0].myRoute!.startingCoordinates!.last;
          myRouteFinishLatitude.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.endingCoordinates!.first
              : responseBody.data![0].myRoute!.endingCoordinates!.first;
          myRouteFinishLongitude.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.endingCoordinates!.last
              : responseBody.data![0].myRoute!.endingCoordinates!.last;
          myRouteFinishAddress.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.endingOpenAdress!
              : responseBody.data![0].myRoute!.endingOpenAdress!;
          myRouteStartAddress.value = responseBody.data![0].myRoute == null
              ? responseBody.data![0].route!.startingOpenAdress!
              : responseBody.data![0].myRoute!.startingOpenAdress!;
        },
      );
      await addAllElements();
      update();
    } catch (e) {
      print("ROUTEDETAİLS GET ERROR -> $e");
    }
  }

  addPointIntoPolylineList(String encodedPolyline, bool whichPolyline) async {
    if (whichPolyline) {
      List<PointLatLng> result =
          ownerPolylinePoints.decodePolyline(encodedPolyline);
      for (var point in result) {
        ownerPolylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      //log("ownerPolylineCoordinates  333333  ${ownerPolylineCoordinates.toString()}");
      var newPolylineCoordinates = ownerPolylineCoordinates.toSet().toList();
      //log("newPolylineCoordinates  111111  ${newPolylineCoordinates.toString()}");
      Polyline polyline = Polyline(
        polylineId: ownerPolylineId,
        color: AppConstants().ltMainRed,
        points: newPolylineCoordinates,
        width: 4,
      );
      ownerPolylines[ownerPolylineId] = polyline;
      generalPolylines.add(polyline);
      update();
    } else {
      List<PointLatLng> result =
          myPolylinePoints.decodePolyline(encodedPolyline);
      for (var point in result) {
        myPolylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      //log("myPolylineCoordinates  444444  ${myPolylineCoordinates.toString()}");
      var newPolylineCoordinates = myPolylineCoordinates.toSet().toList();
      //log("newPolylineCoordinates  222222  ${newPolylineCoordinates.toString()}");
      Polyline polyline = Polyline(
        polylineId: myPolylineId,
        color: AppConstants().ltLogoGrey,
        points: newPolylineCoordinates,
        width: 4,
      );
      myPolylines[myPolylineId] = polyline;
      generalPolylines.add(polyline);
      update();
    }
  }

  void mapDisplayAnimationFuncForOwner() async {
    try {
      double miny =
          (ownerRouteStartLatitude.value <= ownerRouteFinishLatitude.value)
              ? ownerRouteStartLatitude.value
              : ownerRouteFinishLatitude.value;
      //log("miny: $miny");
      double minx =
          (ownerRouteStartLongitude.value <= ownerRouteFinishLongitude.value)
              ? ownerRouteStartLongitude.value
              : ownerRouteFinishLongitude.value;
      //log("minx: $minx");
      double maxy =
          (ownerRouteStartLatitude.value <= ownerRouteFinishLatitude.value)
              ? ownerRouteFinishLatitude.value
              : ownerRouteStartLatitude.value;
      //log("maxy: $maxy");
      double maxx =
          (ownerRouteStartLongitude.value <= ownerRouteFinishLongitude.value)
              ? ownerRouteFinishLongitude.value
              : ownerRouteStartLongitude.value;
      //log("maxx: $maxx");

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;
      // log("southWestLatitude: $southWestLatitude");
      // log("southWestLongitude: $southWestLongitude");
      // log("northEastLatitude: $northEastLatitude");
      // log("northEastLongitude: $northEastLongitude");
      GoogleMapController generalMapController =
          await routeDetailsMapController.future;
      generalMapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100,
        ),
      );
      update();
    } catch (e) {
      log("kamera animasyonu hatası!!! 11111  ${e.toString()}");
      update();
    }
  }

  bool addMarkerFunctionRouteDetails(
    MarkerId markerId,
    LatLng latLng,
    String address,
    BitmapDescriptor icon,
  ) {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
          snippet: address,
        ),
        icon: icon,
      );
      markers.add(marker);
      update();
      return true;
    } catch (e) {
      log("marker ekleme hatası!!  ${e.toString()}");
      update();
      return false;
    }
  }

  Future<CameraPosition> updateInitialCameraPosition() async {
    CameraPosition initialLocation = CameraPosition(
      target: LatLng(myLocationLatitudeDo.value, myLocationLongitudeDo.value),
      zoom: 15.0,
    );
    update();
    return initialLocation;
  }

  getMyCurrentLocation() async {
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
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) async {
      myLocationLatitudeSt.value = 'Latitude : ${position.latitude}';
      myLocationLongitudeSt.value = 'Longitude : ${position.longitude}';
      myLocationLatitudeDo.value = position.latitude;
      myLocationLongitudeDo.value = position.longitude;
      myLocation = position;
      // log(myLocationLatitudeSt.value);
      // log(myLocationLongitudeSt.value);
      getAddressFromLatLang(position);
      update();
    });
    update();
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    myLocationAddress.value = 'Address : ${place.locality},${place.country}';
  }
}
