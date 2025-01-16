import 'dart:convert';
import 'dart:math';

import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/testFolder/test19/route_api_models.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class PolylineService {
  Future<Polyline?> getPolyline(
      double startLat, double startLng, double endLat, double endLng) async {
    MapPageMController mapPageMController = Get.find();
    try {
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        AppConstants.googleMapsApiKey,
        PointLatLng(startLat, startLng),
        PointLatLng(endLat, endLng),
      );

      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = [];
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
        mapPageMController.polylineCoordinates = polylineCoordinates;
        Polyline polyline = Polyline(
          polylineId: const PolylineId("myRoute"),
          color: AppConstants().ltBlue,
          points: polylineCoordinates,
          width: 9,
        );

        return polyline;
      }
    } catch (e) {
      debugPrint("POLYLİNESERVİCE ERR getPolyline  -> $e");
    }
  }

  /// SEYEHAT SÜRESİ HESAPLAMA

  Future<GetPollylineResponseModel?> getRoute(
      double startLat, double startLng, double endLat, double endLng) async {
    GetPollylineResponseModel getPollylineResponseModel;
    const String url = AppConstants.googleMapsGetPolylineLink;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': AppConstants.googleMapsApiKey,
          'X-Goog-FieldMask':
              'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
        },
        body: jsonEncode({
          "origin": {
            "location": {
              "latLng": {"latitude": startLat, "longitude": startLng}
            }
          },
          "destination": {
            "location": {
              "latLng": {"latitude": endLat, "longitude": endLng}
            }
          },
          "routeModifiers": {
            "avoidTolls": false,
            "avoidHighways": false,
            "avoidFerries": false
          },
          "languageCode": "tr",
          "travelMode": "DRIVE",
          "routingPreference": "TRAFFIC_AWARE",
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Rota bilgilerini işleyin

        getPollylineResponseModel =
            GetPollylineResponseModel.fromJson(json.decode(response.body));

        return getPollylineResponseModel;
      } else {
        debugPrint("POLYLİNESERVİCE Error -> ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("POLYLİNESERVİCE catch err -> $e");
    }
  }
}
