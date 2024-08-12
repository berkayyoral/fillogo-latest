import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/create_route_controller.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/date_picker_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/route_description_widget.dart';
import 'package:fillogo/views/map_page_new/view/widgets/create_route/vehicle_type_widget.dart';

class CreateRouteInfoWidget extends StatelessWidget {
  const CreateRouteInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateRouteController createRouteController =
        Get.put(CreateRouteController());

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SvgPicture.asset(
                  'assets/icons/route-icon.svg',
                  color: AppConstants().ltMainRed,
                  height: 32.h,
                  width: 32.w,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Text(
                      'Rota',
                      style: TextStyle(
                        color: AppConstants().ltDarkGrey,
                        fontFamily: 'Sflight',
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            createRouteController.startRouteCity.value,
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sfmedium',
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            ' -> ',
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sfmedium',
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            createRouteController.finishRouteCity.value,
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sfmedium',
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Row(
                        children: [
                          Text(
                            "Tahmini: ",
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                          Obx(() => Text(
                                "${createRouteController.calculatedRouteDistance.value} km",
                                style: TextStyle(
                                  color: AppConstants().ltBlack,
                                  fontFamily: 'Sflight',
                                  fontSize: 12.sp,
                                ),
                              )),
                          Text(
                            " ve ",
                            style: TextStyle(
                              color: AppConstants().ltLogoGrey,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            createRouteController.calculatedRouteTime.value,
                            style: TextStyle(
                              color: AppConstants().ltBlack,
                              fontFamily: 'Sflight',
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => createRouteController.isOpenRouteDetailEntrySection.value
                ? SingleChildScrollView(
                    child: Container(
                      height: createRouteController.isKeyboardVisible.value
                          ? 300.h
                          : 450.h,
                      child: ListView(
                        controller: createRouteController.scrollController,
                        children: [
                          const RouteDateTimePicker(isDeparture: true),
                          const RouteDateTimePicker(isDeparture: false),
                          const VehicleInfoWidget(),
                          const RouteDescriptionWidget(),
                          20.h.spaceY,

                          /// BUTTON

                          SizedBox(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                createRouteController.createRoute();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstants().ltMainRed,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                fixedSize: Size(342.w, 50.h),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  "Rota Oluştur",
                                  style: TextStyle(
                                    fontFamily: "Sfsemidold",
                                    fontSize: 16.sp,
                                    color: AppConstants().ltWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          20.h.spaceY
                        ],
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(8.w),
                    width: 150.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (createRouteController.finishRouteCity.value != "") {
                          createRouteController
                              .isOpenRouteDetailEntrySection.value = true;
                          createRouteController.setDate();
                        } else {
                          Get.snackbar("Varış şehri bulunamadı",
                              "Varış şehrini yeniden seçiniz..",
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: AppConstants().ltBlack);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants().ltMainRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        fixedSize: Size(342.w, 50.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                          "Devam Et",
                          style: TextStyle(
                            fontFamily: "Sfsemidold",
                            fontSize: 16.sp,
                            color: AppConstants().ltWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
