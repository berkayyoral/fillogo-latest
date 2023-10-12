import '../../../export.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.subtitle,
      required this.onPressed})
      : super(key: key);
  final String iconPath;
  final String? title;
  final String? subtitle;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(
            left: 0.w,
            right: 10.w,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppConstants().ltWhiteGrey,
              borderRadius: BorderRadius.circular(
                8.r,
              ),
            ),
            width: 48.w,
            height: 48.w,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.w,
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 24.w,
              ),
            ),
          ),
        ),
        title: Text(
          title!,
          style: TextStyle(
            fontFamily: 'Sfbold',
            fontSize: 14.sp,
            color: AppConstants().ltLogoGrey,
          ),
        ),
        subtitle: Text(
          subtitle!,
          style: TextStyle(
            fontFamily: 'Sfregular',
            fontSize: 12.sp,
            color: AppConstants().ltDarkGrey,
          ),
        ),
        trailing: SvgPicture.asset(
          'assets/icons/next-icon.svg',
          height: 16.h,
          width: 16.w,
          color: AppConstants().ltLogoGrey,
        ),
      ),
    );
  }
}
