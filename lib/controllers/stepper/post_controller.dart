import 'package:fillogo/export.dart';

class PostController extends GetxController {
  var _currentStep = 0.obs;
  var _buttonColor = Colors.grey.obs;
  var _aciklamaText = ''.obs;

  get currentStep {
    update();
    return _currentStep.value;
  }

  get buttonColor {
    update();
    return _buttonColor.value;
  }

  set currentStep(value) {
    update();
    _currentStep.value = value;
  }

  set buttonColor(value) {
    update();
    _buttonColor.value = value;
  }

  get aciklama {
    update();
    return _aciklamaText.value;
  }

  set aciklama(value) {
    update();
    _aciklamaText.value = value;
  }

  void arttir() {
    currentStep += 1;
  }

  void azalt() {
    currentStep -= 1;
  }
}
