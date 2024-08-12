// import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
// import 'package:fillogo/controllers/map/marker_icon_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';
// import 'package:fillogo/widgets/custom_button_design.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:math' show cos, sqrt, asin;

// import 'package:intl/intl.dart';

// import '../../controllers/map/get_current_location_and_listen.dart';

// class CreateNewRoutePageView extends StatefulWidget {
//   const CreateNewRoutePageView({super.key});

//   @override
//   _CreateNewRoutePageViewState createState() => _CreateNewRoutePageViewState();
// }

// TextEditingController _controller1 = TextEditingController();
// TextEditingController _controller2 = TextEditingController();
// TextEditingController _controller3 = TextEditingController();
// //RouteCalculatesViewController currentLocation = Get.find();
// GetMyCurrentLocationController getMyCurrentLocationController =
//     Get.find<GetMyCurrentLocationController>();

// SetCustomMarkerIconController customMarkerIconController = Get.find();

// BottomNavigationBarController bottomNavigationBarController =
//     Get.find<BottomNavigationBarController>();

// StartEndAdressController startEndAdressController =
//     Get.find<StartEndAdressController>();

// class _CreateNewRoutePageViewState extends State<CreateNewRoutePageView> {
//   DateTime firstDateTimeController = DateTime.now();
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//     _getAddress();
//     if (markers.isNotEmpty) markers.clear();
//     if (polylines.isNotEmpty) polylines.clear();
//     if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
//     _placeDistance = null;
//     _calculateDistance().then(
//       (isCalculated) {
//         if (isCalculated) {
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                 'Bir hata oluştu! Lütfen tekrar deneyiniz.',
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   CameraPosition initialLocation = CameraPosition(
//     target: LatLng(getMyCurrentLocationController.myLocationLatitudeDo.value,
//         getMyCurrentLocationController.myLocationLongitudeDo.value),
//     zoom: 15.0,
//   );
//   late GoogleMapController mapController;

//   late Position _currentPosition;
//   String _currentAddress = '';

//   String _startAddress = startEndAdressController.startAdress.value;
//   final String _destinationAddress = startEndAdressController.endAdress.value;
//   String? _placeDistance;

//   Set<Marker> markers = {};

//   late PolylinePoints polylinePoints;
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];

//   bool onTapThreePointButton = false;

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
//         title: Text(
//           "Yeni Rota Oluştur",
//           style: TextStyle(
//             fontFamily: "Sfbold",
//             fontSize: 20.sp,
//             color: AppConstants().ltBlack,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             20.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: Container(
//                 height: 70.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.r,
//                     ),
//                   ),
//                   color: AppConstants().ltWhiteGrey,
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 290.w,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10.w,
//                             ),
//                             child: SvgPicture.asset(
//                               'assets/icons/route-icon.svg',
//                               height: 40.w,
//                               width: 40.w,
//                               color: AppConstants().ltMainRed,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   'Ahmet Pehlivan',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 4.w,
//                                   right: 10.w,
//                                 ),
//                                 child: Text(
//                                   "${startEndAdressController.startAdress.value} -> ${startEndAdressController.endAdress.value}",
//                                   style: TextStyle(
//                                     fontFamily: 'Sfmedium',
//                                     fontSize: 14.sp,
//                                     color: AppConstants().ltLogoGrey,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   top: 2.w,
//                                   left: 4.w,
//                                   right: 4.w,
//                                 ),
//                                 child: Text(
//                                   'Tahmini: 741 km ve 9 Saat 46 Dakika',
//                                   style: TextStyle(
//                                     fontFamily: 'Sflight',
//                                     fontSize: 12.sp,
//                                     color: AppConstants().ltDarkGrey,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             // Map View
//             SizedBox(
//               height: 260.h,
//               width: Get.width,
//               child: GoogleMap(
//                 markers: Set<Marker>.from(markers),
//                 initialCameraPosition: initialLocation,
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: false,
//                 mapType: MapType.normal,
//                 zoomGesturesEnabled: true,
//                 zoomControlsEnabled: true,
//                 polylines: Set<Polyline>.of(polylines.values),
//                 onMapCreated: (GoogleMapController controller) {
//                   mapController = controller;
//                 },
//               ),
//             ),
//             20.h.spaceY,
//             SizedBox(
//               width: 340.w,
//               child: Text(
//                 'Çıkış Tarihi:',
//                 style: TextStyle(
//                   fontFamily: 'Sfbold',
//                   fontSize: 16.sp,
//                   color: AppConstants().ltLogoGrey,
//                 ),
//               ),
//             ),
//             3.h.spaceY,
//             SizedBox(
//               width: 340.w,
//               child: Text(
//                 'Belirlenen rotaya ne zaman başlayacaksın?',
//                 style: TextStyle(
//                   fontFamily: 'Sflight',
//                   fontSize: 12.sp,
//                   color: AppConstants().ltLogoGrey,
//                 ),
//               ),
//             ),
//             10.h.spaceY,
//             Container(
//               width: 340.w,
//               height: 50.h,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppConstants().ltDarkGrey.withOpacity(0.15),
//                     spreadRadius: 5.r,
//                     blurRadius: 7.r,
//                     offset: Offset(0, 3.h),
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 readOnly: true,
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     locale: const Locale("tr", "TR"),
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2101),
//                     builder: (context, child) {
//                       return Theme(
//                         data: ThemeData.light().copyWith(
//                           primaryColor: AppConstants().ltMainRed,
//                           colorScheme: ColorScheme.light(
//                             primary: AppConstants().ltMainRed,
//                             secondary: AppConstants().ltLogoGrey,
//                           ),
//                           buttonTheme: const ButtonThemeData(
//                               textTheme: ButtonTextTheme.primary),
//                         ),
//                         child: child!,
//                       );
//                     },
//                   );

