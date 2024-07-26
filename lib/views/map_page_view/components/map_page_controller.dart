// import 'dart:async';
// import 'dart:developer';
// import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
// import 'package:fillogo/models/routes_models/get_users_on_area.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'dart:convert' as convert;
// import '../../../controllers/map/get_current_location_and_listen.dart';
// import '../../../controllers/map/marker_icon_controller.dart';
// import '../../../export.dart';
// import '../../../models/routes_models/get_my_routes_model.dart';
// import '../../../services/general_sevices_template/general_services.dart';
// import '../../testFolder/test19/route_api_models.dart';

// class MapPageController extends GetxController {
//   SetCustomMarkerIconController customMarkerIconController = Get.find();
//   GetMyCurrentLocationController getMyCurrentLocationController =
//       Get.find<GetMyCurrentLocationController>();

//   late Timer timer;

//   @override
//   void onInit() async {
//     print("MAPPAGECONTROLER CREATE");

//     await getMyRoutesServicesRequestRefreshable();
//     // await updateMyLocationMarkers(); //NEWMAP
//     super.onInit();
//   }

//   RxBool isLoading = false.obs;
//   /* Rx<CameraPosition> cameraPosition(animateLat,animateLong) {
//     Rx<CameraPosition> cameraPosition =
//         CameraPosition(
//            bearing: 90,
//                   tilt: 45,
//                    zoom: 14,
//           target: LatLng(animateLat.value, animateLong.value)).obs;
//     return cameraPosition;
//   }
//   */
//   var myNameAndSurname = "".obs;
//   var myUserId = 0.obs;

//   RxList<String> filterCarType = <String>[].obs;

//   RxString differentTime = "".obs;
//   RxString dateTimeFormatCikis = "".obs;
//   RxString dateTimeFormatVaris = "".obs;
//   var dateTimeFormatLast = DateTime.now().obs;

//   List<MyRoutesDetails>? myActivesRoutes;
  // List<MyRoutesDetails>? myPastsRoutes;
  // List<MyRoutesDetails>? mynotStartedRoutes;

//   TextEditingController cikisController = TextEditingController();
//   TextEditingController varisController = TextEditingController();
//   TextEditingController kapasiteController = TextEditingController();
//   TextEditingController aciklamaController = TextEditingController(text: "");

//   RxBool isRouteVisibilty = true.obs;
//   RxBool isRouteAvability = true.obs;

//   var iWantTrackerMyLocation = 0.obs;
//   var selectedDispley = 0.obs;
//   var calculateLevel = 1.obs;
//   RxString formattedDate = ''.obs;
//   Rx<DateTime?> pickedDate = DateTime.now().obs;

//   var calculatedRouteDistance = "".obs;
//   var calculatedRouteTime = "".obs;
//   int calculatedRouteDistanceInt = 0;
//   int calculatedRouteTimeInt = 0;

//   Completer<GoogleMapController> mapCotroller3 = Completer();
//   // GoogleMapController mapController;
//   GoogleMapsPlaces googleMapsPlaces =
//       GoogleMapsPlaces(apiKey: AppConstants.googleMapsApiKey);

//   PolylineId generalPolylineId = const PolylineId('1');
//   PolylineId generalPolylineId2 = const PolylineId('2');
//   PolylineId rotationPolyline = const PolylineId('3');
//   var selectedPolyline = 1.obs;

//   PolylinePoints polylinePoints = PolylinePoints();
//   Set<Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<Polyline> polyliness = [];
//   List<LatLng> polylineCoordinates = [];

//   PolylinePoints polylinePoints2 = PolylinePoints();
//   Set<Marker> markers2 = {};
//   Set<Marker> markers3 = {};
//   Map<PolylineId, Polyline> polylines2 = {};
//   List<LatLng> polylineCoordinates2 = [];

//   List<List<double>> polylineCoordinatesListForB = [];
//   var generalPolylineEncode = "".obs;
//   var generalPolylineEncode2 = "".obs;
//   var generalPolylineEncodeForB = "".obs;

//   var mapPageRouteStartAddress = "".obs;
//   var mapPageRouteStartLatitude = 0.0.obs;
//   var mapPageRouteStartLongitude = 0.0.obs;
//   var mapPageRouteFinishAddress = "".obs;
//   var mapPageRouteFinishLatitude = 0.0.obs;
//   var mapPageRouteFinishLongitude = 0.0.obs;

//   var mapPageRouteStartAddress2 = "".obs;
//   var mapPageRouteStartLatitude2 = 0.0.obs;
//   var mapPageRouteStartLongitude2 = 0.0.obs;
//   var mapPageRouteFinishAddress2 = "".obs;
//   var mapPageRouteFinishLatitude2 = 0.0.obs;
//   var mapPageRouteFinishLongitude2 = 0.0.obs;

//   var startCity = "".obs;
//   var startLatLong = const LatLng(0.0, 0.0);
//   var finishCity = "".obs;
//   var finishLatLong = const LatLng(0.0, 0.0);

//   late StreamSubscription<Position> streamSubscriptionForMyMarker;

//   List<Matching?> myFriendsLocations = [];
//   List<GetMyFriendsMatchingResDatum?> myFriendsLocationsMatching = [];
//   List<GetUsersOnAreaResDatum?> usersOnArea = [];
//   AllRoutes? myAllRoutes;

//   void changeCalculateLevel(int newCalculateLevel) {
//     calculateLevel.value = newCalculateLevel;
//     update(["mapPageController"]);
//   }

//   void changeSelectedDispley(int newSelectedDispley) {
//     selectedDispley.value = newSelectedDispley;
//     update(["mapPageController"]);
//   }

//   void mapPageRouteControllerClear() async {
//     iWantTrackerMyLocation.value = 1;
//     kapasiteController.clear();
//     aciklamaController.clear();

