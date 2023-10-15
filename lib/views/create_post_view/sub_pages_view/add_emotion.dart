import 'dart:convert';

import 'package:fillogo/export.dart';
import 'package:fillogo/models/emoji/emoji_response_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

class CreatePostAddEmotionPageView extends StatelessWidget {
  CreatePostAddEmotionPageView({super.key});

  CreatePostPageController createPostPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
        child: FutureBuilder<EmojiResponseModel?>(
          future: GeneralServicesTemp().makeGetRequest(
            EndPoint.emojis,
            {
              'Authorization':
                  'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
              'Content-Type': 'application/json',
            },
          ).then((value) {
            if (value != null) {
              return EmojiResponseModel.fromJson(json.decode(value));
            }
            return null;
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.data!.isEmpty
                  ? const Center(
                      child: Text("Hiç emoji yok"),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            createPostPageController
                                .changeSelectedEmotion(EmotionData(
                              id: snapshot.data!.data![index].id!,
                              emoji: snapshot.data!.data![index].emoji!,
                              name: snapshot.data!.data![index].name!,
                            ));
                            // log(createPostPageController
                            //     .selectedEmotion.value.id
                            //     .toString());

                            if (createPostPageController
                                .isSelectedEmotion.value) {
                              createPostPageController.isSelectedEmotion.value =
                                  false;
                            } else {
                              createPostPageController.isSelectedEmotion.value =
                                  true;
                            }

                            createPostPageController.update(['emojiAndTag']);
                          },
                          child: EmotionContainerView(
                            emojiImage: snapshot.data!.data![index].emoji!,
                            emojiName: snapshot.data!.data![index].name!,
                            emotionId: snapshot.data!.data![index].id!,
                          ),
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
      ),
    );
  }

  AppBarGenel appBar() {
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
      title: Text(
        "His / Hareket Ekle",
        style: TextStyle(
          fontFamily: "Sfbold",
          fontSize: 20.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EmotionContainerView extends StatelessWidget {
  EmotionContainerView({
    super.key,
    required this.emotionId,
    required this.emojiImage,
    required this.emojiName,
  });
  final int emotionId;
  final String emojiImage;
  final String emojiName;

  CreatePostPageController createPostPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Obx(
        () => Container(
          height: 50.h,
          width: 340.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8.r,
              ),
            ),
            color: AppConstants().ltWhiteGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Image.network(
                      emojiImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    emojiName,
                    style: TextStyle(
                      fontFamily: 'Sfsemibold',
                      fontSize: 16,
                      color: AppConstants().ltLogoGrey,
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: SvgPicture.asset(
                    height: 28.h,
                    width: 28.w,
                    'assets/icons/selected-emotion-icon.svg',
                    color: (createPostPageController.selectedEmotion.value.id ==
                                emotionId) &&
                            (createPostPageController.isSelectedEmotion.value)
                        ? AppConstants().ltMainRed
                        : AppConstants().ltWhiteGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
