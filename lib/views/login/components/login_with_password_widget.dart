import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/login/login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/login/login_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/notificaiton_service/one_signal_notification/one_signal_notification_service.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/widgets/custom_red_button.dart';
import 'package:fillogo/widgets/profilePhoto.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginWithPassword extends StatelessWidget {
  LoginWithPassword({
    super.key,
  });

  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.find<LoginController>();
  final RxBool obscureText = true.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Giriş yap',
            style: TextStyle(
              fontFamily: FontConstants.sfBlack,
              fontSize: 35.sp,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              ProfilePhoto(
                url: loginController.userProfilePicture.value,
                height: 65.w,
                width: 65.w,
              ),
              16.w.spaceX,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${loginController.userName.value.capitalizeFirst} ${loginController.userSurName.value.capitalizeFirst}',
                    style: TextStyle(
                      fontFamily: FontConstants.sfSemiBold,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  Obx(
                    () {
                      return Text(
                        loginController.userEmail.value,
                        style: TextStyle(
                          fontFamily: FontConstants.sfLight,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          Obx(() {
            return CustomTextField(
              textInputAction: TextInputAction.done,
              labelText: 'Parola',
              obscureText: obscureText.value,
              controller: passwordController,
              suffixIcon: TextButton(
                onPressed: () {
                  obscureText.value = !obscureText.value;
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      AppConstants().ltMainRed.withOpacity(0.1)),
                ),
                child: Text(
                  'Göster',
                  style: TextStyle(
                    fontFamily: FontConstants.sfMedium,
                    fontSize: 10.sp,
                    color: AppConstants().ltDarkGrey,
                  ),
                ),
              ),
            );
          }),
          CustomRedButton(
            onTap: () async {
              UiHelper.showLoadingAnimation(context);
              await GeneralServicesTemp()
                  .makePostRequest(
                EndPoint.login,
                LoginRequestModel(
                  phoneNumberOrMail: loginController.userEmail.value,
                  password: passwordController.text,
                ),
                ServicesConstants.appJsonWithoutAuth,
              )
                  .then(
                (value) async {
                  if (value != null) {
                    final response =
                        LoginResponseModel.fromJson(jsonDecode(value));
                    if (response.success == 1) {
                      LocaleManager.instance.setCryptedData(
                          PreferencesKeys.userCredentials,
                          '${loginController.userEmail.value}+${passwordController.text}');

                      await LocaleManager.instance.setInt(
                          PreferencesKeys.currentUserId,
                          response.data![0].user!.id!);
                      print(
                          "ONESİGNALm set id -> ${LocaleManager.instance.getInt(PreferencesKeys.currentUserId)}");
                      // OneSignal().setExternalUserId(
                      //     response.data![0].user!.id!.toString());
                      await OneSignalManager.setupOneSignal()
                          .then((value) => print("ONESİGNALMMMM OLLLkk "));
                      await OneSignal.login(
                              response.data![0].user!.id!.toString())
                          .then((value) => print("ONESİGNALm LOGİN OLDUMkkk"));

                      LocaleManager.instance.setString(
                          PreferencesKeys.currentuserpassword,
                          passwordController.text);
                      LocaleManager.instance.setString(
                          PreferencesKeys.currentUserUserName,
                          response.data![0].user!.username!);
                      LocaleManager.instance.setString(
                          PreferencesKeys.currentUserName,
                          response.data![0].user!.name!);
                      LocaleManager.instance.setString(
                          PreferencesKeys.currentUserSurname,
                          response.data![0].user!.surname!);
                      response.data![0].user!.phoneNumber == null
                          ? LocaleManager.instance.setString(
                              PreferencesKeys.currentUserPhone, "5320000000")
                          : LocaleManager.instance.setString(
                              PreferencesKeys.currentUserPhone,
                              response.data![0].user!.phoneNumber!);
                      LocaleManager.instance.setString(
                          PreferencesKeys.currentUserMail,
                          response.data![0].user!.mail!);
                      LocaleManager.instance.setString(
                          PreferencesKeys.currentUserProfilPhoto,
                          response.data![0].user!.profilePicture ??
                              'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png');
                      log("kankaaaaaa ${LocaleManager.instance.getString(PreferencesKeys.currentuserpassword)}");
                      LocaleManager.instance
                          .setBool(PreferencesKeys.isOnboardViewed, true);
                      Get.back();
                      Get.offAllNamed(NavigationConstants.bottomNavigationBar);
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
                    } else {
                      Get.back();
                      return Get.snackbar(
                          "Hata", "Lütfen giriş bilgilerinizi kontrol ediniz",
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  }
                },
              );
            },
            title: 'Giriş Yap',
          ),
          TextButton(
            onPressed: () {
              loginController.processCounter.value++;
              loginController.containerHeight.value = 236.h;
            },
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
            ),
            child: Text(
              'Şifremi unuttum',
              style: TextStyle(
                fontFamily: FontConstants.sfSemiBold,
                fontSize: 13.sp,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
