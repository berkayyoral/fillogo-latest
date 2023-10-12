import '../../export.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
  }
}