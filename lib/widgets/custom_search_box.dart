import 'package:fillogo/export.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox({
    super.key,
    this.onChanged,
    this.controller,
  });
  final Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
      child: Container(
        width: 340.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.r,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(
                    0.2.r,
                  ),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0.w, 0.w),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 296.w,
              height: 50.h,
              child: TextField(
                onChanged: onChanged,
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
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
                  hintText: 'Kullanıcı ara',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Sflight',
                    color: AppConstants().ltDarkGrey,
                  ),
                ),
              ),
            ),
            FittedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 13.h, bottom: 13.h),
                child: SvgPicture.asset(
                  height: 24.h,
                  width: 24.w,
                  'assets/icons/search-icon.svg',
                  color: AppConstants().ltLogoGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
