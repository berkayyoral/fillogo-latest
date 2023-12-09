import 'dart:async';
import 'dart:convert';

import 'package:fillogo/controllers/login/login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/login/forgot_pass_compare_code_model.dart';
import 'package:fillogo/models/user/login/forgot_pass_send_code.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:flutter/gestures.dart';
import 'package:pinput/pinput.dart';

class CompareCodeForPassword extends StatelessWidget {
  CompareCodeForPassword({
    super.key,
  });

  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.find<LoginController>();

  Timer? timer;
  final RxInt countdownTime = 120.obs;
  final RxBool isTimeExpired = false.obs;
  final TextEditingController pintputController = TextEditingController();

  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        countdownTime.value--;
        if (countdownTime.value == 0) {
          timer.cancel();
          isTimeExpired.value = true;
        }
      },
    );
  }

  String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();
    String result = "$minuteLeft:$secondsLeft";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
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
          Obx(() {
            return RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: loginController.userEmail.value,
                    style: TextStyle(
                      fontFamily: FontConstants.sfSemiBold,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' adresine bir doğrulama kodu gönderdik. Lütfen devam etmek için kodu giriniz',
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Pinput(
                  length: 6,
                  keyboardType: TextInputType.number,
                  onCompleted: (value) async {
                    UiHelper.showLoadingAnimation(context);
                    await GeneralServicesTemp()
                        .makePostRequest(
                      EndPoint.forgotPassCompareCode,
                      ForgotPasswordCompareCodeRequestModel(
                        code: value,
                      ),
                      ServicesConstants.appJsonWithCustomToke(
                          loginController.authToken.value),
                    )
                        .then(
                      (value) {
                        if (value != null) {
                          final response =
                              ForgotPasswordCompareCodeResponseModel.fromJson(
                                  jsonDecode(value));
                          if (response.succes == 1) {
                            UiHelper.showSuccessSnackBar(
                                context, 'Doğrulama başarılı.');
                            pintputController.clear();
                            Get.back();
                            loginController.containerHeight.value = 346.h;
                            loginController.processCounter.value++;
                          } else {
                            UiHelper.showWarningSnackBar(context,
                                'Doğrulama kodu yanlış! Lütfen tekrar deneyiniz.');
                            Get.back();
                            pintputController.clear();
                          }
                        }
                      },
                    );
                  },
                  defaultPinTheme: PinTheme(
                    height: 46.h,
                    width: 46.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontFamily: FontConstants.sfBold,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  enabled: !isTimeExpired.value,
                  disabledPinTheme: PinTheme(
                    height: 46.h,
                    width: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                );
              }),
              8.h.spaceY,
              Obx(() {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${intToTimeLeft(countdownTime.value)}   ',
                        style: TextStyle(
                          fontFamily: FontConstants.sfSemiBold,
                          fontSize: 14.sp,
                          color: !isTimeExpired.value
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                      TextSpan(
                        text: ' Yeniden kod gönder',
                        style: TextStyle(
                          fontFamily: isTimeExpired.value
                              ? FontConstants.sfSemiBold
                              : FontConstants.sfLight,
                          fontSize: 14.sp,
                          color: isTimeExpired.value
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (isTimeExpired.value) {
                              UiHelper.showLoadingAnimation(context);
                              await GeneralServicesTemp()
                                  .makePostRequest(
                                EndPoint.forgotPassSendCode,
                                ForgotPasswordSendCodeRequestModel(
                                  mail: loginController.userEmail.value,
                                ),
                                ServicesConstants.appJsonWithoutAuth,
                              )
                                  .then((value) {
                                pintputController.clear();
                                if (value != null) {
                                  final response =
                                      ForgotPasswordSendCodeResponseModel
                                          .fromJson(jsonDecode(value));
                                  loginController.authToken.value =
                                      response.data![0].token!;
                                  if (response.succes == 1) {
                                    UiHelper.showSuccessSnackBar(context,
                                        'Doğrulama kodu başarıyla gönderildi. Lütfen eposta adresinizi kontrol ediniz.');
                                    Get.back();
                                    startTimer();
                                    isTimeExpired.value = false;
                                    countdownTime.value = 120;
                                  }
                                }
                              });
                            } else {
                              UiHelper.showWarningSnackBar(context,
                                  "Lütfen daha sonra tekrar deneyiniz!");
                            }
                          },
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
