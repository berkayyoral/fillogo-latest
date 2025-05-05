import 'package:fillogo/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/navigation_constants.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.userType});

  final int userType;

  @override
  Widget build(BuildContext context) {
    final String buttonText = _getButtonText();
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(NavigationConstants.login);
      },
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(AppConstants().ltWhite),
        backgroundColor: WidgetStateProperty.all(AppConstants().ltMainRed),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppConstants().ltMainRed),
          ),
        ),
      ),
      child: SizedBox(
        width: 250.h,
        height: 50.h,
        child: Row(
          children: [
            _buildIconWidget(),
            const Spacer(),
            Text(
              buttonText,
              style: TextStyle(
                fontFamily: "RobotoMedium",
                fontSize: 24,
                color: AppConstants().ltWhite,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  String _getButtonText() {
    if (userType == 0) {
      return "Öğretmen";
    } else if (userType == 1) {
      return "Veli";
    } else if (userType == 2) {
      return "Yönetici";
    }
    return "";
  }

  Widget _buildIconWidget() {
    if (userType == 0) {
      return Image.asset(
        "assets/icons/teacher_operations.png",
        height: 35.h,
      );
    } else if (userType == 1) {
      return Image.asset(
        "assets/icons/parent_operations.png",
        height: 30.h,
      );
    } else if (userType == 2) {
      return const Icon(Icons.admin_panel_settings_outlined);
    }
    return Container();
  }
}
