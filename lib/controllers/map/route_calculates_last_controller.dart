import 'dart:async';

import 'package:fillogo/export.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class RouteCalculatesLastController extends GetxController {
  var currentLatitude = 0.0.obs;
  var currentLlongitude = 0.0.obs;
  late StreamSubscription<Position> streamSubscription;
  var address = 'Adres Hesaplanıyor..'.obs;

  getCurrentLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Konum servisleri devre dışı.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Konum izinleri reddedildi.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Konum izinleri kalıcı olarak reddedilir, izin isteyemeyiz.');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentLatitude.value = position.latitude;
      currentLlongitude.value = position.longitude;
      getAddressFromLatLang(position);
    });
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address.value = 'Address : ${place.locality},${place.country}';
  }
}
