import 'package:fillogo/export.dart';

class ChatMessageTextField extends StatelessWidget {
  const ChatMessageTextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
        ),
        height: 50.h,
        width: 300.w,
        child: Material(
          borderRadius: BorderRadius.circular(8.r),
          elevation: 5,
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            autofocus: false,
            keyboardType: TextInputType.text,
            obscureText: false,
            cursorColor: AppConstants().ltMainRed,
            style: TextStyle(
              fontSize: 16.sp,
              fontFamily: 'Sfregular',
              color: AppConstants().ltLogoGrey,
            ),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
                borderSide: BorderSide.none,
              ),
              hintText: 'Mesaj yaz',
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Sflight',
                color: AppConstants().ltDarkGrey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
            ),
          ),
        ));
  }
}
