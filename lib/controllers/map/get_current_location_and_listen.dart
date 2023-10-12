import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:developer';

class GetMyCurrentLocationController extends GetxController {
  var myLocationLatitudeSt = ''.obs;
  var myLocationLongitudeSt = ''.obs;
  var myLocationAddress = ''.obs;
  var myLocationLatitudeDo = 0.0.obs;
  var myLocationLongitudeDo = 0.0.obs;
  late StreamSubscription<Position> streamSubscription;
  final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialLocation;

  GoogleMapController? myLocationMapController;
  Position? myLocation;

  @override
  void onInit() async {
    await getMyCurrentLocation();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
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
      log("Şuanki Konumum:  ${myLocationLatitudeSt.value} / ${myLocationLongitudeSt.value}");
      //await getAddressFromLatLang(position);
      //await trackerForMyLocation();
      update();
      initialLocation = CameraPosition(
        bearing: 90,
        tilt: 45,
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 14,
      );
    });
    update();
  }

  Future<GoogleMapController> trackerForMyLocation() async {
    if (myLocationLatitudeDo.value != 0.0 &&
        myLocationLongitudeDo.value != 0.0) {
      myLocationMapController = await _controller.future;
      await myLocationMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15.0,
            target: LatLng(
              myLocationLatitudeDo.value,
              myLocationLongitudeDo.value,
            ),
          ),
        ),
      );
      update();
    } else {
      log("Tracker Çalışmadı!!  şuanki konum: '0.0'");
    }

    return myLocationMapController!;
  }

  Future<void> getAddressFromLatLang(LatLng position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    myLocationAddress.value = 'Address : ${place.locality},${place.country}';
  }
}
