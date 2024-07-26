import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/core/init/ui_helper/ui_helper.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RouteDateTimePicker extends StatelessWidget {
  final bool isDeparture;
  const RouteDateTimePicker({super.key, required this.isDeparture});

  @override
  Widget build(BuildContext context) {
    CreateRouteController createRouteController = Get.find();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 340.w,
            child: Text(
              isDeparture ? 'Çıkış Tarihi:' : 'Varış Tarihi',
              style: TextStyle(
                fontFamily: 'Sfbold',
                fontSize: 16.sp,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ),
        3.h.spaceY,
        SizedBox(
          width: 340.w,
          child: Text(
            isDeparture
                ? 'Belirlenen rotaya ne zaman başlayacaksın?'
                : 'Yolculuğun ne zaman son bulacak?',
            style: TextStyle(
              fontFamily: 'Sflight',
              fontSize: 12.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        10.h.spaceY,
        Container(
            width: 340.w,
            height: 50.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppConstants().ltDarkGrey.withOpacity(0.15),
                  spreadRadius: 5.r,
                  blurRadius: 7.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Obx(
              () {
                print(
                    "SHOWDATEPİCKER WİDGET -> ${createRouteController.departureController.value.text}");
                return TextField(
                  readOnly: true,
                  controller: isDeparture
                      ? createRouteController.departureController.value
                      : createRouteController.arrivalController.value,
                  onTap: () async {
                    var pickedDate = await showDatePicker(
                      confirmText: "Devam",
                      locale: const Locale("tr", "TR"),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: AppConstants().ltMainRed,
                            colorScheme: ColorScheme.light(
                              primary: AppConstants().ltMainRed,
                              secondary: AppConstants().ltLogoGrey,
                            ),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                    );

                    var pickedTime = await showTimePicker(
                      builder: (BuildContext context, child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: AppConstants().ltMainRed,
                            colorScheme: ColorScheme.light(
                              primary: AppConstants().ltMainRed,
                              secondary: AppConstants().ltLogoGrey,
                            ),
                            buttonTheme: const ButtonThemeData(
                                textTheme: ButtonTextTheme.primary),
                          ),
                          child: child!,
                        );
                      },
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );

                    DateFormat('dd/MM/yyyy').format(pickedDate!);

                    createRouteController.dateTimeFormatLast.value = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime!.hour,
                      pickedTime.minute,
                    ).add(
                      Duration(
                        minutes: createRouteController.calculatedRouteTimeInt,
                      ),
                    );

                    print(
                        "SHOWDATEPİCKER dateTimeFormatLast -> ${createRouteController.dateTimeFormatLast.value}");

                    createRouteController.dateTimeFormatArrival.value =
                        DateFormat('yyyy-MM-dd HH:mm').format(
                            createRouteController.dateTimeFormatLast.value);

                    print(
                        "SHOWDATEPİCKER dateTimeFormatVaris -> ${createRouteController.dateTimeFormatArrival.value}");

                    createRouteController.dateTimeFormatDeparture.value =
                        DateFormat('yyyy-MM-dd HH:mm').format(
                      DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      ),
                    );
                    createRouteController.departureController.value.text =
                        createRouteController.dateTimeFormatDeparture.value;
                    createRouteController.arrivalController.value.text =
                        createRouteController.dateTimeFormatArrival.value;

                    print(
                        "SHOWDATEPİCKER dateTimeFormatCikis -> ${createRouteController.dateTimeFormatDeparture.value}");
                  },
                  cursorColor: AppConstants().ltMainRed,
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: AppConstants().ltWhite,
                    hintStyle: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 14.sp,
                      color: AppConstants().ltDarkGrey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(15.w),
                    hintText: isDeparture
                        ? 'Çıkış tarihi giriniz'
                        : 'Varış tarihi giriniz',
                  ),
                  style: TextStyle(
                    fontFamily: "Sflight",
                    fontSize: 14.sp,
                    color: AppConstants().ltBlack,
                  ),
                );
              },
            )),
      ],
    );
  }
}
