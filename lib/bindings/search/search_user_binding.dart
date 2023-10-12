import 'package:fillogo/controllers/search/search_user_controller.dart';

import '../../export.dart';

class SearchUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchUserController());
  }
}
