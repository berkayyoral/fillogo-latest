import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/delete_route_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../controllers/map/get_current_location_and_listen.dart';
import '../map_page_view/components/map_page_controller.dart';
import '../route_details_page_view/components/selected_route_controller.dart';

class MyRoutesPageView extends StatelessWidget {
  MyRoutesPageView({super.key});

  CreatePostPageController createPostPageController = Get.find();
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();
  MapPageController mapPageController = Get.find<MapPageController>();
  GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  DateFormat inputFormat = DateFormat('dd.MM.yyyy');

  BerkayController berkayController = Get.put(BerkayController());
  SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 2.w,
            ),
            child: SvgPicture.asset(
              height: 20.h,
              width: 20.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Rotalarım",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: GetBuilder<MapPageController>(
        id: "mapPageController",
        initState: (_) async {
          //mapPageController.getMyRoutesServicesRequestRefreshable();
          mapPageController.getMyRoutesServicesRequestRefreshable();
        },
        builder: (_) {
          return SizedBox(
            height: Get.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButtonDesign(
                      text: 'Yeni Rota Oluştur',
                      textColor: AppConstants().ltWhite,
                      onpressed: () {
                        bottomNavigationBarController.selectedIndex.value = 1;
                        mapPageController.selectedDispley.value = 0;
                        mapPageController.iWantTrackerMyLocation.value = 2;
                        mapPageController.changeCalculateLevel(2);
                        mapPageController
                            .addMarkerFunctionForMapPageWithoutOnTap2(
                          const MarkerId("myLocationMarker"),
                          LatLng(
                            getMyCurrentLocationController
                                .myLocationLatitudeDo.value,
                            getMyCurrentLocationController
                                .myLocationLongitudeDo.value,
                          ),
                          mapPageController.mapPageRouteStartAddress2.value,
                          BitmapDescriptor.fromBytes(mapPageController
                              .customMarkerIconController.mayLocationIcon!),
                        );
                        Get.back();
                      },
                      iconPath: '',
                      color: AppConstants().ltMainRed,
                      height: 50.h,
                      width: 341.w,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Visibility(
                      visible: mapPageController.myActivesRoutes!.isNotEmpty,
                      child: Text(
                        'Aktif Rotam',
                        style: TextStyle(
                          fontFamily: 'Sfsemibold',
                          fontSize: 20.sp,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: mapPageController.myActivesRoutes!.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              //height: 95.h,
                              child: mapPageController
                                      .myActivesRoutes!.isNotEmpty
                                  ? ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: mapPageController
                                          .myActivesRoutes!.length,
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      "Bu Rotayı Silmek İstiyor musunuz?",
                                                    ),
                                                    titlePadding:
                                                        const EdgeInsets.all(32),
                                                    titleTextStyle: TextStyle(
                                                        fontSize: 22,
                                                        color: AppConstants()
                                                            .ltBlack),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          GeneralServicesTemp()
                                                              .makeDeleteRequest(
                                                            EndPoint
                                                                .deleteRoute,
                                                            DeleteRouteRequestModel(
                                                                routeId:
                                                                    mapPageController
                                                                        .myActivesRoutes![
                                                                            i]
                                                                        .id!),
                                                            {
                                                              "Content-type":
                                                                  "application/json",
                                                              'Authorization':
                                                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                            },
                                                          ).then((value) async {
                                                            var response =
                                                                DeleteRouteResponseModel
                                                                    .fromJson(
                                                                        jsonDecode(
                                                                            value!));
                                                            if (response
                                                                    .success ==
                                                                1) {
                                                              //  mapPageController
                                                              //    .updateMyRoutesView();
                                                              mapPageController
                                                                  .selectedDispley(
                                                                      1);

                                                              mapPageController
                                                                  .markers2
                                                                  .clear();
                                                              mapPageController
                                                                  .polylineCoordinates
                                                                  .clear();
                                                              mapPageController
                                                                  .polylineCoordinates2
                                                                  .clear();
                                                              mapPageController
                                                                  .polylineCoordinatesListForB
                                                                  .clear();
                                                              mapPageController
                                                                  .polylines
                                                                  .clear();
                                                              mapPageController
                                                                  .polylines2
                                                                  .clear();
                                                              CameraPosition(
                                                                bearing: 90,
                                                                tilt: 45,
                                                                target: LatLng(
                                                                  getMyCurrentLocationController
                                                                      .myLocationLatitudeDo
                                                                      .value,
                                                                  getMyCurrentLocationController
                                                                      .myLocationLongitudeDo
                                                                      .value,
                                                                ),
                                                                zoom: 14,
                                                              );

                                                              mapPageController
                                                                  .getMyRoutesServicesRequestRefreshable();
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              bottomNavigationBarController
                                                                  .selectedIndex
                                                                  .value = 1;

                                                              Get.snackbar(
                                                                  "Başarılı!",
                                                                  "Rota başarıyla silindi.",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  colorText:
                                                                      AppConstants()
                                                                          .ltBlack);
                                                            } else {
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              Get.snackbar(
                                                                  "Bir hata ile karşılaşıldı!",
                                                                  "Lütfen tekrar deneyiniz.",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  colorText:
                                                                      AppConstants()
                                                                          .ltBlack);
                                                            }
                                                          });
                                                        },
                                                        color: AppConstants()
                                                            .ltMainRed,
                                                        child: Text(
                                                          "Evet",
                                                          style: TextStyle(
                                                              color:
                                                                  AppConstants()
                                                                      .ltWhite),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text("Hayır"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: RouteDetailsIntoRoutesWidget(
                                            onTap: () {
                                              berkayController
                                                  .canVisible.value = false;
                                              selectedRouteController
                                                      .selectedRouteId.value =
                                                  mapPageController
                                                      .myActivesRoutes![i].id!;
                                              Get.toNamed(NavigationConstants
                                                  .routeDetails);
                                            },
                                            startPoint: mapPageController
                                                .myActivesRoutes![i]
                                                .startingCity!,
                                            endPoint: mapPageController
                                                .myActivesRoutes![i]
                                                .endingCity!,
                                            userName: mapPageController
                                                .myNameAndSurname.value,
                                            endDate: mapPageController
                                                .myActivesRoutes![i].arrivalDate
                                                .toString()
                                                .split(" ")[0],
                                            startDate: mapPageController
                                                .myActivesRoutes![i]
                                                .departureDate
                                                .toString()
                                                .split(" ")[0],
                                          ),
                                        );
                                      },
                                    )
                                  : UiHelper.notFoundAnimationWidget(
                                      context, "Şu an aktif rotan yok!"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: mapPageController.mynotStartedRoutes!.isNotEmpty,
                      child: Text(
                        'Gelecek Tarihli Rotalarım',
                        style: TextStyle(
                          fontFamily: 'Sfsemibold',
                          fontSize: 20.sp,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: mapPageController.mynotStartedRoutes!.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              //height: 295.h,
                              child: mapPageController
                                      .mynotStartedRoutes!.isNotEmpty
                                  ? ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: mapPageController
                                          .mynotStartedRoutes!.length,
                                      itemBuilder: (context, i) {
                                        log(mapPageController
                                            .mynotStartedRoutes![i].id
                                            .toString());
                                        return GestureDetector(
                                          onLongPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      "Bu Rotayı Silmek İstiyor musunuz?",
                                                    ),
                                                    titlePadding:
                                                        const EdgeInsets.all(32),
                                                    titleTextStyle: TextStyle(
                                                        fontSize: 22,
                                                        color: AppConstants()
                                                            .ltBlack),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          GeneralServicesTemp()
                                                              .makeDeleteRequest(
                                                            EndPoint
                                                                .deleteRoute,
                                                            DeleteRouteRequestModel(
                                                                routeId:
                                                                    mapPageController
                                                                        .mynotStartedRoutes![
                                                                            i]
                                                                        .id!),
                                                            {
                                                              "Content-type":
                                                                  "application/json",
                                                              'Authorization':
                                                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                            },
                                                          ).then((value) {
                                                            var response =
                                                                DeleteRouteResponseModel
                                                                    .fromJson(
                                                                        jsonDecode(
                                                                            value!));
                                                            if (response
                                                                    .success ==
                                                                1) {
                                                              mapPageController
                                                                  .getMyRoutesServicesRequestRefreshable();
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              Get.snackbar(
                                                                  "Başarılı!",
                                                                  "Rota başarıyla silindi.",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  colorText:
                                                                      AppConstants()
                                                                          .ltBlack);
                                                            } else {
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              Get.snackbar(
                                                                  "Bir hata ile karşılaşıldı!",
                                                                  "Lütfen tekrar deneyiniz.",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  colorText:
                                                                      AppConstants()
                                                                          .ltBlack);
                                                            }
                                                          });
                                                        },
                                                        color: AppConstants()
                                                            .ltMainRed,
                                                        child: Text(
                                                          "Evet",
                                                          style: TextStyle(
                                                              color:
                                                                  AppConstants()
                                                                      .ltWhite),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text("Hayır"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: RouteDetailsIntoRoutesWidget(
                                            onTap: () {
                                              berkayController
                                                  .canVisible.value = true;
                                              selectedRouteController
                                                      .selectedRouteId.value =
                                                  mapPageController
                                                      .mynotStartedRoutes![i]
                                                      .id!;
                                              Get.toNamed(NavigationConstants
                                                  .routeDetails);
                                            },
                                            startPoint: mapPageController
                                                .mynotStartedRoutes![i]
                                                .startingCity!,
                                            endPoint: mapPageController
                                                .mynotStartedRoutes![i]
                                                .endingCity!,
                                            userName: mapPageController
                                                .myNameAndSurname.value,
                                            endDate: inputFormat.format(
                                                DateTime.parse(mapPageController
                                                    .mynotStartedRoutes![i]
                                                    .arrivalDate
                                                    .toString()
                                                    .split(" ")[0])),
                                            startDate: inputFormat.format(
                                                DateTime.parse(mapPageController
                                                    .mynotStartedRoutes![i]
                                                    .departureDate
                                                    .toString()
                                                    .split(" ")[0])),
                                          ),
                                        );
                                      },
                                    )
                                  : UiHelper.notFoundAnimationWidget(
                                      context, "Şu an aktif rotan yok!"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: mapPageController.myPastsRoutes!.isNotEmpty,
                      child: Text(
                        'Geçmiş Rotalarım',
                        style: TextStyle(
                          fontFamily: 'Sfsemibold',
                          fontSize: 20.sp,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: mapPageController.myPastsRoutes!.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              //height: 595.h,
                              child: mapPageController.myPastsRoutes!.isNotEmpty
                                  ? ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: mapPageController
                                          .myPastsRoutes!.length,
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      "Bu Rotayı Silmek İstiyor musunuz?",
                                                    ),
                                                    titlePadding:
                                                        const EdgeInsets.all(32),
                                                    titleTextStyle: TextStyle(
                                                        fontSize: 22,
                                                        color: AppConstants()
                                                            .ltBlack),
                                                    actions: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          GeneralServicesTemp()
                                                              .makeDeleteRequest(
                                                            EndPoint
                                                                .deleteRoute,
                                                            DeleteRouteRequestModel(
                                                                routeId:
                                                                    mapPageController
                                                                        .myPastsRoutes![
                                                                            i]
                                                                        .id!),
                                                            {
                                                              "Content-type":
                                                                  "application/json",
                                                              'Authorization':
                                                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                                            },
                                                          ).then((value) {
                                                            var response =
                                                                DeleteRouteResponseModel
                                                                    .fromJson(
                                                                        jsonDecode(
                                                                            value!));
                                                            if (response
                                                                    .success ==
                                                                1) {
                                                              mapPageController
                                                                  .getMyRoutesServicesRequestRefreshable();
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              Get.snackbar(
                                                                  "Başarılı!",
                                                                  "Rota başarıyla silindi.",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  colorText:
                                                                      AppConstants()
                                                                          .ltBlack);
                                                            } else {
                                                              Get.back(
                                                                  closeOverlays:
                                                                      true);
                                                              Get.snackbar(
                                                                  "Bir hata ile karşılaşıldı!",
                                                                  "Lütfen tekrar deneyiniz.",
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  colorText:
                                                                      AppConstants()
                                                                          .ltBlack);
                                                            }
                                                          });
                                                        },
                                                        color: AppConstants()
                                                            .ltMainRed,
                                                        child: Text(
                                                          "Evet",
                                                          style: TextStyle(
                                                              color:
                                                                  AppConstants()
                                                                      .ltWhite),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text("Hayır"),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: RouteDetailsIntoRoutesWidget(
                                            onTap: () {
                                              berkayController
                                                  .canVisible.value = false;
                                              selectedRouteController
                                                      .selectedRouteId.value =
                                                  mapPageController
                                                      .myPastsRoutes![i].id!;
                                              Get.toNamed(NavigationConstants
                                                  .routeDetails);
                                            },
                                            startPoint: mapPageController
                                                .myPastsRoutes![i]
                                                .startingCity!,
                                            endPoint: mapPageController
                                                .myPastsRoutes![i].endingCity!,
                                            userName: mapPageController
                                                .myNameAndSurname.value,
                                            endDate: inputFormat.format(
                                                DateTime.parse(mapPageController
                                                    .myPastsRoutes![i]
                                                    .arrivalDate
                                                    .toString()
                                                    .split(" ")[0])),
                                            startDate: inputFormat.format(
                                                DateTime.parse(mapPageController
                                                    .myPastsRoutes![i]
                                                    .departureDate
                                                    .toString()
                                                    .split(" ")[0])),
                                          ),
                                        );
                                      },
                                    )
                                  : UiHelper.notFoundAnimationWidget(
                                      context, "Şu an aktif rotan yok!"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.h.spaceY,
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RouteDetailsIntoRoutesWidget extends StatelessWidget {
  RouteDetailsIntoRoutesWidget(
      {super.key,
      required this.startPoint,
      required this.endPoint,
      required this.userName,
      required this.startDate,
      required this.endDate,
      required this.onTap});

  String startPoint;
  String endPoint;
  String userName;
  String startDate;
  String endDate;

  CreatePostPageController createPostPageController = Get.find();
  StartEndAdressController startEndAdressController =
      Get.find<StartEndAdressController>();

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8.r,
              ),
            ),
            color: AppConstants().ltWhiteGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 276.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/route-icon.svg',
                        height: 40.w,
                        width: 40.w,
                        color: AppConstants().ltMainRed,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.w,
                            right: 10.w,
                          ),
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontFamily: 'Sflight',
                              fontSize: 14.sp,
                              color: AppConstants().ltDarkGrey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 4.w,
                            right: 10.w,
                          ),
                          child: Text(
                            "$startPoint -> $endPoint",
                            style: TextStyle(
                              fontFamily: 'Sfmedium',
                              fontSize: 16.sp,
                              color: AppConstants().ltLogoGrey,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 4.w,
                                right: 4.w,
                              ),
                              child: Text(
                                startDate,
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 14.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 14.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.w,
                                left: 4.w,
                                right: 10.w,
                              ),
                              child: Text(
                                endDate,
                                style: TextStyle(
                                  fontFamily: 'Sflight',
                                  fontSize: 14.sp,
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                child: GestureDetector(
                  onTap: () async {
                    createPostPageController.changeHaveRoute(0);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/arrow-right.svg',
                    height: 24.w,
                    width: 24.w,
                    color: AppConstants().ltMainRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
