import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'dart:convert' as convert;

import 'package:fillogo/views/map_page_view/components/map_page_controller.dart';

class FirstOpenIsActiveRoute extends GetxController {
  bool isActiveRoute = false;
  DateTime routeFinishDate = DateTime.now();

  void getIsActiveRoute() async {
    String? token =
        LocaleManager.instance.getString(PreferencesKeys.accessToken);

    if (token != null) {
      await GeneralServicesTemp()
          .makeGetRequest(
        EndPoint.getMyRoutes,
        ServicesConstants.appJsonWithToken,
      )
          .then(
        (value) async {
          GetMyRouteResponseModel? getMyRouteResponseModel =
              GetMyRouteResponseModel.fromJson(convert.json.decode(value!));
          if (getMyRouteResponseModel.data != null &&
              getMyRouteResponseModel
                  .data.first.allRoutes.activeRoutes!.isNotEmpty) {
            isActiveRoute =
                getMyRouteResponseModel.data[0].allRoutes.activeRoutes!.isEmpty
                    ? false
                    : true;
            routeFinishDate = getMyRouteResponseModel
                    .data[0].allRoutes.activeRoutes!.isNotEmpty
                ? getMyRouteResponseModel
                    .data[0].allRoutes.activeRoutes![0].arrivalDate
                : DateTime.now();

            routeFinishDate = routeFinishDate.add(Duration(hours: 3));

            // print("ROTANIZINBİTİSSAATİ ${getMyRouteResponseModel
            //   .data[0].allRoutes.activeRoutes![0].}");
          }
        },
      );

      // Şu anki tarih ve saat
      DateTime now = DateTime.now();

      // İki tarih arasındaki farkı hesapla
      Duration difference = routeFinishDate.difference(now);
      print(
          'ROTANIZINBİTİSSAATİ The given date is in the past by ${isActiveRoute}');

      if (difference.isNegative) {
        print(
            'ROTANIZINBİTİSSAATİ The given date is in the past by ${difference.abs()}');
      } else if (!difference.isNegative) {
        print(
            'ROTANIZINBİTİSSAATİ The given date is in the future by $difference');
      } else {
        print('ROTANIZINBİTİSSAATİ The given date is now.');
      }

      // if (routeFinishDate != DateTime.now() &&
      //     (routeFinishDate.millisecondsSinceEpoch >
      //         (DateTime.now().millisecondsSinceEpoch + 300000)))
      if (isActiveRoute && difference.isNegative) {
        Get.dialog(
            barrierDismissible: false,
            Dialog(
              backgroundColor: AppConstants().ltWhite,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text("Rotanızın bitiş saati geldi."),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                      child: Text(
                        "Rotayı sonlandırmak ister misiniz?",
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            MapPageMController mapPageController = Get.find();

                            GeneralServicesTemp().makePatchRequest(
                              EndPoint.activateRoute,
                              ActivateRouteRequestModel(
                                  routeId:
                                      mapPageController.myActivesRoutes[0].id),
                              {
                                "Content-type": "application/json",
                                'Authorization':
                                    'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                              },
                            ).then((value) {
                              ActivateRouteResponseModel response =
                                  ActivateRouteResponseModel.fromJson(
                                      jsonDecode(value!));
                              if (response.success == 1) {
                                BerkayController berkayController =
                                    Get.find<BerkayController>();
                                berkayController.isAlreadyHaveRoute = false.obs;

                                mapPageController.markers.clear();

                                mapPageController.polylines.clear();
                                mapPageController.markers.clear();
                              }
                            });

                            Get.back();
                          },
                          child: Center(
                            child: Container(
                              height: 36,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppConstants().ltMainRed,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Text(
                                "Evet",
                                style: TextStyle(color: AppConstants().ltWhite),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Center(
                            child: Container(
                              height: 36,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppConstants().ltWhiteGrey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Text(
                                "Hayır",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      } else {}
    }
  }

  @override
  void onInit() {
    getIsActiveRoute();
    super.onInit();
  }
}
