import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/core/constants/navigation_constants.dart';
import 'package:fillogo/core/init/ui_helper/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VehicleInfoWidget extends StatelessWidget {
  const VehicleInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    VehicleInfoController vehicleInfoController = Get.find();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 340.w,
            child: Text(
              'Araç Bilgileri:',
              style: TextStyle(
                fontFamily: 'Sfbold',
                fontSize: 16.sp,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ),
        3.h.spaceY,
        Obx(
          () => SizedBox(
            width: 340.w,
            child: Row(
              children: [
                Text(
                  'Yolculuğa çıkılacak araç: ',
                  style: TextStyle(
                    fontFamily: 'Sflight',
                    fontSize: 12.sp,
                    color: AppConstants().ltLogoGrey,
                  ),
                ),
                Text(
                  '${vehicleInfoController.vehicleMarka.value} / ${vehicleInfoController.vehicleModel.value}',
                  style: TextStyle(
                    fontFamily: 'Sfbold',
                    fontSize: 12.sp,
                    color: AppConstants().ltLogoGrey,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final newValue =
                        await Get.toNamed(NavigationConstants.vehicleSettings);

                    if (newValue != null) {
                      print("NEWW WALL VAR -> ${newValue["type"]}");
                    } else {
                      print("NEWW WALL YOK");
                    }
                  },
                  child: Text(
                    "Düzenle",
                    style: TextStyle(
                      fontFamily: 'Sfbold',
                      fontSize: 12.sp,
                      color: AppConstants().ltMainRed,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
