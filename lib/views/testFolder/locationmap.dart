// import 'package:dio/dio.dart';
// import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/testFolder/directionsrepository.dart';
// import 'package:fillogo/views/testFolder/locationprovider.dart';
// import 'package:fillogo/views/testFolder/taskdetail.dart';
// import 'package:flutter/foundation.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class LocationMap extends StatefulWidget {
//   LocationMap(TaskDetail taskDetail) {
//     taskDetails = taskDetail;
//   }

//   @override
//   _LocationMapState createState() => _LocationMapState();
// }

// TaskDetail? taskDetails;
// bool _showCardView = true; //this is to map destination Info

// Color myHexColor = Color(0xff003499);
// String _timeString = "";

// String _formatDateTime(DateTime dateTime) {
//   return DateFormat('E | MMMM d, yyyy | hh:mm a').format(dateTime);
// }

// class _LocationMapState extends State<LocationMap> {

//   RouteCalculatesViewController currentLocationController = Get.find();
//   @override
//   void initState() {
//     super.initState();
//     _timeString = _formatDateTime(DateTime.now());
//     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//     Provider.of<LocationProvider>(context, listen: false).initialization();
//   }

//   void _getTime() {
//     final DateTime now = DateTime.now();
//     final String formattedDateTime = _formatDateTime(now);
//     setState(() {
//       _timeString = formattedDateTime;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       child: Container(
//         child: googleMapUI(),
//       ),
//       onWillPop: () {
//         return Future.value(true); // if true allow back else block it
//       },
//     );
//   }

//   static const String _baseUrl =
//       'https://maps.googleapis.com/maps/api/directions/json?';

//   Dio _dio = Dio();
//   final Set<Polyline> _polyline = {};
//   LatLng? origin;
//   LatLng? dest;
//   Widget googleMapUI() {
//     List<LatLng> latLen = [
//       LatLng(currentLocationController.latitude.value,
//           currentLocationController.longitude.value),
//       LatLng(currentLocationController.latitude.value + 0.0005,
//           currentLocationController.longitude.value + 0.0005),
//     ];
//     return Consumer<LocationProvider>(builder: (consumerContext, model, child) {
//       if (model.locationPosition != null) {
//         return GoogleMap(
//           onTap: (argument) {
//             setState(() {
//               currentLocationController.directionLatitude.value =
//                   argument.latitude;
//               currentLocationController.directionLongitude.value =
//                   argument.longitude;
//               DirectionsRepository()
//                   .getDirections(origin: origin!, destination: dest!);
//             });
//           },
//           gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
//             new Factory<OneSequenceGestureRecognizer>(
//               () => new EagerGestureRecognizer(),
//             ),
//           ].toSet(),
//           mapType: MapType.normal,
//           initialCameraPosition: CameraPosition(
//             target: model.locationPosition!,
//             zoom: 15,
//           ),
//           myLocationEnabled: true,
//           myLocationButtonEnabled: false,
//           markers: Set<Marker>.of(model.markers!.values),
//           polylines: Set<Polyline>.of(model.polylines.values),
//           onMapCreated: (GoogleMapController controller) async {
//             Provider.of<LocationProvider>(context, listen: false)
//                 .setMapController(controller);
//           },
//         );
//       }

//       return Container(
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     });
//   }
// }
