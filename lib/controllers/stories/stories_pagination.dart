import 'dart:convert';

import 'package:fillogo/models/stories/user_stories.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

import '../../export.dart';

class StoriesPaginationController extends GetxController {
  final RxInt currentPage = 1.obs;
  final RxInt totalPage = 1.obs;
  final RxInt userId = 0.obs;

  RxList<Result?> snapshotList = <Result?>[].obs;

  Future<void> addList(int page) async {
    UserStoriesResponse? response = await GeneralServicesTemp()
        .makeGetRequest("/stories/user-stories/${userId.value}?page=$page", {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
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
  }

  void fillList() async {
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
  }
}
