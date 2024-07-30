import 'package:fillogo/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonTitleWidget extends StatelessWidget {
  final String title;
  const ButtonTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        color: AppConstants().ltWhiteGrey,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