//     calculateLevel.value = 1;
//     finishCity = "".obs;
//     startCity = "".obs;
//     Timer? timer;
//     mapPageRouteStartAddress2.value = "";
//     mapPageRouteStartLatitude2.value = 0.0;
//     mapPageRouteStartLongitude2.value = 0.0;
//     mapPageRouteFinishAddress2.value = "";
//     mapPageRouteFinishLatitude2.value = 0.0;
//     mapPageRouteFinishLongitude2.value = 0.0;

//     startLatLong = const LatLng(0.0, 0.0);
//     finishLatLong = const LatLng(0.0, 0.0);

//     calculatedRouteDistance.value = "";
//     calculatedRouteTime.value = "";

//     polyliness.clear();

//     polylinePoints2 = PolylinePoints();
//     markers2.clear();
//     markers3.clear();
//     polylines2.clear();
//     polylineCoordinates2 = [];
//     generalPolylineEncode2.value = "";

//     SetCustomMarkerIconController controller =
//         Get.put(SetCustomMarkerIconController());
//     await controller.setCustomMarkerIcon3();
//     addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myLocationMarker"),
//       LatLng(
//         getMyCurrentLocationController.myLocationLatitudeDo.value,
//         getMyCurrentLocationController.myLocationLongitudeDo.value,
//       ),
//       mapPageRouteStartAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
//     );
//     addMarkerFunctionForMapPageWithoutOnTap(
//       const MarkerId("myLocationMarker"),
//       LatLng(
//         getMyCurrentLocationController.myLocationLatitudeDo.value,
//         getMyCurrentLocationController.myLocationLongitudeDo.value,
//       ),
//       mapPageRouteStartAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
//     );
//     update(["mapPageController"]);
//   }

//   getUsersOnArea(
//       {required BuildContext context, required List<String>? carType}) async {
//     try {
//       print("ONAREA CARTYPE -> ${carType}");
//       await GeneralServicesTemp().makePostRequest(
//         EndPoint.getUsersOnArea,
//         {
//           "filter": carType,
//           "radius": 190000,
//           "visibility": true,
//           "availability": true
//         },
//         {
//           "Content-type": "application/json",
//           'Authorization':
//               'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
//         },
//       ).then((value) async {
//         UsersOnAreaModel response =
//             UsersOnAreaModel.fromJson(convert.json.decode(value!));

//         print("ONAREA  Success = ${response.succes}");

//         usersOnArea = response.data!.first;
//         print("ONAREA  LENGT ->  = ${usersOnArea.length}");
//         for (var i = 0; i < usersOnArea.length; i++) {
//           if (usersOnArea[i]!.userId !=
//               LocaleManager.instance.getInt(PreferencesKeys.currentUserId)) {
//             String carType = usersOnArea[i]!
//                 .usertousercartypes!
//                 .first
//                 .cartypetousercartypes!
//                 .carType!;
//             String iconPath = carType == "Otomobil"
//                 ? 'assets/icons/friendsLocationLightCommercial.png'
//                 : carType == "Tır"
//                     ? 'assets/icons/friendsLocationTruck.png'
//                     : 'assets/icons/friendsLocationMotorcycle.png';
//             // polyliness.add();
//             if (usersOnArea[i]!.userpostroutes!.isNotEmpty) {
//               print("ONAREA ROTASI VAR");
//               Map<String, LatLng> route;
//               route = {
//                 "start": LatLng(
//                     usersOnArea[i]!
//                         .userpostroutes![0]
//                         .startingCoordinates!
//                         .first,
//                     usersOnArea[i]!
//                         .userpostroutes![0]
//                         .startingCoordinates!
//                         .last),
//                 "end": LatLng(
//                     usersOnArea[i]!.userpostroutes![0].endingCoordinates!.first,
//                     usersOnArea[i]!.userpostroutes![0].endingCoordinates!.last)
//               };
//               // _getPolyline(route, i);
//               addMarkerFunctionForMapPage(
//                 usersOnArea[i]!.userId!,
//                 usersOnArea[i]!.userpostroutes!.first.id!,
//                 MarkerId(usersOnArea[i]!.userId.toString()),
//                 LatLng(
//                     usersOnArea[i]!
//                         .userpostroutes!
//                         .first
//                         .polylineDecode!
//                         .first
//                         .first,
//                     usersOnArea[i]!
//                         .userpostroutes!
//                         .first
//                         .polylineDecode!
//                         .first
//                         .last),
//                 BitmapDescriptor.fromBytes(await customMarkerIconController
//                     .getBytesFromAsset(iconPath, 100)),
//                 "${usersOnArea[i]!.name!} ${usersOnArea[i]!.surname!}",
//                 usersOnArea[i]!.userpostroutes![0].departureDate.toString(),
//                 usersOnArea[i]!.userpostroutes![0].arrivalDate.toString(),
//                 usersOnArea[i]!
//                     .usertousercartypes![0]
//                     .cartypetousercartypes!
//                     .carType!,
//                 usersOnArea[i]!.userpostroutes!.first.startingCity!,
//                 usersOnArea[i]!.userpostroutes!.first.endingCity!,
//                 usersOnArea[i]!.userpostroutes!.first.routeDescription ??
//                     "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
//                 usersOnArea[i]!.profilePic!,
//                 context,
//               );
//             } else {
//               ///ROTASI YOKSA
//               print("ONAREA ROTASI YOK");
//               addMarkerFunctionForMapPage(
//                 usersOnArea[i]!.userId!,
//                 usersOnArea[i]!.userpostroutes!.first.id!,
//                 MarkerId(usersOnArea[i]!.userId.toString()),
//                 LatLng(
//                   usersOnArea[i]!.latitude!,
//                   usersOnArea[i]!.longitude!,
//                 ),
//                 BitmapDescriptor.fromBytes(await customMarkerIconController
//                     .getBytesFromAsset(iconPath, 100)),
//                 "${usersOnArea[i]!.name!} ${usersOnArea[i]!.surname!}",
//                 "",
//                 "",
//                 usersOnArea[i]!
//                     .usertousercartypes![0]
//                     .cartypetousercartypes!
//                     .carType!,
//                 "",
//                 "",
//                 "",
//                 usersOnArea[i]!.profilePic!,
//                 context,
//               );
//             }
//           } else {
//             print("ONAREA MATCHİNGROTADATA benim rotam $i");
//             // Map<String, LatLng> route;
//             // route = {
//             //   "start": LatLng(
//             //       myFriendsLocationsMatching.first!.matching![i]
//             //           .userpostroutes![0].startingCoordinates!.first,
//             //       myFriendsLocationsMatching.first!.matching![i]
//             //           .userpostroutes![0].startingCoordinates!.last),
//             //   "end": LatLng(
//             //       myFriendsLocationsMatching.first!.matching![i]
//             //           .userpostroutes![0].endingCoordinates!.first,
//             //       myFriendsLocationsMatching.first!.matching![i]
//             //           .userpostroutes![0].endingCoordinates!.last)
//             // };
//             // _getPolyline(route, i);
//           }
//         }
//       });
//     } catch (e) {
//       print("ONAREA GET USERS ON AREA ERR -> $e");
//     }
//   }

