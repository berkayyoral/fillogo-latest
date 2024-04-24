import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fillogo/models/stories/create_story.dart';
import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/core/init/bussiness_helper/bussiness_helper.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

import '../../export.dart';

class AddStoryView extends StatefulWidget {
  const AddStoryView({Key? key}) : super(key: key);

  @override
  State<AddStoryView> createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  CreatePostPageController createPostPageController = Get.find();
  MediaPickerController mediaPickerController =
      Get.put(MediaPickerController());

  var imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants().ltWhiteGrey,
      appBar: AppBarGenel(
        title: Text(
          'Hikaye Ekle',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/icons/back-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          mediaPickerController.isMediaPicked != false
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Image.file(
                    File(mediaPickerController.media!.path!),
                    fit: BoxFit.cover,
                  ))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RedButton(
                        text: 'Galeriden Fotoğraf/Video Yükle',
                        onpressed: () async {
                          mediaPickerController.media =
                              await BussinessHelper.pickFile(context)
                                  .then((value) {
                            if (value != null) {
                              Logger().e("Yes Picked");

                              //log('file picked ${value.name}');
                              mediaPickerController.isMediaPicked = true;

                              if (value.name.split('.').last == 'mp4') {
                                mediaPickerController.isVideo = true;
                              } else {
                                mediaPickerController.isVideo = false;
                              }
                            } else {
                              mediaPickerController.isVideo = false;
                            }
                            print("value = $value");

                            imageFile = value;
                            return value;
                          });

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
          mediaPickerController.isMediaPicked != false
              ? Positioned(
                  bottom: 12.h,
                  left: 16.w,
                  right: 16.w,
                  child: RedButton(
                    text: 'Paylaş',
                    onpressed: () async {
                      Map<String, dynamic> formData1 = {
                        'file': mediaPickerController.media
                      };
                      GeneralServicesTemp().makePostRequestWithFormData(
                        EndPoint.createStories,
                        formData1,
                        {
                          "Content-Type": "multipart/form-data",
                          'Authorization':
                              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                        },
                      ).then((value) {
                        log(value.toString());
                        if (value != null) {
                          log("${mediaPickerController.media}");
                          log("${formData1}");
                          final response =
                              CreateStoryResponse.fromJson(jsonDecode(value));
                          if (response.success == 1) {
                            Get.back();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Hikaye başarıyla eklendi...',
                                ),
                              ),
                            );
                          }
                        }
                      });
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
