// import 'package:fillogo/controllers/map/marker_icon_controller.dart';
// import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/route_calculate_view/route_calculate_last.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_routes/google_maps_routes.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// class RouteCalculatesView extends StatefulWidget {
//   const RouteCalculatesView({Key? key}) : super(key: key);

//   @override
//   State<RouteCalculatesView> createState() => _RouteCalculatesViewState();
// }

// RouteCalculatesViewController currentLocationCont = Get.find();

// SetCustomMarkerIconController markerIconController = Get.find();

// class _RouteCalculatesViewState extends State<RouteCalculatesView> {
//   static CameraPosition initialPosition = CameraPosition(
//     target: LatLng(currentLocationCont.latitude.value,
//         currentLocationCont.longitude.value),
//     zoom: 14,
//   );

//   Completer<GoogleMapController> _controller = Completer();

//   String totalTime = "";

//   // LatLng origin = const LatLng(41.2911619, 36.3370133);
//   // LatLng destination = const LatLng(36.1980885, 36.1599316);

//   //PolylineResponse polylineResponse = PolylineResponse();

//   //Set<Polyline> polylinePoints = {};

//   Set<Marker> markers = {};

//   late Position _currentPosition;
//   String _currentAddress = '';

//   List<LatLng> points = const [
//     LatLng(45.82917150748776, 14.63705454546316),
//     LatLng(45.833828635680355, 14.636544256202207),
//     LatLng(45.851254420031296, 14.624331708344428),
//     LatLng(45.84794984187217, 14.605434384742317)
//   ];

//   MapsRoutes route = MapsRoutes();
//   DistanceCalculator distanceCalculator = DistanceCalculator();
//   String googleApiKey = 'AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8';
//   String totalDistance = 'No route';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarGenel(
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 20.w,
//               right: 5.h,
//             ),
//             child: SvgPicture.asset(
//               height: 25.h,
//               width: 25.w,
//               'assets/icons/back-icon.svg',
//               color: AppConstants().ltLogoGrey,
//             ),
//           ),
//         ),
//         title: Image.asset(
//           'assets/logo/logo-1.png',
//           height: 45,
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Get.to(() => RouteCalculateLastView());
//             },
//             child: Padding(
//               padding: EdgeInsets.only(
//                 right: 20.w,
//               ),
//               child: SvgPicture.asset(
//                 height: 25.h,
//                 width: 25.w,
//                 'assets/icons/route-icon.svg',
//                 color: AppConstants().ltMainRed,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: GoogleMap(
//               zoomControlsEnabled: true,
//               polylines: route.routes,
//               initialCameraPosition: const CameraPosition(
//                 zoom: 15.0,
//                 target: LatLng(45.82917150748776, 14.63705454546316),
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               markers: markers,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: 200,
//                 height: 50,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15.0)),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(totalDistance, style: TextStyle(fontSize: 25.0)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await route.drawRoute(
//               points, 'Test routes', AppConstants().ltMainRed, googleApiKey,
//               travelMode: TravelModes.walking);
//           setState(() {
//             totalDistance =
//                 distanceCalculator.calculateRouteDistance(points, decimals: 1);
//           });
//         },
//       ),
//     );
//   }
// }



// // import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// // import 'package:fillogo/export.dart';
// // import 'package:fillogo/views/testFolder/new_polyline_drawing/polyline_response.dart';

// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert' as convert;

// // class RouteCalculatesView extends StatefulWidget {
// //   const RouteCalculatesView({Key? key}) : super(key: key);

// //   @override
// //   State<RouteCalculatesView> createState() => _RouteCalculatesViewState();
// // }

// // RouteCalculatesViewController currentLocationCont = Get.find();

// // class _RouteCalculatesViewState extends State<RouteCalculatesView> {
// //   static CameraPosition initialPosition = CameraPosition(
// //       target: LatLng(currentLocationCont.latitude.value,
// //           currentLocationCont.longitude.value),
// //       zoom: 14);

