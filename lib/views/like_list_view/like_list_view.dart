import 'dart:convert';
import 'dart:developer';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/post/post_like_list_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/like_list_view/components/like_controller.dart';
import 'package:fillogo/widgets/custom_user_information_card.dart';

class LikeListView extends StatelessWidget {
  LikeListView({super.key});
  LikeController likeController = Get.find();
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
        title: Text(
          "Beğenenler",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: FutureBuilder<PostLikeListResponse?>(
        future: GeneralServicesTemp().makeGetRequest(
            "//posts/get-likes/${likeController.likeListPostId}", {
          "Content-type": "application/json",
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
        }).then((value) {
          if (value != null) {
            return PostLikeListResponse.fromJson(json.decode(value));
          }
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.data!.isEmpty
                ? const Text("Bir hata oluştu")
                : ListView.builder(
                    itemCount: snapshot.data!.data![0].likes!.result!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var user = snapshot
                          .data!.data![0].likes!.result![index].likedposts!;
                      return snapshot.data!.data![0].likes!.result!.isEmpty
                          ? const Center(
                              child:
                                  Text("Henüz kimse tarafından beğenilmemiş"),
                            )
                          : UserInformationCard(
                              imagePath: user.profilePicture!,
                              name: user.username!,
                              onTap: () {
                                log("hey");
                              },
                              userId: snapshot
                                  .data!.data![0].likes!.result![index].id!,
                            );
                    },
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