//   getMyFriendsMatchingRoutes(BuildContext context, polylineEncode,
//       {required List<String>? carType}) async {
//     try {
//       print("CARTYPLE MAPPAGEİSLOADMATCHİNG ${carType!.length}");
//       await GeneralServicesTemp().makePostRequest(
//         EndPoint.getMyfriendsMatchingRoutes,
//         GetMyFriendsMatchingRoutesRequest(
//           startingCity: "",
//           endingCity: "",
//           route: polylineEncode,
//           carType: carType,
//         ),
//         {
//           "Content-type": "application/json",
//           'Authorization':
//               'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
//         },
//       ).then(
//         (value) async {
//           print("MATCHİNGROTADATANNNN");
//           GetMyFriendsMatchingRoutesResponse response =
//               GetMyFriendsMatchingRoutesResponse.fromJson(
//                   convert.json.decode(value!));

//           print(
//               "MATCHİNGROTADATA -> ${response.data!.first.matching!.first.usertousercartypes!.first.cartypetousercartypes!.carType}");
//           print("MATCHİNGROTADATA Matching Success = ${response.success}");
//           print("MATCHİNGROTADATA Matching Message = ${response.message}");

//           print(
//               "MATCHİNGROTADATA Matching response data = ${response.data!.length}");

//           myFriendsLocationsMatching = response.data!;
//           print(
//               "MATCHİNGROTADATA userloc -> ${myFriendsLocationsMatching.first!.matching!.first.userpostroutes!.first.userLocation}");
//           for (var i = 0;
//               i < myFriendsLocationsMatching.first!.matching!.length;
//               i++) {
//             if (myFriendsLocationsMatching.first!.matching![i].id! !=
//                 LocaleManager.instance.getInt(PreferencesKeys.currentUserId)) {
//               String carType = myFriendsLocationsMatching.first!.matching![i]
//                   .usertousercartypes!.first.cartypetousercartypes!.carType!;
//               String iconPath = carType == "Otomobil"
//                   ? 'assets/icons/friendsLocationLightCommercial.png'
//                   : carType == "Tır"
//                       ? 'assets/icons/friendsLocationTruck.png'
//                       : 'assets/icons/friendsLocationMotorcycle.png';
//               print("MATCHİNGROTADATA CAR TYPE -> $iconPath");
//               print(
//                   "MATCHİNGROTADATA my fri ${myFriendsLocationsMatching.first!.matching!.length}");
//               // polyliness.add();

//               Map<String, LatLng> route;
//               route = {
//                 "start": LatLng(
//                     myFriendsLocationsMatching.first!.matching![i]
//                         .userpostroutes![0].startingCoordinates!.first,
//                     myFriendsLocationsMatching.first!.matching![i]
//                         .userpostroutes![0].startingCoordinates!.last),
//                 "end": LatLng(
//                     myFriendsLocationsMatching.first!.matching![i]
//                         .userpostroutes![0].endingCoordinates!.first,
//                     myFriendsLocationsMatching.first!.matching![i]
//                         .userpostroutes![0].endingCoordinates!.last)
//               };
//               _getPolyline(route, i);
//               addMarkerFunctionForMapPage(
//                   myFriendsLocationsMatching.first!.matching![i].id!,
//                   myFriendsLocationsMatching
//                       .first!.matching![i].userpostroutes!.first.id!,
//                   MarkerId(myFriendsLocationsMatching.first!.matching![i].id
//                       .toString()),
//                   LatLng(
//                       myFriendsLocationsMatching.first!.matching![i]
//                           .userpostroutes!.first.polylineDecode!.first.first,
//                       myFriendsLocationsMatching.first!.matching![i]
//                           .userpostroutes!.first.polylineDecode!.first.last),
//                   BitmapDescriptor.fromBytes(await customMarkerIconController
//                       .getBytesFromAsset(iconPath, 100)),
//                   "${myFriendsLocationsMatching.first!.matching![i].name!} ${myFriendsLocationsMatching.first!.matching![i].surname!}",
//                   myFriendsLocationsMatching
//                       .first!.matching![i].userpostroutes![0].departureDate
//                       .toString(),
//                   myFriendsLocationsMatching
//                       .first!.matching![i].userpostroutes![0].arrivalDate
//                       .toString(),
//                   myFriendsLocationsMatching.first!.matching![i]
//                       .usertousercartypes![0].cartypetousercartypes!.carType!,
//                   myFriendsLocationsMatching
//                       .first!.matching![i].userpostroutes!.first.startingCity!,
//                   myFriendsLocationsMatching
//                       .first!.matching![i].userpostroutes!.first.endingCity!,
//                   myFriendsLocationsMatching.first!.matching![i].userpostroutes!
//                           .first.routeDescription ??
//                       "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
//                   myFriendsLocationsMatching
//                       .first!.matching![i].profilePicture!,
//                   context);
//             } else {
//               print("MATCHİNGROTADATA benim rotam $i");
//               // Map<String, LatLng> route;
//               // route = {
//               //   "start": LatLng(
//               //       myFriendsLocationsMatching.first!.matching![i]
//               //           .userpostroutes![0].startingCoordinates!.first,
//               //       myFriendsLocationsMatching.first!.matching![i]
//               //           .userpostroutes![0].startingCoordinates!.last),
//               //   "end": LatLng(
//               //       myFriendsLocationsMatching.first!.matching![i]
//               //           .userpostroutes![0].endingCoordinates!.first,
//               //       myFriendsLocationsMatching.first!.matching![i]
//               //           .userpostroutes![0].endingCoordinates!.last)
//               // };

