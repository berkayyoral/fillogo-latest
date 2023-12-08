import 'package:fillogo/export.dart';

class DropdownController extends GetxController {
  final _dropdownValue = 0.obs;
  get dropdownValue => _dropdownValue.value;
  set dropdownValue(value) => _dropdownValue.value = value;
}