// //   final Completer<GoogleMapController> _controller = Completer();

// //   String totalDistance = "";
// //   String totalTime = "";

// //   String apiKey = "AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8";

// //   LatLng origin = const LatLng(40.5530321, 34.9602469);
// //   LatLng destination = const LatLng(41.2911619, 36.3370133);

// //   PolylineResponse polylineResponse = PolylineResponse();

// //   Set<Polyline> polylinePoints = {};

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Polyline"),
// //       ),
// //       body: Stack(
// //         children: [
// //           GoogleMap(
// //             polylines: polylinePoints,
// //             zoomControlsEnabled: false,
// //             initialCameraPosition: initialPosition,
// //             mapType: MapType.normal,
// //             onMapCreated: (GoogleMapController controller) {
// //               _controller.complete(controller);
// //             },
// //           ),
// //           Container(
// //             margin: const EdgeInsets.all(20),
// //             padding: const EdgeInsets.all(20),
// //             color: Colors.white,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Text("Total Distance: " + totalDistance),
// //                 Text("Total Time: " + totalTime),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           drawPolyline();
// //         },
// //         child: const Icon(Icons.directions),
// //       ),
// //     );
// //   }

// //   void drawPolyline() async {
// //     var response = await http.post(
// //         Uri.parse("https://maps.googleapis.com/maps/api/directions/json?key=" +
// //             apiKey +
// //             "&units=metric&origin=" +
// //             origin.latitude.toString() +
// //             "," +
// //             origin.longitude.toString() +
// //             "&destination=" +
// //             destination.latitude.toString() +
// //             "," +
// //             destination.longitude.toString() +
// //             "&mode=driving"),
// //         body: convert.jsonEncode({
// //           "origin": {
// //             "location": {
// //               "latLng": {
// //                 "latitude": 40.5530321,
// //                 "longitude": 34.9602469,
// //               }
// //             },
// //           },
// //           "destination": {
// //             "location": {
// //               "latLng": {
// //                 "latitude": 41.2911619,
// //                 "longitude": 36.3370133,
// //               }
// //             },
// //           },
// //           "travelMode": "DRIVE",
// //           "polylineQuality": "HIGH_QUALITY",
// //           "polylineEncoding": "ENCODED_POLYLINE",
// //           "computeAlternativeRoutes": "TRUE",
// //           "routeModifiers": {
// //             "avoidTolls": true,
// //             "avoidHighways": false,
// //             "avoidFerries": true
// //           },
// //           "languageCode": "en-US",
// //           "units": "metric",
// //         }),
// //         headers: {
// //           "Content-Type": "application/json",
// //           "X-Goog-Api-Key": apiKey,
// //           "X-Goog-FieldMask":
// //               "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline"
// //         });

// //     print(response.body);

// //     polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

// //     totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
// //     totalTime = polylineResponse.routes![0].legs![0].duration!.text!;
// //     print("AAAAAAAAA totalTime " + totalTime.toString());
// //     print("AAAAAAAAA totalDistance1 " + totalDistance.toString());

// //     for (int i = 0;
// //         i < polylineResponse.routes![0].legs![0].steps!.length;
// //         i++) {
// //       polylinePoints.add(Polyline(
// //           polylineId: PolylineId(
// //               polylineResponse.routes![0].legs![0].steps![i].polyline!.points!),
// //           points: [
// //             LatLng(
// //                 polylineResponse
// //                     .routes![0].legs![0].steps![i].startLocation!.lat!,
// //                 polylineResponse
// //                     .routes![0].legs![0].steps![i].startLocation!.lng!),
// //             LatLng(
// //                 polylineResponse
// //                     .routes![0].legs![0].steps![i].endLocation!.lat!,
// //                 polylineResponse
// //                     .routes![0].legs![0].steps![i].endLocation!.lng!),
// //           ],
// //           width: 3,
// //           color: Colors.red));
// //     }

// //     setState(() {});
// //   }
// // }






