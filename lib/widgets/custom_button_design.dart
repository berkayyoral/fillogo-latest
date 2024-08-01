import 'package:fillogo/export.dart';

class CustomButtonDesign extends StatelessWidget {
  CustomButtonDesign({
    Key? key,
    required this.text,
    required this.textColor,
    this.onpressed,
    required this.iconPath,
    required this.color,
    required this.height,
    required this.width,
    Future<void> Function()? onPressed,
  }) : super(key: key);
  String? text;
  Color? textColor;
  final VoidCallback? onpressed;
  String? iconPath;
  Color? color;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: (iconPath!.isNotEmpty),
              child: (iconPath!.isNotEmpty)
                  ? SvgPicture.asset(
                      iconPath!,
                    )
                  : const SizedBox(),
            ),
            Visibility(
              visible: (iconPath!.isNotEmpty),
              child: 5.w.spaceX,
            ),
            Expanded(
              child: Text(
                text!,
                style: TextStyle(
                  fontFamily: "Sfsemidold",
                  fontSize: 16.sp,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
