import 'package:fillogo/export.dart';

class ChatCreateAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatCreateAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarGenel(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 2.w,
          ),
          child: SvgPicture.asset(
            height: 20.h,
            width: 20.w,
            'assets/icons/back-icon.svg',
            color: AppConstants().ltLogoGrey,
          ),
        ),
      ),
      title: Text(
        "Yeni Sohbet Ekle",
        style: TextStyle(
          fontFamily: "Sfbold",
          fontSize: 20.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
