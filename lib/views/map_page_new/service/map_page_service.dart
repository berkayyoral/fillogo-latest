import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/core/constants/enums/preference_keys_enum.dart';
import 'package:fillogo/core/init/locale/locale_manager.dart';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';
import 'package:fillogo/models/routes_models/get_users_on_area.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'dart:convert' as convert;

class MapPageService {
  Future<UsersOnAreaModel?> getUsersOnArea(
      {required List<String> carTypeFilter}) async {
    UsersOnAreaModel? usersOnAreaModel;
    try {
      await GeneralServicesTemp().makePostRequest(
        EndPoint.getUsersOnArea,
        {
          "filter": carTypeFilter,
          "radius": 190000,
          "visibility": true,
          "availability": true
        },
        {
          "Content-type": "application/json",
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
        },
      ).then((value) {
        usersOnAreaModel =
            UsersOnAreaModel.fromJson(convert.json.decode(value!));
        print(
            "MAPPAGESERVİCE ONAREA -> ${usersOnAreaModel!.data!.first.length}");
        return usersOnAreaModel;
      });
    } catch (e) {
      print("MAPPAGESERVİCE error getUsersOnArea -> $e");
    }
    return usersOnAreaModel;
  }

  Future updateLocation({required double lat, required double long}) async {
    try {
      await GeneralServicesTemp().makePostRequest(
        EndPoint.updateLocation,
        {"lat": lat, "long": long},
        {
          "Content-type": "application/json",
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
        },
      );
      print("UPDATELOCATİON SUCCESS");
    } catch (e) {
      print("MAPPAGESERVİCE error updateLocation  -> $e");
    }
  }

  Future<List<Matching>?> getMatchingRoutes(
      {required String routePolylineCode}) async {
    try {
      GetMatchingRoutesResponse? matchingRoutesResponse;
      await GeneralServicesTemp().makePostRequest(
        EndPoint.getMatchingRoutes,
        GetMyFriendsMatchingRoutesRequest(
          startingCity: "",
          endingCity: "",
          route: routePolylineCode,
          carType: ["Tır", "Motorsiklet", "Otomobil"],
        ),
        {
          "Content-type": "application/json",
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
        },
      ).then((value) {
        matchingRoutesResponse =
            GetMatchingRoutesResponse.fromJson(convert.json.decode(value!));
      });
      return matchingRoutesResponse!.matchingRoutes![0].matching;
    } catch (e) {
      print("MapService GetMatchingRoutes error -> $e");
    }
  }
}