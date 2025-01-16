import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/routes_models/get_my_routes_model.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import '../controllers/map/get_current_location_and_listen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({super.key, this.bottomnavBarKey});
  GlobalKey<ScaffoldState>? bottomnavBarKey;
  final GeneralDrawerController drawerControl =
      Get.find<GeneralDrawerController>();
  final BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  final MapPageMController mapPageController = Get.find<MapPageMController>();
  final GetMyCurrentLocationController getMyCurrentLocationController =
      Get.find<GetMyCurrentLocationController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildDrawerHeader(),
          DrawerItem(
            iconPath: 'assets/icons/profil-icon.svg',
            title: 'Profilim',
            onTap: () async {
              bottomnavBarKey!.currentState!.closeDrawer();
              await _drawerControlIndex();
              bottomNavigationBarController.selectedIndex.value = 3;
            },
          ),
          DrawerItem(
            iconPath: 'assets/icons/route-icon.svg',
            title: 'Rotalarım',
            onTap: () async {
              await _drawerControlIndex();

              Get.toNamed('/myRoutesPageView');
            },
          ),
          DrawerItem(
            iconPath: 'assets/icons/intersecting-routes-search.svg',
            title: 'Kesişen Rotaları Ara',
            onTap: () async {
              bottomnavBarKey!.currentState!.closeDrawer();
              await _drawerControlIndex();
              bottomNavigationBarController.selectedIndex.value = 2;
            },
          ),
          DrawerItem(
            iconPath: 'assets/icons/search-icon.svg',
            title: 'Kullanıcı Ara',
            onTap: () async {
              await _drawerControlIndex();
              Get.toNamed(NavigationConstants.searchUser);
            },
          ),
          // DrawerItem(
          //   iconPath: 'assets/icons/about_us.svg',
          //   title: 'Hakkımızda',
          //   onTap: () async {
          //     await _drawerControlIndex();
          //     Get.toNamed('/aboutUs');
          //   },
          // ),
          DrawerItem(
            iconPath: 'assets/icons/settings.svg',
            title: 'Ayarlar',
            onTap: () async {
              await _drawerControlIndex();
              Get.toNamed('/settings');
            },
          ),
          /* DrawerItem(
            iconPath: 'assets/icons/about_us.svg',
            title: 'Sorun Bildir',
            onTap: () async {
              await _drawerControlIndex();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Sorun Bildir",
                        style: TextStyle(),
                      ),
                      content: Column(
                        children: [TextField()],
                      ),
                      actions: [],
                    );
                  });
            },
          ),*/
          DrawerItem(
            iconPath: 'assets/icons/logout-icon.svg',
            title: 'Çıkış Yap',
            onTap: () async {
              await _drawerControlIndex();

              bottomNavigationBarController.selectedIndex.value = 0;

              await LocaleManager.instance.clear();
              LocaleManager.instance.remove(PreferencesKeys.userCredentials);
              LocaleManager.instance.remove(PreferencesKeys.currentUserName);
              LocaleManager.instance
                  .remove(PreferencesKeys.currentuserpassword);
              LocaleManager.instance.remove(PreferencesKeys.accessToken);
              ServicesConstants.appJsonWithToken.clear();
              mapPageController.myAllRoutes = AllRoutes();
              mapPageController.markers.clear();
              mapPageController.polylines.clear();
              mapPageController.polylineCoordinates.clear();
              mapPageController.myActivesRoutes.clear();

              Get.offAllNamed(NavigationConstants.welcomelogin);
            },
          ),
          const DrawerVersionText(
            versionNumber: '1.0.12',
          ),
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.w,
          ),
          child: InkWell(
            onTap: () {
              _drawerControlIndex();
            },
            child: SvgPicture.asset(
              height: 36.w,
              width: 36.w,
              'assets/icons/close-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 44.w,
          ),
          child: Image.asset(
            'assets/logo/logo-1.png',
            height: 40.h,
            width: 100.w,
          ),
        ),
      ],
    );
  }

  _drawerControlIndex() {
    if (drawerControl.generalDrawerPageController == 1) {
      drawerControl.closePostFlowScaffoldDrawer();
    } else if (drawerControl.generalDrawerPageController == 2) {
      drawerControl.closeMapPageScaffoldDrawer();
    } else if (drawerControl.generalDrawerPageController == 3) {
      drawerControl.closeRouteCalculatePageScaffoldDrawer();
    } else if (drawerControl.generalDrawerPageController == 4) {
      drawerControl.closeMyProfilePageScaffoldDrawer();
    }
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.onTap})
      : super(key: key);

  final String iconPath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 10.w, top: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
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
            Text(
              title,
              style: TextStyle(
                color: AppConstants().ltLogoGrey,
                fontFamily: 'Sfbold',
                fontSize: 14.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerVersionText extends StatelessWidget {
  const DrawerVersionText({
    super.key,
    required this.versionNumber,
  });

  final String versionNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            top: 46.h,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'from by ',
                  style: TextStyle(
                    fontFamily: 'Sfregular',
                    fontSize: 14.sp,
                    color: AppConstants().ltLogoGrey,
                  ),
                ),
                TextSpan(
                  text: 'FilloGO',
                  style: TextStyle(
                    fontFamily: 'Sfbold',
                    fontSize: 14.sp,
                    color: AppConstants().ltLogoGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            top: 5.h,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'version $versionNumber',
                  style: TextStyle(
                    fontFamily: 'Sfregular',
                    fontSize: 14.sp,
                    color: AppConstants().ltDarkGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