//               // _getPolyline(route, i);
//             }
//           }

//           // for (var i = 0; i < myFriendsLocations.length; i++) {
//           //   print("MATCHİNGROTADATA my fri ${myFriendsLocations.length}");
//           //   addMarkerFunctionForMapPage(
//           //     myFriendsLocations[i]!.followed!.id!,
//           //     MarkerId(myFriendsLocations[i]!.followed!.id.toString()),
//           //     LatLng(
//           //         myFriendsLocations[i]!
//           //             .followed!
//           //             .userpostroutes![0]
//           //             .currentRoute![0],
//           //         myFriendsLocations[i]!
//           //             .followed!
//           //             .userpostroutes![0]
//           //             .currentRoute![1]),
//           //     BitmapDescriptor.fromBytes(
//           //         customMarkerIconController.myFriendsLocation!),
//           //     context,
//           //     "${myFriendsLocations[i]!.followed!.name!} ${myFriendsLocations[i]!.followed!.surname!}",
//           //     myFriendsLocations[i]!
//           //         .followed!
//           //         .userpostroutes![0]
//           //         .departureDate
//           //         .toString(),
//           //     myFriendsLocations[i]!
//           //         .followed!
//           //         .userpostroutes![0]
//           //         .arrivalDate
//           //         .toString(),
//           //     "Tır",
//           //     myFriendsLocations[i]!.followed!.userpostroutes![0].startingCity!,
//           //     myFriendsLocations[i]!.followed!.userpostroutes![0].endingCity!,
//           //     "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
//           //     myFriendsLocations[i]!.followed!.profilePicture!,
//           //   );
//           // }
//         },
//       );
//     } catch (e) {
//       print("MATCHİNGROTADATA GET MATCHİNG ROUTE ERROR -> $e");
//     }
//   }

//   getMyFriendsRoutesRequestRefreshable(BuildContext context) async {
//     await GeneralServicesTemp().makeGetRequest(
//       EndPoint.getMyfriendsRoute,
//       {
//         "Content-type": "application/json",
//         'Authorization':
//             'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
//       },
//     ).then(
//       (value) async {
//         // GetMyFriendsRouteResponseModel getMyFriendsRouteResponseModel =
//         //     GetMyFriendsRouteResponseModel.fromJson(
//         //         convert.json.decode(value!));
//         // myFriendsLocations = getMyFriendsRouteResponseModel.data;
//         // //Anlık arkadaş konumu bağlandı
//         // for (var i = 0; i < myFriendsLocations.length; i++) {
//         //   addMarkerFunctionForMapPage(
//         //     myFriendsLocations[i]!.followed!.id!,
//         //     MarkerId(myFriendsLocations[i]!.followed!.id.toString()),
//         //     LatLng(
//         //         myFriendsLocations[i]!
//         //             .followed!
//         //             .userpostroutes![0]
//         //             .currentRoute![0],
//         //         myFriendsLocations[i]!
//         //             .followed!
//         //             .userpostroutes![0]
//         //             .currentRoute![1]),
//         //     BitmapDescriptor.fromBytes(
//         //         customMarkerIconController.myFriendsLocation!),
//         //     context,
//         //     "${myFriendsLocations[i]!.followed!.name!} ${myFriendsLocations[i]!.followed!.surname!}",
//         //     myFriendsLocations[i]!
//         //         .followed!
//         //         .userpostroutes![0]
//         //         .departureDate
//         //         .toString(),
//         //     myFriendsLocations[i]!
//         //         .followed!
//         //         .userpostroutes![0]
//         //         .arrivalDate
//         //         .toString(),
//         //     "Tır",
//         //     myFriendsLocations[i]!.followed!.userpostroutes![0].startingCity!,
//         //     myFriendsLocations[i]!.followed!.userpostroutes![0].endingCity!,
//         //     "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
//         //     myFriendsLocations[i]!.followed!.profilePicture!,
//         //   );
//         // }
//       },
//     );
//   }

//   getMyRoutesServicesRequestRefreshable() async {
//     mapPageRouteControllerClear();
//     await GeneralServicesTemp().makeGetRequest(
//       EndPoint.getMyRoutes,
//       {
//         "Content-type": "application/json",
//         'Authorization':
//             'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
//       },
//     ).then(
//       (value) async {
//         GetMyRouteResponseModel getMyRouteResponseModel =
//             GetMyRouteResponseModel.fromJson(convert.json.decode(value!));

//         //myAllRoutes = getMyRouteResponseModel.data![0].allRoutes;
//         if (getMyRouteResponseModel.data!.isNotEmpty) {
//           print("DEBUGMODEM -> ${getMyRouteResponseModel.data!}");
//           myActivesRoutes =
//               getMyRouteResponseModel.data![0].allRoutes!.activeRoutes;
//           myPastsRoutes =
//               getMyRouteResponseModel.data![0].allRoutes!.pastRoutes;
//           mynotStartedRoutes =
//               getMyRouteResponseModel.data![0].allRoutes!.notStartedRoutes;
//           isRouteVisibilty.value = myActivesRoutes!.isNotEmpty
//               ? myActivesRoutes!.first.isInvisible!
//                   ? false
//                   : true
//               : true;
//           isRouteAvability.value = myActivesRoutes!.isNotEmpty
//               ? myActivesRoutes!.first.isAvailable!
//               : true;
//           print(
//               "VİSİBİLİTY -> ${isRouteVisibilty.value} avabilty -> ${isRouteAvability.value}");
//         }
//       },
//     );
//     update(["mapPageController"]);
//   }

