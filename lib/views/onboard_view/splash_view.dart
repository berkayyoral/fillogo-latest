import 'dart:convert';

import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/onboard/onboard_one_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../../core/constants/enums/preference_keys_enum.dart';
import '../../core/constants/navigation_constants.dart';
import '../../core/init/locale/locale_manager.dart';
import '../../models/user/login/login_model.dart';
import '../../services/general_sevices_template/general_services.dart';
import '../../services/socket/socket_service.dart';
import 'onboard_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //onboard daha önce görüldüyse initial route => welcome login,
    bool isOnboardViewed =
        LocaleManager.instance.getBool(PreferencesKeys.isOnboardViewed) ??
            false;
    String initialRoute = isOnboardViewed
        ? NavigationConstants.welcomelogin
        : NavigationConstants.onboardone;
    //
    print("LOGİNİÇİNUSERINFO  initial-> ${initialRoute}");
    // yerelde kayıtlı username ve passwordu çeker. null gelirse '' şeklinde kalır
    String? userCredentials = LocaleManager.instance
            .getCryptedData(PreferencesKeys.userCredentials) ??
        '';

    Timer(const Duration(seconds: 3), () async {
      if (LocaleManager.instance.getString(PreferencesKeys.accessToken) ==
          null) {
        if (!mounted) return;

        Get.toNamed(NavigationConstants.onboards);
      } else {
        if (userCredentials != '') {
          print("LOGİNMAİNRES userCredentials -> ${userCredentials}");
          GeneralServicesTemp()
              .makePostRequest(
            EndPoint.login,
            LoginRequestModel(
              phoneNumberOrMail: userCredentials.split('+').first,
              password: userCredentials.split('+').last,
            ),
            ServicesConstants.appJsonWithoutAuth,
          )
              .then((value) async {
            if (value != null) {
              final response = LoginResponseModel.fromJson(jsonDecode(value));
              print("LOGİNİÇİNUSERINFO GİRİŞ NULDEĞİL ${jsonEncode(response)}");
              if (response.success == 1) {
                await LocaleManager.instance.setBool(
                    PreferencesKeys.isVisibility,
                    !response.data![0].user!.isInvisible!);
                await LocaleManager.instance.setBool(
                    PreferencesKeys.isAvability,
                    response.data![0].user!.isAvailable!);
                MapPageMController mapPageMController = Get.find();

                print(
                    "VİSİORAVA VİSİVİBİLTRMARKER visibli -> ${response.data![0].user!.isInvisible!} / ${LocaleManager.instance.getBool(PreferencesKeys.isVisibility)}");
                print(
                    "VİSİORAVA VİSİVİBİLTRMARKER availb -> ${response.data![0].user!.isAvailable!} / ${LocaleManager.instance.getBool(PreferencesKeys.isAvability)}");
                mapPageMController.isRouteVisibilty.value =
                    !response.data![0].user!.isInvisible!;
                print(
                    "VİSİORAVA mappage availb -> ${mapPageMController.isRouteVisibilty.value} ");
                LocaleManager.instance.setInt(
                    PreferencesKeys.currentUserId, response.data![0].user!.id!);
                LocaleManager.instance.setString(
                    PreferencesKeys.currentUserUserName,
                    response.data![0].user!.username!);
                LocaleManager.instance.setInt(
                    PreferencesKeys.currentUserId, response.data![0].user!.id!);
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
                Get.toNamed(NavigationConstants.bottomNavigationBar);
                // Get.rootDelegate
                //     .toNamed(NavigationConstants.bottomNavigationBar);
              } else {
                Get.toNamed(NavigationConstants.welcomelogin);
                print("LOGİNİÇİNUSERINFO GİRİŞ NULDEĞİL burda");
              }
            }
          });
        }
        // LoginViewController loginViewController =
        //     Get.put(LoginViewController());
        // String userCredentials = LocaleManager.instance
        //     .getCryptedData(PreferencesKeys.userCredentials)!;
        // String email = userCredentials.split(' ').first;
        // String password = userCredentials.split(' ').last;
        // loginViewController.login(
        //     isSplash: true, phone: email, password: password);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants().ltMainRed,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstants().ltMainRed,
              AppConstants().ltMainRed,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset("assets/logo/logo-2.png"),
        ),
      ),
    );
  }
}
