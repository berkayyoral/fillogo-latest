import 'package:fillogo/export.dart';

class LoginController extends GetxController {
  final RxDouble containerHeight = 360.h.obs;
  final RxDouble containerWidth = 341.w.obs;
  final RxInt processCounter = 0.obs;
  final RxString userEmail = ''.obs;
  final RxString userName = ''.obs;
  final RxString userSurName = ''.obs;
  final RxString userProfilePicture = ''.obs;
  final RxString authToken = ''.obs;
}
