import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/models/stories/user_stories.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

import '../../export.dart';

class StoriesPaginationController extends GetxController {
  @override
  Future<void> onInit() async {
    await addList(1);
    fillList();
    super.onInit();
  }

  final RxInt currentPage = 1.obs;
  final RxInt totalPage = 1.obs;
  final RxInt userId = 0.obs;

  RxBool isLoading = false.obs;

  RxList<Result?> snapshotList = <Result?>[].obs;

  Future<void> addList(int page) async {
    try {
      isLoading.value = true;
      UserStoriesResponse? response = await GeneralServicesTemp()
          .makeGetRequest("/stories/user-stories/${userId.value}?page=$page", {
        "Content-type": "application/json",
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
      }).then((value) {
        isLoading.value = false;
        if (value != null) {
          return UserStoriesResponse.fromJson(json.decode(value));
        }
        return null;
      });
      if (response == null) {
        return;
      }
      //print("totalPage.value 1 = " + totalPage.value.toString());
      totalPage.value = response.data![0].stories!.pagination!.totalPage!;
      print("a = ${totalPage.value}");
      //print("totalPage.value 2 = " + totalPage.value.toString());

      update(["userStories"]);
    } catch (e) {
      log("STORYYYWİEEWW ADDLİST ERR -> $e");
    }
    isLoading.value = false;
  }

  fillList() async {
    isLoading.value = true;
    try {
      for (int i = 0; i < totalPage.value; i++) {
        currentPage.value = i + 1;

        UserStoriesResponse? response = await GeneralServicesTemp()
            .makeGetRequest(
                "/stories/user-stories/${userId.value}?page=${currentPage.value}",
                {
              "Content-type": "application/json",
              'Authorization':
                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
            }).then((value) {
          isLoading.value = false;
          if (value != null) {
            return UserStoriesResponse.fromJson(json.decode(value));
          }
          return null;
        });
        if (response == null) {
          return;
        }
        //print("totalPage.value 1 = " + totalPage.value.toString());
        //totalPage.value = response.data![0].stories!.pagination!.totalPage!;
        //print("totalPage.value 2 = " + totalPage.value.toString());
        snapshotList.add(response.data![0].stories!.result![0]);
        print(snapshotList[i]!.url);
      }

      update(["userStories"]);
    } catch (e) {
      log("STORYYYWİEEWW ADDLİST ERR -> $e");
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    snapshotList.clear();
    totalPage.value = 0;
    log("STORYYYWİEEWW STORYTEMİZLENDEİ");
    super.dispose();
  }
}
