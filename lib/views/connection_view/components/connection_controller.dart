import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/followers/search_followers_request.dart';
import 'package:fillogo/models/search/following/search_following_request.dart';
import 'package:fillogo/models/user/profile/user_profile.dart';

class ConnectionsController extends GetxController {
  final _user = Users().obs;
  Users get user => _user.value;
  set user(newUser) => _user.value = newUser;

  final RxInt _followerCount = 0.obs;
  int get followerCount => _followerCount.value;
  set followerCount(newValue) => _followerCount.value = newValue;

  final RxInt _followingCount = 0.obs;
  int get followingCount => _followingCount.value;
  set followingCount(newValue) => _followingCount.value = newValue;

  final RxInt _routeCount = 0.obs;
  int get routeCount => _routeCount.value;
  set routeCount(newValue) => _routeCount.value = newValue;
  SearchFollowersRequest searchFollowersRequest = SearchFollowersRequest();
  SearchFollowingRequest searchFollowingRequest = SearchFollowingRequest();

  final RxString _searchRequestText = "".obs;
  String get searchRequestText => _searchRequestText.value;
  set searchRequestText(newValue) => _searchRequestText.value = newValue;
}
