import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/welcome_login/welcome_login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/welcome_login/route_login_or_register_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/widgets/custom_red_button.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';

class RouteLoginOrRegister extends StatelessWidget {
  RouteLoginOrRegister({
    super.key,
  });

  final WelcomeLoginController welcomeLoginController =
      Get.find<WelcomeLoginController>();
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Hoşgeldiniz',
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
                  text: 'Lütfen kullanmak istediğiniz ',
                  style: TextStyle(
                    fontFamily: FontConstants.sfLight,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: 'Eposta',
                  style: TextStyle(
                    fontFamily: FontConstants.sfSemiBold,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: ' bilgisini giriniz.',
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
            textInputAction: TextInputAction.done,
            labelText: 'Eposta',
            controller: controller,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomRedButton(
            onTap: () async {
              if (!controller.text.isEmail) {
                UiHelper.showWarningSnackBar(
                    context, 'Lütfen geçerli bir eposta adresi giriniz.');
                return;
              }
              UiHelper.showLoadingAnimation(context);
              RouteLoginOrRegisterResponseModel response;
              await GeneralServicesTemp()
                  .makePostRequest(
                EndPoint.routeLoginOrRegister,
                RouteLoginOrRegisterRequestModel(
                  mail: controller.text,
                ),
                ServicesConstants.appJsonWithoutAuth,
              )
                  .then(
                (value) {
                  if (value != null) {
                    response = RouteLoginOrRegisterResponseModel.fromJson(
                        json.decode(value.trimLeft().trimRight()));
                    log(controller.text);
                    log(response.message.toString());
                    log(response.data.toString());
                    if (response.success == 1) {
                      Get.back();
                      welcomeLoginController.processCounter.value = 1;
                      welcomeLoginController.containerHeight.value = 253.h;
                      welcomeLoginController.userEmail.value = controller.text;
                    } else if (response.success == -2) {
                      Get.back();
                      Get.toNamed(
                        NavigationConstants.login,
                        arguments: [
                          controller.text,
                          response.data![0].name,
                          response.data![0].surname,
                          response.data![0].profilePicture,
                        ],
                      );
                    } else {}
                  }
                },
              );
              // if (controller.text.isNotEmpty) {
              //   Get.toNamed(NavigationConstants.register);
              //   return;
              // }
            },
            title: 'Devam Et',
          ),
        ],
      ),
    );
  }
}
