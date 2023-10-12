import 'dart:developer';
import 'dart:io';
import '../export.dart';

class SharePostProgressBarWidget extends StatelessWidget {
  const SharePostProgressBarWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      width: 395.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppConstants().ltMainRed,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                'Gönderi Yükleniyor...',
                style: TextStyle(
                  fontFamily: 'MulishMedium',
                  color: AppConstants().ltWhite,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 363.w,
            child: Obx(
              () => const LinearProgressIndicator(value: 0.1),
            ),
          )
        ],
      ),
    );
  }
}
