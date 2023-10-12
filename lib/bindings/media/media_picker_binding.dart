import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/controllers/search/search_user_controller.dart';

import '../../export.dart';

class MediaPickerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MediaPickerController());
  }
}
