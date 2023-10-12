import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/custom_button_design.dart';

class ShowAllertDialogWidget extends StatelessWidget {
  ShowAllertDialogWidget(
      {super.key,
      required this.title,
      required this.discription1,
      required this.buttonCount,
      required this.button1Text,
      required this.button1TextColor,
      required this.button1Color,
      required this.onPressed1,
      required this.button1IconPath,
      required this.button1Height,
      required this.button1Width,
      this.discription2,
      this.button2TextColor,
      this.button2Text,
      this.button2Color,
      this.onPressed2,
      this.button2IconPath,
      this.button2Height,
      this.button2Width,
      this.note});

  final String title;
  final String discription1;
  final int buttonCount;
  final String button1Text;
  final Color button1TextColor;
  final Color button1Color;
  final VoidCallback onPressed1;
  final String button1IconPath;
  final double button1Height;
  final double button1Width;
  final String? discription2;
  final Color? button2TextColor;
  final String? button2Text;
  final Color? button2Color;
  final VoidCallback? onPressed2;
  final String? button2IconPath;
  final double? button2Height;
  final double? button2Width;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Sfsemibold',
          fontSize: 16.sp,
          color: AppConstants().ltLogoGrey,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            discription1,
            style: TextStyle(
              fontFamily: 'Sfregular',
              fontSize: 14.sp,
              color: AppConstants().ltLogoGrey,
            ),
          ),
          Visibility(
            visible: discription2 != null,
            child: 15.h.spaceY,
          ),
          Visibility(
            visible: discription2 != null,
            child: Text(
              discription2 ?? '',
              style: TextStyle(
                fontFamily: 'Sfregular',
                fontSize: 14.sp,
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
          20.h.spaceY,
          Padding(
            padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
            child: CustomButtonDesign(
              text: button1Text,
              textColor: button1TextColor,
              onpressed: onPressed1,
              iconPath: button1IconPath,
              color: button1Color,
              height: button1Height,
              width: button1Width,
            ),
          ),
          Visibility(
            visible: buttonCount == 2,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.w, right: 12.w, left: 12.w),
              child: CustomButtonDesign(
                text: button2Text ?? '',
                textColor: button2TextColor ?? AppConstants().ltWhite,
                onpressed: onPressed2 ?? () {},
                iconPath: button2IconPath ?? '',
                color: button2Color ?? AppConstants().ltWhite,
                height: button2Height ?? 0,
                width: button2Width ?? 0,
              ),
            ),
          ),
          Visibility(
            visible: note != null,
            child: SizedBox(
              width: Get.width,
              child: Wrap(
                runSpacing: 2.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Not: ",
                          style: TextStyle(
                            fontFamily: 'Sfbold',
                            fontSize: 12.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                        TextSpan(
                          text: note ?? '',
                          style: TextStyle(
                            fontFamily: 'Sflight',
                            fontSize: 12.sp,
                            color: AppConstants().ltLogoGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
