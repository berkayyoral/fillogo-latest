import 'package:fillogo/controllers/register/register_controller.dart';
import 'package:fillogo/export.dart';

import 'package:fillogo/widgets/custom_red_button.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({
    super.key,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isAlphabetic(String input) {
    final alphabetic = RegExp(r'^[a-zA-ZğĞüÜıİöÖçÇşŞ]+$');
    return alphabetic.hasMatch(input);
  }

  final RegisterController registerController = Get.find<RegisterController>();
  final userEmail = Get.arguments;
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
            'Kaydol',
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
                  text: 'Görünüşe göre bir hesabın yok! Hadi ',
                  style: TextStyle(
                    fontFamily: FontConstants.sfLight,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: userEmail.toString(),
                  style: TextStyle(
                    fontFamily: FontConstants.sfSemiBold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' ile yeni bir hesap oluşturalım',
                  style: TextStyle(
                    fontFamily: FontConstants.sfLight,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CustomTextField(
            onChanged: (value) {
              if (!isAlphabetic(value)) {
                nameController.text =
                    nameController.text.substring(0, value.length - 1);
              }
            },
            labelText: 'İsim',
            keyboardType: TextInputType.name,
            controller: nameController,
            textInputAction: TextInputAction.next,
          ),
          CustomTextField(
            onChanged: (value) {
              if (!isAlphabetic(value)) {
                nameController.text =
                    nameController.text.substring(0, value.length - 1);
              }
            },
            textInputAction: TextInputAction.next,
            labelText: 'Soyisim',
            keyboardType: TextInputType.name,
            controller: surNameController,
          ),
          Obx(() {
            return CustomTextField(
              textInputAction: TextInputAction.done,
              labelText: 'Parola',
              controller: passwordController,
              keyboardType: TextInputType.name,
              obscureText: obscureText.value,
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
            onTap: () {
              if (nameController.text.length < 3) {
                UiHelper.showWarningSnackBar(
                    context, 'İsim 3 karakterden kısa olamaz');
              } else if (surNameController.text.length < 2) {
                UiHelper.showWarningSnackBar(
                    context, 'Soyisim iki karakterden kısa olamaz');
              } else if (passwordController.text.length < 6) {
                UiHelper.showWarningSnackBar(
                    context, 'Şifre 6 karakterden kısa olamaz');
              } else {
                registerController.nameController.value =
                    nameController.value.text;
                registerController.surNameController.value =
                    surNameController.value.text;
                registerController.passwordController.value =
                    passwordController.value.text;
                registerController.emailController.value = userEmail;
                registerController.containerHeight.value = 540.h;
                registerController.processCounter.value++;
                LocaleManager.instance.setString(
                    PreferencesKeys.currentUserName, nameController.value.text);
                LocaleManager.instance.setString(
                    PreferencesKeys.currentUserSurname,
                    surNameController.value.text);
              }
            },
            title: 'Devam Et',
          ),
        ],
      ),
    );
  }
}
