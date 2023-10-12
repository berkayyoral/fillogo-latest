import '../../../export.dart';
import '../../../widgets/shild_icon_pinned.dart';

class FriendsStoryView extends StatelessWidget {
  FriendsStoryView({
    super.key,
    required this.storyImageUrl,
    required this.profileImageUrl,
    required this.userName,
    required this.arguments,
  });
  final String storyImageUrl;
  final String profileImageUrl;
  final String userName;
  final dynamic arguments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/storyPageView', arguments: arguments);
      },
      child: Container(
        width: 100.w,
        height: 160.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(0.2),
              spreadRadius: 0.r,
              blurRadius: 15.r,
            ),
          ],
          image: DecorationImage(
              image: NetworkImage(
                storyImageUrl,
              ),
              fit: BoxFit.cover),
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppConstants().ltBlack, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Positioned(
              left: 0.w,
              right: 0.w,
              top: 140.h,
              child: Text(
                userName,
                style: TextStyle(
                  fontFamily: 'Sfsemibold',
                  fontSize: 12.sp,
                  color: AppConstants().ltWhite,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              left: 8.w,
              top: 8.h,
              child: SizedBox(
                height: 40.h,
                width: 36.w,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/kalkan-full-icon.svg',
                        height: 40.h,
                        width: 36.w,
                        color: AppConstants().ltMainRed,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ClipPath(
                        clipper: ShildIconCustomPainter(),
                        child: SizedBox(
                          height: 32.h,
                          width: 28.w,
                          //color: AppConstants().ltWhite,
                          child: Image.network(
                            profileImageUrl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
