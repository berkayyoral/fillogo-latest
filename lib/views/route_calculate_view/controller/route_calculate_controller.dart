import 'package:get/get.dart';

class SearchRouteController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool showFilterButton = false.obs;
  RxList<bool> filterSelectedList = [true, true, true].obs;
  List<String> carTypeList = ["Otomobil", "Tır", "Motorsiklet"];

  RxBool showOnlyMap = false.obs;

  void fillCarTypeList() {
    carTypeList.clear();
    if (filterSelectedList[0]) {
      carTypeList.add("Otomobil");
    }
    if (filterSelectedList[1]) {
      carTypeList.add("Tır");
    }
    if (filterSelectedList[2]) {
      carTypeList.add("Motorsiklet");
    }
  }
}
