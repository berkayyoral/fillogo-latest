import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/user/search_user_request.dart';

class SearchUserController extends GetxController {


  SearchUserRequest searchUserRequest = SearchUserRequest();

  final RxString _searchRequestText = "".obs;
  String get searchRequestText => _searchRequestText.value;
  set searchRequestText(newValue) => _searchRequestText.value = newValue;
}
