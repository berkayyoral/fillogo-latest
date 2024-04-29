import 'dart:convert';
import 'package:fillogo/models/user/login/login_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'export.dart';
import 'services/notificaiton_service/one_signal_notification/one_signal_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await LocaleManager.instance.preferencesInit();
  // await initializeDateFormatting('tr_TR');
  SocketService.instance().connect();
  OneSignalNotificationService();
  OneSignalNotificationService().handleClickNotification();
  //HttpOverrides.global = MyHttpOverrides();

  // onboard daha önce görüldüyse initial route => welcome login,
  bool isOnboardViewed =
      LocaleManager.instance.getBool(PreferencesKeys.isOnboardViewed) ?? false;
  String initialRoute = isOnboardViewed
      ? NavigationConstants.welcomelogin
      : NavigationConstants.onboardone;
  //

  // yerelde kayıtlı username ve passwordu çeker. null gelirse '' şeklinde kalır
  String? userCredentials =
      LocaleManager.instance.getCryptedData(PreferencesKeys.userCredentials) ??
          '';
  //

  // login isteği atar, success 1 dönerse inital route => bottomNavigationBar
  if (userCredentials != '') {
    await GeneralServicesTemp()
        .makePostRequest(
      EndPoint.login,
      LoginRequestModel(
        phoneNumberOrMail: userCredentials.split('+').first,
        password: userCredentials.split('+').last,
      ),
      ServicesConstants.appJsonWithoutAuth,
    )
        .then((value) {
      if (value != null) {
        final response = LoginResponseModel.fromJson(jsonDecode(value));
        if (response.success == 1) {
          LocaleManager.instance.setInt(
              PreferencesKeys.currentUserId, response.data![0].user!.id!);
          LocaleManager.instance.setString(PreferencesKeys.currentUserUserName,
              response.data![0].user!.username!);
          LocaleManager.instance.setString(
              PreferencesKeys.currentUserProfilPhoto,
              response.data![0].user!.profilePicture ??
                  'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png');
          LocaleManager.instance.setString(
            PreferencesKeys.accessToken,
            response.data![0].tokens!.accessToken!,
          );
          LocaleManager.instance.setString(
            PreferencesKeys.refreshToken,
            response.data![0].tokens!.refreshToken!,
          );

          SocketService.instance()
              .socket
              .emit("new-user-add", response.data![0].user!.id!);
          initialRoute = NavigationConstants.bottomNavigationBar;
        }
      }
    });
  }
  //

  bool isDarkMode =
      LocaleManager.instance.getBool(PreferencesKeys.isDarkMode) ??
          Get.isPlatformDarkMode;
  String languageCode =
      LocaleManager.instance.getString(PreferencesKeys.languageCode) ??
          Get.deviceLocale?.languageCode ??
          AppConstants.defaultLanguage;
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(
    ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: UiHelper.designSize,
      builder: (context, child) => GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale("tr", "TR"),
        ],
        locale: const Locale("tr", "TR"),
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        getPages: NavigationService.routes,
        initialRoute:
            initialRoute, // inital route yukarda belirtildiği gibi belirlenir... :)
        initialBinding: InitialBinding(), // Initial binding always run
        theme: AppTheme.instance.lightTheme,
        darkTheme: AppTheme.instance.darkTheme,
        themeMode:
            ThemeMode.light, //isDarkMode ? ThemeMode.dark : ThemeMode.light,
        translations: Languages(),
      ),
    ),
  );
}
 //githubcheck
 