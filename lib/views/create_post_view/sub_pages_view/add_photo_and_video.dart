// import 'package:fillogo/export.dart';
// import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

// class CreatePostAddPhotoAndVideoPageView extends StatelessWidget {
//   CreatePostAddPhotoAndVideoPageView({super.key});

//   CreatePostPageController createPostPageController =
//       Get.find<CreatePostPageController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarGenel(
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 20.w,
//               right: 2.w,
//             ),
//             child: SvgPicture.asset(
//               height: 20.h,
//               width: 20.w,
//               'assets/icons/back-icon.svg',
//               color: AppConstants().ltLogoGrey,
//             ),
//           ),
//         ),
//         title: Text(
//           "Fotoğraf Ekle",
//           style: TextStyle(
//             fontFamily: "Sfbold",
//             fontSize: 20.sp,
//             color: AppConstants().ltBlack,
//           ),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               Get.toNamed(NavigationConstants.notifications);
//             },
//             child: Padding(
//               padding: EdgeInsets.only(
//                 right: 20.w,
//               ),
//               child: SvgPicture.asset(
//                 height: 32.h,
//                 width: 32.w,
//                 'assets/icons/settings.svg',
//                 color: AppConstants().ltLogoGrey,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
//         child: Container(),
//       ),
//     );
//   }
// }
