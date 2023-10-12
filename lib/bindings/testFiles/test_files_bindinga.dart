


import '../../export.dart';

class UserInfoBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserInfoController());
  }
}