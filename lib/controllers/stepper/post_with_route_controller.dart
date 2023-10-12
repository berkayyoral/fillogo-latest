import 'package:fillogo/export.dart';

class PostWithRouteController extends GetxController {
  var _currentStep = 0.obs;
  var _cikisText = 'Lütfen tarih ve saat seçiniz.'.obs;
  var _varisText = 'Lütfen tarih ve saat seçiniz.'.obs;
  var _aciklamaText = ''.obs;
  var _isCikisSelected = false.obs;
  var _isVarisSelected = false.obs;
  var _isAciklamaFilled = false.obs;
  var _buttonColor = AppConstants().ltDarkGrey.obs;

  get currentStep {
    return _currentStep.value;
  }

  set currentStep(value) {
    _currentStep.value = value;
  }

  get cikisText {
    return _cikisText.value;
  }

  set cikisText(value) {
    _cikisText.value = value;
  }

  get varisText {
    return _varisText.value;
  }

  set varisText(value) {
    _varisText.value = value;
  }

  get isCikisSelected {
    return _isCikisSelected.value;
  }

  set isCikisSelected(value) {
    _isCikisSelected.value = value;
  }

  get isVarisSelected {
    return _isVarisSelected.value;
  }

  set isVarisSelected(value) {
    _isVarisSelected.value = value;
  }

  get buttonColor {
    return _buttonColor.value;
  }

  set buttonColor(value) {
    _buttonColor.value = value;
  }

  get aciklamaText {
    return _aciklamaText.value;
  }

  set aciklamaText(value) {
    _aciklamaText.value = value;
  }

  get isAciklamaFilled {
    return _isAciklamaFilled.value;
  }

  set isAciklamaFilled(value) {
    _isAciklamaFilled.value = value;
  }
}
