import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_friends_matching_routes.dart';

class SelectedRouteController extends GetxController {
  var selectedRouteId = 0.obs;
  var selectedRouteUserId = 0.obs;
  MatchedOn? matchedOn;
}
