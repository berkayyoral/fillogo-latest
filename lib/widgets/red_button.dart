import 'package:fillogo/export.dart';

class RedButton extends StatelessWidget {
  RedButton({Key? key, required this.text, this.onpressed}) : super(key: key);
  String? text;
  final VoidCallback? onpressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 348.w,
      height: 45.h,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants().ltMainRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontFamily: "Sfsemidold",
            fontSize: 16.sp,
            color: AppConstants().ltWhite,
          ),
        ),
      ),
    );
  }
}
