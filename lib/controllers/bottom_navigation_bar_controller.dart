import 'package:fillogo/export.dart';

class BottomNavigationBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
