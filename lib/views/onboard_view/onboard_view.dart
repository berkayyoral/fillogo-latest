import 'package:fillogo/export.dart';
import 'package:fillogo/views/onboard_view/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'components/login_button.dart';
import 'components/onboard_models.dart';

class OnboardPages extends StatelessWidget {
  OnboardPages({super.key});

  final OnboardController currentPageController = Get.put(OnboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: AppConstants().ltMainRed,
          body: PageView.builder(
            controller: currentPageController.pageController,
            itemCount: onboardModels.length,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(onboardModels[index].imgAsset),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // index == 3
                    //     ? Column(
                    //         children: [
                    //           const LoginButton(userType: 0),
                    //           SizedBox(height: 36.h),
                    //           const LoginButton(userType: 1),
                    //           SizedBox(height: 36.h),
                    //           const LoginButton(userType: 2),
                    //         ],
                    //       )
                    //     :
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 300.h),
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !onboardModels[index].isJukkaLogo
                                ? Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: SizedBox(
                                      width: 320.w,
                                      child: Text(
                                        onboardModels[index].title,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child:
                                        Image.asset("assets/logo/logo-2.png"),
                                  ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: SizedBox(
                                width: 400.w,
                                child: Text(
                                  onboardModels[index].description,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppConstants().ltWhite,
                                    fontFamily: "RobotoBold",
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 36.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: currentPageController.pageController,
                            count: onboardModels.length,
                            effect: WormEffect(
                                dotHeight: 12.h,
                                dotWidth: 12.w,
                                activeDotColor: AppConstants().ltWhite,
                                dotColor: AppConstants().ltLogoGrey),
                          ),
                          Obx(
                            () => Visibility(
                              visible:
                                  currentPageController.currentPage.value == 3
                                      ? false
                                      : true,
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r)),
                                  minWidth: 90.w,
                                  color: AppConstants().ltWhite,
                                  onPressed: () {
                                    print("PAGEORDERNE ONBOAR -> ${index}");
                                    if (index == 2) {
                                      Get.toNamed(
                                          NavigationConstants.welcomelogin);
                                    } else {
                                      currentPageController.nextPage();
                                    }
                                  },
                                  child: Text(
                                    index == 2 ? "Giriş" : "İleri",
                                    style: TextStyle(
                                      color: AppConstants().ltMainRed,
                                      fontFamily: "RobotoMedium",
                                      fontSize: 16.sp,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   left: 30.w,
                    //   bottom: 50.h,
                    //   child: SmoothPageIndicator(
                    //     controller: currentPageController.pageController,
                    //     count: 2,
                    //     effect: WormEffect(
                    //         dotHeight: 12.h,
                    //         dotWidth: 12.w,
                    //         activeDotColor: AppConstants().ltWhite,
                    //         dotColor: AppConstants().ltLogoGrey),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
