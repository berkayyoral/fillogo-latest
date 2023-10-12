// import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
// import 'package:fillogo/controllers/map/marker_icon_controller.dart';
// import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/services/general_sevices_template/general_services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../../controllers/map/get_current_location_and_listen.dart';
// import 'map_page_controller.dart';

// class MapCreate extends StatelessWidget {
//   MapCreate({Key? key}) : super(key: key);

//   final SetCustomMarkerIconController setCustomMarkerIconController =
//       Get.find();
//   final RouteCalculatesViewController routeCalculatesViewController =
//       Get.find();

//   // final MapPageMyRouteController mapPageMyRouteController =
//   //     Get.find<MapPageMyRouteController>();

//   final MapPageController mapPageControllerMapCreate =
//       Get.find<MapPageController>();

//   final GetMyCurrentLocationController getMyCurrentLocationController =
//       Get.find<GetMyCurrentLocationController>();

//   //RouteCalculatesViewController currentLocation = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialLocation = CameraPosition(
//       target: LatLng(getMyCurrentLocationController.myLocationLatitudeDo.value,
//           getMyCurrentLocationController.myLocationLongitudeDo.value),
//       zoom: 15.0,
//     );
//     return GetBuilder<GetMyCurrentLocationController>(
//       init: getMyCurrentLocationController,
//       initState: (_) {},
//       builder: (getMyCurrentLocationController) {
//         return Scaffold(
//           body: routeCalculatesViewController.latitude.value == 0.0
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : GoogleMap(
//                   markers: Set<Marker>.from(mapPageControllerMapCreate.markers),
//                   initialCameraPosition: initialLocation,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   mapType: MapType.normal,
//                   zoomGesturesEnabled: true,
//                   zoomControlsEnabled: true,
//                   polylines: Set<Polyline>.of(
//                       mapPageControllerMapCreate.polylines.values),
//                   onMapCreated: (GoogleMapController controller) {
//                     mapPageControllerMapCreate.createRouteMapController =
//                         controller;
//                   },
//                 ),
//         );
//       },
//     );
//   }
// }
