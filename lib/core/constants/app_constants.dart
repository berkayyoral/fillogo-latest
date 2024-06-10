import 'package:fillogo/export.dart';

class AppConstants {
  static const String appName = 'App Name';
  static String baseURL = "https://fillogo.com/test/api";
  static const String fontFamily = 'Sfuidisplay';
  static const String defaultLanguage = 'tr';
  static const int responseTimeout = 60;
  static int indexNavigation = 0;
  static int selectedDestination = 0;
  static const String oneSignalAppId = '43ddc771-f2eb-4ecf-bcc8-95434809b1dc';
  static const String googleMapsApiKey =
      "AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8";
  static const String googleMapsGetPolylineLink =
      "https://routes.googleapis.com/directions/v2:computeRoutes";

  String logoImagePath = 'assets/logo/logo-2.png';

  Color ltWhite = const Color(0xFFFFFFFF);
  Color ltLogoGrey = const Color(0xFF3E3E3E);
  Color ltDarkGrey = const Color(0xFF7D7D7D);
  Color ltWhiteGrey = const Color(0xFFEDEDED);
  Color ltMainRed = const Color(0xFFA91916);
  Color ltBlack = const Color(0xFF000000);
  Color ltBlue = const Color(0xFF62a6ed);
}

class EndPoint {
  //users
  static const String login = "/users/login";
  static const String register = "/users/register";
  static const String routeLoginOrRegister = "/users/route-login-or-register";
  static const String mailSendCode = "/users/send-code";
  static const String mailCompareCode = "/users/compare-code";
  static const String addUserCarInfo = "/users/add-user-car-infos";
  static const String forgotPassSendCode = "/users/send-notverifacated-code";
  static const String forgotPassCompareCode = "/users/compare-code-password";
  static const String setNewPassword = "/users/set-password";
  static const String updateBanner = "/users/banner";
  static const String updateProfilePicture = "/users/profile-picture";
  static const String emojis = "/emojis";
  static const String getMyRoutes = "/routes/routes";
  static const String routesNew = "/routes/new";
  static const String getMyfriendsRoute = "/routes/myfriends-route";
  static const String setNewToken = "/users/set-new-token";
  static const String getRouteDetailsById = "/routes/getroute";
  static const String routesSearchByCitys = "/routes/search";
  static const String getNotifications = "/users/notifications?page=1";
  static const String deleteRoute = "/routes/delete-route";
  static const String activateRoute = "/routes/activate-route";
  static const String createStories = "/stories";
  static const String getUsersWithStories = "/stories/users-with-stories";
  static const String haveIStory = "/stories/my-stories?page=1";
  static const String followUser = "/users/follow-user/";
  static const String getMyfriendsMatchingRoutes = "/routes/matching";
  static const String deleteAccount = "/users/delete-account";
  static const String getCarTypes = "/users/get-car-types";
  static const String searchUserRoutes = "/users/search-user-routes";
  static const String updateProfile = "/users/update-user-profile";
  static const String blockUser = "/report/block-user/";
  static const String updateUserCarInfos = "/users/update-car-infos";
  static const String getUserCarTypes = "/users/user-car-types";
  static const String reportProblem = "/report/report-problem";
  static const String deletePost = "/posts/delete-post/";
  static const String deleteStory = "/stories/";
  static const String getMyFriendsCircular = "/routes/get-friends-on-circular";
}

class ServicesConstants {
  static const Map<String, String> appJsonWithoutAuth = {
    'Content-Type': 'application/json'
  };

  static Map<String, String> appJsonWithCustomToke(String authToken) {
    return {
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    };
  }

  static Map<String, String> appJsonWithToken = {
    'Authorization':
        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
    'Content-Type': 'application/json',
  };

  static Map<String, String> getPolylineRequestHeader = {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': AppConstants.googleMapsApiKey,
    'X-Goog-FieldMask':
        'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
  };
}

class FontConstants {
  static const String sfBlack = 'Sfblack';
  static const String sfBold = 'Sfbold';
  static const String sfHeavy = 'Sfheavy';
  static const String sfLight = 'Sflight';
  static const String sfMedium = 'Sfmedium';
  static const String sfSemiBold = 'Sfsemibold';
  static const String sfThin = 'Sfthin';
  static const String sfUlr = 'Sfsemibold';
}