// //haritada görünen
//   addPointIntoPolylineList(String encodedPolyline) async {
//     List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
//     polylineCoordinates.clear();
//     for (var point in result) {
//       //polylineCoordinatesListForB.add([point.latitude, point.longitude]);
//       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//     }
//     // log("polylineCoordinates1:  ${polylineCoordinates.toString()}");
//     var newPolylineCoordinates = polylineCoordinates.toSet().toList();

//     Polyline polyline = Polyline(
//         polylineId: generalPolylineId,
//         color: selectedPolyline.value != 3
//             ? AppConstants().ltBlue
//             : AppConstants().ltLogoGrey,
//         points: newPolylineCoordinates,
//         width: 11,
//         zIndex: 1);
//     polylines[generalPolylineId] = polyline;
//     polyliness.isEmpty ? polyliness.add(polyline) : polyliness[0] = (polyline);
//     print("MATCHİNGROTADATA benim rotamm ");
//     update(["mapPageController"]);
//   }

// //rotada görünen
//   addPointIntoPolylineList2(String encodedPolyline) async {
//     List<PointLatLng> result = polylinePoints2.decodePolyline(encodedPolyline);

//     for (var point in result) {
//       polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
//     }
//     log("MATCHİNGROTADATA polylineCoordinates2 ben:  ${polylineCoordinates2.length}- ${calculateLevel.value}");
//     log("MATCHİNGROTADATA polylineCoordinates2:  ${polylineCoordinates2.toString()}");
//     var newPolylineCoordinates = polylineCoordinates2.toSet().toList();

//     Polyline polyline = Polyline(
//       polylineId: generalPolylineId,
//       color: selectedPolyline.value != 3
//           ? AppConstants().ltMainRed
//           : AppConstants().ltLogoGrey,
//       points: newPolylineCoordinates,
//       width: 11,
//       zIndex: 1,
//     );
//     polylines2[generalPolylineId2] = polyline;
//     polyliness.isEmpty ? polyliness.add(polyline) : polyliness[0] = (polyline);

//     print(
//         "MATCHİNGROTADATA polylineCoordinates2 benim rotamm ${polyliness.length}");
//     // update(["mapPageController"]);
//   }

//   updatePolyline(LatLng newPoint) {
//     // myAllRoutes!.activeRoutes![0].endingCoordinates![1];
//     mapPageRouteFinishLatitude2.value = finishLatLong.latitude;
//     mapPageRouteFinishLongitude2.value = finishLatLong.longitude;

//     double thresholdDistance = 30.0;
//     // Kullanıcının hedefe olan mesafesini kontrol edin
//     double distanceToDestination = Geolocator.distanceBetween(
//       newPoint.latitude,
//       newPoint.longitude,
//       mapPageRouteFinishLatitude2.value,
//       mapPageRouteFinishLongitude2.value,
//     );

//     log("updatePolyLine:  ${distanceToDestination.toString()}");

//     if (distanceToDestination > thresholdDistance) {
//       drawIntoMapPolyline2();
//       // getMyFriendsRoutesCircular(newPoint);
//     }
//   }

//   updateMyLocationMarkers() async {
//     bool serviceEnabled;

//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     streamSubscriptionForMyMarker =
//         Geolocator.getPositionStream().listen((Position position) async {
//       await updateLocation(lat: position.latitude, long: position.longitude)
//           .then(
//               (value) => print("updateMyLocationMarkers LOCATİON GÜNCELLENDİ"));
//       mapPageRouteStartLatitude2.value = position.latitude;
//       mapPageRouteStartLongitude2.value = position.longitude;
//       if (polylines.isNotEmpty) {
//         updatePolyline(LatLng(position.latitude, position.longitude));
//       }
//       if (polyliness.isNotEmpty) {
//         print("POLYLİNEE -> ");
//         updatePolyline(LatLng(position.latitude, position.longitude));
//       }
//       Marker newMarker1 = markers.firstWhere(
//           (marker) => marker.markerId.value == "myLocationMarker",
//           orElse: () => const Marker(markerId: MarkerId("")));
//       markers.remove(newMarker1);
//       //log("marker myLocationMarker1 silindi: ${newMarker1.markerId.value}");

//       Marker newMarker2 = markers2.firstWhere(
//           (marker) => marker.markerId.value == "myLocationMarker",
//           orElse: () => const Marker(markerId: MarkerId("")));
//       markers2.remove(newMarker2);
//       //log("marker myLocationMarker2 silindi: ${newMarker2.markerId.value}");

//       addMarkerFunctionForMapPageWithoutOnTap2(
//         const MarkerId("myLocationMarker"),
//         LatLng(
//           position.latitude,
//           position.longitude,
//         ),
//         "",
//         BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
//       );
//       //log("marker myLocationMarker2 eklendi");

//       addMarkerFunctionForMapPageWithoutOnTap(
//         const MarkerId("myLocationMarker"),
//         LatLng(
//           position.latitude,
//           position.longitude,
//         ),
//         "",
//         BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
//       );
//       //log("marker myLocationMarker1 eklendi");

//       update(["mapPageController"]);
//     });
//     update(["mapPageController"]);
//   }

//   List<int> friendList = [];
//   //Belirli bir alandaki arkadaşları getiren istek
//   getMyFriendsRoutesCircular(LatLng point) async {
//     // await GeneralServicesTemp()
//     //     .makePostRequest(
//     //         EndPoint.getMyFriendsCircular,
//     //         {"lat": point.latitude, "long": point.longitude},
//     //         ServicesConstants.appJsonWithToken)
//     //     .then((value) {
//     //   log("Circular request response -> {$value}");
//     //   Marker newMarker3 = markers3.firstWhere(
//     //       (marker) => marker.markerId.value == "myFriendsLocationMarker",
//     //       orElse: () => const Marker(markerId: MarkerId("")));
//     //   markers3.remove(newMarker3);
//     //   if (value != null) {
//     //     final response = FriendsRoutesCircular.fromJson(jsonDecode(value));