//                   if (pickedDate != null) {
//                     String formattedDate =
//                         DateFormat('dd/MM/yyyy').format(pickedDate);

//                     setState(() {
//                       _controller1.text = formattedDate;
//                       firstDateTimeController = pickedDate;
//                       _controller2.clear();
//                     });
//                   } else {}
//                 },
//                 controller: _controller1,
//                 cursorColor: AppConstants().ltMainRed,
//                 decoration: InputDecoration(
//                   counterText: "",
//                   filled: true,
//                   fillColor: AppConstants().ltWhite,
//                   hintStyle: TextStyle(
//                     fontFamily: "Sflight",
//                     fontSize: 14.sp,
//                     color: AppConstants().ltDarkGrey,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8.r),
//                     ),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.all(15.w),
//                   hintText: 'Çıkış tarihi giriniz',
//                 ),
//                 style: TextStyle(
//                   fontFamily: "Sflight",
//                   fontSize: 14.sp,
//                   color: AppConstants().ltBlack,
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             SizedBox(
//               width: 340.w,
//               child: Text(
//                 'Varış Tarihi:',
//                 style: TextStyle(
//                   fontFamily: 'Sfbold',
//                   fontSize: 16.sp,
//                   color: AppConstants().ltLogoGrey,
//                 ),
//               ),
//             ),
//             3.h.spaceY,

//             SizedBox(
//               width: 340.w,
//               child: Text(
//                 'Yolculuğun ne zaman son bulacak?',
//                 style: TextStyle(
//                   fontFamily: 'Sflight',
//                   fontSize: 12.sp,
//                   color: AppConstants().ltLogoGrey,
//                 ),
//               ),
//             ),
//             10.h.spaceY,
//             Container(
//               width: 340.w,
//               height: 50.h,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppConstants().ltDarkGrey.withOpacity(0.15),
//                     spreadRadius: 5.r,
//                     blurRadius: 7.r,
//                     offset: Offset(0, 3.h), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 readOnly: true,
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     locale: const Locale("tr", "TR"),
//                     context: context,
//                     initialDate: firstDateTimeController,
//                     firstDate: firstDateTimeController,
//                     lastDate: DateTime(2101),
//                     builder: (context, child) {
//                       return Theme(
//                         data: ThemeData.light().copyWith(
//                           primaryColor: AppConstants().ltMainRed,
//                           colorScheme: ColorScheme.light(
//                             primary: AppConstants().ltMainRed,
//                             secondary: AppConstants().ltLogoGrey,
//                           ),
//                           buttonTheme: const ButtonThemeData(
//                               textTheme: ButtonTextTheme.primary),
//                         ),
//                         child: child!,
//                       );
//                     },
//                   );

//                   if (pickedDate != null) {
//                     String formattedDate =
//                         DateFormat('dd/MM/yyyy').format(pickedDate);

//                     setState(() {
//                       _controller2.text = formattedDate;
//                     });
//                   } else {
//                     //print("Date is not selected");
//                   }
//                 },
//                 cursorColor: AppConstants().ltMainRed,
//                 controller: _controller2,
//                 decoration: InputDecoration(
//                   counterText: "",
//                   //labelText: label,
//                   filled: true,
//                   fillColor: AppConstants().ltWhite,
//                   hintStyle: TextStyle(
//                     fontFamily: "Sflight",
//                     fontSize: 14.sp,
//                     color: AppConstants().ltDarkGrey,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8.r),
//                     ),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.all(15.w),
//                   hintText: 'Varış tarihi giriniz',
//                 ),
//                 style: TextStyle(
//                   fontFamily: "Sflight",
//                   fontSize: 14.sp,
//                   color: AppConstants().ltBlack,
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             SizedBox(
//               width: 340.w,
//               child: Text(
//                 'Araç Bilgileri:',
//                 style: TextStyle(
//                   fontFamily: 'Sfbold',
//                   fontSize: 16.sp,
//                   color: AppConstants().ltLogoGrey,
//                 ),
//               ),
//             ),
//             3.h.spaceY,
//             SizedBox(
//               width: 340.w,
//               child: Row(
//                 children: [
//                   Text(
//                     'Yolculuğa çıkılacak araç: ',
//                     style: TextStyle(
//                       fontFamily: 'Sflight',
//                       fontSize: 12.sp,
//                       color: AppConstants().ltLogoGrey,
//                     ),
//                   ),
//                   Text(
//                     'Mercedes Benz / 2018',
//                     style: TextStyle(
//                       fontFamily: 'Sfbold',
//                       fontSize: 12.sp,
//                       color: AppConstants().ltLogoGrey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             3.h.spaceY,
//             SizedBox(
//               width: 340.w,
//               child: Text(
//                 'Aracının doluluk oranını % kaç? Arkadaşların için bu bilgi çok önemli!',
//                 style: TextStyle(
//                   fontFamily: 'Sflight',
//                   fontSize: 12.sp,
//                   color: AppConstants().ltLogoGrey,
//                 ),
//               ),
//             ),
//             10.h.spaceY,
//             Container(
//               width: 340.w,
//               height: 50.h,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppConstants().ltDarkGrey.withOpacity(0.15),
//                     spreadRadius: 5.r,
//                     blurRadius: 7.r,
//                     offset: Offset(0, 3.h), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 // onChanged: (value) {
//                 //   _controller3.text = "%";
//                 // },
//                 keyboardType: TextInputType.number,
//                 maxLength: 2,
//                 cursorColor: AppConstants().ltMainRed,
//                 controller: _controller3,
//                 decoration: InputDecoration(
//                   counterText: '',
//                   filled: true,
//                   fillColor: AppConstants().ltWhite,
//                   hintStyle: TextStyle(
//                     fontFamily: "Sflight",
//                     fontSize: 14.sp,
//                     color: AppConstants().ltDarkGrey,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8.r),
//                     ),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.all(15.w),
//                   hintText: 'Doluluk oranı giriniz',
//                 ),
//                 style: TextStyle(
//                   fontFamily: "Sflight",
//                   fontSize: 14.sp,
//                   color: AppConstants().ltBlack,
//                 ),
//               ),
//             ),
//             20.h.spaceY,
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 16.w),
//               child: GestureDetector(
//                 onTap: () async {
//                   _controller1.clear();
//                   _controller2.clear();
//                   _controller3.clear();

//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) =>
//                         showNewAllertDialog(context),
//                   );
//                 },
//                 child: Container(
//                   height: 50.h,
//                   width: 340.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         8.r,
//                       ),
//                     ),
//                     color: AppConstants().ltMainRed,
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Rotayı Oluştur',
//                       style: TextStyle(
//                         fontFamily: 'Sfbold',
//                         fontSize: 16.sp,
//                         color: AppConstants().ltWhite,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             40.h.spaceY,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget showNewAllertDialog(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         'Tebrikler',
//         style: TextStyle(
//           fontFamily: 'Sfsemibold',
//           fontSize: 16.sp,
//           color: AppConstants().ltLogoGrey,
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Column(
//             children: [
//               Text(
//                 "Rotanız başarıyla oluşturuldu.",
//                 style: TextStyle(
//                   fontFamily: 'Sfregular',
//                   fontSize: 16.sp,
//                   color: AppConstants().ltDarkGrey,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           Text(
//             "Rotanız başarıyla oluşturuldu. Yeni rotanızı duvarınızda yayınlamak ve arkadaşlarınız ile paylaşmak ister misiniz?",
//             style: TextStyle(
//               fontFamily: 'Sfregular',
//               fontSize: 14.sp,
//               color: AppConstants().ltLogoGrey,
//             ),
//           ),
//           10.h.spaceY,
//           Text(
//             "Rotayı paylaşmak istemezseniz arkadaşlarınız ve diğer kullanıcılar rota araması yaparak rotanızı görüntüleyebilecek.",
//             style: TextStyle(
//               fontFamily: 'Sfregular',
//               fontSize: 14.sp,
//               color: AppConstants().ltLogoGrey,
//             ),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
//               child: CustomButtonDesign(
//                 text: 'Rotayı Paylaş',
//                 textColor: AppConstants().ltWhite,
//                 onpressed: () {
//                   bottomNavigationBarController.selectedIndex.value = 0;
//                   Get.back();
//                   Get.back();
//                   Get.toNamed(NavigationConstants.createPostPage);
//                 },
//                 iconPath: '',
//                 color: AppConstants().ltMainRed,
//                 height: 50.h,
//                 width: 341.w,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
//               child: CustomButtonDesign(
//                 text: 'Rotayı Paylaşma',
//                 textColor: AppConstants().ltWhite,
//                 onpressed: () {
//                   bottomNavigationBarController.selectedIndex.value = 0;
//                   Get.back();
//                   Get.back();
//                 },
//                 iconPath: '',
//                 color: AppConstants().ltDarkGrey,
//                 height: 50.h,
//                 width: 341.w,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   _getCurrentLocation() async {
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         _currentPosition = position;
//         //print('CURRENT POS: $_currentPosition');
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(
//                 getMyCurrentLocationController.myLocationLatitudeDo.value,
//                 getMyCurrentLocationController.myLocationLongitudeDo.value,
//               ),
//               zoom: 15,
//             ),
//           ),
//         );
//       });
//       await _getAddress();
//     }).catchError((e) {
//       //print(e);
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
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       //print(e);
//     }
//   }

//   Future<bool> _calculateDistance() async {
//     try {
//       List<Location> startPlacemark = await locationFromAddress(_startAddress);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(_destinationAddress);
//       // Use the retrieved coordinates of the current position,
//       // instead of the address if the start position is user's
//       // current position, as it results in better accuracy.
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
//           customMarkerIconController.myRouteStartIcon!,
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
//           customMarkerIconController.myRouteFinishIcon!,
//         ),
//       );

//       // Adding the markers to the list
//       markers.add(startMarker);
//       markers.add(destinationMarker);

//       // print(
//       //   'START COORDINATES: ($startLatitude, $startLongitude)',
//       // );
//       // print(
//       //   'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
//       // );

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
//         //print("AAAAAAAAA polylineCoordinates.length " +
//         //polylineCoordinates.length.toString());
//         totalDistance += _coordinateDistance(
//           polylineCoordinates[i].latitude,
//           polylineCoordinates[i].longitude,
//           polylineCoordinates[i + 1].latitude,
//           polylineCoordinates[i + 1].longitude,
//         );
//       }
//       //print("AAAAAAAAA polylineCoordinates " + polylineCoordinates.toString());

//       setState(() {
//         _placeDistance = totalDistance.toStringAsFixed(2);
//         //print('DISTANCE: $_placeDistance km');
//       });

//       return true;
//     } catch (e) {
//       //print(e);
//     }
//     //print("AAAAAAAAA  222222");
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
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     }

//     PolylineId id = const PolylineId('1');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: AppConstants().ltMainRed,
//       points: polylineCoordinates,
//       width: 4,
//     );
//     polylines[id] = polyline;
//   }
// }

// class Secrets {
//   // Add your Google Maps API Key here
//   static const apiKey = 'AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8';
// }
