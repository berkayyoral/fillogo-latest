import 'package:fillogo/core/constants/app_constants.dart';
import 'package:fillogo/core/init/ui_helper/ui_helper.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/map_page_new/view/widgets/matching_routes/matching_routes_button.dart';
import 'package:fillogo/views/map_page_view/components/active_friends_list_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MatchingRoutesWidget extends StatelessWidget {
  const MatchingRoutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MapPageMController mapPageMController = Get.find();
    return Obx(
      () => mapPageMController.isLoading.value
          ? CircularProgressIndicator()
          : Visibility(
              visible: mapPageMController.isOpenMatchingRoutesWidget.value,
              child: Container(
                width: Get.width,
                height: Get.height,
                color: AppConstants().ltWhite,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: Text(
                                "Seninle Kesişen Rotalar",
                                style: TextStyle(
                                  fontFamily: "Sfsemibold",
                                  fontSize: 16.sp,
                                  color: AppConstants().ltLogoGrey,
                                ),
                              ),
                            ),
                            mapPageMController.isLoading.value
                                ? SizedBox(
                                    height: 500.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : SizedBox(
                                    height: 500.h,
                                    child: mapPageMController
                                            .matchingRoutes!.value.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: mapPageMController
                                                .matchingRoutes!.length,
                                            itemBuilder: (context, index) {
                                              return ActivesFriendsRoutesCard(
                                                profilePhotoUrl:
                                                    mapPageMController
                                                        .matchingRoutes![index]
                                                        .profilePicture!,
                                                id: mapPageMController
                                                    .matchingRoutes![index]
                                                    .userpostroutes![0]
                                                    .id!,
                                                userName:
                                                    "${mapPageMController.matchingRoutes![index].name!} ${mapPageMController.matchingRoutes![index].surname!}",
                                                startAdress: mapPageMController
                                                    .matchingRoutes![index]
                                                    .userpostroutes![0]
                                                    .startingCity!,
                                                endAdress: mapPageMController
                                                    .matchingRoutes![index]
                                                    .userpostroutes![0]
                                                    .endingCity!,
                                                startDateTime:
                                                    mapPageMController
                                                        .matchingRoutes![index]
                                                        .userpostroutes![0]
                                                        .departureDate!
                                                        .toString()
                                                        .split(" ")[0],
                                                endDateTime: mapPageMController
                                                    .matchingRoutes![index]
                                                    .userpostroutes![0]
                                                    .arrivalDate!
                                                    .toString()
                                                    .split(" ")[0],
                                                userId: mapPageMController
                                                    .matchingRoutes!
                                                    .value[index]
                                                    .id!,
                                              );
                                            },
                                          )
                                        : UiHelper.notFoundAnimationWidget(
                                            context,
                                            "Şu an aktif rotada eşleşen arkadaşın yok!",
                                          ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const MatchingRoutesButton(isMatchingRoute: false),
                  ],
                ),
              ),
            ),
    );
  }
}