//     //     for (int i = 0; i < response.data.length; i++) {
//     //       if (!friendList.contains(response.data[i].userID)) {
//     //         LocalNotificationService().showNotification(
//     //             title: "Arkadaşın Yakınında", body: response.data[i].message!);
//     //         friendList.add(response.data[i].userID!);
//     //       }
//     //       customMarkerIconController
//     //           .setCustomMarkerIcon5(response.data[i].profilePic!);
//     //       addMarkerFunctionForMapPage(
//     //         response.data[i].userID!,
//     //         const MarkerId("myFriendsLocationMarker"),
//     //         LatLng(
//     //           response.data[i].latitude as double,
//     //           response.data[i].longitude as double,
//     //         ),
//     //         BitmapDescriptor.fromBytes(
//     //             customMarkerIconController.myFriendsLocation!),
//     //         "${myFriendsLocations[i]!.name!} ${myFriendsLocations[i]!.surname!}",
//     //         myFriendsLocations[i]!.userpostroutes![0].departureDate.toString(),
//     //         myFriendsLocations[i]!.userpostroutes![0].arrivalDate.toString(),
//     //         "Tır",
//     //         myFriendsLocations[i]!.userpostroutes![0].startingCity!,
//     //         myFriendsLocations[i]!.userpostroutes![0].endingCity!,
//     //         "Akşam 8’de Samsundan yola çıkacağım, 12 saat sürecek yarın 10 gibi ankarada olacağım. Yolculuk sırasında Çorumda durup leblebi almadan geçeceğimi zannediyorsanız hata yapıyorsunuz",
//     //         myFriendsLocations[i]!.profilePicture!,context
//     //       );
//     //     }
//     //   }
//     //   update(["mapPageController"]);
//     // });
//   }

//   void mapDisplayAnimationFuncMap1() async {
//     try {
//       double miny = (mapPageRouteStartLatitude2.value <=
//               mapPageRouteFinishLatitude2.value)
//           ? mapPageRouteStartLatitude2.value
//           : mapPageRouteFinishLatitude2.value;

//       double minx = (mapPageRouteStartLongitude2.value <=
//               mapPageRouteFinishLongitude2.value)
//           ? mapPageRouteStartLongitude2.value
//           : mapPageRouteFinishLongitude2.value;

//       double maxy = (mapPageRouteStartLatitude2.value <=
//               mapPageRouteFinishLatitude2.value)
//           ? mapPageRouteFinishLatitude2.value
//           : mapPageRouteStartLatitude2.value;

//       double maxx = (mapPageRouteStartLongitude2.value <=
//               mapPageRouteFinishLongitude2.value)
//           ? mapPageRouteFinishLongitude2.value
//           : mapPageRouteStartLongitude2.value;

//       double southWestLatitude = miny;
//       double southWestLongitude = minx;

//       double northEastLatitude = maxy;
//       double northEastLongitude = maxx;

//       GoogleMapController generalMapController = await mapCotroller3.future;
//       generalMapController.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             northeast: LatLng(northEastLatitude, northEastLongitude),
//             southwest: LatLng(southWestLatitude, southWestLongitude),
//           ),
//           100,
//         ),
//       );
//       update(["mapPageController"]);
//     } catch (e) {
//       log("kamera animasyonu hatası!!! 55555  ${e.toString()}");
//       update(["mapPageController"]);
//     }
//   }

//   bool addMarkerFunctionForMapPage(
//       int userID,
//       int routeID,
//       MarkerId markerId,
//       LatLng latLng,
//       BitmapDescriptor icon,
//       String name,
//       String firstDestination,
//       String secondDestination,
//       String vehicleType,
//       String startCity,
//       String endCity,
//       String description,
//       String userProfilePhotoLink,
//       BuildContext context) {
//     try {
//       print("MARKERİDbenim -> $markerId");

//       Marker marker = Marker(
//         markerId: markerId,
//         position: latLng,
//         icon: icon,
//         zIndex: markerId.value == "myLocationMarker" ? 1 : 0.5,
//         onTap: () {
//           showModalBottomSheet(
//             context: context,
//             useRootNavigator: false,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8.r),
//                   topRight: Radius.circular(8.r)),
//             ),
//             builder: (builder) {
//               return PopupPrifilInfo(
//                 userId: userID,
//                 routeId: routeID,
//                 name: name,
//                 emptyPercent: 70,
//                 firstDestination: firstDestination,
//                 secondDestination: secondDestination,
//                 vehicleType: vehicleType,
//                 startCity: startCity,
//                 endCity: endCity,
//                 description: description,
//                 userProfilePhotoLink: userProfilePhotoLink,
//               );
//             },
//           );
//         },
//       );
//       markers.add(marker);
//       update(["mapPageController"]);
//       return true;
//     } catch (e) {
//       log("marker ekleme hatası!!  ${e.toString()}");
//       update(["mapPageController"]);
//       return false;
//     }
//   }

//   bool addMarkerFunctionForMapPageWithoutOnTap(
//     MarkerId markerId,
//     LatLng latLng,
//     // String title,
//     String address,
//     BitmapDescriptor? icon,
//   ) {
//     try {
//       print("MARKERİDmnekibenim -> $markerId");
//       Marker marker = Marker(
//         markerId: markerId,
//         position: latLng,
//         zIndex: markerId.value == "myLocationMarker" ? 1 : 0.5,
//         infoWindow: InfoWindow(
//           //title: title,
//           snippet: address,
//         ),
//         icon: icon!,
//       );
//       markers.add(marker);
//       update(["mapPageController"]);
//       return true;
//     } catch (e) {
//       log("marker ekleme hatası!!  ${e.toString()}");
//       update(["mapPageController"]);
//       return false;
//     }
//   }

