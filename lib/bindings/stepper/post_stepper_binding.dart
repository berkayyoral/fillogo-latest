import 'package:fillogo/controllers/stepper/post_with_route_controller.dart';

import '../../controllers/stepper/post_controller.dart';
import '../../export.dart';

class PostStepperBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PostController());
  }
}
