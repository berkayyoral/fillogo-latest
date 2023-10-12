import 'dart:convert';

import 'package:fillogo/controllers/welcome_login/welcome_login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/welcome_login/mail_send_code_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/widgets/custom_red_button.dart';

class SendVerificationCode extends StatelessWidget {
  SendVerificationCode({
    super.key,
  });

  final WelcomeLoginController welcomeLoginController =
      Get.find<WelcomeLoginController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Doğrulama',
            style: TextStyle(
              fontFamily: FontConstants.sfBlack,
              fontSize: 35.sp,
              color: Colors.white,
            ),
          ),
          Obx(() {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Eposta adresinizi doğrulamak için ',
                    style: TextStyle(
                      fontFamily: FontConstants.sfLight,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: welcomeLoginController.userEmail.value,
                    style: TextStyle(
                      fontFamily: FontConstants.sfSemiBold,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: ' adresinize bir doğrulama kodu göndereceğiz',
                    style: TextStyle(
                      fontFamily: FontConstants.sfLight,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
          CustomRedButton(
            onTap: () async {
              UiHelper.showLoadingAnimation(context);
              await GeneralServicesTemp()
                  .makePostRequest(
                EndPoint.mailSendCode,
                MailSendCodeRequestModel(
                  mail: welcomeLoginController.userEmail.value,
                ),
                ServicesConstants.appJsonWithoutAuth,
              )
                  .then((value) {
                if (value != null) {
                  final response =
                      MailSendCodeResponseModel.fromJson(jsonDecode(value));
                  if (response.succes == 1) {
                    UiHelper.showSuccessSnackBar(context,
                        'Doğrulama kodu başarıyla gönderildi. Lütfen eposta adresinizi kontrol ediniz.');
                    Get.back();
                    welcomeLoginController.processCounter.value = 2;
                    welcomeLoginController.containerHeight.value = 324.h;
                    welcomeLoginController.authToken.value =
                        response.data![0].token!;
                  }
                }
              });
            },
            title: 'Kodu Gönder',
          ),
        ],
      ),
    );
  }
}
