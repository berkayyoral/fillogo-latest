import 'package:flutter_switch/flutter_switch.dart';

import '../../../controllers/settings/notification_settings_controller.dart';
import '../../../export.dart';
import '../../../widgets/popup_view_widget.dart';

class NotificationSettingsView extends StatelessWidget {
  NotificationSettingsView({Key? key}) : super(key: key);

  NotificationSettingsController notificationSettingsController = Get.put(NotificationSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Bildirim Ayarları',
          style: TextStyle(fontFamily: 'Sfsemibold', color: AppConstants().ltLogoGrey, fontSize: 28),
        ),
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
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 70.h,
                      width: 341.w,
                      child: ListTile(
                        title: Text(
                          'Tümünü Durdur',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                        subtitle: Text(
                          'Uygulama bildirimlerini tamamen durdurun',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                        ),
                        trailing: Obx(
                          () => SizedBox(
                            width: 44.w,
                            height: 28.h,
                            child: FlutterSwitch(
                              activeToggleColor: const Color.fromARGB(255, 107, 221, 69),
                              inactiveToggleColor: AppConstants().ltDarkGrey,
                              inactiveColor: AppConstants().ltWhiteGrey,
                              activeColor: AppConstants().ltWhiteGrey,
                              showOnOff: false,
                              toggleSize: 26.w,
                              padding: 0.w,
                              borderRadius: 16.r,
                              value: notificationSettingsController.commentStatus.value,
                              onToggle: (val) {
                                if (val) {
                                  notificationSettingsController.addedStoryStatus.value = false;
                                  notificationSettingsController.likedStatus.value = false;
                                  notificationSettingsController.secureStatus.value = false;
                                  notificationSettingsController.sharedStatus.value = false;
                                }

                                notificationSettingsController.commentStatus.value = val;

                                // notificationSettingsController.commentStatus.value =
                                //     val;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 70.h,
                      width: 341.w,
                      child: ListTile(
                        title: Text(
                          'Mesajlar',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                        subtitle: Text(
                          'Mesaj bildirimlerini durdurun.',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                        ),
                        trailing: Obx(
                          () => SizedBox(
                            width: 44.w,
                            height: 28.h,
                            child: FlutterSwitch(
                              activeToggleColor: const Color.fromARGB(255, 107, 221, 69),
                              inactiveToggleColor: AppConstants().ltDarkGrey,
                              inactiveColor: AppConstants().ltWhiteGrey,
                              activeColor: AppConstants().ltWhiteGrey,
                              showOnOff: false,
                              toggleSize: 26.w,
                              padding: 0.w,
                              borderRadius: 16.r,
                              value: notificationSettingsController.secureStatus.value,
                              onToggle: (val) {
                                notificationSettingsController.secureStatus.value = val;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 70.h,
                      width: 341.w,
                      child: ListTile(
                        title: Text(
                          'Yorumlar',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                        subtitle: Text(
                          'Yorum bildirimlerini durdurun.',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                        ),
                        trailing: Obx(
                          () => SizedBox(
                            width: 44.w,
                            height: 28.h,
                            child: FlutterSwitch(
                              activeToggleColor: const Color.fromARGB(255, 107, 221, 69),
                              inactiveToggleColor: AppConstants().ltDarkGrey,
                              inactiveColor: AppConstants().ltWhiteGrey,
                              activeColor: AppConstants().ltWhiteGrey,
                              showOnOff: false,
                              toggleSize: 26.w,
                              padding: 0.w,
                              borderRadius: 16.r,
                              value: notificationSettingsController.sharedStatus.value,
                              onToggle: (val) {
                                notificationSettingsController.sharedStatus.value = val;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 70.h,
                      width: 341.w,
                      child: ListTile(
                        title: Text(
                          'Rotalar',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                        subtitle: Text(
                          'Rota bildirimlerini durdurun.',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                        ),
                        trailing: Obx(
                          () => SizedBox(
                            width: 44.w,
                            height: 28.h,
                            child: FlutterSwitch(
                              activeToggleColor: const Color.fromARGB(255, 107, 221, 69),
                              inactiveToggleColor: AppConstants().ltDarkGrey,
                              inactiveColor: AppConstants().ltWhiteGrey,
                              activeColor: AppConstants().ltWhiteGrey,
                              showOnOff: false,
                              toggleSize: 26.w,
                              padding: 0.w,
                              borderRadius: 16.r,
                              value: notificationSettingsController.likedStatus.value,
                              onToggle: (val) {
                                notificationSettingsController.likedStatus.value = val;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 70.h,
                      width: 341.w,
                      child: ListTile(
                        title: Text(
                          'Hikaye',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                        subtitle: Text(
                          'Hikaye bildirimlerini durdurun.',
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                        ),
                        trailing: Obx(
                          () => SizedBox(
                            width: 44.w,
                            height: 28.h,
                            child: FlutterSwitch(
                              activeToggleColor: const Color.fromARGB(255, 107, 221, 69),
                              inactiveToggleColor: AppConstants().ltDarkGrey,
                              inactiveColor: AppConstants().ltWhiteGrey,
                              activeColor: AppConstants().ltWhiteGrey,
                              showOnOff: false,
                              toggleSize: 26.w,
                              padding: 0.w,
                              borderRadius: 16.r,
                              value: notificationSettingsController.addedStoryStatus.value,
                              onToggle: (val) {
                                notificationSettingsController.addedStoryStatus.value = val;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 20.h,
              right: 20.h,
              child: RedButton(
                text: 'Değişiklikleri Kaydet',
                onpressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ShowAllertDialogWidget(
                      button1Color: AppConstants().ltMainRed,
                      button1Height: 50.h,
                      button1IconPath: '',
                      button1Text: 'Kaydet',
                      button1TextColor: AppConstants().ltWhite,
                      button1Width: Get.width,
                      button2Color: AppConstants().ltDarkGrey,
                      button2Height: 50.h,
                      button2IconPath: '',
                      button2Text: 'Kaydetme',
                      button2TextColor: AppConstants().ltWhite,
                      button2Width: Get.width,
                      buttonCount: 2,
                      discription1: "Bildirim ayarlarınızda yaptığınız değişiklikler kaydedilsin mi?",
                      onPressed1: () {
                        Get.back();
                        Get.back();
                      },
                      onPressed2: () {
                        Get.back();
                      },
                      title: 'Bildirim Ayarları',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
