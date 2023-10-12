// import 'package:fillogo/controllers/drawer/drawer_controller.dart';
// import 'package:fillogo/controllers/map/marker_icon_controller.dart';
// import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';
// import 'package:fillogo/widgets/custom_button_design.dart';
// import 'package:fillogo/widgets/navigation_drawer.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:math' show cos, sqrt, asin;

// class RouteCalculatesTest extends StatefulWidget {
//   @override
//   _RouteCalculatesTestState createState() => _RouteCalculatesTestState();
// }

// //RouteCalculatesViewController currentLocation = Get.find();

// SetCustomMarkerIconController customMarkerIconController = Get.find();
// GeneralDrawerController drawerController = Get.find<GeneralDrawerController>();

// StartEndAdressController startEndAdressController =
//     Get.find<StartEndAdressController>();

// class _RouteCalculatesTestState extends State<RouteCalculatesTest> {
//   CameraPosition initialLocation = CameraPosition(
//     target:
//         LatLng(currentLocation.latitude.value, currentLocation.longitude.value),
//     zoom: 15.0,
//   );
//   CameraPosition initialLocation = CameraPosition(
//     target:
//         LatLng(0.0, 0.0,),
//     zoom: 15.0,
//   );
//   late GoogleMapController mapController;

//   late Position _currentPosition;
//   String _currentAddress = '';

//   final startAddressController = TextEditingController();
//   final destinationAddressController = TextEditingController();

//   final startAddressFocusNode = FocusNode();
//   final desrinationAddressFocusNode = FocusNode();

//   String _startAddress = '';
//   String _destinationAddress = '';
//   String? _placeDistance;

//   Set<Marker> markers = {};

//   late PolylinePoints polylinePoints;
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];

//   bool onTapThreePointButton = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: drawerController.routeCalculatePageScaffoldKey,
//       appBar: AppBarGenel(
//         leading: GestureDetector(
//           onTap: () {
//             drawerController.openRouteCalculatePageScaffoldDrawer();
//           },
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 20.w,
//               right: 5.h,
//             ),
//             child: SvgPicture.asset(
//               height: 25.h,
//               width: 25.w,
//               'assets/icons/open-drawer-icon.svg',
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
//               Get.toNamed(NavigationConstants.notifications);
//             },
//             child: Padding(
//               padding: EdgeInsets.only(
//                 right: 5.w,
//               ),
//               child: SvgPicture.asset(
//                 height: 25.h,
//                 width: 25.w,
//                 'assets/icons/notification-icon.svg',
//                 color: AppConstants().ltLogoGrey,
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Get.toNamed(NavigationConstants.message);
//             },
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 5.w,
//                 right: 20.w,
//               ),
//               child: SvgPicture.asset(
//                 'assets/icons/message-icon.svg',
//                 height: 25.h,
//                 width: 25.w,
//                 color: AppConstants().ltLogoGrey,
//               ),
//             ),
//           ),
//         ],
//       ),
//       drawer: NavigationDrawerWidget(),
//       body: Stack(
//         children: <Widget>[
//           // Map View
//           SizedBox(
//             height: Get.height,
//             width: Get.width,
//             child: GoogleMap(
//               markers: Set<Marker>.from(markers),
//               initialCameraPosition: initialLocation,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               mapType: MapType.normal,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: true,
//               polylines: Set<Polyline>.of(polylines.values),
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//             ),
//           ),
//           Visibility(
//             visible: _placeDistance == null ? false : true,
//             child: Positioned(
//               top: onTapThreePointButton == false ? 500.h : 450.h,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppConstants().ltWhite,
//                 ),
//                 width: Get.width,
//                 height: onTapThreePointButton == false ? 140.h : 190.h,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: Get.width,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(10.w),
//                             child: SvgPicture.asset(
//                               'assets/icons/route-icon.svg',
//                               color: AppConstants().ltMainRed,
//                               height: 32.h,
//                               width: 32.w,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(5.w),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(bottom: 5.h),
//                                   child: Text(
//                                     'Rota',
//                                     style: TextStyle(
//                                       color: AppConstants().ltDarkGrey,
//                                       fontFamily: 'Sflight',
//                                       fontSize: 12.sp,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(bottom: 5.h),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         _startAddress.toUpperCase(),
//                                         style: TextStyle(
//                                           color: AppConstants().ltLogoGrey,
//                                           fontFamily: 'Sfmedium',
//                                           fontSize: 14.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         ' -> ',
//                                         style: TextStyle(
//                                           color: AppConstants().ltLogoGrey,
//                                           fontFamily: 'Sfmedium',
//                                           fontSize: 12.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         _destinationAddress.toUpperCase(),
//                                         style: TextStyle(
//                                           color: AppConstants().ltLogoGrey,
//                                           fontFamily: 'Sfmedium',
//                                           fontSize: 14.sp,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(bottom: 5.h),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         'Mesafe: ',
//                                         style: TextStyle(
//                                           color: AppConstants().ltLogoGrey,
//                                           fontFamily: 'Sflight',
//                                           fontSize: 12.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         _placeDistance.toString(),
//                                         style: TextStyle(
//                                           color: AppConstants().ltLogoGrey,
//                                           fontFamily: 'Sflight',
//                                           fontSize: 12.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         ' km',
//                                         style: TextStyle(
//                                           color: AppConstants().ltLogoGrey,
//                                           fontFamily: 'Sflight',
//                                           fontSize: 12.sp,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: Get.width,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10.w),
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 startEndAdressController.startAdress.value =
//                                     _startAddress;
//                                 startEndAdressController.endAdress.value =
//                                     _destinationAddress;
//                                 setState(() {
//                                   // initialLocation = CameraPosition(
//                                   //   target: LatLng(
//                                   //       currentLocation.latitude.value,
//                                   //       currentLocation.longitude.value),
//                                   //   zoom: 15.0,
//                                   // );
//                                   initialLocation = CameraPosition(
//                                     target: LatLng(
//                                         0.0,
//                                         0.0, ),
//                                     zoom: 15.0,
//                                   );

