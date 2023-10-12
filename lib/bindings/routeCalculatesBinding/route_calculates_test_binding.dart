import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/export.dart';

class RouteCalculatesTestBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SetCustomMarkerIconController());
    //Get.put(RouteCalculatesViewController());
  }
}
