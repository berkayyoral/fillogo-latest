import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

class CreateNewPostPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostPageController());
  }
}
