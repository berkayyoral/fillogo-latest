import '../../controllers/dropdown/dropdown_controller.dart';
import '../../export.dart';

class DropdownBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DropdownController());
  }
}
