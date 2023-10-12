import 'package:fillogo/export.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsSwitchWidget extends StatelessWidget {
  const SettingsSwitchWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.switchValue,
    required this.switchToggle,
  });

  final String title;
  final String subTitle;
  final RxBool switchValue;
  final Function(bool) switchToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: 70.h,
        width: 341.w,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Sfbold',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
          subtitle: Text(
            subTitle,
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
                value: switchValue.value,
                onToggle: switchToggle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
