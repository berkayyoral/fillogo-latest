import 'dart:ui';
import 'package:fillogo/controllers/register/register_controller.dart';
import 'package:fillogo/views/register/components/add_vehicle_info.dart';
import 'package:fillogo/views/register/components/register_widget.dart';
import 'package:fillogo/export.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isAlphabetic(String input) {
    final alphabetic = RegExp(r'^[a-zA-ZğĞüÜıİöÖçÇşŞ]+$');
    return alphabetic.hasMatch(input);
  }

  final RegisterController registerController =
      Get.put<RegisterController>(RegisterController());

  @override
  Widget build(BuildContext context) {
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
                  image: AssetImage('assets/images/6-1.png'),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: (registerController.processCounter.value == 0)
                    ? false
                    : true,
                child: Positioned(
                  top: 64.h,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: () {
                      if (registerController.processCounter.value == 1) {
                        registerController.containerHeight.value = 420.h;
                      }
                      registerController.processCounter.value--;
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
                child: Obx(() {
                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    width: registerController.containerWidth.value,
                    height: registerController.containerHeight.value,
                    color: Colors.black.withOpacity(0.4),
                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 600,
                      ),
                      switchInCurve: Curves.easeInCubic,
                      child: getWidget(
                        registerController.processCounter.value,
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getWidget(int pageOrder) {
    switch (pageOrder) {
      case 0:
        return RegisterWidget();
      case 1:
        return AddVehicleInfoWidget();
      default:
        return RegisterWidget();
    }
  }
}