// // import 'package:fillogo/controllers/drawer/drawer_controller.dart';
// // import 'package:fillogo/controllers/map/marker_icon_controller.dart';
// // import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// // import 'package:fillogo/export.dart';
// // import 'package:fillogo/widgets/custom_button_design.dart';
// // import 'package:fillogo/widgets/navigation_drawer.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class RouteCalculatesView extends StatelessWidget {
// //   RouteCalculatesView({super.key});
// //   GeneralDrawerController routeCalculatePageDrawerController =
// //       Get.find<GeneralDrawerController>();

// //   RouteCalculatesViewController currentLocation =
// //       Get.find<RouteCalculatesViewController>();

// //   SetCustomMarkerIconController customMarkerIconController = Get.find();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       key: routeCalculatePageDrawerController.routeCalculatePageScaffoldKey,
// //       appBar: AppBarGenel(
// //         leading: GestureDetector(
// //           onTap: () {
// //             // routeCalculatePageDrawerController
// //             //     .openRouteCalculatePageScaffoldDrawer();
// //             Get.back();
// //           },
// //           child: Padding(
// //             padding: EdgeInsets.only(
// //               left: 20.w,
// //               right: 5.h,
// //             ),
// //             child: SvgPicture.asset(
// //               height: 25.h,
// //               width: 25.w,
// //               'assets/icons/open-drawer-icon.svg',
// //               color: AppConstants().ltLogoGrey,
// //             ),
// //           ),
// //         ),
// //         title: Image.asset(
// //           'assets/logo/logo-1.png',
// //           height: 45,
// //         ),
// //         actions: [
// //           GestureDetector(
// //             onTap: () {
// //               Get.toNamed(NavigationConstants.notifications);
// //             },
// //             child: Padding(
// //               padding: EdgeInsets.only(
// //                 right: 5.w,
// //               ),
// //               child: SvgPicture.asset(
// //                 height: 25.h,
// //                 width: 25.w,
// //                 'assets/icons/notification-icon.svg',
// //                 color: AppConstants().ltLogoGrey,
// //               ),
// //             ),
// //           ),
// //           GestureDetector(
// //             onTap: () {
// //               Get.toNamed(NavigationConstants.message);
// //             },
// //             child: Padding(
// //               padding: EdgeInsets.only(
// //                 left: 5.w,
// //                 right: 20.w,
// //               ),
// //               child: SvgPicture.asset(
// //                 'assets/icons/message-icon.svg',
// //                 height: 25.h,
// //                 width: 25.w,
// //                 color: const Color(0xff3E3E3E),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       drawer: NavigationDrawerWidget(),
// //       body: Stack(
// //         children: [
// //           Obx(
// //             () => googleMapViewWidget(
// //               CameraPosition(
// //                 target: LatLng(
// //                   currentLocation.latitude.value,
// //                   currentLocation.longitude.value,
// //                 ),
// //               ),
// //               {
// //                 currentLocation.markers.first,
// //                 currentLocation.markers.last,
// //               },
// //               Set<Polyline>.of(
// //                 currentLocation.polylines.values,
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //             left: 37.w,
// //             right: 37.w,
// //             top: 20.h,
// //             child: calculateDistanceTextField(
// //               hint: 'Çıkış noktasını giriniz',
// //               controller: currentLocation.startAddressController,
// //               focusNode: currentLocation.startAddressFocusNode.value,
// //               width: 300.w,
// //               locationCallback: (String value) {
// //                 currentLocation.startAddress.value = value;
// //               },
// //             ),
// //           ),
// //           Positioned(
// //             left: 37.w,
// //             right: 37.w,
// //             top: 70.h,
// //             child: calculateDistanceTextField(
// //               hint: 'Varış noktasını giriniz',
// //               controller: currentLocation.destinationAddressController,
// //               focusNode: currentLocation.desrinationAddressFocusNode.value,
// //               width: 300.w,
// //               locationCallback: (String value) {
// //                 currentLocation.destinationAddress.value = value;
// //               },
// //             ),
// //           ),
// //           Positioned(
// //             left: 37.w,
// //             right: 37.w,
// //             top: 120.h,
// //             child: Obx(
// //               () => CustomButtonDesign(
// //                 color: AppConstants().ltMainRed,
// //                 height: 50.h,
// //                 iconPath: '',
// //                 text: 'Rota Hesapla',
// //                 textColor: AppConstants().ltWhite,
// //                 width: 300.w,
// //                 onpressed: (currentLocation.startAddress.value != '' &&
// //                         currentLocation.destinationAddress.value != '')
// //                     ? () async {
// //                         currentLocation.startAddressFocusNode.value.unfocus();
// //                         currentLocation.desrinationAddressFocusNode.value
// //                             .unfocus();
// //                         if (currentLocation.markers.isNotEmpty)
// //                           currentLocation.markers.clear();
// //                         if (currentLocation.polylines.isNotEmpty)
// //                           currentLocation.polylines.clear();
// //                         if (currentLocation.polylineCoordinates.isNotEmpty)
// //                           currentLocation.polylineCoordinates.clear();
// //                         currentLocation.placeDistance.value = '';

