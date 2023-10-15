import 'package:fillogo/controllers/media/media_controller.dart';

import '../../export.dart';

class MediaPickerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MediaPickerController());
  }
}
