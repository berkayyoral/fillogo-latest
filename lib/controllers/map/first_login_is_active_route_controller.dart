import 'dart:async';
import 'dart:convert';
import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/map/start_or_delete_route_dialog.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/activate_route_model.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'dart:convert' as convert;

class FirstOpenIsActiveRoute extends GetxController {
  bool isActiveRoute = false;
  DateTime routeFinishDate = DateTime.now();

  DateTime? targetDate = DateTime(2024, 8, 9, 10, 5);
  Timer? timer;
  int? isNotStartedRouteID;
  MyRoutesDetails? myNextRoute;

  MapPageMController mapPageController = Get.put(MapPageMController());

  void checkRoutes(List<MyRoutesDetails> routes) {
    DateTime now = DateTime.now();
    Duration closestDuration =
        Duration(days: 365); // Başlangıçta uzak bir tarih

    for (MyRoutesDetails route in routes) {
      print(
          'ROTANIZINBASLANGICSAATİ Route k ${route.departureDate.isBefore(now)} ');
      print(
          'ROTANIZINBASLANGICSAATİ Route k ${route.departureDate.isBefore(now)} ');
      if (route.departureDate.isBefore(now)) {
        print(
            'ROTANIZINBASLANGICSAATİ Route on ${route.departureDate} has passed.');
        myNextRoute = route;
        StartOrRouteRouteDialog.show(
            isStartDatePast: true,
            startCity: myNextRoute!.startingCity,
            finishCity: myNextRoute!.endingCity,
            departureTime: myNextRoute!.departureDate,
            routeId: myNextRoute!.id,
            myNextRoute: myNextRoute);
      } else {
        if (route.departureDate.year == now.year &&
            route.departureDate.month == now.month &&
            route.departureDate.day == now.day) {
          Duration duration = route.departureDate.difference(now).abs();
          if (duration < closestDuration) {
            closestDuration = duration;
            targetDate = route.departureDate;
          }

          // startTimer();
        }
        targetDate = route.departureDate.add(
          Duration(
            seconds: 5,
          ),
        );
        print(
            'ROTANIZINBASLANGICSAATİ Route on ${route.departureDate} is upcoming.');
      }
    }
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    timer = Timer.periodic(duration, (Timer timer) {
      print("ROUTETİMER -> ${timer.tick}");
      DateTime now = DateTime.now();
      if (now.isAfter(targetDate!)) {
        print("ROUTETİMER ->zaman geldi");
        timer.cancel();
        // StartOrRouteRouteDialog.show(isStartDatePast: false);
        print("ROUTETİMER ->zaman geldi çalıştı");
        // startOrDeleteRouteDialog(isStartDatePast: false);
      }
    });
  }

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
          if (getMyRouteResponseModel
              .data[0].allRoutes.notStartedRoutes!.isNotEmpty) {
            checkRoutes(
                getMyRouteResponseModel.data[0].allRoutes.notStartedRoutes!);

            // startTimer();
          }

          print(
              "ROTANIZINBİTİSSAATİ gelecek geldi ->  ${LocaleManager.instance.getBool(PreferencesKeys.showStartRouteAlert)}");

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
          }
        },
      );

      // Şu anki tarih ve saat
      DateTime now = DateTime.now();

      // İki tarih arasındaki farkı hesapla
      Duration difference = routeFinishDate.difference(now);
      print('ROTANIZINBİTİSSAATİ  ${isActiveRoute}');
      print(
          "NOTİFYCMM ROTA BİLDİRİMİ GELDİ locale -> ${LocaleManager.instance.getBool(PreferencesKeys.showStartRouteAlert)}");

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

                                mapPageController.polylineCoordinates.clear();
                                mapPageController.polylines.clear();
                                mapPageController.markers.clear();
                                mapPageController.isThereActiveRoute.value =
                                    false;
                                mapPageController.getMyRoutes();
                                mapPageController.getUsersOnArea(
                                    carTypeFilter:
                                        mapPageController.carTypeList);
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
    LocaleManager.instance.setBool(PreferencesKeys.showStartRouteAlert, false);
    getIsActiveRoute();
    super.onInit();
  }
}
