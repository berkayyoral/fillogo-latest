// import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
// import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
// import 'package:fillogo/widgets/custom_button_design.dart';
// import 'package:fillogo/widgets/popup_view_widget.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../../controllers/map/get_current_location_and_listen.dart';

// class CreatePostAddRoutePageView extends StatelessWidget {
//   CreatePostAddRoutePageView({super.key});

//   final CreatePostPageController createPostPageController = Get.find();
//   final BottomNavigationBarController bottomNavigationBarController =
//       Get.find<BottomNavigationBarController>();

//   final GetMyCurrentLocationController getMyCurrentLocationController =
//       Get.find<GetMyCurrentLocationController>();

//   // MapPageController mapPageController = Get.find<MapPageController>();
//   final MapPageMController mapPageController = Get.find();
//   final String currentUserName =
//       LocaleManager.instance.getString(PreferencesKeys.currentUserUserName)!;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarGenel(
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 20.w,
//               right: 2.w,
//             ),
//             child: SvgPicture.asset(
//               height: 20.h,
//               width: 20.w,
//               'assets/icons/back-icon.svg',
//               color: AppConstants().ltLogoGrey,
//             ),
//           ),
//         ),
//         title: Text(
//           "Rota Ekle",
//           style: TextStyle(
//             fontFamily: "Sfbold",
//             fontSize: 20.sp,
//             color: AppConstants().ltBlack,
//           ),
//         ),
//       ),
//       body: GetBuilder<MapPageMController>(
//         id: "mapPageMController",
//         initState: (_) async {
//           // mapPageController.getMyRoutesServicesRequestRefreshable();
//         },
//         builder: (_) {
//           return SizedBox(
//             height: Get.height,
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomButtonDesign(
//                       text: 'Yeni Rota Oluştur',
//                       textColor: AppConstants().ltWhite,
//                       onpressed: () {
//                         bottomNavigationBarController.selectedIndex.value = 1;

//                         mapPageController.addMarkerIcon(
//                             markerID: "myLocationMarker",
//                             location: LatLng(
//                                 getMyCurrentLocationController
//                                     .myLocationLatitudeDo.value,
//                                 getMyCurrentLocationController
//                                     .myLocationLongitudeDo.value));
//                         Get.back();
//                         Get.back();
//                       },
//                       iconPath: '',
//                       color: AppConstants().ltMainRed,
//                       height: 50.h,
//                       width: 341.w,
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     Visibility(
//                       visible: mapPageController.myActivesRoutes!.isNotEmpty,
//                       child: Text(
//                         'Aktif Rotam',
//                         style: TextStyle(
//                           fontFamily: 'Sfsemibold',
//                           fontSize: 20.sp,
//                           color: AppConstants().ltLogoGrey,
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: mapPageController.myActivesRoutes!.isNotEmpty,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               //height: 95.h,
//                               child:
//                                   mapPageController.myActivesRoutes!.isNotEmpty
//                                       ? ListView.builder(
//                                           physics:
//                                               const NeverScrollableScrollPhysics(),
//                                           shrinkWrap: true,
//                                           itemCount: mapPageController
//                                               .myActivesRoutes!.length,
//                                           itemBuilder: (context, i) {
//                                             return AddRouteIntoPostWidget(
//                                               startAdress: mapPageController
//                                                   .myActivesRoutes![i]
//                                                   .startingCity,
//                                               endAdress: mapPageController
//                                                   .myActivesRoutes![i]
//                                                   .endingCity,
//                                               userName:
//                                                   "${LocaleManager.instance.getString(PreferencesKeys.currentUserName)} ${LocaleManager.instance.getString(PreferencesKeys.currentUserSurname)}",
//                                               endDateTime: mapPageController
//                                                   .myActivesRoutes![i]
//                                                   .arrivalDate,
//                                               id: mapPageController
//                                                   .myActivesRoutes![i].id,
//                                               startDateTime: mapPageController
//                                                   .myActivesRoutes![i]
//                                                   .departureDate,
//                                             );
//                                           },
//                                         )
//                                       : UiHelper.notFoundAnimationWidget(
//                                           context, "Şu an aktif rotan yok!"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: mapPageController.mynotStartedRoutes!.isNotEmpty,
//                       child: Text(
//                         'Gelecek Tarihli Rotalarım',
//                         style: TextStyle(
//                           fontFamily: 'Sfsemibold',
//                           fontSize: 20.sp,
//                           color: AppConstants().ltLogoGrey,
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: mapPageController.mynotStartedRoutes!.isNotEmpty,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               //height: 295.h,
//                               child: mapPageController
//                                       .mynotStartedRoutes!.isNotEmpty
//                                   ? ListView.builder(
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: mapPageController
//                                           .mynotStartedRoutes!.length,
//                                       itemBuilder: (context, i) {
//                                         return AddRouteIntoPostWidget(
//                                           startAdress: mapPageController
//                                               .mynotStartedRoutes![i]
//                                               .startingCity,
//                                           endAdress: mapPageController
//                                               .mynotStartedRoutes![i]
//                                               .endingCity,
//                                           userName:
//                                               ("${LocaleManager.instance.getString(PreferencesKeys.currentUserName)} ${LocaleManager.instance.getString(PreferencesKeys.currentUserSurname)}"),
//                                           endDateTime: mapPageController
//                                               .mynotStartedRoutes![i]
//                                               .arrivalDate,
//                                           id: mapPageController
//                                               .mynotStartedRoutes![i].id,
//                                           startDateTime: mapPageController
//                                               .mynotStartedRoutes![i]
//                                               .departureDate,
//                                         );
//                                       },
//                                     )
//                                   : UiHelper.notFoundAnimationWidget(
//                                       context, "Şu an aktif rotan yok!"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: mapPageController.myPastsRoutes!.isNotEmpty,
//                       child: Text(
//                         'Geçmiş Rotalarım',
//                         style: TextStyle(
//                           fontFamily: 'Sfsemibold',
//                           fontSize: 20.sp,
//                           color: AppConstants().ltLogoGrey,
//                         ),
//                       ),
//                     ),
//                     Visibility(
//                       visible: mapPageController.myPastsRoutes!.isNotEmpty,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               //height: 595.h,
//                               child: mapPageController.myPastsRoutes!.isNotEmpty
//                                   ? ListView.builder(
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: mapPageController
//                                           .myPastsRoutes!.length,
//                                       itemBuilder: (context, i) {
//                                         return AddRouteIntoPostWidget(
//                                           startAdress: mapPageController
//                                               .myPastsRoutes![i].startingCity,
//                                           endAdress: mapPageController
//                                               .myPastsRoutes![i].endingCity,
//                                           userName:
//                                               ("${LocaleManager.instance.getString(PreferencesKeys.currentUserName)} ${LocaleManager.instance.getString(PreferencesKeys.currentUserSurname)}"),
//                                           endDateTime: mapPageController
//                                               .myPastsRoutes![i].arrivalDate,
//                                           id: mapPageController
//                                               .myPastsRoutes![i].id,
//                                           startDateTime: mapPageController
//                                               .myPastsRoutes![i].departureDate,
//                                         );
//                                       },
//                                     )
//                                   : UiHelper.notFoundAnimationWidget(
//                                       context, "Şu an aktif rotan yok!"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     10.h.spaceY,
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class AddRouteIntoPostWidget extends StatelessWidget {
//   AddRouteIntoPostWidget({
//     super.key,
//     required this.userName,
//     required this.id,
//     required this.startAdress,
//     required this.endAdress,
//     required this.startDateTime,
//     required this.endDateTime,
//   });
//   final int id;
//   final String userName;
//   final String startAdress;
//   final String endAdress;
//   final DateTime startDateTime;
//   final DateTime endDateTime;

//   CreatePostPageController createPostPageController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.h),
//       child: GestureDetector(
//         onTap: () async {
//           createPostPageController.routeId.value = id;
//           createPostPageController.haveRoute.value = 1;
//           createPostPageController.userName.value = userName;
//           // createPostPageController.routeContent.value =
//           //     '$startAdress -> $endAdress';
//           // createPostPageController.routeEndDate.value = endAdress;
//           showDialog(
//             context: context,
//             builder: (BuildContext context) => ShowAllertDialogWidget(
//               button1Color: AppConstants().ltMainRed,
//               button1Height: 50.h,
//               button1IconPath: '',
//               button1Text: 'Tamam',
//               button1TextColor: AppConstants().ltWhite,
//               button1Width: Get.width,
//               buttonCount: 1,
//               discription1:
//                   "Seçmiş olduğunuz rota başarıyla gönderinize eklendi.",
//               onPressed1: () {
//                 Get.back();
//                 Get.back();
//               },
//               title: 'Rota Başarıyla Eklendi',
//               note: 'Rotayı kaldırmak isterseniz "X" butonuna basabilirsiniz.',
//             ),
//           );
//         },
//         child: Container(
//           height: 70.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 8.r,
//               ),
//             ),
//             color: AppConstants().ltWhiteGrey,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 290.w,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 10.w,
//                       ),
//                       child: SvgPicture.asset(
//                         'assets/icons/route-icon.svg',
//                         height: 40.w,
//                         width: 40.w,
//                         color: AppConstants().ltMainRed,
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 4.w,
//                             right: 10.w,
//                           ),
//                           child: Text(
//                             userName,
//                             style: TextStyle(
//                               fontFamily: 'Sflight',
//                               fontSize: 14.sp,
//                               color: AppConstants().ltDarkGrey,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 4.w,
//                             right: 10.w,
//                           ),
//                           child: Text(
//                             "$startAdress -> $endAdress",
//                             style: TextStyle(
//                               fontFamily: 'Sfmedium',
//                               fontSize: 16.sp,
//                               color: AppConstants().ltLogoGrey,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(
//                                 top: 2.w,
//                                 left: 4.w,
//                                 right: 4.w,
//                               ),
//                               child: Text(
//                                 "${startDateTime.year}-${startDateTime.month}-${startDateTime.day}",
//                                 style: TextStyle(
//                                   fontFamily: 'Sflight',
//                                   fontSize: 14.sp,
//                                   color: AppConstants().ltDarkGrey,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(),
//                               child: Text(
//                                 '-',
//                                 style: TextStyle(
//                                   fontFamily: 'Sflight',
//                                   fontSize: 14.sp,
//                                   color: AppConstants().ltDarkGrey,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(
//                                 top: 2.w,
//                                 left: 4.w,
//                                 right: 10.w,
//                               ),
//                               child: Text(
//                                 "${endDateTime.year}-${endDateTime.month}-${endDateTime.day}",
//                                 style: TextStyle(
//                                   fontFamily: 'Sflight',
//                                   fontSize: 14.sp,
//                                   color: AppConstants().ltDarkGrey,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: 10.w,
//                   right: 10.w,
//                 ),
//                 child: GestureDetector(
//                   onTap: () async {
//                     createPostPageController.changeHaveRoute(0);
//                   },
//                   child: SvgPicture.asset(
//                     'assets/icons/arrow-right.svg',
//                     height: 24.w,
//                     width: 24.w,
//                     color: AppConstants().ltMainRed,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
