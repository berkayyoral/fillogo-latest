import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'dart:convert' as convert;

class FirstOpenIsActiveRoute extends GetxController {
  bool isActiveRoute = false;
  DateTime routeFinishDate = DateTime.now();

  void getIsActiveRoute() async {
    await GeneralServicesTemp()
        .makeGetRequest(
      EndPoint.getMyRoutes,
      ServicesConstants.appJsonWithToken,
    )
        .then(
      (value) async {
        GetMyRouteResponseModel getMyRouteResponseModel =
            GetMyRouteResponseModel.fromJson(convert.json.decode(value!));

        isActiveRoute =
            getMyRouteResponseModel.data![0].allRoutes!.activeRoutes!.isEmpty
                ? false
                : true;
        routeFinishDate = getMyRouteResponseModel
            .data![0].allRoutes!.activeRoutes![0].arrivalDate!;
      },
    );
    log("Aktif rota: " + isActiveRoute.toString());
    log("Aktif rota bitiş tarihi: " + routeFinishDate.toString());
    log("Aktif DateTime.now() : " + DateTime.now().toString());
    if (routeFinishDate.millisecondsSinceEpoch >
        DateTime.now().millisecondsSinceEpoch + 300000) {
      Get.dialog(
          barrierDismissible: false,
          Dialog(
            backgroundColor: AppConstants().ltWhite,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Rotanızın bitiş saati geldi."),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 24),
                    child: Text(
                      "Rotayı sonlandırmak ister misiniz?",
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                            child: Text(
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
    }
  }

  @override
  void onInit() {
    getIsActiveRoute();
    super.onInit();
  }
}
