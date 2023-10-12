import 'package:fillogo/views/route_details_page_view/components/route_details_page_controller.dart';
import '../../../export.dart';

class RouteDetailsPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RouteDetailsPageController());
  }
}