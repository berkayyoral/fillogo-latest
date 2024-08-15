import 'dart:io';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/map/first_login_is_active_route_controller.dart';
import 'package:fillogo/controllers/map/start_or_delete_route_dialog.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/map_page_viewm.dart';
import 'package:fillogo/views/map_page_view/components/map_page_controller.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';

import '../views/route_calculate_view/route_calculate_last.dart';

class BottomNavigationBarView extends StatelessWidget {
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  GeneralDrawerController drawerControl = Get.find<GeneralDrawerController>();
  BottomNavigationBarView({super.key});

  final screens = [
    PostFlowView(),
    // MapPageView(),
    MapPageViewM(),
    RouteCalculateLastView(),
    const MyProfilView(),
  ];

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

  MapPageMController mapPageMController = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
          context: context,
          builder: (BuildContext context) => ShowAllertDialogWidget(
            button1Color: AppConstants().ltMainRed,
            button1Height: 50.h,
            button1IconPath: '',
            button1Text: 'Çık',
            button1TextColor: AppConstants().ltWhite,
            button1Width: Get.width,
            button2Color: AppConstants().ltDarkGrey,
            button2Height: 50.h,
            button2IconPath: '',
            button2Text: 'Kal',
            button2TextColor: AppConstants().ltWhite,
            button2Width: Get.width,
            buttonCount: 2,
            discription1: "Uygulamadan çıkmak istediğine emin misin?",
            onPressed1: () {
              exit(0);
            },
            onPressed2: () {
              Get.back();
            },
            title: 'Emin Misin?',
          ),
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: bottomNavigationBarController.selectedIndex.value,
            children: screens,
          ),
        ),
        bottomNavigationBar: Obx(
          () => SizedBox(
            height: 86.h,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppConstants().ltMainRed,
              unselectedItemColor: AppConstants().ltLogoGrey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) async {
                await _drawerControlIndex();
                if (index == 1) {
                  mapPageMController.getMyLocationInMap();
                  await mapPageMController.getMyRoutes();
                }
                bottomNavigationBarController.changeIndex(index);
              },
              currentIndex: bottomNavigationBarController.selectedIndex.value,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home-icon.svg',
                    height: 24.h,
                    width: 24.w,
                    color:
                        bottomNavigationBarController.selectedIndex.value == 0
                            ? AppConstants().ltMainRed
                            : AppConstants().ltLogoGrey,
                  ),
                  backgroundColor: AppConstants().ltWhite,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/route-icon.svg',
                    height: 24.h,
                    width: 24.w,
                    color:
                        bottomNavigationBarController.selectedIndex.value == 1
                            ? AppConstants().ltMainRed
                            : AppConstants().ltLogoGrey,
                  ),
                  backgroundColor: AppConstants().ltWhite,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/new-route-icon.svg',
                    height: 24.h,
                    width: 24.w,
                    color:
                        bottomNavigationBarController.selectedIndex.value == 2
                            ? AppConstants().ltMainRed
                            : AppConstants().ltLogoGrey,
                  ),
                  backgroundColor: AppConstants().ltWhite,
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/profil-icon.svg',
                    height: 24.h,
                    width: 24.w,
                    color:
                        bottomNavigationBarController.selectedIndex.value == 3
                            ? AppConstants().ltMainRed
                            : AppConstants().ltLogoGrey,
                  ),
                  backgroundColor: AppConstants().ltWhite,
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