//                                   _currentAddress = '';

//                                   startAddressController.clear();
//                                   destinationAddressController.clear();

//                                   _startAddress = '';
//                                   _destinationAddress = '';
//                                   _placeDistance = null;

//                                   markers = {};

//                                   polylinePoints;
//                                   polylines = {};
//                                   polylineCoordinates = [];

//                                   onTapThreePointButton = false;

//                                   Get.toNamed('/createNewRouteView');
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: AppConstants().ltMainRed,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                 ),
//                                 fixedSize: Size(290.w, 50.h),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(8.w),
//                                 child: Text(
//                                   "Rota Oluştur",
//                                   style: TextStyle(
//                                     fontFamily: "Sfsemidold",
//                                     fontSize: 16.sp,
//                                     color: AppConstants().ltWhite,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 onTapThreePointButton =
//                                     !onTapThreePointButton;
//                               });
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(right: 10.w),
//                               child: CustomButtonDesign(
//                                 color: AppConstants().ltMainRed,
//                                 height: 50.h,
//                                 iconPath: '',
//                                 text: onTapThreePointButton == false
//                                     ? '...'
//                                     : 'X',
//                                 textColor: AppConstants().ltMainRed,
//                                 width: 50.w,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Visibility(
//                       visible: onTapThreePointButton,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                           left: 10.w,
//                           right: 10.w,
//                           top: 10.h,
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             setState(() {
//                               initialLocation = CameraPosition(
//                                     target: LatLng(
//                                         0.0,
//                                         0.0, ),
//                                     zoom: 15.0,
//                                   );
//                               // initialLocation = CameraPosition(
//                               //   target: LatLng(currentLocation.latitude.value,
//                               //       currentLocation.longitude.value),
//                               //   zoom: 15.0,
//                               // );

//                               _currentAddress = '';

//                               startAddressController.clear();
//                               destinationAddressController.clear();

//                               _startAddress = '';
//                               _destinationAddress = '';
//                               _placeDistance = null;

//                               markers = {};

//                               polylinePoints;
//                               polylines = {};
//                               polylineCoordinates = [];

//                               onTapThreePointButton = false;

//                               Get.toNamed('/findSimilarRoutesPageView');
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: AppConstants().ltMainRed,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.r),
//                             ),
//                             fixedSize: Size(Get.width, 50.h),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(8.w),
//                             child: Text(
//                               "Kesişen Rotaları Bul",
//                               style: TextStyle(
//                                 fontFamily: "Sfsemidold",
//                                 fontSize: 16.sp,
//                                 color: AppConstants().ltWhite,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(24.h),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppConstants().ltWhite,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(8.r),
//                 ),
//               ),
//               width: 340.w,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     _textField(
//                         hint: 'Çıkış noktasını giriniz',
//                         controller: startAddressController,
//                         focusNode: startAddressFocusNode,
//                         width: Get.width,
//                         locationCallback: (String value) {
//                           setState(() {
//                             _startAddress = value;
//                           });
//                         }),
//                     10.h.spaceY,
//                     _textField(
//                       hint: 'Varış noktasını giriniz',
//                       controller: destinationAddressController,
//                       focusNode: desrinationAddressFocusNode,
//                       width: Get.width,
//                       locationCallback: (String value) {
//                         setState(
//                           () {
//                             _destinationAddress = value;
//                           },
//                         );
//                       },
//                     ),
//                     10.h.spaceY,
//                     SizedBox(
//                       width: 300.w,
//                       height: 50.h,
//                       child: ElevatedButton(
//                         onPressed: (_startAddress != '' &&
//                                 _destinationAddress != '')
//                             ? () async {
//                                 startAddressFocusNode.unfocus();
//                                 desrinationAddressFocusNode.unfocus();
//                                 setState(
//                                   () {
//                                     if (markers.isNotEmpty) markers.clear();
//                                     if (polylines.isNotEmpty)
//                                       polylines.clear();
//                                     if (polylineCoordinates.isNotEmpty)
//                                       polylineCoordinates.clear();
//                                     _placeDistance = null;
//                                   },
//                                 );
//                                 _calculateDistance().then(
//                                   (isCalculated) {
//                                     if (isCalculated) {
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                           content: Text(
//                                             'Bir hata oluştu! Lütfen tekrar deneyiniz.',
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                 );
//                               }
//                             : null,
//                         style: ElevatedButton.styleFrom(
//                           primary: AppConstants().ltMainRed,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(8.w),
//                           child: Text(
//                             "Rota Hesapla",
//                             style: TextStyle(
//                               fontFamily: "Sfsemidold",
//                               fontSize: 16.sp,
//                               color: AppConstants().ltWhite,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _textField({
//     required TextEditingController controller,
//     required FocusNode focusNode,
//     required String hint,
//     required double width,
//     required Function(String) locationCallback,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Container(
//         width: 300.w,
//         height: 44.h,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: AppConstants().ltDarkGrey.withOpacity(0.15),
//               spreadRadius: 5.r,
//               blurRadius: 7.r,
//               offset: Offset(0, 3.h), // changes position of shadow
//             ),
//           ],
//         ),
//         child: TextField(
//           cursorColor: AppConstants().ltMainRed,
//           onChanged: (value) {
//             locationCallback(value);
//           },
//           controller: controller,
//           focusNode: focusNode,
//           decoration: InputDecoration(
//             //labelText: label,
//             filled: true,
//             fillColor: AppConstants().ltWhite,
//             hintStyle: TextStyle(
//               fontFamily: "Sflight",
//               fontSize: 14.sp,
//               color: AppConstants().ltDarkGrey,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(8.r),
//               ),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: EdgeInsets.all(15.w),
//             hintText: hint,
//           ),
//           style: TextStyle(
//             fontFamily: "Sflight",
//             fontSize: 14.sp,
//             color: AppConstants().ltBlack,
//           ),
//         ),
//       ),
//     );
//   }

//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         print('CURRENT POS: $_currentPosition');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             // CameraPosition(
//             //   target: LatLng(
//             //     currentLocation.latitude.value,
//             //     currentLocation.longitude.value,
//             //   ),
//             //   zoom: 20,
//             // ),
//             CameraPosition(
//               target: LatLng(
//                 0.0,
//                 0.0,
//               ),
//               zoom: 20,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   _getAddress() async {
//     try {
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition.latitude, _currentPosition.longitude);
//       Placemark place = p[0];
//       setState(() {
//         _currentAddress =
//             "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
//         startAddressController.text = _currentAddress;
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<bool> _calculateDistance() async {
//     try {
//       List<Location> startPlacemark = await locationFromAddress(_startAddress);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(_destinationAddress);
//       double startLatitude = _startAddress == _currentAddress
//           ? _currentPosition.latitude
//           : startPlacemark[0].latitude;

//       double startLongitude = _startAddress == _currentAddress
//           ? _currentPosition.longitude
//           : startPlacemark[0].longitude;

//       double destinationLatitude = destinationPlacemark[0].latitude;

//       double destinationLongitude = destinationPlacemark[0].longitude;

//       String startCoordinatesString = '($startLatitude, $startLongitude)';
//       String destinationCoordinatesString =
//           '($destinationLatitude, $destinationLongitude)';

//       // Start Location Marker
//       Marker startMarker = Marker(
//         markerId: MarkerId(startCoordinatesString),
//         position: LatLng(startLatitude, startLongitude),
//         infoWindow: InfoWindow(
//           title: 'Start $startCoordinatesString',
//           snippet: _startAddress,
//         ),
//         icon: BitmapDescriptor.fromBytes(
//           customMarkerIconController.currentIcon!,
//         ),
//       );

//       // Destination Location Marker
//       Marker destinationMarker = Marker(
//         markerId: MarkerId(destinationCoordinatesString),
//         position: LatLng(destinationLatitude, destinationLongitude),
//         infoWindow: InfoWindow(
//           title: 'Destination $destinationCoordinatesString',
//           snippet: _destinationAddress,
//         ),
//         icon: BitmapDescriptor.fromBytes(
//           customMarkerIconController.markerIcon!,
//         ),
//       );

//       // Adding the markers to the list
//       markers.add(startMarker);
//       markers.add(destinationMarker);

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
//       // double distanceInMeters = await Geolocator.bearingBetween(
//       //   startLatitude,
//       //   startLongitude,
//       //   destinationLatitude,
//       //   destinationLongitude,
//       // );

//       await _createPolylines(startLatitude, startLongitude, destinationLatitude,
//           destinationLongitude);

//       double totalDistance = 0.0;

//       // Calculating the total distance by adding the distance
//       // between small segments
//       for (int i = 0; i < polylineCoordinates.length - 1; i++) {
//         print("AAAAAAAAA polylineCoordinates.length " +
//             polylineCoordinates.length.toString());
//         totalDistance += _coordinateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude,
//         );
//       }
//       print("AAAAAAAAA polylineCoordinates " + polylineCoordinates.toString());

//       setState(() {
//         _placeDistance = totalDistance.toStringAsFixed(2);
//         print('DISTANCE: $_placeDistance km');
//       });

//       return true;
//     } catch (e) {
//       print(e);
//     }
//     print("AAAAAAAAA  222222");
//     return false;
//   }

//   // Formula for calculating distance between two coordinates
//   // https://stackoverflow.com/a/54138876/11910277
//   double _coordinateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   _createPolylines(
//     double startLatitude,
//     double startLongitude,
//     double destinationLatitude,
//     double destinationLongitude,
//   ) async {
//     polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       Secrets.apiKey,
//       PointLatLng(startLatitude, startLongitude),
//       PointLatLng(destinationLatitude, destinationLongitude),
//       travelMode: TravelMode.walking,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }

//     PolylineId id = PolylineId('1');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: AppConstants().ltMainRed,
//       points: polylineCoordinates,
//       width: 4,
//     );
//     polylines[id] = polyline;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
// }

// class Secrets {
//   // Add your Google Maps API Key here
//   static const apiKey = 'AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8';
// }
