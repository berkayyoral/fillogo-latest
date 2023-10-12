import 'package:fillogo/export.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

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
              left: 24.w,
            ),
            child: SvgPicture.asset(
              height: 24.h,
              width: 24.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Hakkımızda",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(color: AppConstants().ltWhite),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.h.spaceY,

            // Container(
            //   width: Get.height,
            //   child: SvgPicture.asset("assets/logo/logo-1.png"),
            // ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's It has survived not only five centuries, ",
                      style: TextStyle(
                        fontFamily: 'Sfmedium',
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/truck_example.png',
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Image.asset('assets/images/truck_example-2.png'),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      "but also the leap into electronic typesetting, remaining essentially unchanged. ",
                      style: TextStyle(
                        fontFamily: 'Sfmedium',
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.h.spaceY,
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "NOT: BU SAYFANIN İÇERİĞİ HENÜZ BELİRLENMEDİ! ŞİRKET TARAFINDAN İLETİLECEK HAKKIMIZDA YAZISI VE ONA UYGUN HAZIRLANACAK TASARIM EKLENECEK.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Sfmedium',
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            20.h.spaceY,
            // SizedBox(height: 20.h),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Gizlilik İlkesi',
            //     style: TextStyle(
            //       fontFamily: 'Sfbold',
            //       fontSize: 24,
            //       color: AppConstants().ltMainRed,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
