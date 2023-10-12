import 'package:fillogo/export.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.onChanged,
    this.enabled,
    this.keyboardType,
    this.onTap,
    this.inputFormatters,
    this.suffixIcon,
    this.obscureText = false,
    required this.textInputAction
  });

  final String labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? enabled;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    const emojiRegex =
        '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])';
    return TextField(
      onChanged: onChanged,
      enabled: enabled,
      onTap: onTap,
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.deny(RegExp(emojiRegex)),
          ],
      obscureText: obscureText,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: Text(
          labelText,
          style: TextStyle(
            fontFamily: FontConstants.sfMedium,
            fontSize: 16.sp,
            color: AppConstants().ltDarkGrey,
          ),
        ),
        floatingLabelStyle: TextStyle(
          fontFamily: FontConstants.sfMedium,
          fontSize: 10.sp,
          color: AppConstants().ltDarkGrey,
        ),
        contentPadding: EdgeInsets.fromLTRB(12.w, 24.h, 12.w, 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppConstants().ltMainRed,
            width: 2.w,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
