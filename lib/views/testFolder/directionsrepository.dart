// import 'package:dio/dio.dart';
// import 'package:fillogo/views/testFolder/directionsmodel.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class DirectionsRepository {
//   static const String _baseUrl =
//       'https://maps.googleapis.com/maps/api/directions/json?';

//   //final Dio _dio;
// var dio = Dio();
//   //DirectionsRepository({Dio dio}) : _dio = dio;

//   Future<Directions> getDirections({
//     required LatLng origin,
//     required LatLng destination,
//   }) async {
//     final response = await dio.get(
//       _baseUrl,
//       queryParameters: {
//         'origin': '${origin.latitude},${origin.longitude}',
//         'destination': '${destination.latitude},${destination.longitude}',
//         'key': 'AIzaSyCxZTC2Aw9oWeyck-hD4D4A7z5A1t-iKdA',
//       },
//     );

//     // Check if response is successful
//     if (response.statusCode == 200) {
//       return Directions.fromMap(response.data);
//     }
//     return Directions.fromMap(response.data);
//   }
// }