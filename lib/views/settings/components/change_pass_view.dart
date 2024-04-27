import 'dart:convert';

import 'package:fillogo/models/user/profile/set_password.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:pinput/pinput.dart';

import '../../../export.dart';

class ChangePassView extends StatelessWidget {
  ChangePassView({Key? key}) : super(key: key);

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPass1Controller = TextEditingController();
  TextEditingController newPass2Controller = TextEditingController();

  SetPasswordRequest setPasswordRequest = SetPasswordRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Şifreni Değiştir',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/icons/back-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _textField(
                controller: oldPassController,
                hint: 'Eski şifre',
              ),
              _textField(
                controller: newPass1Controller,
                hint: 'Yeni şifre',
              ),
              _textField(
                controller: newPass2Controller,
                hint: 'Tekrar yeni şifre',
              ),
              40.h.spaceY,
              Align(
                alignment: Alignment.bottomCenter,
                child: RedButton(
                  text: 'Kaydet',
                  onpressed: () {
                    // Yeni şifreleri kontrol et
                    if (newPass1Controller.text != newPass2Controller.text) {
                      // Hata döndür
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Yeni şifreler uyuşmuyor!'),
                        ),
                      );
                      return; // İşlemi durdur
                    } else if (newPass1Controller.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Yeni şifreniz 6 karakterden uzun olmalı'),
                        ),
                      );
                      return;
                    } else if (LocaleManager.instance
                            .getString(PreferencesKeys.currentuserpassword) !=
                        oldPassController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Eski şifrenizi kontrol ediniz. '),
                        ),
                      );
                      return;
                    } else if (oldPassController.text ==
                        newPass1Controller.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Eski şifreniz ile yeni şifreniz aynı olamaz.'),
                        ),
                      );
                      return;
                    } else {
                      Map<String, dynamic> formData1 = {
                        'newPassword': newPass1Controller.text
                      };
                      setPasswordRequest.newPassword = newPass1Controller.text;
                      GeneralServicesTemp().makePatchRequest(
                        "/users/change-password",
                        formData1,
                        {
                          "Content-type": "application/json",
                          'Authorization':
                              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                        },
                      ).then((value) {
                        var response = json.decode(value!);
                        print("cevap $response");

                        if (response['succes'] == 1) {
                          print("cevap $response");

                          Get.offAllNamed(NavigationConstants.welcomelogin);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Şifreniz başarıyla değiştirildi.'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Bir sorun oluştu. Lütfen tekrar deneyiniz. Bir yanlışlık olduğunu düşünüyorsanız "Şifremi Unuttum" kısmından deneyiniz. ${response['message']}'),
                            ),
                          );
                        }
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: TextStyle(
              fontFamily: 'Sfsemibold',
              fontSize: 16.sp,
            ),
          ),
          10.h.spaceY,
          Container(
            width: 340.w,
            height: 50.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              cursorColor: AppConstants().ltMainRed,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: "Sfregular",
                  fontSize: 12.sp,
                  color: AppConstants().ltDarkGrey,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                fontFamily: "Sfregular",
                fontSize: 12.sp,
                color: AppConstants().ltBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
