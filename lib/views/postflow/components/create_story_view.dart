import '../../../export.dart';

class CreateStoryView extends StatelessWidget {
  const CreateStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(NavigationConstants.addStory);
      },
      child: Container(
        width: 100.w,
        height: 160.h,
        //alignment: AlignmentDirectional.bottomEnd,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 10.r,
            ),
          ],
          image: const DecorationImage(
              image: NetworkImage(
                'https://picsum.photos/150',
              ),
              fit: BoxFit.cover),
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0.w,
              right: 0.w,
              bottom: 0.h,
              child: Container(
                width: 100.w,
                height: 36.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants().ltLogoGrey.withOpacity(0.2),
                      spreadRadius: 0.r,
                      blurRadius: 0.r,
                    ),
                  ],
                  color: AppConstants().ltWhite,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            Positioned(
              left: 28.w,
              right: 28.w,
              top: 112.h,
              child: SvgPicture.asset(
                'assets/icons/kalkan-full-icon.svg',
                height: 28.h,
                width: 28.w,
                color: AppConstants().ltWhite,
              ),
            ),
            Positioned(
              left: 28.w,
              right: 28.w,
              top: 112.h,
              child: SvgPicture.asset(
                'assets/icons/navi-feed-icon.svg',
                height: 28.h,
                width: 28.w,
                color: AppConstants().ltMainRed,
              ),
            ),
            Positioned(
              left: 0.w,
              right: 0.w,
              top: 140.h,
              child: Text(
                "Hikaye Oluştur",
                style: TextStyle(
                  fontFamily: 'Sfsemibold',
                  fontSize: 10.sp,
                  color: AppConstants().ltLogoGrey,
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
