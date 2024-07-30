import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/route_info_widget.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../../export.dart';

class CreateRouteView extends StatelessWidget {
  final RxBool isCreateRoute;
  CreateRouteView({super.key, required this.isCreateRoute});

  final CreateRouteController createRouteController =
      Get.put(CreateRouteController());
  final MapPageMController mapPageMController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Obx(
        () => isCreateRoute.value
            ? Container(
                height: createRouteController.finishRouteAdress.value != ""
                    ? createRouteController.isOpenRouteDetailEntrySection.value
                        ? 650.h
                        : 350.h
                    : 240.h, //240.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants().ltLogoGrey.withOpacity(0.2),
                      spreadRadius: 0.r,
                      blurRadius: 10.r,
                    ),
                  ],
                  color: AppConstants().ltWhite,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          isCreateRoute.value = false;
                          createRouteController
                              .isOpenRouteDetailEntrySection.value = false;
                          createRouteController.routePolyline.value = "";
                          createRouteController.routePolyline.value = "";
                          mapPageMController.polylines.clear();
                          mapPageMController.polylineCoordinates.clear();
                          mapPageMController.markers.clear();
                          mapPageMController.addMarkerIcon(
                              markerID: "myLocationMarker",
                              location: LatLng(
                                  mapPageMController.currentLocationController
                                      .myLocationLatitudeDo.value,
                                  mapPageMController.currentLocationController
                                      .myLocationLongitudeDo.value));
                          createRouteController.clearFinishRouteInfo();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          child: SvgPicture.asset(
                            "assets/icons/close-icon.svg",
                            width: 32.w,
                          ),
                        ),
                      ),
                    ),
                    !createRouteController.isOpenRouteDetailEntrySection.value
                        ? Column(
                            children: [
                              selectRouteCities(
                                  context: context, isStartCity: true),
                              selectRouteCities(
                                  context: context, isStartCity: false)
                            ],
                          )
                        : Container(),
                    createRouteController.finishRouteAdress.value != ""
                        ? const CreateRouteInfoWidget()
                        : Container(),
                  ],
                ),
              )
            : mapPageMController.isThereActiveRoute.value
                ? Container()
                : GestureDetector(
                    onTap: () {
                      print(
                          "ROUTEVİSİBLİYTTY -> ${mapPageMController.isRouteVisibilty.value}");
                      if (!mapPageMController.isRouteVisibilty.value) {
                        Get.snackbar("Başarısız!",
                            "Görünürlüğünüz kapalıyken rota oluşturamazsınız..",
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: AppConstants().ltBlack);
                      } else {
                        isCreateRoute.value = true;
                        if (createRouteController.startRouteCity == "") {
                          createRouteController.startRouteLocation.value =
                              LatLng(
                                  createRouteController
                                      .currentLocationController
                                      .myLocationLatitudeDo
                                      .value,
                                  createRouteController
                                      .currentLocationController
                                      .myLocationLongitudeDo
                                      .value);
                          createRouteController.getRouteInfo();
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.w),
                      padding: EdgeInsets.all(4.w),
                      height: 50.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppConstants().ltLogoGrey.withOpacity(0.2),
                            spreadRadius: 0.r,
                            blurRadius: 10.r,
                          ),
                        ],
                        color: AppConstants().ltWhite,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/route-icon.svg',
                              color: AppConstants().ltMainRed,
                              width: 20.w,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Rota oluştur",
                              style: TextStyle(
                                color: AppConstants().ltLogoGrey,
                                fontFamily: "SfLight",
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  GestureDetector selectRouteCities(
      {required BuildContext context, required bool isStartCity}) {
    return GestureDetector(
      onTap: () async {
        try {
          Prediction? place = await PlacesAutocomplete.show(
              overlayBorderRadius: BorderRadius.circular(8.r),
              textDecoration: InputDecoration(
                labelStyle: TextStyle(
                  color: AppConstants().ltLogoGrey,
                  fontFamily: "SfLight",
                  fontSize: 12.sp,
                ),
              ),
              textStyle: TextStyle(
                color: AppConstants().ltLogoGrey,
                fontFamily: "SfLight",
                fontSize: 12.sp,
              ),
              resultTextStyle: TextStyle(
                color: AppConstants().ltBlack,
                fontFamily: "SfLight",
                fontSize: 12.sp,
              ),
              logo: const SizedBox(height: 0),
              backArrowIcon: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SvgPicture.asset(
                  "assets/icons/close-icon.svg",
                  width: 24.w,
                ),
              ),
              hint: isStartCity
                  ? 'Çıkış Noktası Giriniz'
                  : 'Varış Noktası Giriniz',
              context: context,
              apiKey: AppConstants.googleMapsApiKey,
              mode: Mode.overlay,
              types: [],
              strictbounds: false,
              components: [Component(Component.country, 'tr')],
              onError: (err) {
                print("VARIŞNOKTASIERR ÇIKIŞ -> ${err.errorMessage}");
              });

          PlacesDetailsResponse detail = await createRouteController
              .googleMapsPlaces
              .getDetailsByPlaceId(place!.placeId!);

          if (isStartCity) {
            createRouteController.startRouteLocation.value = LatLng(
                detail.result.geometry!.location.lat,
                detail.result.geometry!.location.lng);
            createRouteController.getRouteInfo();
          } else {
            createRouteController.finishRouteLocation.value = LatLng(
                detail.result.geometry!.location.lat,
                detail.result.geometry!.location.lng);
            createRouteController.getRouteInfo(isStartLocation: false);
          }

          print(
              "CREATEROUTE starts adres -> ${createRouteController.startRouteAdress.value}");
        } catch (e) {
          print("CREATEROUTE error-> $e");
        }
      },
      child: Container(
        margin: EdgeInsets.all(10.w),
        padding: EdgeInsets.all(4.w),
        height: 50.h,
        width: 330.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 10.r,
            ),
          ],
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/route-icon.svg',
                color: AppConstants().ltMainRed,
                width: 20.w,
              ),
              SizedBox(width: 12.w),
              Obx(
                () => Expanded(
                  child: Text(
                    isStartCity
                        ? createRouteController.startRouteAdress.value != ""
                            ? createRouteController.startRouteAdress.value
                            : "Çıkış noktasını giriniz..."
                        : createRouteController.finishRouteAdress.value != ""
                            ? createRouteController.finishRouteAdress.value
                            : "Varış Noktasını Giriniz...",
                    style: TextStyle(
                      color: AppConstants().ltLogoGrey,
                      fontFamily: "SfLight",
                      fontSize: 12.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
