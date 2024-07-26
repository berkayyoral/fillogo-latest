import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/core/init/ui_helper/ui_helper.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RouteDescriptionWidget extends StatelessWidget {
  const RouteDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final createRouteController = Get.find<CreateRouteController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: 340.w,
            child: Text(
              'Açıklama:',
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
          width: 340.h,
          child: Text(
            'Yolculuğun hakkında arkadaşlarını bilgilendir!',
            style: TextStyle(
              fontFamily: 'Sflight',
              fontSize: 12.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        10.h.spaceY,
        Container(
          height: 125.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppConstants().ltDarkGrey.withOpacity(0.15),
                spreadRadius: 5.r,
                blurRadius: 7.r,
                offset: Offset(0, 3.h), // changes position of shadow
              ),
            ],
          ),
          child: TextField(
            maxLines: 6,
            keyboardType: TextInputType.text,
            cursorColor: AppConstants().ltMainRed,
            controller: createRouteController.routeDescriptionController,
            decoration: InputDecoration(
              counterText: '',
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
              hintText: 'Açıklama giriniz',
            ),
            style: TextStyle(
              fontFamily: "Sflight",
              fontSize: 14.sp,
              color: AppConstants().ltBlack,
            ),
          ),
        ),
      ],
    );
  }
}
