import 'dart:async';
import 'dart:developer';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../export.dart';
import 'dart:convert' as convert;
import '../../services/general_sevices_template/general_services.dart';
import '../../views/testFolder/test19/route_api_models.dart';

class GoogleMapsGeneralWidgetsController extends GetxController {
  Future<Map<PolylineId, Polyline>> addPolylineIntoPolylineSet(
    String encodedPolyline,
    PolylineId polylineId,
    Color polylineColor,
    Map<PolylineId, Polyline> polylines,
  ) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
    List<LatLng> polylineCoordinates = [];

    for (var point in result) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }
    var newPolylineCoordinates = polylineCoordinates.toSet().toList();

    Polyline polyline = Polyline(
      polylineId: polylineId,
      color: polylineColor,
      points: newPolylineCoordinates,
      width: 4,
    );
    polylines[polylineId] = polyline;
    return polylines;
  }

  Future animatedCameraPosition(
    Completer<GoogleMapController> mapCotroller,
    LatLng target,
    String getxBuilderId,
  ) async {
    try {
      GoogleMapController newMapController = await mapCotroller.future;
      newMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0,
            zoom: 15.0,
            target: target,
          ),
        ),
      );
      update([getxBuilderId]);
    } catch (e) {
      log("kamera animasyonu hatası! 111 ${e.toString()}");
      //update([getxBuilderId]);
    }
  }

  Future animatedBounceCameraPosition(
    LatLng target1,
    LatLng target2,
    Completer<GoogleMapController> mapCotroller,
    String getxBuilderId,
  ) async {
    try {
      double miny = (target1.latitude <= target2.latitude)
          ? target1.latitude
          : target2.latitude;

      double minx = (target1.longitude <= target2.longitude)
          ? target1.longitude
          : target2.longitude;

      double maxy = (target1.latitude <= target2.latitude)
          ? target2.latitude
          : target1.latitude;

      double maxx = (target1.longitude <= target2.longitude)
          ? target2.longitude
          : target1.longitude;

      GoogleMapController generalMapController = await mapCotroller.future;
      generalMapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(maxy, maxx),
            southwest: LatLng(miny, minx),
          ),
          100,
        ),
      );
      update([getxBuilderId]);
    } catch (e) {
      log("kamera animasyonu hatası! 222 ${e.toString()}");
      //update([getxBuilderId]);
    }
  }

  Future<bool> addMarkerFunctionClickAble(
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
    Set<Marker> markers,
    String getxBuilderId,
    int routeID,
  ) async {
    try {
      Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        icon: icon,
        onTap: () async {
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
      update([getxBuilderId]);
      return true;
    } catch (e) {
      log("marker ekleme hatası!! markerId: $markerId --- ${e.toString()}");
      //update([getxBuilderId]);
      return false;
    }
  }

  Future<bool> addMarkerFunction(
    MarkerId markerId,
    LatLng latLng,
    String address,
    BitmapDescriptor icon,
    Set<Marker> markers,
    String getxBuilderId,
    // String title,
  ) async {
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
      update([getxBuilderId]);
      return true;
    } catch (e) {
      log("marker ekleme hatası!! markerId: $markerId --- ${e.toString()}");
      //update([getxBuilderId]);
      return false;
    }
  }

  Future<GetPollylineResponseModel> getPolylineEncodeRequest(
    int selectedPolyline,
    double lati1,
    double longi1,
    double lati2,
    double longi2,
    String getxBuilderId,
    String distenceText,
    int intDistence,
    String timeText,
    int intTime,
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
          getPollylineResponseModel =
              GetPollylineResponseModel.fromJson(convert.json.decode(value));
          distenceText =
              "${((getPollylineResponseModel.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
          intDistence =
              getPollylineResponseModel.routes![0].distanceMeters! ~/ 1000;
          int calculatedTime = int.parse(
              getPollylineResponseModel.routes![0].duration!.split("s")[0]);
          timeText =
              "${calculatedTime ~/ 3600} saat ${((calculatedTime / 60) % 60).toInt()} dk";
          intTime = ((calculatedTime ~/ 3600) * 60) +
              ((calculatedTime / 60) % 60).toInt();
          //getPollylineResponseModel.routes![0].polyline!.encodedPolyline!;
          update([getxBuilderId]);
          return getPollylineResponseModel;
        }
        //update([getxBuilderId]);
      },
    );
    //update([getxBuilderId]);
    return getPollylineResponseModel;
  }

  Future<List<String>> getAddressFromLatLang(LatLng position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    String myAddress = "";
    String myStartCity = "";
    myAddress =
        "${place.street} ${place.thoroughfare}, ${place.subAdministrativeArea}, ${place.administrativeArea}/${place.country}";
    myStartCity = place.administrativeArea!;
    return [myAddress, myStartCity];
  }

  // Future drawAndAddPolylineIntoMap() async {
  //   // if (markers2.isNotEmpty) markers2.clear();
  //   // if (polylines2.isNotEmpty) polylines2.clear();
  //   // if (polylineCoordinates2.isNotEmpty) polylineCoordinates2.clear();
  //   // if (calculatedRouteDistance.value != "") calculatedRouteDistance.value = "";

  //   await getPolylineEncodeRequest(
  //     selectedPolyline.value,
  //     mapPageRouteStartLatitude2.value,
  //     mapPageRouteStartLongitude2.value,
  //     mapPageRouteFinishLatitude2.value,
  //     mapPageRouteFinishLongitude2.value,
  //   ).then((value) async {
  //     calculatedRouteDistance.value =
  //         "${((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
  //     calculatedRouteTime.value =
  //         "${int.parse(value.routes![0].duration!.split("s")[0]) ~/ 3600} saat ${((int.parse(value.routes![0].duration!.split("s")[0]) / 60) % 60).toInt()} dk";
  //     generalPolylineEncode2.value =
  //         value.routes![0].polyline!.encodedPolyline!;

  //     update(["mapPageController"]);
  //   });

  //   addPointIntoPolylineList2(generalPolylineEncode2.value);

  //   addMarkerFunctionForMapPageWithoutOnTap2(
  //     MarkerId("myLocationMarker"),
  //     LatLng(
  //       getMyCurrentLocationController.myLocationLatitudeDo.value,
  //       getMyCurrentLocationController.myLocationLongitudeDo.value,
  //     ),
  //     "${mapPageRouteStartAddress2.value}",
  //     BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
  //   );

  //   addMarkerFunctionForMapPageWithoutOnTap2(
  //     MarkerId("myRouteStartMarker2"),
  //     LatLng(
  //       mapPageRouteStartLatitude2.value,
  //       mapPageRouteStartLongitude2.value,
  //     ),
  //     "${mapPageRouteStartAddress2.value}",
  //     BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
  //   );

  //   addMarkerFunctionForMapPageWithoutOnTap2(
  //     MarkerId("myRouteFinishMarker2"),
  //     LatLng(
  //       mapPageRouteFinishLatitude2.value,
  //       mapPageRouteFinishLongitude2.value,
  //     ),
  //     "${mapPageRouteFinishAddress2.value}",
  //     BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
  //   );

  //   mapDisplayAnimationFuncMap1();

  //   update(["mapPageController"]);
  // }
}
