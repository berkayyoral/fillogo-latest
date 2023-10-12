import 'package:fillogo/export.dart';

authenticationAppBar() {
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
      'Kimlik Doğrulama',
      style: TextStyle(
          fontFamily: 'Sfsemibold',
          color: AppConstants().ltLogoGrey,
          fontSize: 28),
    ),
    backgroundColor: AppConstants().ltWhite,
    centerTitle: true,
    elevation: 5,
  );
}
