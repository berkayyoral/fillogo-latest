// import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
// import 'package:fillogo/controllers/stepper/post_with_route_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/rota_view/components/rota_appBar.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
// import 'package:r_dotted_line_border/r_dotted_line_border.dart';

// class RotaView extends StatefulWidget {
//   const RotaView({Key? key}) : super(key: key);

//   @override
//   State<RotaView> createState() => _RotaViewState();
// }

// class _RotaViewState extends State<RotaView> {
//   Completer<GoogleMapController> _controller = Completer();
//   PostWithRouteController _postWithRouteController = Get.find();
//   RouteCalculatesViewController routeCalculatesViewController = Get.find();
//   DateTime? cikisTarihi = DateTime.now();
//   TimeOfDay? cikisSaati = TimeOfDay.now();
//   DateTime? varisTarihi = DateTime.now();

//   TimeOfDay? varisSaati = TimeOfDay.now();
//   RouteCalculatesViewController currentDirectionsController =
//       Get.put(RouteCalculatesViewController());
//   TextEditingController aciklamaController = TextEditingController();
//   LocationData? currentLocation;
//   getCurrentLocation() {
//     Location location = Location();

//     location.getLocation().then((location) {
//       currentLocation = location;
//       setState(() {});
//     });
//   }

//   final Set<Polyline> _polyline = {};

//   @override
//   void initState() {
//     getCurrentLocation();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     currentLocation;
//     Future.delayed(Duration(seconds: 2));
//     List<LatLng> latLen = [
//       LatLng(routeCalculatesViewController.latitude.value,
//           routeCalculatesViewController.longitude.value),
//       LatLng(routeCalculatesViewController.latitude.value + 0.0005,
//           routeCalculatesViewController.longitude.value + 0.0005),
//     ];

