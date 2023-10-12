import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/models/post/get_home_post.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

import '../../export.dart';

class HomeController extends GetxController {
  final RxInt currentPage = 1.obs;
  final RxInt totalPage = 1.obs;
  final RxDouble scrollOffset = (600.0).obs;
  final ScrollController scrollController = ScrollController();
  RxList<Result?> snapshotList = <Result?>[].obs;

  void fillList(int page) async {
    GetHomePostResponse? response = await GeneralServicesTemp()
        .makeGetRequest("/posts/get-home-posts?page=${page}", {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
      if (value != null) {
        return GetHomePostResponse.fromJson(json.decode(value));
      }
    });
    if (response == null) {
      return;
    }
    totalPage.value = response.data![0].pagination!.totalPage!;
    for (int i = 0; i < response.data![0].result!.length; i++) {
      snapshotList.add(response.data![0].result![i]);
    }
    update(["homePage"]);
  }

  void addList(int page) async {
    GetHomePostResponse? response = await GeneralServicesTemp()
        .makeGetRequest("/posts/get-home-posts?page=${page}", {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
      if (value != null) {
        return GetHomePostResponse.fromJson(json.decode(value));
      }
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
