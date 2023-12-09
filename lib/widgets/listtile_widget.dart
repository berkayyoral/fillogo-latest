import '../export.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.subTitle});

  final String iconPath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
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
            width: 32.w,
            height: 32.h,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontFamily: "Sfbold"),
      ),
      subtitle: Text(subTitle),
      trailing: SvgPicture.asset('assets/icons/arrow-right.svg'),
    );
  }
}