// //                         currentLocation.calculateDistance(context).then(
// //                           (isCalculated) {
// //                             if (isCalculated) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(
// //                                   content: Text(
// //                                     'Distance Calculated Sucessfully',
// //                                   ),
// //                                 ),
// //                               );
// //                             } else {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(
// //                                   content: Text(
// //                                     'Error Calculating Distance',
// //                                   ),
// //                                 ),
// //                               );
// //                             }
// //                           },
// //                         );
// //                       }
// //                     : null,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget googleMapViewWidget(
// //     CameraPosition cameraPosition,
// //     Set<Marker> markers,
// //     Set<Polyline> polyline,
// //   ) {
// //     return SizedBox(
// //       height: Get.height,
// //       width: Get.width,
// //       child: GoogleMap(
// //         initialCameraPosition: cameraPosition,
// //         myLocationButtonEnabled: false,
// //         zoomControlsEnabled: true,
// //         zoomGesturesEnabled: true,
// //         onMapCreated: (controller) => {
// //           currentLocation.mapController = controller,
// //         },
// //         markers: markers,
// //         mapType: MapType.normal,
// //         polylines: polyline,
// //       ),
// //     );
// //   }

// //   Widget calculateDistanceTextField({
// //     required TextEditingController controller,
// //     required FocusNode focusNode,
// //     //required String label,
// //     required String hint,
// //     required double width,
// //     required Function(String) locationCallback,
// //   }) {
// //     return Container(
// //       width: 300.w,
// //       height: 50.h,
// //       decoration: BoxDecoration(
// //         boxShadow: [
// //           BoxShadow(
// //             color: AppConstants().ltLogoGrey.withOpacity(0.2),
// //             spreadRadius: 2.r,
// //             blurRadius: 10.r,
// //             offset: Offset(0.w, 0.h), // changes position of shadow
// //           ),
// //         ],
// //       ),
// //       child: TextField(
// //         cursorColor: AppConstants().ltMainRed,
// //         onChanged: (value) {
// //           locationCallback(value);
// //         },
// //         controller: controller,
// //         focusNode: focusNode,
// //         decoration: InputDecoration(
// //           filled: true,
// //           fillColor: AppConstants().ltWhite,
// //           hintStyle: TextStyle(
// //             fontFamily: "Sflight",
// //             fontSize: 16.sp,
// //             color: AppConstants().ltDarkGrey,
// //           ),
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.all(
// //               Radius.circular(8.r),
// //             ),
// //             borderSide: BorderSide.none,
// //           ),
// //           contentPadding: EdgeInsets.all(10.w),
// //           hintText: hint,
// //         ),
// //         style: TextStyle(
// //           fontFamily: "Sflight",
// //           fontSize: 16.sp,
// //           color: AppConstants().ltBlack,
// //         ),
// //       ),
// //     );
// //   }
// // }
