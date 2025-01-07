import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/models/post/get_home_post.dart';
import 'package:fillogo/models/user/get_user_car_types.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../export.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  final RxInt currentPage = 1.obs;
  final RxInt totalPage = 1.obs;
  final RxDouble scrollOffset = (600.0).obs;
  final ScrollController scrollController = ScrollController();
  RxList<Result?> snapshotList = <Result?>[].obs;

  RxBool isRefresh = false.obs;
  GeneralDrawerController drawerController = Get.find();
  VehicleInfoController vehicleInfoController =
      Get.put(VehicleInfoController());
  void fillList(int page) async {
    GetHomePostResponse? response = await GeneralServicesTemp()
        .makeGetRequest("/posts/get-home-posts?page=$page", {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
      if (value != null) {
        return GetHomePostResponse.fromJson(json.decode(value));
      }
      return null;
    });
    if (response == null) {
      return;
    }
    if (response.data!.isNotEmpty) {
      totalPage.value = response.data![0].pagination!.totalPage!;
      for (int i = 0; i < response.data![0].result!.length; i++) {
        snapshotList.value.add(response.data![0].result![i]);
      }
    }

    update(["homePage"]);
    update(["comment"]);
    update(["like"]);
    update(["homePagem"]);
  }

  void addList(int page) async {
    GetHomePostResponse? response = await GeneralServicesTemp()
        .makeGetRequest("/posts/get-home-posts?page=$page", {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
      if (value != null) {
        return GetHomePostResponse.fromJson(json.decode(value));
      }
      return null;
    });
    if (response == null) {
      return;
    }
    for (int i = 0; i < response.data![0].result!.length; i++) {
      snapshotList.add(response.data![0].result![i]);
    }
    update(["homePage"]);
    update(["homePagem"]);
  }

  @override
  void onInit() {
    fillList(1);
    scrollController.addListener(() {
      if (scrollController.position.pixels > scrollOffset.value &&
          currentPage <= totalPage.value) {
        log('ISTEK ATILDI #########');
        currentPage.value += 1;
        scrollOffset.value += 700.0;
        addList(currentPage.value);
        update();
      }
    });

    print("POSTFLOWAÇILDIIIIII");
    GeneralServicesTemp().makeGetRequest(EndPoint.getUserCarTypes, {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
      var response = GetUserCarTypesResponse.fromJson(json.decode(value!));
      print("aaa $response");
      print("aaa $value");

      if (response.succes == 1) {
        vehicleInfoController.vehicleMarka =
            response.data![0].userCarTypes![0].carBrand.toString().obs;
        vehicleInfoController.vehicleModel =
            response.data![0].userCarTypes![0].carModel.toString().obs;
      } else {
        print("Response Hata = ${response.message}");
        print("Response Hata = ${response.succes}");
      }
    });

    super.onInit();
  }
}
