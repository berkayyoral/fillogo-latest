import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/map/get_current_location_and_listen.dart';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/create_route_view.dart';
import 'package:fillogo/views/map_page_new/view/matching_routes_view.dart';
import 'package:fillogo/views/map_page_new/view/widgets/map_view/active_route_info_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/map_view/car_filter_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/map_view/visibility_status_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/matching_routes/matching_routes_button.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// konsolu "NEWMAP" ile takip edebiliriz
class MapPageViewM extends StatelessWidget {
  MapPageViewM({super.key});
  final MapPageMController mapPageMController = Get.find();
  final NotificationController notificationController = Get.find();
  final GeneralDrawerController mapPageDrawerController =
      Get.find<GeneralDrawerController>();
  final GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  @override
  Widget build(BuildContext context) {
    mapPageMController.context = context;
    return SafeArea(
      child: Scaffold(
        key: mapPageDrawerController.mapPageScaffoldKey,
        appBar: AppBarGenel(
          leading: GestureDetector(
            onTap: () {
              mapPageDrawerController.openMapPageScaffoldDrawer();
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 5.h,
              ),
              child: SvgPicture.asset(
                height: 25.h,
                width: 25.w,
                'assets/icons/open-drawer-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
          title: Image.asset(
            'assets/logo/logo-1.png',
            height: 40,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(NavigationConstants.notifications);
                notificationController.isUnOpenedNotification.value = false;
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: 5.w,
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SvgPicture.asset(
                      height: 20.h,
                      width: 20.w,
                      'assets/icons/notification-icon.svg',
                      color: AppConstants().ltLogoGrey,
                    ),
                    Obx(() =>
                        notificationController.isUnOpenedNotification.value
                            ? CircleAvatar(
                                radius: 6.h,
                                backgroundColor: AppConstants().ltMainRed,
                              )
                            : const SizedBox())
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Get.toNamed(NavigationConstants.message);
                notificationController.isUnReadMessage.value = false;
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: 5.w,
                  right: 20.w,
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/message-icon.svg',
                      height: 20.h,
                      width: 20.w,
                      color: const Color(0xff3E3E3E),
                    ),
                    Obx(() => notificationController.isUnReadMessage.value
                        ? CircleAvatar(
                            radius: 6.h,
                            backgroundColor: AppConstants().ltMainRed,
                          )
                        : const SizedBox())
                  ],
                ),
              ),
            ),
          ],
        ),
        drawer: NavigationDrawerWidget(),
        body: Stack(
          children: [
            ///MAP
            Obx(
              () {
                return mapPageMController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        height: mapPageMController.isCreateRoute.value
                            ? 270.h
                            : Get.height,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            mapPageMController.mapController = controller;
                          },
                          initialCameraPosition: CameraPosition(
                            bearing: 90,
                            tilt: 45,
                            target: LatLng(
                              getMyCurrentLocationController
                                  .myLocationLatitudeDo.value,
                              getMyCurrentLocationController
                                  .myLocationLongitudeDo.value,
                            ),
                            zoom: 15,
                          ),
                          onCameraMoveStarted: () async {},
                          onCameraMove: (position) {},
                          onCameraIdle: () async {
                            LatLngBounds bounds = await mapPageMController
                                .mapController!
                                .getVisibleRegion();
                            LatLng center = LatLng(
                              (bounds.northeast.latitude +
                                      bounds.southwest.latitude) /
                                  2,
                              (bounds.northeast.longitude +
                                      bounds.southwest.longitude) /
                                  2,
                            );

                            ///Haritayı hareket ettirince görünen yerin ortasındaki konumla kendi konumumu karşılaştırır / burda sadece latitude değerlerini karşılaştırdık
                            int count = getSameDigitsCount(
                                center.latitude.toString(),
                                mapPageMController.currentLocationController
                                    .myLocationLatitudeDo.value
                                    .toString());
                            print(
                                "NEWMAP Haritanın merkezi: ${center.latitude}, ${center.longitude}\n\t NEWMAP Haritanın merkezi: ${mapPageMController.currentLocationController.myLocationLatitudeDo.value}, ${mapPageMController.currentLocationController.myLocationLongitudeDo.value}\n\t SAME ->NEWMAP COUNT -> $count");

                            if (count < 7) {
                              mapPageMController.shouldUpdateLocation.value =
                                  false;
                            }
                          },
                          markers: Set<Marker>.from(
                              mapPageMController.markers.value),
                          polylines: Set<Polyline>.of(
                              mapPageMController.polylines.value),
                          myLocationEnabled: true,
                          compassEnabled: false,
                          myLocationButtonEnabled: false,
                          mapType: MapType.normal,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                        ),
                      );
              },
            ),

            ///ARAÇ TÜRÜ FİLTRESİ
            CarFilterOptionWidget(mapPageMController: mapPageMController),

            ///GÖRÜNÜRLÜK-MÜSAİTLİK BİLGİSİ
            const VisibilityStatusWidget(),

            /// ORTALA BUTONU
            // getMapCenter(),

            /// ORTALAMA BUTONU (sağ üstteki)
            getMyLocationButton(
                isActiveRoute:
                    mapPageMController.isThereActiveRoute.value ? true : false),

            CreateRouteView(isCreateRoute: mapPageMController.isCreateRoute),

            ActiveRouteInfoWidget(context: context),

            const MatchingRoutesButton(isMatchingRoute: true),
            const MatchingRoutesWidget(),
          ],
        ),
      ),
    );
  }

  Obx getMapCenter() {
    return Obx(
      () {
        return mapPageMController.shouldUpdateLocation.value
            ? Container()
            : Positioned(
                bottom: mapPageMController.isThereActiveRoute.value
                    ? mapPageMController.finishRouteButton.value
                        ? 170.h
                        : 110.h
                    : 65.h,
                left: 6.w,
                child: InkWell(
                  onTap: () async {
                    mapPageMController.getMyLocationInMap();
                  },
                  child: Container(
                    width: 100.w,
                    margin: EdgeInsets.all(4.w),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppConstants().ltMainRed.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.location_on),
                        Text(
                          "Ortala",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  getMyLocationButton({required bool isActiveRoute}) {
    return Obx(() => mapPageMController.isCreateRoute.value
        ? Container()
        : Positioned(
            top: 330.h,
            right: 5.w,
            child: InkWell(
              onTap: () async {
                mapPageMController.getMyLocationInMap();
                mapPageMController.getUsersOnArea(
                    carTypeFilter: mapPageMController.carTypeList);
              },
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  color: AppConstants().ltWhiteGrey,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: SvgPicture.asset(
                    "assets/icons/getMyLocationIcon2.svg",
                    height: 24.w,
                    color: AppConstants().ltMainRed,
                  ),
                ),
              ),
            ),
          ));
  }

  int getSameDigitsCount(String str1, String str2) {
    int minLength = str1.length < str2.length ? str1.length : str2.length;
    int count = 0;

    for (int i = 0; i < minLength; i++) {
      if (str1[i] == str2[i]) {
        count++;
      } else {
        break;
      }
    }

    return count;
  }
}
