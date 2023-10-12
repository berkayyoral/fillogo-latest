import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/my_routes_view/my_routes_page_view.dart';
import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';
import 'package:fillogo/widgets/custom_button_design.dart';

class FindSimilarRoutesPageView extends StatelessWidget {
  FindSimilarRoutesPageView({super.key});

  CreatePostPageController createPostPageController = Get.find();
  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  StartEndAdressController startEndAdressController =
      Get.find<StartEndAdressController>();

  var isSearched = false.obs;

  TextEditingController startAdressController = TextEditingController();
  var startAdress = ''.obs;
  TextEditingController endAdressController = TextEditingController();
  var endAdress = ''.obs;
  var isComplated1 = true.obs;
  bool isComplated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 2.w,
            ),
            child: SvgPicture.asset(
              height: 20.h,
              width: 20.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Kesişen Rotaları Bul",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, bottom: 10.h, top: 20.h),
                child: Container(
                  width: 340.w,
                  height: 44.h,
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
                    onChanged: (value) {
                      isComplated = true;
                      startEndAdressController.startAdress.value =
                          startAdressController.text;
                    },
                    onTapOutside: (event) {
                      startAdress.value = startAdressController.text;
                    },
                    controller: startAdressController,
                    cursorColor: AppConstants().ltMainRed,
                    decoration: InputDecoration(
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
                      hintText: 'Çıkış adresi',
                    ),
                    style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 14.sp,
                      color: AppConstants().ltBlack,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: Container(
                  width: 340.w,
                  height: 44.h,
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
                    onChanged: (value) {
                      //endAdress.value = endAdressController.text;
                      startEndAdressController.endAdress.value =
                          endAdressController.text;
                      isComplated = true;
                    },
                    onTapOutside: (event) {
                      endAdress.value = endAdressController.text;
                    },
                    // onEditingComplete: () {
                    //   endAdress.value = endAdressController.text;
                    // },
                    controller: endAdressController,
                    cursorColor: AppConstants().ltMainRed,
                    decoration: InputDecoration(
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
                      hintText: 'Varış adresi',
                    ),
                    style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 14.sp,
                      color: AppConstants().ltBlack,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                child: CustomButtonDesign(
                  text: 'Kesişen Rota Ara',
                  textColor: AppConstants().ltWhite,
                  onpressed: () {
                    isSearched.value = true;
                    isComplated1.value = isComplated;
                  },
                  iconPath: '',
                  color: AppConstants().ltMainRed,
                  height: 50.h,
                  width: 341.w,
                ),
              ),
              Obx(() => Visibility(
                    visible: isSearched.value &&
                        (startAdressController.text != '') &&
                        (endAdressController.text != ''),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 20.h),
                      child: Column(
                        children: [
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Sadık Pehlivan',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Furkan Semiz',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Doğukan Tek',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'İnanç Telci',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Fatih Pehlivan',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Arda Turan',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Mesut Arslan',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'İsmail İşeri',
                          // ),
                          // RouteDetailsIntoRoutesWidget(
                          //   startPoint: startAdress.value,
                          //   endPoint: endAdress.value,
                          //   userName: 'Fatih Terim',
                          // ),
                        ],
                      ),
                    ),
                  )),
              30.h.spaceY,
            ],
          ),
        ),
      ),
    );
  }
}
