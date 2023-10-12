import 'package:fillogo/export.dart';

class PopUpController extends GetxController {
  var isPressed = false.obs;
  pressFunction() {
    isPressed.value = !isPressed.value;
  }
}
