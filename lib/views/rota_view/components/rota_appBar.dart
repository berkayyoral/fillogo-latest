import 'package:fillogo/export.dart';

RotaAppBar() {
  return AppBar(
    leading: Builder(
      builder: (context) => InkWell(
        onTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            'assets/icons/back-icon.svg',
            color: AppConstants().ltLogoGrey,
          ),
        ),
      ),
    ),
    title: Text(
      'Yeni Rota',
      style: TextStyle(
          fontFamily: 'Sfsemibold',
          fontSize: 28,
          color: AppConstants().ltBlack),
    ),
    actions: [
      InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: AppConstants().ltBlack,
                  size: 36,
                )),
          )),
    ],
    backgroundColor: AppConstants().ltWhite,
    centerTitle: true,
    elevation: 5,
  );
}