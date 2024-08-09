import 'dart:async';
import 'dart:convert';

import 'package:fillogo/controllers/welcome_login/welcome_login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/welcome_login/mail_compare_code_model.dart';
import 'package:fillogo/models/user/welcome_login/mail_send_code_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class CompareVerificationCode extends StatelessWidget {
  CompareVerificationCode({
    super.key,
  });

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

  final WelcomeLoginController welcomeLoginController =
      Get.find<WelcomeLoginController>();
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
                    text: welcomeLoginController.userEmail.value,
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
                  controller: pintputController,
                  onCompleted: (value) async {
                    UiHelper.showLoadingAnimation();
                    await GeneralServicesTemp()
                        .makePostRequest(
                      EndPoint.mailCompareCode,
                      MailCompareCodeRequestModel(
                        code: value,
                      ),
                      ServicesConstants.appJsonWithCustomToke(
                          welcomeLoginController.authToken.value),
                    )
                        .then(
                      (value) {
                        if (value != null) {
                          final response =
                              MailCompareCodeResponseModel.fromJson(
                                  jsonDecode(value));
                          if (response.succes == 1) {
                            UiHelper.showSuccessSnackBar(
                                context, 'Doğrulama başarılı.');
                            pintputController.clear();
                            Get.back();
                            Get.offNamed(
                              NavigationConstants.register,
                              arguments: welcomeLoginController.userEmail.value,
                            );
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
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
                          ..onTap = () {
                            if (isTimeExpired.value) {
                              GeneralServicesTemp()
                                  .makePostRequest(
                                EndPoint.mailSendCode,
                                MailSendCodeRequestModel(
                                  mail: welcomeLoginController.userEmail.value,
                                ),
                                ServicesConstants.appJsonWithoutAuth,
                              )
                                  .then((value) {
                                pintputController.clear();
                                if (value != null) {
                                  final response =
                                      MailSendCodeResponseModel.fromJson(
                                          jsonDecode(value));
                                  welcomeLoginController.authToken.value =
                                      response.data![0].token!;
                                  if (response.succes == 1) {
                                    UiHelper.showLoadingAnimation();
                                    UiHelper.showSuccessSnackBar(context,
                                        'Doğrulama kodu başarıyla gönderildi. Lütfen eposta adresinizi kontrol ediniz.');
                                    startTimer();
                                    isTimeExpired.value = false;
                                    countdownTime.value = 120;
                                    Get.back();
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
