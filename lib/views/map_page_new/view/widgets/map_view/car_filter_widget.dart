import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'dart:ui' as ui;

class CarFilterOptionWidget extends StatelessWidget {
  final MapPageMController mapPageMController;

  const CarFilterOptionWidget({super.key, required this.mapPageMController});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.all(4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                alignment: Alignment.center,
                height: 65.h,
                width: 175.w,
                decoration: BoxDecoration(
                  color: mapPageMController.showFilterOption.value
                      ? AppConstants().ltMainRed
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: Row(
                  mainAxisAlignment: mapPageMController.showFilterOption.value
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: mapPageMController.showFilterOption.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          filterOptionWidget(
                              logo: 'assets/icons/filterLightCommercial.png',
                              index: 0),
                          filterOptionWidget(
                              logo: 'assets/icons/filterTruck.png', index: 1),
                          filterOptionWidget(
                              logo: 'assets/icons/filterMotorcycle.png',
                              index: 2),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !mapPageMController.showFilterOption.value,
                      child: GestureDetector(
                        onTap: () async {
                          mapPageMController.showFilterOption.value = true;
                        },
                        child: Container(
                            height: 65.w,
                            decoration: BoxDecoration(
                              color: AppConstants().ltMainRed,
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset(
                                'assets/icons/filter.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: mapPageMController.showFilterOption.value,
                child: Container(
                  width: 75.w,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: mapPageMController.showFilterOption.value
                        ? AppConstants().ltMainRed
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5.w),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppConstants().ltBlack,
                        AppConstants().ltMainRed
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      if (mapPageMController.showFilterOption.value) {
                        await mapPageMController.filterButtonOnTap();
                      }
                    },
                    child: Center(
                      child: Text(
                        "Uygula",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  InkWell filterOptionWidget({required String logo, required int index}) {
    return InkWell(
      onTap: () {
        mapPageMController.filterSelectedList[index] =
            !mapPageMController.filterSelectedList[index];
      },
      child: Container(
        height: 50.w,
        width: 50.w,
        margin: EdgeInsets.all(1.w),
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: AppConstants().ltMainRed,
          borderRadius: BorderRadius.circular(10.w),
          border: mapPageMController.filterSelectedList[index]
              ? Border.all(
                  color: const ui.Color.fromARGB(255, 177, 174, 174),
                  width: 2,
                )
              : null,
          // gradient: LinearGradient(
          //   colors: [
          //     AppConstants().ltMainRed,
          //     AppConstants().ltBlack,
          //   ],
          //   begin: Alignment.center,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Image.asset(
          logo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