//   //mfu
//   bool myRouteStartIconNotShow(
//     MarkerId markerId,
//     LatLng latLng,
//     // String title,
//     String address,
//   ) {
//     try {
//       print("MARKERİD -> $markerId");
//       Marker marker = Marker(
//         markerId: markerId,
//         zIndex: markerId.value == "myLocationMarker" ? 1 : 0.5,
//         position: latLng,
//         infoWindow: InfoWindow(
//           //title: title,
//           snippet: address,
//         ),
//       );
//       markers.add(marker);
//       update(["mapPageController"]);
//       return true;
//     } catch (e) {
//       log("marker ekleme hatası!!  ${e.toString()}");
//       update(["mapPageController"]);
//       return false;
//     }
//   }

// //mfu
//   bool addMarkerFunctionForMapPageWithoutOnTap2(
//     MarkerId markerId,
//     LatLng latLng,
//     // String title,
//     String address,
//     BitmapDescriptor icon,
//   ) {
//     try {
//       print("MARKERİD -> $markerId");
//       Marker marker = Marker(
//         markerId: markerId,
//         position: latLng,
//         zIndex: markerId.value == "myLocationMarker" ? 1 : 0.5,
//         infoWindow: InfoWindow(
//           //title: title,
//           snippet: address,
//         ),
//         icon: icon,
//       );
//       markers2.add(marker);
//       update(["mapPageController"]);
//       return true;
//     } catch (e) {
//       log("marker ekleme hatası!!  ${e.toString()}");
//       update(["mapPageController"]);
//       return false;
//     }
//   }

//   bool addMarkerFunctionForMapPageWithoutOnTap3(
//     MarkerId markerId,
//     LatLng latLng,
//     // String title,
//     String address,
//     BitmapDescriptor icon,
//   ) {
//     try {
//       print("MARKERİD -> $markerId");
//       Marker marker = Marker(
//         markerId: markerId,
//         position: latLng,
//         zIndex: markerId.value == "myLocationMarker" ? 1 : 0.5,
//         infoWindow: InfoWindow(
//           //title: title,
//           snippet: address,
//         ),
//         icon: icon,
//       );
//       markers.add(marker);
//       update(["mapPageController"]);
//       return true;
//     } catch (e) {
//       log("marker ekleme hatası!!  ${e.toString()}");
//       update(["mapPageController"]);
//       return false;
//     }
//   }

//   void drawIntoMapPolyline() async {
//     if (markers2.isNotEmpty) markers2.clear();
//     if (polylines2.isNotEmpty) polylines2.clear();
//     if (polylineCoordinates2.isNotEmpty) polylineCoordinates2.clear();
//     if (calculatedRouteDistance.value != "") calculatedRouteDistance.value = "";

//     await getPolylineEncodeRequest(
//       selectedPolyline.value,
//       mapPageRouteStartLatitude2.value,
//       mapPageRouteStartLongitude2.value,
//       mapPageRouteFinishLatitude2.value,
//       mapPageRouteFinishLongitude2.value,
//     ).then((value) async {
//       print("Finish NEWROUTEEM polyline encode");
//       if (value.routes != null) {
//         calculatedRouteDistance.value =
//             "${((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
//         calculatedRouteTime.value =
//             "${int.parse(value.routes![0].duration!.split("s")[0]) ~/ 3600} saat ${((int.parse(value.routes![0].duration!.split("s")[0]) / 60) % 60).toInt()} dk";
//         generalPolylineEncode2.value =
//             value.routes![0].polyline!.encodedPolyline!;

//         print("CALCULATEDİSTANCE -> ${calculatedRouteDistance.value}");
//       }

//       update(["mapPageController"]);
//     });

//     addPointIntoPolylineList2(generalPolylineEncode2.value);

//     addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myLocationMarker"),
//       LatLng(
//         getMyCurrentLocationController.myLocationLatitudeDo.value,
//         getMyCurrentLocationController.myLocationLongitudeDo.value,
//       ),
//       mapPageRouteStartAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
//     );

//     addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myRouteStartMarker2"),
//       LatLng(
//         mapPageRouteStartLatitude2.value,
//         mapPageRouteStartLongitude2.value,
//       ),
//       mapPageRouteStartAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
//     );

//     addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myRouteFinishMarker2"),
//       LatLng(
//         mapPageRouteFinishLatitude2.value,
//         mapPageRouteFinishLongitude2.value,
//       ),
//       mapPageRouteFinishAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
//     );

//     mapDisplayAnimationFuncMap1();

//     update(["mapPageController"]);
//   }

//   void drawIntoMapPolyline2() async {
//     if (markers2.isNotEmpty) markers2.clear();
//     if (polylines2.isNotEmpty) polylines2.clear();
//     if (polylineCoordinates2.isNotEmpty) polylineCoordinates2.clear();
//     if (calculatedRouteDistance.value != "") calculatedRouteDistance.value = "";

//     await getPolylineEncodeRequest(
//       selectedPolyline.value,
//       mapPageRouteStartLatitude2.value,
//       mapPageRouteStartLongitude2.value,
//       mapPageRouteFinishLatitude2.value,
//       mapPageRouteFinishLongitude2.value,
//     ).then((value) async {
//       if (value.routes!.isNotEmpty) {
//         calculatedRouteDistance.value =
//             "${((value.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
//         calculatedRouteTime.value =
//             "${int.parse(value.routes![0].duration!.split("s")[0]) ~/ 3600} saat ${((int.parse(value.routes![0].duration!.split("s")[0]) / 60) % 60).toInt()} dk";
//         generalPolylineEncode2.value =
//             value.routes![0].polyline!.encodedPolyline!;
//       }

//       update(["mapPageController"]);
//     });

