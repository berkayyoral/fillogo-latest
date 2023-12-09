import 'package:fillogo/controllers/stepper/post_with_route_controller.dart';

import '../../export.dart';

class PostWithRouteStepperBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostWithRouteController());
  }
}
