import 'package:fillogo/export.dart';

class PostWithRouteController extends GetxController {
  final _currentStep = 0.obs;
  final _cikisText = 'Lütfen tarih ve saat seçiniz.'.obs;
  final _varisText = 'Lütfen tarih ve saat seçiniz.'.obs;
  final _aciklamaText = ''.obs;
  final _isCikisSelected = false.obs;
  final _isVarisSelected = false.obs;
  final _isAciklamaFilled = false.obs;
  final _buttonColor = AppConstants().ltDarkGrey.obs;

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
