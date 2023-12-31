import 'dart:convert';

import 'package:fillogo/models/user/profile/set_password.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

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
                    setPasswordRequest.newPassword = newPass1Controller.text;
                    setPasswordRequest.newPasswordAgain =
                        newPass2Controller.text;
                    setPasswordRequest.oldPassword = oldPassController.text;
                    GeneralServicesTemp().makePatchRequest(
                        "/users/set-password", setPasswordRequest, {
                      "Content-type": "application/json",
                      'Authorization':
                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                    }).then((value) {
                      return json.decode(value!);
                    });
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Şifreniz başarıyla değiştirildi...',
                        ),
                      ),
                    );
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