//     return Scaffold(
//       appBar: RotaAppBar(),
//       body: Container(
//         width: Get.width,
//         height: Get.height,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/world-bg-1.png'),
//                 fit: BoxFit.fitHeight)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               DummyBox15(),
//               Row(
//                 children: [
//                   25.w.spaceX,
//                   Text(
//                     'Rotanız',
//                     style: TextStyle(fontFamily: 'Sflight'),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   25.w.spaceX,
//                   Text(
//                     'Samsun -> Ankara',
//                     style: TextStyle(fontFamily: 'Sfsemibold'),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   25.w.spaceX,
//                   Text(
//                     'Tahmini 412 km ve 4 Saat 23 Dakika',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ],
//               ),
//               DummyBox15(),
//               /*Container(
//                   width: Get.width * 0.9,
//                   height: Get.height * 0.4,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(24),
//                   ),
//                   child: ApiTest(TaskDetail(
//                       startLocationCoordinate.latitude,
//             startLocationCoordinate.longitude,
//             finishLocationCoordinate.latitude,
//             finishLocationCoordinate.longitude))),*/
//               Theme(
//                 data: ThemeData(
//                   colorScheme: ColorScheme.light(
//                     primary: AppConstants().ltMainRed,
//                   ),
//                 ),
//                 child: Obx(
//                   () => Stepper(
//                     physics: NeverScrollableScrollPhysics(),
//                     currentStep: _postWithRouteController.currentStep,
//                     steps: getSteps(),
//                     controlsBuilder: (context, details) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 10,
//                         ),
//                         child: Row(
//                           children: [
//                             GestureDetector(
//                                 onTap: () {
//                                   switch (
//                                       _postWithRouteController.currentStep) {
//                                     case 0:
//                                       if (_postWithRouteController
//                                           .isCikisSelected) {
//                                         _postWithRouteController.currentStep +=
//                                             1;
//                                         if (!_postWithRouteController
//                                             .isVarisSelected) {
//                                           _postWithRouteController.buttonColor =
//                                               AppConstants().ltDarkGrey;
//                                         }
//                                       }
//                                       break;
//                                     case 1:
//                                       if (_postWithRouteController
//                                           .isVarisSelected) {
//                                         _postWithRouteController.currentStep +=
//                                             1;
//                                         if (!_postWithRouteController
//                                             .isAciklamaFilled) {
//                                           _postWithRouteController.buttonColor =
//                                               AppConstants().ltDarkGrey;
//                                         }
//                                       }
//                                       break;
//                                     case 2:
//                                       if (_postWithRouteController
//                                           .isAciklamaFilled) {
//                                         _postWithRouteController.currentStep +=
//                                             1;
//                                       }
//                                       break;
//                                     case 3:
//                                       Get.offAndToNamed(
//                                           NavigationConstants.postflow);
//                                       break;
//                                     default:
//                                   }
//                                 },
//                                 child: Obx(
//                                   () => Container(
//                                     height: Get.height * 0.04,
//                                     width: Get.width * 0.16,
//                                     decoration: BoxDecoration(
//                                       color:
//                                           _postWithRouteController.buttonColor,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         _postWithRouteController.currentStep ==
//                                                 3
//                                             ? 'Paylaş'
//                                             : 'İleri',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: 'Sfbold',
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                             SizedBox(
//                               width: Get.width * 0.05,
//                             ),
//                             _postWithRouteController.currentStep == 0
//                                 ? SizedBox()
//                                 : GestureDetector(
//                                     onTap: () {
//                                       switch (_postWithRouteController
//                                           .currentStep) {
//                                         case 1:
//                                           _postWithRouteController
//                                               .currentStep -= 1;
//                                           if (_postWithRouteController
//                                               .isCikisSelected) {
//                                             _postWithRouteController
//                                                     .buttonColor =
//                                                 AppConstants().ltMainRed;
//                                           }
//                                           break;
//                                         case 2:
//                                           _postWithRouteController
//                                               .currentStep -= 1;
//                                           _postWithRouteController.buttonColor =
//                                               AppConstants().ltMainRed;
//                                           break;
//                                         case 3:
//                                           _postWithRouteController
//                                               .currentStep -= 1;
//                                           break;
//                                         default:
//                                       }
//                                     },
//                                     child: Container(
//                                       height: Get.height * 0.04,
//                                       width: Get.width * 0.16,
//                                       decoration: BoxDecoration(
//                                         color: AppConstants().ltWhiteGrey,
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'Geri',
//                                           style: TextStyle(
//                                             color: AppConstants().ltDarkGrey,
//                                             fontFamily: 'Sfbold',
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.02,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.offAndToNamed(NavigationConstants.generalSettings);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: Get.width * 0.1,
//                     ),
//                     Text(
//                       'Genel Ayarları Düzenle',
//                       style: TextStyle(
//                           color: AppConstants().ltMainRed,
//                           fontSize: 16,
//                           fontFamily: 'Sfsemibold'),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: Get.height * 0.05,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Step> getSteps() {
//     return [
//       Step(
//         title: Text(
//           'Çıkış Zamanı (Zorunlu)',
//           style: TextStyle(
//             fontFamily: 'Sfbold',
//             color: _postWithRouteController.currentStep >= 0
//                 ? AppConstants().ltMainRed
//                 : AppConstants().ltDarkGrey,
//           ),
//         ),
//         subtitle: _postWithRouteController.isCikisSelected
//             ? Text(
//                 //TODO: alınan veri subtitle a verilecek
//                 _postWithRouteController.cikisText,
//                 style: TextStyle(
//                   fontFamily: 'Sfbold',
//                   color: AppConstants().ltDarkGrey,
//                   fontSize: 10,
//                 ),
//               )
//             : SizedBox(),
//         isActive: _postWithRouteController.currentStep >= 0 ? true : false,
//         content: GestureDetector(
//           onTap: () async {
//             cikisTarihi = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month,
//                   DateTime.now().day),
//               builder: (context, child) {
//                 return Theme(
//                   data: ThemeData.dark().copyWith(
//                     colorScheme: ColorScheme.light(
//                       primary: AppConstants().ltMainRed,
//                       onPrimary: AppConstants().ltWhite,
//                       surface: AppConstants().ltWhite,
//                       onSurface: AppConstants().ltBlack,
//                     ),
//                     dialogBackgroundColor: AppConstants().ltWhite,
//                   ),
//                   child: MediaQuery(
//                     data: MediaQuery.of(context).copyWith(
//                       alwaysUse24HourFormat: true,
//                     ),
//                     child: child!,
//                   ),
//                 );
//               },
//             );
//             cikisSaati = await showTimePicker(
//               context: context,
//               initialTime: TimeOfDay.now(),
//               initialEntryMode: TimePickerEntryMode.input,
//               builder: (context, child) {
//                 return Theme(
//                   data: ThemeData.dark().copyWith(
//                     colorScheme: ColorScheme.light(
//                       primary: AppConstants().ltMainRed,
//                       onPrimary: AppConstants().ltWhite,
//                       surface: AppConstants().ltWhite,
//                       onSurface: AppConstants().ltBlack,
//                     ),
//                     dialogBackgroundColor: AppConstants().ltWhite,
//                   ),
//                   child: MediaQuery(
//                     data: MediaQuery.of(context).copyWith(
//                       alwaysUse24HourFormat: true,
//                     ),
//                     child: child!,
//                   ),
//                 );
//               },
//             );
//             if (cikisSaati == null || cikisTarihi == null) {
//               _postWithRouteController.isCikisSelected = false;
//               _postWithRouteController.buttonColor = AppConstants().ltDarkGrey;
//             } else {
//               _postWithRouteController.isCikisSelected = true;
//               _postWithRouteController.buttonColor = AppConstants().ltMainRed;
//             }
//             _postWithRouteController.cikisText =
//                 '${DateFormat('dd/MM/yyyy').format(cikisTarihi!)} ' +
//                     (cikisSaati == null
//                         ? ' - LUTFEN SAAT SECİNİZ!'
//                         : ' - ${cikisSaati?.hour}:${cikisSaati?.minute}');
//           },
//           child: Card(
//             elevation: 10,
//             child: SizedBox(
//               height: 40,
//               width: Get.width * 0.85,
//               child: Center(
//                   child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _postWithRouteController.cikisText,
//                       style: TextStyle(
//                         color: AppConstants().ltDarkGrey,
//                       ),
//                     ),
//                     Icon(
//                       Icons.calendar_month,
//                       color: AppConstants().ltDarkGrey,
//                     ),
//                   ],
//                 ),
//               )),
//             ),
//           ),
//         ),
//       ),
//       Step(
//         title: Text(
//           'Varış Zamanı (Zorunlu)',
//           style: TextStyle(
//             fontFamily: 'Sfbold',
//             color: _postWithRouteController.currentStep >= 1
//                 ? AppConstants().ltMainRed
//                 : AppConstants().ltDarkGrey,
//           ),
//         ),
//         subtitle: _postWithRouteController.isVarisSelected
//             ? Text(
//                 //TODO: alınan veri subtitle a verilecek
//                 _postWithRouteController.varisText,
//                 style: TextStyle(
//                   fontFamily: 'Sfbold',
//                   color: AppConstants().ltDarkGrey,
//                   fontSize: 10,
//                 ),
//               )
//             : SizedBox(),
//         isActive: _postWithRouteController.currentStep >= 1 ? true : false,
//         content: GestureDetector(
//           onTap: () async {
//             varisTarihi = await showDatePicker(
//               context: context,
//               initialDate: cikisTarihi!,
//               firstDate: cikisTarihi!,
//               lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month,
//                   DateTime.now().day),
//               builder: (context, child) {
//                 return Theme(
//                   data: ThemeData.dark().copyWith(
//                     colorScheme: ColorScheme.light(
//                       primary: AppConstants().ltMainRed,
//                       onPrimary: AppConstants().ltWhite,
//                       surface: AppConstants().ltWhite,
//                       onSurface: AppConstants().ltBlack,
//                     ),
//                     dialogBackgroundColor: AppConstants().ltWhite,
//                   ),
//                   child: MediaQuery(
//                     data: MediaQuery.of(context).copyWith(
//                       alwaysUse24HourFormat: true,
//                     ),
//                     child: child!,
//                   ),
//                 );
//               },
//             );
//             varisSaati = await showTimePicker(
//               context: context,
//               initialTime: TimeOfDay.now(),
//               initialEntryMode: TimePickerEntryMode.input,
//               builder: (context, child) {
//                 return Theme(
//                   data: ThemeData.dark().copyWith(
//                     colorScheme: ColorScheme.light(
//                       primary: AppConstants().ltMainRed,
//                       onPrimary: AppConstants().ltWhite,
//                       surface: AppConstants().ltWhite,
//                       onSurface: AppConstants().ltBlack,
//                     ),
//                     dialogBackgroundColor: AppConstants().ltWhite,
//                   ),
//                   child: MediaQuery(
//                     data: MediaQuery.of(context).copyWith(
//                       alwaysUse24HourFormat: true,
//                     ),
//                     child: child!,
//                   ),
//                 );
//               },
//             );
//             if (varisSaati == null || varisTarihi == null) {
//               _postWithRouteController.isVarisSelected = false;
//               _postWithRouteController.buttonColor = AppConstants().ltDarkGrey;
//             } else {
//               _postWithRouteController.isVarisSelected = true;
//               _postWithRouteController.buttonColor = AppConstants().ltMainRed;
//             }
//             _postWithRouteController.varisText =
//                 '${DateFormat('dd/MM/yyyy').format(varisTarihi!)} ' +
//                     (varisSaati == null
//                         ? ' - LUTFEN SAAT SECİNİZ!'
//                         : ' - ${varisSaati?.hour}:${varisSaati?.minute}');
//           },
//           child: Card(
//             elevation: 10,
//             child: SizedBox(
//               height: 40,
//               width: Get.width * 0.85,
//               child: Center(
//                   child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _postWithRouteController.varisText,
//                       style: TextStyle(
//                         color: AppConstants().ltDarkGrey,
//                       ),
//                     ),
//                     Icon(
//                       Icons.calendar_month,
//                       color: AppConstants().ltDarkGrey,
//                     ),
//                   ],
//                 ),
//               )),
//             ),
//           ),
//         ),
//       ),
//       Step(
//         title: Text(
//           'Açıklama (Zorunlu)',
//           style: TextStyle(
//             fontFamily: 'Sfbold',
//             color: _postWithRouteController.currentStep >= 2
//                 ? AppConstants().ltMainRed
//                 : AppConstants().ltDarkGrey,
//           ),
//         ),
//         subtitle: _postWithRouteController.isAciklamaFilled
//             ? Text(
//                 _postWithRouteController.aciklamaText,
//                 style: TextStyle(
//                   fontFamily: 'Sfbold',
//                   color: AppConstants().ltDarkGrey,
//                   fontSize: 10,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               )
//             : SizedBox(),
//         isActive: _postWithRouteController.currentStep >= 2 ? true : false,
//         content: Card(
//           elevation: 10,
//           child: SizedBox(
//             width: Get.width * 0.85,
//             child: TextFormField(
//               controller: aciklamaController,
//               minLines: 6,
//               maxLines: 8,
//               onChanged: (value) {
//                 if (value.isNotEmpty) {
//                   _postWithRouteController.buttonColor =
//                       AppConstants().ltMainRed;
//                   _postWithRouteController.isAciklamaFilled = true;
//                 } else {
//                   _postWithRouteController.buttonColor =
//                       AppConstants().ltDarkGrey;
//                   _postWithRouteController.isAciklamaFilled = false;
//                 }
//                 _postWithRouteController.aciklamaText = value;
//               },
//               decoration: InputDecoration(
//                 fillColor: AppConstants().ltWhite,
//                 filled: true,
//                 hintText:
//                     'Yeni rotanız hakkında arkadaşlarınıza ne söylemek istersiniz?',
//                 hintStyle: TextStyle(fontSize: 14),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: AppConstants().ltWhite,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppConstants().ltWhite),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: AppConstants().ltWhite,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       Step(
//         title: Text(
//           'Fotoğraf',
//           style: TextStyle(
//             fontFamily: 'Sfbold',
//             color: _postWithRouteController.currentStep >= 3
//                 ? AppConstants().ltMainRed
//                 : AppConstants().ltDarkGrey,
//           ),
//         ),
//         isActive: _postWithRouteController.currentStep >= 3 ? true : false,
//         content: Container(
//           // TODO: foto yukleme islemleri yapılacak
//           height: Get.height * 0.15,
//           width: Get.width * 0.6,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.7),
//             boxShadow: [],
//             borderRadius: BorderRadius.circular(5),
//             border: RDottedLineBorder.all(
//               dottedLength: 15,
//               dottedSpace: 5,
//               width: 1,
//               color: AppConstants().ltMainRed.withOpacity(0.7),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Icon(
//                 Icons.photo,
//                 color: AppConstants().ltMainRed.withOpacity(0.7),
//                 size: Get.height * 0.07,
//               ),
//               Text(
//                 'Fotoğraf Ekle',
//                 style: TextStyle(
//                   color: AppConstants().ltMainRed.withOpacity(0.7),
//                   fontFamily: 'Sfbold',
//                 ),
//               ),
//               Text(
//                 '(Maksimum boyut: 20 MB)',
//                 style: TextStyle(
//                   color: AppConstants().ltMainRed.withOpacity(0.7),
//                   fontFamily: 'Sfbold',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ];
//   }
// }
