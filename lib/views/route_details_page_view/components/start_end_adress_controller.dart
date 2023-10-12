import 'package:fillogo/export.dart';

class StartEndAdressController extends GetxController {
  var startAdress = ''.obs;
  var endAdress = ''.obs;

  void changeStartAdress(String index) {
    startAdress.value = index;
  }

  void changeEndAdress(String index) {
    endAdress.value = index;
  }
}
