import 'dart:convert';

import 'package:fillogo/models/user/report_problem.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

import '../../../export.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final TextEditingController controller = TextEditingController();

  int dropdownValue = 0;

  final List<DropdownMenuItem<int>> list = <DropdownMenuItem<int>>[
    DropdownMenuItem(
      value: 0,
      child: Text(
        'Spam',
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 12.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text(
        'Hata',
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 12.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text(
        'Şikayet',
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 12.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    ),
  ];

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
          "Bildir",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 5.h,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 720.h,
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      20.h.spaceY,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Kategori',
                            style: TextStyle(
                              fontFamily: 'Sfsemibold',
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      10.h.spaceY,
                      Container(
                        width: 340.w,
                        height: 50.h,
                        padding: const EdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: AppConstants().ltWhite,
                        ),
                        child: DropdownButton<int>(
                          style: TextStyle(
                            fontFamily: "Sfregular",
                            fontSize: 12.sp,
                            color: AppConstants().ltBlack,
                          ),
                          icon: const SizedBox(),
                          underline: const SizedBox(),
                          value: dropdownValue,
                          items: list,
                          dropdownColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value ?? 0;
                            });
                          },
                        ),
                      ),
                      _textField(controller: controller, hint: 'Mesajınız'),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  right: 10.w,
                  child: RedButton(
                    text: 'Gönder',
                    onpressed: () {
                      GeneralServicesTemp().makePostRequest(
                          EndPoint.reportProblem,
                          ReportProblemRequest(
                              category: dropdownValue == 0
                                  ? "Spam"
                                  : dropdownValue == 1
                                      ? "Hata"
                                      : "Şikayet",
                              message: controller.text),
                          {
                            "Content-type": "application/json",
                            'Authorization':
                                'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                          }).then((value) {
                        var response =
                            ReportProblemResponse.fromJson(json.decode(value!));
                        if (response.success == 1) {
                          Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Bildiriniz başarıyla gönderildi...',
                              ),
                            ),
                          );
                        } else {
                          UiHelper.showWarningSnackBar(context,
                              "Bir hata ile karşılaşıldı Tekrar Deneyiniz!");
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: TextStyle(
              fontFamily: 'Sfsemibold',
              fontSize: 16.sp,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            width: 340.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: 10,
              cursorColor: AppConstants().ltMainRed,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: "Sfregular",
                  fontSize: 12.sp,
                  color: AppConstants().ltDarkGrey,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                fontFamily: "Sfregular",
                fontSize: 12.sp,
                color: AppConstants().ltBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