//     addPointIntoPolylineList(generalPolylineEncode2.value);

//     /*  addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myLocationMarker"),
//       LatLng(
//         getMyCurrentLocationController.myLocationLatitudeDo.value,
//         getMyCurrentLocationController.myLocationLongitudeDo.value,
//       ),
//       mapPageRouteStartAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.mayLocationIcon!),
//     );

//     addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myRouteStartMarker2"),
//       LatLng(
//         mapPageRouteStartLatitude2.value,
//         mapPageRouteStartLongitude2.value,
//       ),
//       mapPageRouteStartAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.myRouteStartIcon!),
//     );

//     addMarkerFunctionForMapPageWithoutOnTap2(
//       const MarkerId("myRouteFinishMarker2"),
//       LatLng(
//         mapPageRouteFinishLatitude2.value,
//         mapPageRouteFinishLongitude2.value,
//       ),
//       mapPageRouteFinishAddress2.value,
//       BitmapDescriptor.fromBytes(customMarkerIconController.myRouteFinishIcon!),
//     );
// */
//     //   mapDisplayAnimationFuncMap1();

//     update(["mapPageController"]);
//   }

//   Future<GetPollylineResponseModel> getPolylineEncodeRequest(
//     int selectedPolyline,
//     double lati1,
//     double longi1,
//     double lati2,
//     double longi2,
//   ) async {
//     print("Finish NEWROUTEEM polyyy");
//     GetPollylineResponseModel getPollylineResponseModel =
//         GetPollylineResponseModel();
//     try {
//       print(
//           "finish lati11/long -> ${lati1} ${lati1} // lati12/long -> ${lati2} ${lati2}");

//       // GetPollylineResponseModel getPollylineResponseModel =
//       //     GetPollylineResponseModel(
//       //   routes: [
//       //     RouteMyModel(
//       //       distanceMeters: 0,
//       //       duration: "0s",
//       //       polyline: PolylineMyModel(
//       //         encodedPolyline: "",
//       //       ),
//       //     ),
//       //   ],
//       // );
//       GetPollylineRequestModel getPollylineRequestModel =
//           GetPollylineRequestModel(
//         languageCode: "tr",
//         computeAlternativeRoutes: false,
//         //departureTime: "2023-10-15T15:01:23.045123456Z",
//         destination: OriginMyModel.fromJson(
//           {
//             "location": {
//               "latLng": {"latitude": lati2, "longitude": longi2}
//             }
//           },
//         ),
//         origin: OriginMyModel.fromJson(
//           {
//             "location": {
//               "latLng": {"latitude": lati1, "longitude": longi1}
//             }
//           },
//         ),
//         routeModifiers: RouteModifiersMyModel(
//           avoidTolls: false,
//           avoidHighways: false,
//           avoidFerries: false,
//         ),
//         routingPreference: "TRAFFIC_AWARE",
//         travelMode: "DRIVE",
//         units: "METRIC",
//       );
//       print("MAPTENPOLYLİNECODU getpolylineEncode");

//       await GeneralServicesTemp()
//           .makePostRequestForPolyline(
//         AppConstants.googleMapsGetPolylineLink,
//         getPollylineRequestModel,
//         ServicesConstants.getPolylineRequestHeader,
//       )
//           .then(
//         (value) {
//           try {
//             print("Finish NEWROUTEEM polyyy ");
//             if (value != null) {
//               getPollylineResponseModel = GetPollylineResponseModel.fromJson(
//                   convert.json.decode(value));

//               if (getPollylineResponseModel.routes!.isNotEmpty) {
//                 calculatedRouteDistance.value =
//                     "${((getPollylineResponseModel.routes![0].distanceMeters)! / 1000).toStringAsFixed(0)} km";
//                 calculatedRouteDistanceInt =
//                     getPollylineResponseModel.routes![0].distanceMeters! ~/
//                         1000;
//                 int calculatedTime = int.parse(getPollylineResponseModel
//                     .routes![0].duration!
//                     .split("s")[0]);
//                 calculatedRouteTime.value =
//                     "${calculatedTime ~/ 3600} saat ${((calculatedTime / 60) % 60).toInt()} dk";
//                 calculatedRouteTimeInt = ((calculatedTime ~/ 3600) * 60) +
//                     ((calculatedTime / 60) % 60).toInt();
//                 getPollylineResponseModel.routes![0].polyline!.encodedPolyline!;
//               }

//               update(["mapPageController"]);
//               return getPollylineResponseModel;
//             }
//             update(["mapPageController"]);
//           } catch (e) {
//             print("Finish NEWROUTEEM polyyy value  ERROR-> $e");
//           }
//         },
//       );
//       update(["mapPageController"]);
//     } catch (e) {
//       print("Finish NEWROUTEEM polyyy error -> $e");
//     }
//     return getPollylineResponseModel;
//   }

//   _getPolyline(Map<String, LatLng> route, int index) async {
//     print("MAPTENPOLYLİNECODU -> mapPageController _getPolyline()");
//     PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
//       AppConstants.googleMapsApiKey,
//       PointLatLng(route["start"]!.latitude, route["start"]!.longitude),
//       PointLatLng(route["end"]!.latitude, route["end"]!.longitude),
//     );

//     if (result.points.isNotEmpty) {
//       List<LatLng> polylineCoordinates = [];
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });

//       polyliness.add(Polyline(
//         polylineId: PolylineId("polyline_$index"),
//         color: Colors.primaries[index % Colors.primaries.length],
//         points: polylineCoordinates,
//         width: 11,
//       ));
//     }
//   }

//   Future updateLocation({required double lat, required double long}) async {
//     try {
//       await GeneralServicesTemp().makePostRequest(
//         EndPoint.updateLocation,
//         {"lat": lat, "long": long},
//         {
//           "Content-type": "application/json",
//           'Authorization':
//               'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
//         },
//       );
//     } catch (e) {
//       print("UPDATELOCATİON ERR -> $e");
//     }
//   }
// }
