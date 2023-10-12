import 'dart:ui';

import 'package:fillogo/controllers/welcome_login/welcome_login_controller.dart';
import 'package:fillogo/views/welcome_login/components/compare_verification_widget.dart';
import 'package:fillogo/views/welcome_login/components/route_login_or_register_widget.dart';
import 'package:fillogo/views/welcome_login/components/send_verification_widget.dart';
import '../../export.dart';

class WelcomeLoginView extends StatelessWidget {
  WelcomeLoginView({Key? key}) : super(key: key);

  final WelcomeLoginController welcomeLoginController =
      Get.put<WelcomeLoginController>(WelcomeLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/5-1.png'),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: welcomeLoginController.processCounter.value == 0
                    ? false
                    : true,
                child: Positioned(
                  top: 64.h,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: () {
                      if (welcomeLoginController.processCounter.value == 2) {
                        welcomeLoginController.containerHeight.value = 253.h;
                      } else {
                        welcomeLoginController.containerHeight.value = 268.h;
                      }
                      welcomeLoginController.processCounter.value--;
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
                      width: welcomeLoginController.containerWidth.value,
                      height: welcomeLoginController.containerHeight.value,
                      color: Colors.black.withOpacity(0.4),
                      child: AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 600,
                        ),
                        switchInCurve: Curves.easeInCubic,
                        child: getWidget(
                          welcomeLoginController.processCounter.value,
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
        return RouteLoginOrRegister();
      case 1:
        return SendVerificationCode();
      case 2:
        return CompareVerificationCode();
      default:
        return RouteLoginOrRegister();
    }
  }
}
