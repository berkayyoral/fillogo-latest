import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/models/post/get_home_post.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
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
        snapshotList.add(response.data![0].result![i]);
        print(
            "BUPINGILIZCENEDEN Ğ-> ${snapshotList[0]!.post!.createdAt!.toString()}");
        print(
            "BUPINGILIZCENEDEN Ğ-> ${timeago.format(DateTime.parse(snapshotList[0]!.post!.createdAt!.toString()), locale: "TR")}");
      }
    }

    update(["homePage"]);
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
    super.onInit();
  }
}
