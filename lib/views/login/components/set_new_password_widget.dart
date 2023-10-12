import 'dart:convert';

import 'package:fillogo/controllers/login/login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/set_new_password_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/widgets/custom_red_button.dart';

class SetNewPassword extends StatelessWidget {
  SetNewPassword({
    super.key,
  });

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool obscurePass = true.obs;
  final RxBool obscureConfirmPass = true.obs;

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Yeni şifre',
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
                  text: 'Lütfen yeni şifrenizi giriniz',
                  style: TextStyle(
                    fontFamily: FontConstants.sfLight,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return CustomTextField(
              textInputAction: TextInputAction.next,
              labelText: 'Yeni şifre',
              controller: passwordController,
              obscureText: obscurePass.value,
              suffixIcon: TextButton(
                onPressed: () {
                  obscurePass.value = !obscurePass.value;
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
          Obx(() {
            return CustomTextField(
              textInputAction: TextInputAction.done,
              labelText: 'Tekrar yeni şifre',
              controller: confirmPasswordController,
              obscureText: obscureConfirmPass.value,
              suffixIcon: TextButton(
                onPressed: () {
                  obscureConfirmPass.value = !obscureConfirmPass.value;
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
              if (passwordController.text.length < 6) {
                UiHelper.showWarningSnackBar(
                    context, 'Şifre 6 karakterden kısa olamaz');
                return;
              }
              if (passwordController.text != confirmPasswordController.text) {
                UiHelper.showWarningSnackBar(context, 'Şifreler eşleşmiyor.');
                return;
              }
              UiHelper.showLoadingAnimation(context);
              await GeneralServicesTemp()
                  .makePatchRequest(
                EndPoint.setNewPassword,
                SetNewPasswordRequestModel(
                  newPassword: confirmPasswordController.text,
                ),
                ServicesConstants.appJsonWithCustomToke(
                    loginController.authToken.value),
              )
                  .then((value) {
                if (value != null) {
                  final response =
                      SetNewPasswordResponseModel.fromJson(jsonDecode(value));
                  if (response.success == 1) {
                    UiHelper.showSuccessSnackBar(
                        context, 'Şifre başarıyla değiştirildi');
                    Get.back();
                    loginController.processCounter.value = 0;
                    loginController.containerHeight.value = 360.h;
                  } else {
                    UiHelper.showWarningSnackBar(context,
                        'Bir şeyler ters gitti. Lütfen tekrar deneyiniz.');
                    Get.back();
                    loginController.processCounter.value = 0;
                    loginController.containerHeight.value = 360.h;
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
