import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/widgets/map_view/button_description_widget.dart';

class VisibilityStatusWidget extends StatelessWidget {
  const VisibilityStatusWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapPageMController mapPageMController = Get.find();
    return Obx(
      () => mapPageMController.isCreateRoute.value
          ? Container()
          : Positioned(
              top: 160.h,
              right: 0.w,
              child: Container(
                height: 270.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// GÖRÜNÜRLÜK
                    Expanded(
                      child: visibilityOrAvabilityWidget(
                          mapPageMController, context, isForVisibility: true,
                          onTap: () async {
                        SetCustomMarkerIconController
                            customMarkerIconController = Get.find();
                        await customMarkerIconController.setCustomMarkerIcon3(
                            isOffVisibility: true);
                        print(
                            "AKTİFROTAM -> ${mapPageMController.isThereActiveRoute.value}");
                        if (mapPageMController.isThereActiveRoute.value) {
                          Get.snackbar("Başarısız!",
                              "Aktif rotanız varken görünürlük bilginiz kapatılamaz",
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: AppConstants().ltBlack);
                        } else {
                          mapPageMController.isRouteVisibilty.value =
                              !mapPageMController.isRouteVisibilty.value;

                          await GeneralServicesTemp().makePostRequest(
                            EndPoint.updateStatus,
                            {
                              "visible":
                                  mapPageMController.isRouteVisibilty.value,
                              "available":
                                  mapPageMController.isRouteAvability.value
                            },
                            {
                              "Content-type": "application/json",
                              'Authorization':
                                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                            },
                          ).then((value) => print(
                              "VİSİBİLİTY değişti  visib -> ${mapPageMController.isRouteVisibilty.value} avabil -> ${mapPageMController.isRouteAvability.value} re -> ${value}"));
                          mapPageMController.markers.removeWhere((marker) =>
                              marker.markerId.value == 'myLocationMarker');
                          LocaleManager.instance
                              .setBool(PreferencesKeys.isVisibility,
                                  mapPageMController.isRouteVisibilty.value)
                              .then((value) {
                            print(
                                "VİSİVİBİLTRMARKER -> ${LocaleManager.instance.getBool(PreferencesKeys.isVisibility)}");
                            return customMarkerIconController
                                .setCustomMarkerIcon3(
                                    isOffVisibility: mapPageMController
                                        .isRouteVisibilty.value);
                          });

                          Get.snackbar("Başarılı!",
                              "Görünürlüğünüz ${mapPageMController.isRouteVisibilty.value ? "Açıldı" : "Kapatıldı"}.",
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: AppConstants().ltBlack);
                        }
                      }),
                    ),

                    Expanded(
                      child: visibilityOrAvabilityWidget(
                          mapPageMController, context, isForVisibility: false,
                          onTap: () async {
                        mapPageMController.isRouteAvability.value =
                            !mapPageMController.isRouteAvability.value;

                        await GeneralServicesTemp().makePostRequest(
                          EndPoint.updateStatus,
                          {
                            "available":
                                mapPageMController.isRouteAvability.value,
                          },
                          {
                            "Content-type": "application/json",
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                          },
                        ).then((value) => print("AVABİLİTY değişti"));

                        Get.snackbar("Başarılı!",
                            "Müsaitlik bilginiz ${mapPageMController.isRouteAvability.value ? "Açıldı" : "Kapatıldı"}.",
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: AppConstants().ltBlack);
                      }),
                    ),

                    const Spacer()
                  ],
                ),
              ),
            ),
    );
  }

  Visibility visibilityOrAvabilityWidget(
    MapPageMController mapPageMController,
    BuildContext context, {
    required bool isForVisibility,
    required Future<void> Function() onTap,
  }) {
    return Visibility(
      visible:
          isForVisibility ? true : mapPageMController.isRouteVisibilty.value,
      child: Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
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
                    padding: EdgeInsets.all(4.w),
                    child: Icon(
                      isForVisibility ? Icons.remove_red_eye : Icons.car_repair,
                      color: isForVisibility
                          ? mapPageMController.isRouteVisibilty.value
                              ? AppConstants().ltMainRed
                              : AppConstants().ltDarkGrey
                          : mapPageMController.isRouteAvability.value
                              ? AppConstants().ltMainRed
                              : AppConstants().ltDarkGrey,
                    ),
                  ),
                ),
                ButtonTitleWidget(
                  title: isForVisibility
                      ? mapPageMController.isRouteVisibilty.value
                          ? "\tGörünür Olma\t"
                          : "\t\t\t\tGörünür Ol\t\t\t\t"
                      : mapPageMController.isRouteAvability.value
                          ? "\tMüsait\t"
                          : "\tMüsait Değil\t",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
