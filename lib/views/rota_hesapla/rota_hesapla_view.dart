// import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/testFolder/apitest.dart';
// import 'package:fillogo/views/testFolder/taskdetail.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class RotaHesaplaView extends StatefulWidget {
//   const RotaHesaplaView({super.key});

//   @override
//   State<RotaHesaplaView> createState() => _RotaHesaplaViewState();
// }

// class _RotaHesaplaViewState extends State<RotaHesaplaView> {
//   final startAddressController = TextEditingController();
//   final destinationAddressController = TextEditingController();
//   final discriptionController = TextEditingController();

//   RouteCalculatesViewController currentLocation = Get.find();

//   List<LatLng> polylineCoordinates = [];

//   String _startAddress = '';
//   String _destinationAddress = '';

//   late Location startLocationCoordinate;
//   late Location finishLocationCoordinate;

//   bool isPressed = false;
//   bool isPhotoVisible = false;

//   @override
//   void initState() {
//     startLocationCoordinate =
//         Location(latitude: 0, longitude: 0, timestamp: DateTime(0));
//     finishLocationCoordinate =
//         Location(latitude: 0, longitude: 0, timestamp: DateTime(0));
//     super.initState();
//   }

//   Future<bool> _calculateDistance() async {
//     try {
//       List<Location> startPlacemark = await locationFromAddress(_startAddress);
//       List<Location> destinationPlacemark =
//           await locationFromAddress(_destinationAddress);

//       double startLatitude = startPlacemark[0].latitude;

//       double startLongitude = startPlacemark[0].longitude;

//       startLocationCoordinate = startPlacemark[0];

//       double destinationLatitude = destinationPlacemark[0].latitude;

//       double destinationLongitude = destinationPlacemark[0].longitude;

//       finishLocationCoordinate = destinationPlacemark[0];

//       String startCoordinatesString = '($startLatitude, $startLongitude)';
//       String destinationCoordinatesString =
//           '($destinationLatitude, $destinationLongitude)';

//       print(
//         'START COORDINATES: ($startLatitude, $startLongitude)',
//       );
//       print(
//         'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
//       );

//       return true;
//     } catch (e) {
//       print(e);
//     }
//     print("XXXXXXXXXXXXXXX  222222");
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition _initialLocation = CameraPosition(
//       target: LatLng(
//           currentLocation.latitude.value, currentLocation.longitude.value),
//     );
//     return Scaffold(
//       appBar: AppBarGenel(
//         title: Text(
//           'Rota Hesapla',
//           style: TextStyle(
//               fontFamily: 'Sfsemibold',
//               color: AppConstants().ltLogoGrey,
//               fontSize: 28),
//         ),
//         actions: [],
//         leading: Builder(
//           builder: (context) => InkWell(
//             onTap: () => Get.toNamed(NavigationConstants.mapPage),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SvgPicture.asset(
//                 'assets/icons/back-icon.svg',
//                 color: AppConstants().ltLogoGrey,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             width: Get.width * 0.9,
//             color: AppConstants().ltWhite,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const SizedBox(height: 15),
//                   SizedBox(
//                     width: Get.width * 0.8,
//                     child: const Text(
//                       'Çıkış ve varış noktalarını yazarak hesaplama yapabilirsiniz',
//                       style: TextStyle(fontFamily: 'Sfregular'),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   _textField(
//                     hint: 'Çıkış noktasını giriniz',
//                     controller: startAddressController,
//                     width: Get.width,
//                     height: 50,
//                   ),
//                   const SizedBox(height: 10),
//                   _textField(
//                     hint: 'Varış noktasını giriniz',
//                     controller: destinationAddressController,
//                     width: Get.width,
//                     height: 50,
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: Get.width * 0.8,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           isPressed = true;
//                           _startAddress = startAddressController.text;
//                           _destinationAddress =
//                               destinationAddressController.text;
//                         });
//                         if (_startAddress != '' && _destinationAddress != '') {
//                           _calculateDistance().then(
//                             (isCalculated) {
//                               if (isCalculated) {
//                                 print(startLocationCoordinate);
//                                 print(finishLocationCoordinate);
//                               } else {
//                                 print("HATAAAAAA");
//                               }
//                             },
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: AppConstants().ltMainRed,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Rota Hesapla",
//                           style: TextStyle(
//                             fontFamily: "Sfsemidold",
//                             fontSize: 16,
//                             color: AppConstants().ltWhite,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   Visibility(
//                     visible: isPressed == true ? true : false,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             const SizedBox(
//                               width: 25,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   startAddressController.text.toUpperCase(),
//                                   style:
//                                       const TextStyle(fontFamily: 'Sfsemibold'),
//                                 ),
//                                 const Text(
//                                   " -> ",
//                                   style: TextStyle(fontFamily: 'Sfsemibold'),
//                                 ),
//                                 Text(
//                                   destinationAddressController.text
//                                       .toUpperCase(),
//                                   style:
//                                       const TextStyle(fontFamily: 'Sfsemibold'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: const [
//                             SizedBox(
//                               width: 25,
//                             ),
//                             Text(
//                               'Tahmini 412 km ve 4 Saat 23 Dakika',
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15),
//                         _mapCalculates(),
//                         const SizedBox(height: 15),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 35),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _mapCalculates() {
//     if (startLocationCoordinate.latitude.toString() != "" &&
//         finishLocationCoordinate.latitude.toString() != "") {
//       return Container(
//         width: Get.width * 0.8,
//         height: Get.width * 0.8,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: ApiTest(
//           TaskDetail(
//               startLocationCoordinate.latitude,
//               startLocationCoordinate.longitude,
//               finishLocationCoordinate.latitude,
//               finishLocationCoordinate.longitude),
//         ),
//       );
//     } else {
//       return Container(
//         width: Get.width * 0.8,
//         height: Get.width * 0.8,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: const Text("deneme"),
//       );
//     }
//   }

//   Widget _textField({
//     required TextEditingController controller,
//     required String hint,
//     required double width,
//     required double height,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Container(
//         width: Get.width * 0.8,
//         height: height,
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: TextField(
//           cursorColor: AppConstants().ltMainRed,
//           controller: controller,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             hintStyle: TextStyle(
//               fontFamily: "Sflight",
//               fontSize: 16,
//               color: AppConstants().ltDarkGrey,
//             ),
//             border: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10.0),
//               ),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(15),
//             hintText: hint,
//           ),
//           style: TextStyle(
//             fontFamily: "Sflight",
//             fontSize: 16,
//             color: AppConstants().ltBlack,
//           ),
//         ),
//       ),
//     );
//   }
// }
