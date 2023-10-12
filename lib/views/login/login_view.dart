import 'dart:ui';
import 'package:fillogo/controllers/login/login_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/login/components/compare_code_for_pass_widget.dart';
import 'package:fillogo/views/login/components/forgot_password_widget.dart';
import 'package:fillogo/views/login/components/login_with_password_widget.dart';
import 'package:fillogo/views/login/components/set_new_password_widget.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final LoginController loginController =
      Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    loginController.userEmail.value = Get.arguments[0];
    loginController.userName.value = Get.arguments[1];
    loginController.userSurName.value = Get.arguments[2];
    loginController.userProfilePicture.value = Get.arguments[3];
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/7-1.png'),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible:
                    loginController.processCounter.value == 0 ? false : true,
                child: Positioned(
                  top: 64.h,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: () {
                      if (loginController.processCounter.value == 3) {
                        loginController.containerHeight.value = 334.h;
                      } else if (loginController.processCounter.value == 2) {
                        loginController.containerHeight.value = 236.h;
                      } else if (loginController.processCounter.value == 1) {
                        loginController.containerHeight.value = 360.h;
                      }
                      loginController.processCounter.value--;
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 32.r,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 0),
                          color: Colors.white.withOpacity(0.6),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Obx(
                  () {
                    return AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      width: loginController.containerWidth.value,
                      height: loginController.containerHeight.value,
                      color: Colors.black.withOpacity(0.4),
                      child: AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 600,
                        ),
                        switchInCurve: Curves.easeInCubic,
                        child: getWidget(
                          loginController.processCounter.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getWidget(int pageOrder) {
    switch (pageOrder) {
      case 0:
        return LoginWithPassword();
      case 1:
        return ForgotPassword();
      case 2:
        return CompareCodeForPassword();
      case 3:
        return SetNewPassword();
      default:
        return LoginWithPassword();
    }
  }
}
