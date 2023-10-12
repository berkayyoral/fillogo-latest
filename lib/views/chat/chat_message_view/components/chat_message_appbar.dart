import 'package:fillogo/export.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';
import 'package:fillogo/widgets/profilePhoto.dart';

class ChatMessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatMessageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.find();

    return AppBarGenel(
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
      title: InkWell(
        onTap: () {
          Get.toNamed('/otherprofiles');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfilePhoto(
              height: 28.h,
              width: 28.w,
              url: chatController.receiverUser.profilePicture ??
                  'https://picsum.photos/150',
            ),
            10.w.spaceX,
            Text(
              chatController.receiverUser.name!,
              style: TextStyle(
                fontFamily: "Sfbold",
                fontSize: 20.sp,
                color: AppConstants().ltBlack,
              ),
            ),
            50.w.spaceX,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
