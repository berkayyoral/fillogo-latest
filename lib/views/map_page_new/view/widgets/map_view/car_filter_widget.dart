import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/widgets/map_view/button_description_widget.dart';

class CarFilterOptionWidget extends StatelessWidget {
  final MapPageMController mapPageMController;

  const CarFilterOptionWidget({super.key, required this.mapPageMController});

  @override
  Widget build(BuildContext context) {
    return Obx(() => mapPageMController.isCreateRoute.value
        ? Container()
        : Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 70.h, right: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  alignment: Alignment.center,
                  height: 50.h,
                  width:
                      mapPageMController.showFilterOption.value ? 170.w : 50.h,
                  decoration: BoxDecoration(
                    color: mapPageMController.showFilterOption.value
                        ? AppConstants().ltWhiteGrey
                        : AppConstants().ltWhiteGrey,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            height: 70.w,
                            decoration: BoxDecoration(
                              color: AppConstants().ltWhiteGrey,
                              borderRadius: BorderRadius.circular(10.w),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Image.asset(
                                'assets/icons/filter.png',
                                fit: BoxFit.cover,
                                color: AppConstants().ltMainRed,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !mapPageMController.showFilterOption.value,
                  child: const ButtonTitleWidget(
                    title: "\t\tAraç Cinsi\t\t",
                  ),
                ),
                Visibility(
                  visible: mapPageMController.showFilterOption.value,
                  child: Container(
                    width: 75.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: mapPageMController.showFilterOption.value
                          ? AppConstants().ltWhiteGrey
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5.w),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          AppConstants().ltWhite,
                          AppConstants().ltWhiteGrey
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await mapPageMController.filterButtonOnTap();
                      },
                      child: Center(
                        child: Text(
                          "Uygula",
                          style: TextStyle(
                              color: AppConstants().ltMainRed,
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
          color: AppConstants().ltWhiteGrey,
          borderRadius: BorderRadius.circular(10.w),
          border: mapPageMController.filterSelectedList[index]
              ? Border.all(
                  color: AppConstants()
                      .ltMainRed, //const ui.Color.fromARGB(255, 177, 174, 174),
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
          color: AppConstants().ltMainRed,
        ),
      ),
    );
  }
}
