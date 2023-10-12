import 'package:flutter_switch/flutter_switch.dart';

import 'package:fillogo/controllers/settings/preferences_settings_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';
import 'settings_switch_widget.dart';

class PreferencesSettingsView extends StatelessWidget {
  PreferencesSettingsView({Key? key}) : super(key: key);

  final PreferencesSettingsController preferencesSettingsController =
      Get.put(PreferencesSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Tercihler',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
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
        child: Column(
          children: [
            Column(
              children: [
                SettingsSwitchWidget(
                  title: 'Titreşim',
                  subTitle: 'Bildirim gelince titret',
                  switchValue: preferencesSettingsController.secureStatus,
                  switchToggle: (val) {
                    preferencesSettingsController.secureStatus.value = val;
                  },
                ),
                SettingsSwitchWidget(
                  title: 'Rota Bilgilendirmesi',
                  subTitle:
                      'Rotanıza başlamanız için sie bildirim göndereceğiz',
                  switchValue: preferencesSettingsController.commentStatus,
                  switchToggle: (val) {
                    preferencesSettingsController.commentStatus.value = val;

                    // preferencesSettingsController.commentStatus.value =
                    //     val;
                  },
                ),
                SettingsSwitchWidget(
                  title: 'Konum',
                  subTitle: 'Konum servislerine erişim',
                  switchValue: preferencesSettingsController.sharedStatus,
                  switchToggle: (val) {
                    preferencesSettingsController.sharedStatus.value = val;
                  },
                ),
              ],
            ),
            RedButton(
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
                    discription1:
                        "Tercihlerinizde yaptığınız değişiklikler kaydedilsin mi?",
                    onPressed1: () {
                      Get.back();
                      Get.back();
                    },
                    onPressed2: () {
                      Get.back();
                    },
                    title: 'Tercihler',
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
