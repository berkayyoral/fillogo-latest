import 'dart:convert';

import 'package:fillogo/controllers/login/login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/login/forgot_pass_send_code.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/widgets/custom_red_button.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({
    super.key,
  });
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.find<LoginController>();
  var arguments = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Şifremi unuttum',
            style: TextStyle(
              fontFamily: FontConstants.sfBlack,
              fontSize: 35.sp,
              color: Colors.white,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Şifrenizi sıfırlamak için ',
                  style: TextStyle(
                    fontFamily: FontConstants.sfLight,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: arguments[0],
                  style: TextStyle(
                    fontFamily: FontConstants.sfSemiBold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' adresine bir doğrulama kodu göndereceğiz',
                  style: TextStyle(
                    fontFamily: FontConstants.sfLight,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CustomRedButton(
            onTap: () async {
              String userEmail = arguments[0];
              UiHelper.showLoadingAnimation(context);
              await GeneralServicesTemp()
                  .makePostRequest(
                EndPoint.forgotPassSendCode,
                ForgotPasswordSendCodeRequestModel(
                  mail: userEmail,
                ),
                ServicesConstants.appJsonWithoutAuth,
              )
                  .then((value) {
                if (value != null) {
                  final response = ForgotPasswordSendCodeResponseModel.fromJson(
                      jsonDecode(value));
                  if (response.succes == 1) {
                    UiHelper.showSuccessSnackBar(context,
                        'Doğrulama kodu başarıyla gönderildi. Lütfen epostanızı kontrol ediniz.');
                    Get.back();
                    loginController.authToken.value = response.data![0].token!;
                    loginController.processCounter.value++;
                    loginController.containerHeight.value = 334.h;
                  } else {
                    UiHelper.showWarningSnackBar(context,
                        'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.');
                    Get.back();
                  }
                }
              });
            },
            title: 'Gönder',
          ),
        ],
      ),
    );
  }
}
