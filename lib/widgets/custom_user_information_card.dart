import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

class UserInformationCard extends StatelessWidget {
  const UserInformationCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.onTap,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadMessageCounter,
    required this.userId,
    this.commonFollowers,
  }) : super(key: key);
  final String imagePath;
  final String name;
  final String? lastMessage;
  final String? lastMessageTime;
  final int? unreadMessageCounter;
  final int userId;
  final VoidCallback? onTap;
  final String? commonFollowers;
  @override
  Widget build(BuildContext context) {
    UserStateController userStateController = Get.find();

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
            child: Stack(
              children: [
                ProfilePhoto(
                  height: 48.h,
                  width: 48.w,
                  url: imagePath,
                ),
                Obx(
                  () => userStateController.isUserOnline(userId: userId)
                      ? Positioned(
                          bottom: 0,
                          child: Container(
                            height: 12.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                              color: AppConstants().ltMainRed,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Center(
                              child: Text(
                                'Çevrimiçi',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  color: AppConstants().ltWhite,
                                  fontFamily: 'Sfbold',
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                      width: 285.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontFamily: 'Sfsemibold',
                              fontSize: 16.sp,
                            ),
                          ),
                          (lastMessageTime == "" && lastMessageTime == null)
                              ? const SizedBox()
                              : Text(
                                  lastMessageTime ?? "",
                                  style: TextStyle(
                                    fontFamily: 'SfSemibold',
                                    fontSize: 12.sp,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    lastMessage == null
                        ? const SizedBox()
                        : SizedBox(
                            height: 25.h,
                            width: 285.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 257.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      lastMessage == null
                                          ? const SizedBox()
                                          : SvgPicture.asset(
                                              'assets/icons/check.svg',
                                              color: AppConstants().ltLogoGrey,
                                              height: 8.h,
                                              width: 8.w,
                                            ),
                                      lastMessage == null
                                          ? const SizedBox()
                                          : 5.w.spaceX,
                                      lastMessage == null
                                          ? const SizedBox()
                                          : Text(
                                              commonFollowers == null
                                                  ? ""
                                                  : commonFollowers!,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Sflight',
                                                fontSize: 12.sp,
                                                color:
                                                    AppConstants().ltLogoGrey,
                                              ),
                                            ),
                                      lastMessage == null
                                          ? const SizedBox()
                                          : Flexible(
                                              child: Text(
                                                lastMessage ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Sflight',
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppConstants().ltLogoGrey,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                (unreadMessageCounter == 0 ||
                                        unreadMessageCounter == null)
                                    ? const SizedBox()
                                    : Container(
                                        height: 18.w,
                                        width: 18.w,
                                        decoration: BoxDecoration(
                                          color: AppConstants().ltMainRed,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            unreadMessageCounter.toString(),
                                            style: TextStyle(
                                              color: AppConstants().ltWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
