import 'dart:typed_data';

import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/models/routes_models/get_users_on_area.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_new_route_view/create_new_route_view.dart';
import 'package:fillogo/views/map_page_new/service/map_page_service.dart';
import 'package:fillogo/views/map_page_new/service/polyline_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class MapPageMController extends GetxController implements MapPageService {
  late BuildContext context;

  final RxBool isCreateRoute = false.obs;
  RxBool isLoading = false.obs;
  RxBool isThereActiveRoute = false.obs; //aktif rotam var mı
  RxBool finishRouteButton =
      false.obs; //aktif rotam varsa rotayı bitir butonu görünsün mü

  RxBool isRouteVisibilty = true.obs;
  RxBool isRouteAvability = true.obs;

  AllRoutes myAllRoutes = AllRoutes();
  List<MyRoutesDetails> myActivesRoutes = [];
  List<MyRoutesDetails> myPastsRoutes = [];
  List<MyRoutesDetails> mynotStartedRoutes = [];

  SetCustomMarkerIconController customMarkerIconController = Get.find();
  GetMyCurrentLocationController currentLocationController =
      Get.find<GetMyCurrentLocationController>();
  MapPageService mapPageService = MapPageService();

  final Set<Polyline> polylines = {};

  List<GetUsersOnAreaResDatum?> usersOnArea = [];
  late GoogleMapController mapController;
  RxSet<Marker> markers = <Marker>{}.obs;
  final Rx<LatLng> mapCenter = Rx<LatLng>(const LatLng(0.0, 0.0));

  ///FİLTER CAR
  RxBool showFilterOption = false.obs;
  RxList<bool> filterSelectedList = [true, true, true].obs;
  List<String> carTypeList = ["Otomobil", "Tır", "Motorsiklet"];

  ///HARİTADAKİ KULLANICI DOKUNMALARINI KONTROL ETMEK İÇİN (CameraPosition hareketlerinde kullanılıyor)
  RxBool shouldUpdateLocation = true.obs;
  bool isListenMap = true;

  @override
  void onInit() {
    _startLocationUpdates();

    getUsersOnArea(carTypeFilter: carTypeList);
    updateLocation(
        lat: currentLocationController.myLocationLatitudeDo.value,
        long: currentLocationController.myLocationLongitudeDo.value);
    addMarkerIcon(
        markerID: "myLocationMarker",
        location: LatLng(currentLocationController.myLocationLatitudeDo.value,
            currentLocationController.myLocationLongitudeDo.value));
    getMyRoutes().then((value) {});
    super.onInit();
  }

  Future<GetMyRouteResponseModel?> getMyRoutes(
      {bool isStartRoute = true}) async {
    try {
      GetMyRouteResponseModel myRouteResponseModel;
      await GeneralServicesTemp().makeGetRequest(
        EndPoint.getMyRoutes,
        {
          "Content-type": "application/json",
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
        },
      ).then((value) async {
        myRouteResponseModel =
            GetMyRouteResponseModel.fromJson(json.decode(value!));
        myAllRoutes = myRouteResponseModel.data[0].allRoutes;
        print("GETMYROUTES -> ${myAllRoutes.activeRoutes!.length}");
        if (myRouteResponseModel
            .data[0].allRoutes.notStartedRoutes!.isNotEmpty) {
          mynotStartedRoutes =
              myRouteResponseModel.data[0].allRoutes.notStartedRoutes!;
        }
        if (myRouteResponseModel.data[0].allRoutes.pastRoutes!.isNotEmpty) {
          myPastsRoutes = myRouteResponseModel.data[0].allRoutes.pastRoutes!;
        }
        if (myRouteResponseModel.data[0].allRoutes.activeRoutes!.isNotEmpty) {
          myActivesRoutes =
              myRouteResponseModel.data[0].allRoutes.activeRoutes!;
          print("GETMYROUTES -> ${myActivesRoutes!.first.endingCity}");
          isThereActiveRoute.value = myActivesRoutes!.isNotEmpty ? true : false;
          if (isThereActiveRoute.value) {
            if (isStartRoute) {
              Polyline? polyline = await PolylineService().getPolyline(
                  myActivesRoutes![0].startingCoordinates.first,
                  myActivesRoutes![0].startingCoordinates.last,
                  myActivesRoutes![0].endingCoordinates.first,
                  myActivesRoutes![0].endingCoordinates.last);
              print("GETMYROUTES POLYLİNE ${polyline}");

              polylines.add(polyline!);
            }

            ///start
            addMarkerIcon(
              location: LatLng(
                myActivesRoutes![0].startingCoordinates.first,
                myActivesRoutes![0].startingCoordinates.last,
              ),
              markerID: 'myLocationMarker',
            );

            ///finish
            addMarkerIcon(
              location: LatLng(
                myActivesRoutes![0].endingCoordinates.first,
                myActivesRoutes![0].endingCoordinates.last,
              ),
              markerID: 'myLocationFinishMarker',
            );
          }
        }

        await getUsersOnArea(carTypeFilter: ["Otomobil", "Tır", "Motorsiklet"]);
      });
    } catch (e) {
      print("GETMYROUTES error -> $e");
    }
    return null;
  }

  addMarkerIcon({
    required String markerID,
    required LatLng location,
    Function()? onTap,
    CarType? carType,
  }) async {
    await customMarkerIconController.setCustomMarkerIcon3();
    Uint8List iconByteData = markerID == "myLocationMarker"
        ? customMarkerIconController.mayLocationIcon!
        : markerID == "myLocationFinishMarker"
            ? customMarkerIconController.myRouteFinishIcon!
            : await customMarkerIconController.friendsCustomMarkerIcon(
                carType: carType!);

    markers.add(
      Marker(
        markerId: MarkerId(markerID),
        position: location,
        icon: BitmapDescriptor.fromBytes(iconByteData),
        zIndex: markerID == "myLocationMarker" ? 1 : 0,
        onTap: markerID != "myLocationMarker" ? onTap : null,
      ),
    );
    print("MAPPAGECONTROLLER ONAREA MARKEREKLENDİ ->  ${markerID}");
  }

  ///Harita hareketlerini dinler
  void _startLocationUpdates() {
    Geolocator.getPositionStream().listen((Position position) {
      print("NEWMAP LİSTEN");
      markers
          .removeWhere((marker) => marker.markerId.value == 'myLocationMarker');
      addMarkerIcon(
        markerID: "myLocationMarker",
        location: LatLng(
            getMyCurrentLocationController.myLocationLatitudeDo.value,
            getMyCurrentLocationController.myLocationLongitudeDo.value),
      );

      ///Haritaya dokunulduğunda CameraPosition'un direkt bulunulan konumuna gelmemesi için ///
      if (shouldUpdateLocation.value && isListenMap) {
        LatLng newLatLng = LatLng(position.latitude, position.longitude);
        if (mapCenter.value != newLatLng) {
          try {
            mapCenter.value = newLatLng;
            mapController.animateCamera(
              CameraUpdate.newLatLng(
                newLatLng,
              ),
            );
          } catch (e) {
            print("STARTMAP ERROR -> $e");
          }

          updateLocation(lat: position.latitude, long: position.longitude);
        }
      }
    });
  }

  ///Haritada bulunduğum konumu ortalar
  void getMyLocationInMap() {
    try {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 90,
            tilt: 45,
            target: LatLng(
                getMyCurrentLocationController.myLocationLatitudeDo.value,
                getMyCurrentLocationController.myLocationLongitudeDo.value),
            zoom: 15,
          ),
        ),
      );
      shouldUpdateLocation.value = true;
    } catch (e) {
      print("NEWMAP getMyLocationButton -> $e");
    }
  }

  filterButtonOnTap() async {
    try {
      showFilterOption.value = false;

      isLoading.value = true;
      markers.clear();
      addMarkerIcon(
          markerID: "myLocationMarker",
          location: LatLng(currentLocationController.myLocationLatitudeDo.value,
              currentLocationController.myLocationLongitudeDo.value));
      if (isThereActiveRoute.value) {
        addMarkerIcon(
            markerID: "myLocationFinishMarker",
            location: LatLng(myActivesRoutes![0].endingCoordinates.first,
                myActivesRoutes![0].endingCoordinates.last));
      }

      carTypeList.clear();
      if (filterSelectedList[0]) {
        carTypeList.add("Otomobil");
      }
      if (filterSelectedList[1]) {
        carTypeList.add("Tır");
      }
      if (filterSelectedList[2]) {
        carTypeList.add("Motorsiklet");
      }

      await getUsersOnArea(carTypeFilter: filterSelectedList);

      isLoading.value = false;
      // update(["mapPageController"]);
    } catch (e) {
      print("MAPPAGEİSLOAD ERR -> $e");
    }
  }

  @override
  Future<UsersOnAreaModel?> getUsersOnArea(
      {required List carTypeFilter}) async {
    try {
      mapPageService
          .getUsersOnArea(carTypeFilter: carTypeList)
          .then((value) async {
        print("MAPPAGECONTROLLER ONAREA ${jsonEncode(value)} ");
        usersOnArea = value!.data!.first;

        print("MAPPAGECONTROLLER ONAREA -> ${usersOnArea.length}");

        for (var i = 0; i < usersOnArea.length; i++) {
          if (usersOnArea[i]!.userId !=
              LocaleManager.instance.getInt(PreferencesKeys.currentUserId)) {
            String userCarType = usersOnArea[i]!
                .usertousercartypes!
                .first
                .cartypetousercartypes!
                .carType!;
            CarType carType = userCarType == "Otomobil"
                ? CarType.otomobil
                : userCarType == "Tır"
                    ? CarType.tir
                    : CarType.motorsiklet;
            addMarkerIcon(
              markerID: usersOnArea[i]!.userId!.toString(),
              location: usersOnArea[i]!.userpostroutes!.isNotEmpty
                  ? LatLng(
                      usersOnArea[i]!
                          .userpostroutes!
                          .first
                          .polylineDecode!
                          .first
                          .first,
                      usersOnArea[i]!
                          .userpostroutes!
                          .first
                          .polylineDecode!
                          .first
                          .last)
                  : LatLng(
                      usersOnArea[i]!.latitude!,
                      usersOnArea[i]!.longitude!,
                    ),
              carType: carType,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    useRootNavigator: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r)),
                    ),
                    builder: (BuildContext context) {
                      return usersOnArea[i]!.userpostroutes!.isNotEmpty
                          ? PopupPrifilInfo(
                              userId: usersOnArea[i]!.userId!,
                              routeId: usersOnArea[i]!.userpostroutes![0].id!,
                              name:
                                  "${usersOnArea[i]!.name!}  ${usersOnArea[i]!.surname}",
                              emptyPercent: 70,
                              firstDestination: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .departureDate!
                                  .toString(),
                              secondDestination: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .arrivalDate
                                  .toString(),
                              vehicleType: usersOnArea[i]!
                                  .usertousercartypes![0]
                                  .cartypetousercartypes!
                                  .carType!,
                              startCity: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .startingCity!,
                              endCity: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .endingCity!,
                              description: usersOnArea[i]!
                                  .userpostroutes![0]
                                  .routeDescription!,
                              userProfilePhotoLink: usersOnArea[i]!.profilePic!,
                            )
                          : PopupPrifilInfo(
                              userId: usersOnArea[i]!.userId!,
                              routeId: null,
                              name:
                                  "${usersOnArea[i]!.name!}  ${usersOnArea[i]!.surname}",
                              userProfilePhotoLink: usersOnArea[i]!.profilePic!,
                              vehicleType: usersOnArea[i]!
                                  .usertousercartypes![0]
                                  .cartypetousercartypes!
                                  .carType!,
                              emptyPercent: 70,
                              firstDestination: "",
                              secondDestination: "",
                              startCity: "",
                              endCity: "",
                              description: "",
                            );
                    });
              },
            );
          }
        }
      });
    } catch (e) {
      print("MAPPAGECONTROLLER error getUsersOnArea -> $e");
    }
    return null;
  }

  @override
  Future updateLocation({required double lat, required double long}) async {
    try {
      await mapPageService.updateLocation(lat: lat, long: long);
    } catch (e) {
      print("MAPPAGECONTROLLER error -> $e");
    }
  }
}

enum CarType { motorsiklet, tir, otomobil }
