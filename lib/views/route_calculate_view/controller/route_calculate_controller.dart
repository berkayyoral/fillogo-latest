import 'package:get/get.dart';

class SearchRouteController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxBool showFilterButton = false.obs;
  RxBool showFilterOption = false.obs;
  RxList<bool> filterSelectedList = [false, false, false].obs;

  List<String> carTypeList = ["Ticari Araç"]; //"Otomobil", "Tır", "Motorsiklet"
  final List<String> filterOptionList = [
    "Ticari Araç",
    "Ağır Vasıta",
    "Motorsiklet"
  ];
  RxString selectedCarTypeOption = "".obs;
  // List<String> filterOptionList = [
  //   "Otomobil",
  //   "Tır",
  //   "Motorsiklet"
  // ]; //"Otomobil", "Tır", "Motorsiklet"

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
