// import 'package:fillogo/controllers/map/marker_icon_controller.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:fillogo/export.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:math' show cos, sqrt, asin;

// class RouteCalculatesViewController extends GetxController {
//   var directionLatitude = 0.0.obs;
//   var directionLongitude = 0.0.obs;
//   var latitude = 0.0.obs;
//   var longitude = 0.0.obs;

//   SetCustomMarkerIconController setCustomMarkerIconController = Get.find();

//   final startAddressController = TextEditingController();
//   final destinationAddressController = TextEditingController();

//   late GoogleMapController mapController;

//   var address = 'Adres Hesaplanıyor..'.obs;
//   late StreamSubscription<Position> streamSubscription;

//   var startAddressFocusNode = FocusNode().obs;
//   var desrinationAddressFocusNode = FocusNode().obs;

//   late Marker startDesrinationMarker;
//   late Marker finishDesrinationMarker;

//   Map<PolylineId, Polyline> polylines = {};
//   var polylinesRefresh = false.obs;

//   late PolylinePoints polylinePoints;
//   var polylinePointsRefresh = false.obs;

//   List<LatLng> polylineCoordinates = [];
//   var polylineCoordinatesRefresh = false.obs;

//   var placeDistance = ''.obs;
//   var totalDistance = 0.0.obs;

//   var startAddress = ''.obs;
//   var destinationAddress = ''.obs;

//   var currentAddress = ''.obs;

//   Set<Marker> markers = {};
//   var startMarker;
//   var destinationMarker;
//   var changeMarkers = false.obs;

//   @override
//   void onInit() async {
//     getCurrentLocation();
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     streamSubscription.cancel();
//   }

//   Future<bool> calculateDistance(BuildContext context) async {
//     try {
//       List<Location> startPlacemark =
//           await locationFromAddress(startAddress.value);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(destinationAddress.value);
//       double startLatitude = startAddress.value == currentAddress.value
//           ? latitude.value
//           : startPlacemark[0].latitude;

//       double startLongitude = startAddress.value == currentAddress.value
//           ? longitude.value
//           : startPlacemark[0].longitude;

//       double destinationLatitude = destinationPlacemark[0].latitude;

//       double destinationLongitude = destinationPlacemark[0].longitude;

//       String startCoordinatesString = '($startLatitude, $startLongitude)';
//       String destinationCoordinatesString =
//           '($destinationLatitude, $destinationLongitude)';

//       // Start Location Marker
//       startMarker = Marker(
//         markerId: MarkerId(startCoordinatesString),
//         position: LatLng(startLatitude, startLongitude),
//         infoWindow: InfoWindow(
//           title: 'Çıkış Noktası: $startCoordinatesString',
//           snippet: startAddress.value,
//         ),
//         icon: setCustomMarkerIconController.myRouteStartIcon == null
//             ? BitmapDescriptor.defaultMarker
//             : BitmapDescriptor.fromBytes(
//                 setCustomMarkerIconController.myRouteStartIcon!,
//               ),
//       );

//       // Destination Location Marker
//       destinationMarker = Marker(
//         markerId: MarkerId(destinationCoordinatesString),
//         position: LatLng(destinationLatitude, destinationLongitude),
//         infoWindow: InfoWindow(
//           title: 'Varış Noktası: $destinationCoordinatesString',
//           snippet: destinationAddress.value,
//         ),
//         icon: setCustomMarkerIconController.myRouteFinishIcon == null
//             ? BitmapDescriptor.defaultMarker
//             : BitmapDescriptor.fromBytes(
//                 setCustomMarkerIconController.myRouteFinishIcon!,
//               ),
//       );

//       // Adding the markers to the list
//       updateMarkers(startMarker, destinationMarker);

//       print(
//         'START COORDINATES: ($startLatitude, $startLongitude)',
//       );
//       print(
//         'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
//       );

//       // Calculating to check that the position relative
//       // to the frame, and pan & zoom the camera accordingly.
//       double miny = (startLatitude <= destinationLatitude)
//           ? startLatitude
//           : destinationLatitude;
//       double minx = (startLongitude <= destinationLongitude)
//           ? startLongitude
//           : destinationLongitude;
//       double maxy = (startLatitude <= destinationLatitude)
//           ? destinationLatitude
//           : startLatitude;
//       double maxx = (startLongitude <= destinationLongitude)
//           ? destinationLongitude
//           : startLongitude;

//       double southWestLatitude = miny;
//       double southWestLongitude = minx;

//       double northEastLatitude = maxy;
//       double northEastLongitude = maxx;

//       // Accommodate the two locations within the
//       // camera view of the map
//       mapController.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             northeast: LatLng(northEastLatitude, northEastLongitude),
//             southwest: LatLng(southWestLatitude, southWestLongitude),
//           ),
//           100.0,
//         ),
//       );

//       // Calculating the distance between the start and the end positions
//       // with a straight path, without considering any route
//       double distanceInMeters = await Geolocator.bearingBetween(
//         startLatitude,
//         startLongitude,
//         destinationLatitude,
//         destinationLongitude,
//       );

//       await createPolylines(
//         startLatitude: startLatitude,
//         startLongitude: startLongitude,
//         destinationLatitude: destinationLatitude,
//         destinationLongitude: destinationLongitude,
//       );

//       for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//         print("XXXXXXXXXXXXXXX" + polylineCoordinates.length.toString());
//         totalDistance.value += coordinateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude,
//         );
//       }

//       placeDistance.value = totalDistance.value.toStringAsFixed(2);
//       print('placeDistance DISTANCE: ${placeDistance.value} km');
//       print('totalDistance DISTANCE: ${totalDistance.value} km');

//       return true;
//     } catch (e) {
//       print(e);
//     }
//     print("XXXXXXXXXXXXXXX  222222");
//     return false;
//   }

//   double coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   Future<Widget> createPolylines({
//     required double startLatitude,
//     required double startLongitude,
//     required double destinationLatitude,
//     required double destinationLongitude,
//   }) async {
//     polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyA5Gxhz0PAAAZY8Dmme878YUIrJR2f22_4',
//       PointLatLng(startLatitude, startLongitude),
//       PointLatLng(destinationLatitude, destinationLongitude),
//       travelMode: TravelMode.transit,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }

//     PolylineId id = const PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: AppConstants().ltMainRed,
//       points: polylineCoordinates,
//       width: 2,
//     );
//     polylines[id] = polyline;
//     return Container();
//   }

//   updateMarkers(Marker startMarker, Marker destinationMarker) async {
//     markers.add(startMarker);
//     markers.add(destinationMarker);
//     changeMarkers.value = changeMarkers.value == false ? true : false;
//   }

//   getCurrentLocation() async {
//     bool serviceEnabled;

//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Konum servisleri devre dışı.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Konum izinleri reddedildi.');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Konum izinleri kalıcı olarak reddedilir, izin isteyemeyiz.');
//     }
//     streamSubscription =
//         Geolocator.getPositionStream().listen((Position position) {
//       latitude.value = position.latitude;
//       longitude.value = position.longitude;
//       //getAddressFromLatLang(position);
//     });
//   }

//   Future<void> getAddressFromLatLang(Position position) async {
//     List<Placemark> placemark =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     Placemark place = placemark[0];
//     address.value = 'Address : ${place.locality},${place.country}';
//   }
// }
