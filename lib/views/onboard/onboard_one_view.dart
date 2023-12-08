import 'package:fillogo/export.dart';
import 'package:flutter/gestures.dart';
class OnboardOneView extends StatelessWidget {
  OnboardOneView(
      {Key? key,
      this.imagePath,
      this.nextTap,
      this.skip,
      this.centerText,
      this.nextText})
      : super(key: key);

  String? centerText;
  String? nextText;
  String? imagePath;
  final VoidCallback? nextTap;
  final VoidCallback? skip;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(imagePath!),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 77, left: 51, right: 51),
            child: Image.asset(
              AppConstants().logoImagePath,
              width: Get.width * 0.5,
            ),
          ),
          SizedBox(
            height: Get.height * 0.2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: centerText,
                    style: TextStyle(
                      fontFamily: "Sfmedium",
                      fontSize: 20,
                      color: AppConstants().ltWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ModalRoute.of(context)?.settings.name ==
                  NavigationConstants.onboardtwo
              ? SizedBox(
                  height: Get.height * 0.23,
                )
              : SizedBox(
                  height: Get.height * 0.25,
                ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minWidth: nextText == "Yolculuğa Başla"
                ? Get.width * 0.55
                : Get.width * 0.4,
            height: Get.height * 0.07,
            color: AppConstants().ltWhite,
            onPressed: nextTap,
            child: Text(
              nextText!,
              style: TextStyle(
                  fontFamily: "Sfsemidold",
                  fontSize: 18,
                  color: AppConstants().ltMainRed),
            ),
          ),
          nextText == "Yolculuğa Başla"
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: RichText(
                    text: TextSpan(
                        text: 'Atla',
                        style: TextStyle(
                          fontFamily: "Sfmedium",
                          fontSize: 14,
                          color: AppConstants().ltWhite,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = skip),
                  ),
                ),
        ],
      ),
    );
  }
}
