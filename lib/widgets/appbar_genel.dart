import 'package:fillogo/export.dart';

class AppBarGenel extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;
  bool isDarkMode =
      LocaleManager.instance.getBool(PreferencesKeys.isDarkMode) ??
          Get.isPlatformDarkMode;

  AppBarGenel(
      {Key? key, required this.title, this.actions, required this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      backgroundColor: AppConstants().ltWhite,

      //backgroundColor: isDarkMode ? AppConstants().ltBlack : AppConstants().ltWhite,
      actions: actions,
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
