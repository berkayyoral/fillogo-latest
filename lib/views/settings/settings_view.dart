import 'dart:convert';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/models/user/delete_account.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/permission.dart';
import 'package:fillogo/views/map_page_view/components/map_page_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import '../../export.dart';
import 'components/settings_listTile.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  MapPageController mapPageController = Get.find<MapPageController>();
  BottomNavigationBarController bottomIndex = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 24.w,
            ),
            child: SvgPicture.asset(
              height: 24.h,
              width: 24.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Ayarlar",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 5.h,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 20.h),
              child: Row(
                children: [
                  Text(
                    'Genel Ayarlar',
                    style: TextStyle(fontFamily: 'Sfbold', fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            SettingsListTile(
              iconPath: 'assets/icons/profil-icon.svg',
              title: 'Profil Ayarları',
              subtitle: 'Kişisel bilgilerinizi güncelleyin',
              onPressed: () {
                Get.toNamed(NavigationConstants.profileSettings);
              },
            ),
            // SettingsListTile(
            //   iconPath: 'assets/icons/preferences-icon.svg',
            //   title: 'Tercihler',
            //   subtitle: 'Tercihlerinizi düzenleyiniz',
            //   onPressed: () {
            //     Get.toNamed(NavigationConstants.preferencesSettingsView);
            //   },
            // ),
            SettingsListTile(
              iconPath: 'assets/icons/notification-icon.svg',
              title: 'Bildirim Ayarları',
              subtitle: 'Bildirim tercihlerinizi düzenleyiniz',
              onPressed: () {
                Permissions.instance
                    .requestPermission(context, Permission.notification);
                // Get.toNamed(NavigationConstants.notificationSettingsView);
              },
            ),
            SettingsListTile(
              iconPath: 'assets/icons/information.svg',
              title: 'Hesabımı Sil',
              subtitle: 'Hesabınızı Siliyorsunuz!',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                            'Hesabınızı Silmek Üzeresiniz',
                            style: TextStyle(
                              fontFamily: "Sfbold",
                              fontSize: 20,
                              color: AppConstants().ltBlack,
                            ),
                          ),
                        ),
                        content: Text(
                          'Hesabınızı Silerseniz Bütün Her Şey Silinecektir.Onaylıyor Musunuz?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Sfregular",
                            fontSize: 16,
                            color: AppConstants().ltBlack,
                          ),
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  GeneralServicesTemp().makeDeleteWithoutBody(
                                    EndPoint.deleteAccount,
                                    {
                                      'Authorization':
                                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                      'Content-Type': 'application/json',
                                    },
                                  ).then((value) {
                                    var response =
                                        DeleteAccountResponseModel.fromJson(
                                            jsonDecode(value!));
                                    if (response.success == 1) {
                                      Get.offAllNamed(
                                          NavigationConstants.welcomelogin);

                                      mapPageController.markers2.clear();
                                      mapPageController.polylineCoordinates
                                          .clear();
                                      mapPageController.polylineCoordinates2
                                          .clear();
                                      mapPageController
                                          .polylineCoordinatesListForB
                                          .clear();
                                      mapPageController.polylines.clear();
                                      mapPageController.polylines2.clear();
                                      mapPageController.selectedDispley(0);
                                      mapPageController
                                          .changeSelectedDispley(0);

                                      bottomIndex.selectedIndex.value = 0;

                                      mapPageController
                                          .mapPageRouteControllerClear();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Hesabınız Başarıyla Silindi.',
                                          ),
                                        ),
                                      );
                                    } else {
                                      Get.back();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Bir hata ile karşılaşıldı!!',
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppConstants().ltMainRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Text(
                                  "Sil",
                                  style: TextStyle(
                                    fontFamily: "Sfsemidold",
                                    fontSize: 16.sp,
                                    color: AppConstants().ltWhite,
                                  ),
                                ),
                              ),
                              20.w.horizontalSpace,
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppConstants().ltLogoGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Text(
                                  "Vazgeç",
                                  style: TextStyle(
                                    fontFamily: "Sfsemidold",
                                    fontSize: 16.sp,
                                    color: AppConstants().ltWhite,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    });
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 20.h),
              child: Row(
                children: [
                  Text(
                    'Diğer',
                    style: TextStyle(fontFamily: 'Sfbold', fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            SettingsListTile(
              iconPath: 'assets/icons/bug-report-icon.svg',
              title: 'Bildir',
              subtitle: 'Bir sorun bildirin',
              onPressed: () {
                Get.toNamed(NavigationConstants.reportView);
              },
            ),
            SettingsListTile(
              iconPath: 'assets/icons/share-app-icon.svg',
              title: 'Uygulamayı Paylaş',
              subtitle: "FilloGO'yu arkadaşlarınıza önerin",
              onPressed: () {
                Share.share('Fillogo\'yu hemen indir! https://example.com');
              },
            ),
            SettingsListTile(
              iconPath: 'assets/icons/rate-the-app.svg',
              title: 'Uygulamayı Puanla',
              subtitle: "FilloGO'yu puanla",
              onPressed: () {
                urlLauncher.launchUrl(
                  Uri.parse(
                    'https://play.google.com/store',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
