import 'package:fillogo/export.dart';

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.buttonColor,
  });

  final String title;
  final VoidCallback onTap;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: buttonColor ?? AppConstants().ltMainRed,
          label: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: FontConstants.sfSemiBold,
                fontSize: 16.sp,
                color: AppConstants().ltWhite,
              ),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(12.w, 24.h, 12.w, 16.h),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
