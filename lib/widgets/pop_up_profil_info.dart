import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/homepopup/follow_controller.dart';
import 'package:fillogo/views/route_details_page_view/components/selected_route_controller.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

import '../export.dart';

class PopupPrifilInfo extends StatelessWidget {
  PopupPrifilInfo({
    Key? key,
    required this.userId,
    this.routeId,
    required this.name,
    required this.vehicleType,
    required this.description,
    required this.emptyPercent,
    required this.firstDestination,
    required this.startCity,
    required this.endCity,
    required this.secondDestination,
    required this.userProfilePhotoLink,
  }) : super(key: key);

  final int userId;
  final int? routeId;
  final String name;
  final String vehicleType;
  final String description;
  final String firstDestination;
  final String secondDestination;
  final int emptyPercent;
  final String startCity;
  final String endCity;
  final PopUpController followController = PopUpController();
  final String userProfilePhotoLink;
  final SelectedRouteController selectedRouteController =
      Get.find<SelectedRouteController>();
  final BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      //height: 650.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(() => GestureDetector(
                        onTap: () {
                          followController.pressFunction();
                          //print(followController.isPressed);
                        },
                        child: Column(
                          children: [
                            followController.isPressed.value
                                ? SvgPicture.asset(
                                    'assets/icons/Follow.svg',
                                    height: 60.h,
                                    color: AppConstants().ltMainRed,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/follow-it-icon.svg',
                                    height: 60.h,
                                    color: AppConstants().ltLogoGrey),
                            Text(
                              followController.isPressed.value
                                  ? "Takip Ediliyor"
                                  : "Takip Et",
                              style: TextStyle(
                                  fontFamily: "Sfbold",
                                  fontSize: 14.sp,
                                  color: AppConstants().ltLogoGrey),
                            ),
                          ],
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.toNamed(NavigationConstants.otherprofiles,
                        arguments: userId);
                    //bottomNavigationBarController.selectedIndex.value = 3;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: ProfilePhoto(
                          height: 124.h,
                          width: 124.w,
                          url: userProfilePhotoLink,
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: "Sfbold",
                            fontSize: 16.sp,
                            color: AppConstants().ltBlack),
                      ),
                      Row(
                        children: [
                          Text(
                            vehicleType,
                            style: TextStyle(
                                fontFamily: "Sfmedium",
                                fontSize: 12.sp,
                                color: AppConstants().ltDarkGrey),
                          ),
                          Text(
                            " Şöförü",
                            style: TextStyle(
                                fontFamily: "Sfmedium",
                                fontSize: 12.sp,
                                color: AppConstants().ltDarkGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          //Get.toNamed('/chatDetailsView');
                        },
                        child: SvgPicture.asset(
                          'assets/icons/send-message-icon.svg',
                          height: 60.h,
                          color: AppConstants().ltLogoGrey,
                        ),
                      ),
                      Text(
                        "Mesaj Gönder",
                        style: TextStyle(
                            fontFamily: "Sfbold",
                            fontSize: 14.sp,
                            color: AppConstants().ltLogoGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              child: Text(
                description,
                style: TextStyle(
                    fontFamily: "Sflight",
                    fontSize: 14.sp,
                    color: AppConstants().ltLogoGrey),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
              child: Row(
                children: [
                  Text(
                    "Araç Tipi: ",
                    style: TextStyle(
                        fontFamily: "Sfbold",
                        fontSize: 14.sp,
                        color: AppConstants().ltBlack),
                  ),
                  Text(
                    vehicleType.toUpperCase(),
                    style: TextStyle(
                        fontFamily: "Sfregular",
                        fontSize: 14.sp,
                        color: AppConstants().ltBlack),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: startCity.isNotEmpty ? true : false,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Rota: ",
                                style: TextStyle(
                                    fontFamily: "Sfbold",
                                    fontSize: 14.sp,
                                    color: AppConstants().ltBlack),
                              ),
                              Text(
                                "$startCity -> $endCity",
                                style: TextStyle(
                                    fontFamily: "Sfregular",
                                    fontSize: 14.sp,
                                    color: AppConstants().ltBlack),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (routeId != null) {
                                selectedRouteController.selectedRouteId.value =
                                    routeId!;
                                selectedRouteController
                                    .selectedRouteUserId.value = routeId!;
                                Get.toNamed(NavigationConstants.routeDetails);
                              }
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/route-icon.svg',
                                  height: 25.h,
                                  color: AppConstants().ltMainRed,
                                ),
                                5.w.spaceX,
                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Rotayı Göster',
                                        style: TextStyle(
                                          fontFamily: "Sfregular",
                                          fontSize: 10.sp,
                                          color: AppConstants().ltBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///* DOLULUK ORANI (daha sonra eklenebilir) *////
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "Doluluk Oranı: ",
                    //         style: TextStyle(
                    //             fontFamily: "Sfbold",
                    //             fontSize: 14.sp,
                    //             color: AppConstants().ltBlack),
                    //       ),
                    //       Text(
                    //         "% $emptyPercent DOLU",
                    //         style: TextStyle(
                    //             fontFamily: "Sfregular",
                    //             fontSize: 14.sp,
                    //             color: AppConstants().ltBlack),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            "Çıkış Tarihi: ",
                            style: TextStyle(
                                fontFamily: "Sfbold",
                                fontSize: 14.sp,
                                color: AppConstants().ltBlack),
                          ),
                          Text(
                            firstDestination.split(" ")[0],
                            style: TextStyle(
                                fontFamily: "Sfregular",
                                fontSize: 14.sp,
                                color: AppConstants().ltBlack),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            "Varış Tarihi: ",
                            style: TextStyle(
                                fontFamily: "Sfbold",
                                fontSize: 14.sp,
                                color: AppConstants().ltBlack),
                          ),
                          Text(
                            secondDestination.split(" ")[0],
                            style: TextStyle(
                                fontFamily: "Sfregular",
                                fontSize: 14.sp,
                                color: AppConstants().ltBlack),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            15.h.spaceY,
            RedButton(
              text: 'Profile Git',
              onpressed: () {
                Get.back();
                Get.toNamed(NavigationConstants.otherprofiles,
                    arguments: userId);
              },
            ),
            25.h.spaceY,
          ],
        ),
      ),
    );
  }
}
