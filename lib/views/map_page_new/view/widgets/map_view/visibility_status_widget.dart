import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';

class VisibilityStatusWidget extends StatelessWidget {
  const VisibilityStatusWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapPageMController mapPageMController = Get.find();
    return Obx(
      () => Positioned(
        top: 220.h,
        right: 0,
        child: Container(
          height: 230.h,
          child: Column(
            children: [
              /// GÖRÜNÜRLÜK
              Expanded(
                child: visibilityOrAvabilityWidget(mapPageMController, context,
                    isForVisibility: true, onTap: () async {
                  mapPageMController.isRouteVisibilty.value =
                      !mapPageMController.isRouteVisibilty.value;

                  await GeneralServicesTemp().makePostRequest(
                    EndPoint.updateStatus,
                    {
                      "visible": mapPageMController.isRouteVisibilty.value,
                      "available": mapPageMController.isRouteAvability.value
                    },
                    {
                      "Content-type": "application/json",
                      'Authorization':
                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                    },
                  ).then((value) => print(
                      "VİSİBİLİTY değişti  visib -> ${mapPageMController.isRouteVisibilty.value} avabil -> ${mapPageMController.isRouteAvability.value} re -> ${value}"));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Görünürlüğünüz ${mapPageMController.isRouteVisibilty.value ? "Açıldı" : "Kapatıldı"}."),
                    ),
                  );
                }),
              ),

              Expanded(
                child: visibilityOrAvabilityWidget(mapPageMController, context,
                    isForVisibility: false, onTap: () async {
                  mapPageMController.isRouteAvability.value =
                      !mapPageMController.isRouteAvability.value;

                  await GeneralServicesTemp().makePostRequest(
                    EndPoint.updateStatus,
                    {
                      "available": mapPageMController.isRouteAvability.value,
                    },
                    {
                      "Content-type": "application/json",
                      'Authorization':
                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                    },
                  ).then((value) => print("AVABİLİTY değişti"));

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Müsaitlik bilginiz ${mapPageMController.isRouteAvability.value ? "Açıldı" : "Kapatıldı"}."),
                    ),
                  );
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
        padding: EdgeInsets.only(right: 10.w),
        child: Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 45.w,
              width: 45.w,
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
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  isForVisibility ? Icons.remove_red_eye : Icons.car_repair,
                  color: mapPageMController.isRouteVisibilty.value
                      ? AppConstants().ltMainRed
                      : AppConstants().ltDarkGrey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
